from transformers import CLIPProcessor, CLIPModel
from PIL import Image
import torch
import requests
from db import fetch_all_products

clip_model = CLIPModel.from_pretrained("./models/clip")
clip_processor = CLIPProcessor.from_pretrained("./models/clip")

def predict_products_from_image_url(image_url, top_n=3):
    try:
        image = Image.open(requests.get(image_url, stream=True).raw).convert("RGB")
    except Exception as e:
        print(f"Image download or processing failed: {e}")
        return []

    products = fetch_all_products()
    product_texts = [f"{name} {desc or ''}" for (_, name, desc, *_rest) in products]

    inputs = clip_processor(text=product_texts, images=image, return_tensors="pt", padding=True, truncation=True)

    with torch.no_grad():
        outputs = clip_model(**inputs)

    logits_per_image = outputs.logits_per_image  # [1, num_products]
    probs = logits_per_image.softmax(dim=1).squeeze(0)  # tensor shape: [num_products]

    scored = list(zip(probs.tolist(), products))
    scored.sort(key=lambda x: x[0], reverse=True)

    return [item[1] for item in scored[:top_n]]
