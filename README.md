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
