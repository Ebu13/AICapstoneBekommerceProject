from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
from db import fetch_all_products

model = SentenceTransformer('./models/sentence')

def predict_products_from_text(user_prompt, top_n=3):
    prompt_vec = model.encode([user_prompt], convert_to_tensor=True)  # shape: (1, dim)
    products = fetch_all_products()

    product_texts = [f"{name} {desc or ''}" for (_, name, desc, *_rest) in products]
    product_vecs = model.encode(product_texts, convert_to_tensor=True)  # shape: (num_products, dim)

    # Cosine similarity hesapla (prompt_vec vs tüm ürünler)
    scores = cosine_similarity(prompt_vec.cpu(), product_vecs.cpu())[0]

    scored = list(zip(scores, products))
    scored.sort(key=lambda x: x[0], reverse=True)

    return [item[1] for item in scored[:top_n]]
