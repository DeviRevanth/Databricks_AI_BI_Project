import boto3
import csv
import random
from io import StringIO
from datetime import datetime

s3 = boto3.client("s3")

BUCKET = "s3 Bucket Name"
KEY = "raw_s3_location_csv"

COUNTRIES = {
    "India": "+91",
    "USA": "+1",
    "UK": "+44",
    "Canada": "+1",
    "Australia": "+61"
}

GENDERS = ["M", "F"]

# -----------------------------
# Read existing customers
# -----------------------------
def read_existing_customers():
    try:
        obj = s3.get_object(Bucket=BUCKET, Key=KEY)
        content = obj["Body"].read().decode("utf-8")
        reader = csv.DictReader(StringIO(content))
        return list(reader)
    except s3.exceptions.NoSuchKey:
        return []

# -----------------------------
# Generate phone number
# -----------------------------
def generate_phone(country_code):
    return f"{country_code}{random.randint(6000000000, 9999999999)}"

# -----------------------------
# Lambda Handler
# -----------------------------
def lambda_handler(event, context):

    new_customer_count = event.get("new_customers", random.randint(5, 20))
    existing_customers = read_existing_customers()

    start_id = len(existing_customers) + 1
    new_customers = []

    for i in range(start_id, start_id + new_customer_count):
        country = random.choice(list(COUNTRIES.keys()))
        phone = generate_phone(COUNTRIES[country])

        new_customers.append({
            "customer_id": f"CUST_{i:05d}",
            "customer_name": f"Customer_{i}",
            "email": f"customer{i}@mail.com",
            "country": country,
            "phone_number": phone,
            "gender": random.choice(GENDERS),
            "created_at": datetime.utcnow().isoformat()
        })

    all_customers = existing_customers + new_customers

    buffer = StringIO()
    writer = csv.DictWriter(
        buffer,
        fieldnames=[
            "customer_id",
            "customer_name",
            "email",
            "country",
            "phone_number",
            "gender",
            "created_at"
        ]
    )
    writer.writeheader()
    writer.writerows(all_customers)

    s3.put_object(
        Bucket=BUCKET,
        Key=KEY,
        Body=buffer.getvalue(),
        ContentType="text/csv"
    )

    return {
        "status": "Customers appended",
        "new_customers": len(new_customers)
    }
