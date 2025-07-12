import psycopg2
from config import DB_CONFIG

def get_connection():
    return psycopg2.connect(**DB_CONFIG)

def fetch_all_products():
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT p.id, p.name, p.description, p.image_url,
               COALESCE(AVG(r.rating), 0) as avg_rating,
               COUNT(r.id) as review_count
        FROM products p
        LEFT JOIN product_reviews r ON p.id = r.product_id
        GROUP BY p.id;
    """)
    results = cur.fetchall()
    cur.close()
    conn.close()
    return results