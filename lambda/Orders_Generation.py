import boto3
import csv
import random
from io import StringIO
from datetime import datetime, timezone
import uuid

s3 = boto3.client("s3")

BUCKET = "S3 Bucket Name"
CUSTOMERS_KEY = "raw_s3_location_csv"
PRODUCTS_KEY = "raw_s3_location_csv"

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

    customers = read_csv(CUSTOMERS_KEY)
    products = read_csv(PRODUCTS_KEY)

    if not customers or not products:
        raise Exception("Customers or Products data is empty")

    order_count = event.get("order_count", 100000)

    buffer = StringIO()
    fieldnames = [
        "order_id",
        "order_ts",
        "customer_id",
        "product_id",
        "quantity",
        "unit_price",
        "line_amount",
        "payment_method",
        "order_status"
    ]

    writer = csv.DictWriter(buffer, fieldnames=fieldnames)
    writer.writeheader()

    for _ in range(order_count):
        order_id = f"ORD-{uuid.uuid4().hex[:10].upper()}"
        customer = random.choice(customers)
        order_ts = datetime.now(timezone.utc).isoformat()
        payment_method = random.choice(["UPI", "CARD", "NET_BANKING"])
        order_status = random.choice(["PLACED", "CANCELLED"])

        for prod in random.sample(products, random.randint(1, 4)):
            qty = random.randint(1, 3)
            price = float(prod["price"])

            writer.writerow({
                "order_id": order_id,
                "order_ts": order_ts,
                "customer_id": customer["customer_id"],
                "product_id": prod["product_id"],
                "quantity": qty,
                "unit_price": price,
                "line_amount": round(qty * price, 2),
                "payment_method": payment_method,
                "order_status": order_status
            })

    now = datetime.utcnow()
    key = (
        f"raw/orders/"
        f"year={now.year}/month={now.month:02d}/day={now.day:02d}/"
        f"orders_{now.strftime('%H%M%S')}.csv"
    )

    s3.put_object(
        Bucket=BUCKET,
        Key=key,
        Body=buffer.getvalue(),
        ContentType="text/csv"
    )

    return {
        "status": "Orders generated (flat schema)",
        "orders": order_count
    }
