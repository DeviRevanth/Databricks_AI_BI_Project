import boto3
import csv
from io import StringIO

s3 = boto3.client("s3")

BUCKET = "S3 Bucket Name"

BRANDS_KEY = "raw_s3_location_csv"
CATEGORIES_KEY = "raw_s3_location_csv"

def generator():

    brands = [
        ("BR_001", "Samsung"),
        ("BR_002", "Apple"),
        ("BR_003", "Nike"),
        ("BR_004", "Adidas"),
        ("BR_005", "Ikea"),
        ("BR_006", "Penguin")
    ]

    categories = [
        ("CAT_001", "Electronics"),
        ("CAT_002", "Fashion"),
        ("CAT_003", "Home & Kitchen"),
        ("CAT_004", "Sports"),
        ("CAT_005", "Books")
    ]

    # Write brands
    brand_buffer = StringIO()
    brand_writer = csv.writer(brand_buffer)
    brand_writer.writerow(["brand_id", "brand_name"])
    brand_writer.writerows(brands)

    s3.put_object(
        Bucket=BUCKET,
        Key=BRANDS_KEY,
        Body=brand_buffer.getvalue(),
        ContentType="text/csv"
    )

    # Write categories
    category_buffer = StringIO()
    category_writer = csv.writer(category_buffer)
    category_writer.writerow(["category_id", "category_name"])
    category_writer.writerows(categories)

    s3.put_object(
        Bucket=BUCKET,
        Key=CATEGORIES_KEY,
        Body=category_buffer.getvalue(),
        ContentType="text/csv"
    )

    return {
        "status": "Reference data created",
        "brands": len(brands),
        "categories": len(categories)
    }
