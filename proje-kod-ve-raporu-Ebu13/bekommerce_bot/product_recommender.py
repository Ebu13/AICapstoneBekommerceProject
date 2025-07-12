from nlp_utils import predict_products_from_text
from image_utils import predict_products_from_image_url

def recommend_products_from_text(prompt):
    return predict_products_from_text(prompt)

def recommend_products_from_image_url(url):
    return predict_products_from_image_url(url)
