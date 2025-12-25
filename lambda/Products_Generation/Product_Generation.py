import boto3
import csv
import random
from io import StringIO
from datetime import datetime

s3 = boto3.client("s3")

BUCKET = "S3 Bucket Name"

BRANDS_KEY = "raw_s3_location_csv_file"
CATEGORIES_KEY = "raw_s3_location_csv_file"
PRODUCTS_KEY = "raw_s3_location_csv_file"

from categories_generator import generator
generator()

# -----------------------------
# Read CSV from S3
# -----------------------------
def read_csv(key):
    obj = s3.get_object(Bucket=BUCKET, Key=key)
    content = obj["Body"].read().decode("utf-8")
    return list(csv.DictReader(StringIO(content)))

# -----------------------------
# Lambda Handler
# -----------------------------
def lambda_handler(event, context):

    brands = read_csv(BRANDS_KEY)
    categories = read_csv(CATEGORIES_KEY)

    if not brands or not categories:
        raise Exception("Brands or Categories reference data missing")

    product_count = event.get("product_count", 150)

    products = []

    for i in range(1, product_count + 1):
        brand = random.choice(brands)
        category = random.choice(categories)

        products.append({
            "product_id": f"PROD_{i:05d}",
            "product_name": f"{brand['brand_name']}_Product_{i}",
            "brand_id": brand["brand_id"],
            "category_id": category["category_id"],
            "price": round(random.uniform(299, 9999), 2),
            "created_at": datetime.utcnow().isoformat()
        })

    buffer = StringIO()
    writer = csv.DictWriter(
        buffer,
        fieldnames=[
            "product_id",
            "product_name",
            "brand_id",
            "category_id",
            "price",
            "created_at"
        ]
    )
    writer.writeheader()
    writer.writerows(products)

    s3.put_object(
        Bucket=BUCKET,
        Key=PRODUCTS_KEY,
        Body=buffer.getvalue(),
        ContentType="text/csv"
    )

    return {
        "status": "Products created",
        "count": len(products)
    }
