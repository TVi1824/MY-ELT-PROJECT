# End-to-End Sales ELT Pipeline & Dashboard

## 1. Project Overview
Dự án xây dựng hệ thống tự động hóa luồng dữ liệu (Data Pipeline) từ khâu giả lập dữ liệu giao dịch đến việc trực quan hóa trên Dashboard để hỗ trợ ra quyết định kinh doanh.

## 2. System Architecture
Dữ liệu được vận hành qua các bước:
1. **Source**: Script Python (Faker) sinh dữ liệu giao dịch mẫu.
2. **Warehouse**: PostgreSQL chạy trên Docker.
3. **Orchestration**: n8n tự động hóa việc quét file và nạp dữ liệu vào Database.
4. **Visualization**: Looker Studio kết nối qua Google Sheets để hiển thị báo cáo.

## 3. Tech Stack
* **Language**: Python (Pandas, Faker)
* **Database**: PostgreSQL
* **Tools**: Docker, n8n
* **BI Tool**: Looker Studio

## 4. Key Business Insights
Dashboard cung cấp các chỉ số quan trọng (KPIs):
* **Total Units Sold**: Theo dõi sản lượng bán ra toàn hệ thống.
* **Top Performing Products**: Xác định các mặt hàng chủ lực.
* **Daily Sales Trend**: Nhận diện các biến động doanh số theo thời gian để tối ưu kho vận.

## 5. How to Run
1. `docker-compose up -d` để khởi động hạ tầng.
2. Cài đặt thư viện: `pip install -r requirements.txt`.
3. Chạy script sinh dữ liệu: `python elt/generate_data.py`.