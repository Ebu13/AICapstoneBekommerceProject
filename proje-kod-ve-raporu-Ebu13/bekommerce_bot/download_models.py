from transformers import CLIPProcessor, CLIPModel

model_name = "openai/clip-vit-base-patch32"  # Kendi kullandığın model adı

# Model ve processor'u indir
model = CLIPModel.from_pretrained(model_name)
processor = CLIPProcessor.from_pretrained(model_name)

# Aynı klasöre kaydet
save_dir = "./models/clip"
model.save_pretrained(save_dir)
processor.save_pretrained(save_dir)
