import pandas as pd
from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker()

NUM_ROWS = 2000  
FILE_NAME = 'elt/sales_data.csv'

products = ['P001', 'P002', 'P003', 'P004', 'P005', 'P006', 'P007']
customers = [f'C{str(i).zfill(3)}' for i in range(1, 51)]

data = []
print(f"🔄 Đang khởi tạo {NUM_ROWS} dòng dữ liệu...")

for i in range(NUM_ROWS):
    end_date = datetime.now()
    start_date = end_date - timedelta(days=365)
    random_date = fake.date_between(start_date=start_date, end_date=end_date)
    
    data.append({
        "transaction_id": f"T{str(i+1).zfill(5)}", 
        "customer_id": random.choice(customers),   
        "product_id": random.choice(products),    
        "quantity": random.randint(1, 50),         
        "transaction_date": random_date.strftime('%Y-%m-%d')
    })

df = pd.DataFrame(data)
df.to_csv(FILE_NAME, index=False)

print(f"✅ Hoàn tất! File '{FILE_NAME}' đã sẵn sàng tại thư mục hiện hành.")
