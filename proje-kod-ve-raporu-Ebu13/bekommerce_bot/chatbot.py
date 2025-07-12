from product_recommender import recommend_products_from_text, recommend_products_from_image_url

def chat_with_user(message: str):
    if message.startswith("http"):
        products = recommend_products_from_image_url(message)
        return f"Görsele göre en uygun ürünler:\n" + format_products(products)
    else:
        products = recommend_products_from_text(message)
        return f"İfadeye göre en uygun ürünler:\n" + format_products(products)

def format_products(products):
    if not products:
        return "Üzgünüm, uygun ürün bulamadım."
    result = ""
    for pid, name, desc, img, rating, count in products:
        result += f"\n🛍️ {name} ({rating:.1f} ⭐ / {count} yorum)\n🔗 Resim: {img}\n📝 {desc}\n📦 Ürün ID: {pid}\n"
    return result
