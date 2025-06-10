# Các phiên bản

Chúng tôi phát hành bốn phiên bản của Zerobase để đáp ứng nhu cầu đa dạng của cộng đồng maker và học viên, với các tính năng phong phú và mức giá linh hoạt. Mỗi phiên bản được thiết kế để phục vụ các mục đích khác nhau, từ người mới bắt đầu cho đến những người đam mê công nghệ chuyên sâu.

- **Zerobase**: Dành cho những người mới bắt đầu, yêu cầu một giải pháp vi điều khiển dễ sử dụng và giá thành thấp. Phiên bản này cung cấp tất cả các tính năng cơ bản của Zerobase, giúp người dùng nhanh chóng làm quen với việc lập trình và thực hiện các dự án đầu tiên.

- **Zerobase Core**: Với hình thức SMD (hàn dán), bạn có thể hàn Zerobase Core lên các mạch DIY của bạn. Zerobase Core có kích thước siêu nhỏ phù hợp với những thiết bị có kích thước bé.

- **Zerobase 2**: Được tối ưu hóa với khả năng xử lý mạnh mẽ hơn, bộ nhớ mở rộng và nhiều tính năng bổ sung, phù hợp với những người yêu thích sáng tạo và cần hiệu suất cao hơn. Phiên bản này mang lại khả năng mở rộng linh hoạt, đáp ứng tốt hơn cho các dự án phức tạp. Zerobase 2 có tính tương thích cao với Arduino Nano.

- **Zerobase 2W**: Tương tự như Zerobase 2 nhưng được tích hợp thêm chip ESP8285 WiFi, mang lại khả năng kết nối không dây mạnh mẽ. Phiên bản này hoàn hảo cho các dự án IoT, cho phép điều khiển và giám sát từ xa thông qua kết nối WiFi. Zerobase 2W kết hợp sức mạnh xử lý của vi điều khiển RISC-V với tính năng WiFi linh hoạt.

![Các phiên bản Zerobase](https://cdn.chipstack.vn/zerobase-versions/zerobase_series.png)

## So sánh giữa các phiên bản
|           | Zerobase  | Zerobase Core | Zerobase 2 | Zerobase 2W |
|-----------|-----------|---------------|------------|-------------|
| MCU | CH32V003F4P6 | CH32V003F4P6 | CH32V203C8T6 | CH32V203C8T6 |
| WiFi Chip | :fas fa-times-square fa-fw red: | :fas fa-times-square fa-fw red: | :fas fa-times-square fa-fw red: | ESP8285 |
| CPU | RISC-V | RISC-V | RISC-V | RISC-V |
| Điện áp MCU | 5V | 5V | 3V3 | 3V3 |
| Xung nhịp | 48 MHz | 48 MHz | 144 MHz | 144 MHz |
| Bộ nhớ | 2 KB | 2 KB | 20 KB | 20 KB |
| Flash | 16 KB | 16 KB | 64 KB | 64 KB |
| Nguồn cấp | Qua USB, chân 5V | Qua USB, chân 5V | Qua USB, chân 5V | Qua USB, chân 5V |
| Điện áp IO | 5V | 5V | 3.3V | 3.3V |
| Dải nhiệt độ | -40C to 85C | -40C to 85C | -40C to 85C | -40C to 85C |
| Tương thích chân Arduino | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Kích thước | 43.18 mm x 17.78 mm | 24 mm x 14 mm | 43.18 mm x 17.78 mm | 43.18 mm x 17.78 mm |
| Kiểu chân | Through hole | Half hole | Through hole | Through hole |
| Tổng số chân | 30 | 16 | 30 | 30 |
| Số chân Digital | 15 | 13 | 22 | 22 |
| Số chân Analog | 4 | 4 | 6 | 6 | 
| Số chân PWM | TBD | TBD | TBD | TBD | 
| I2C | 1 | 1 | 2 | 2 | 
| SPI | 1 | 1 | 2 | 2 | 
| UART | 1 | 1 | 3 | 3 |
| USB | 0 | 0 | 2 | 2 |
| CAN | 0 | 0 | 1 | 1 |
| WiFi | :fas fa-times-square fa-fw red: | :fas fa-times-square fa-fw red: | :fas fa-times-square fa-fw red: | :fas fa-square-check fa-fw blue: |
| LDO | :fas fa-times-square fa-fw red: | :fas fa-times-square fa-fw red: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Cổng QWIIC | :fas fa-times-square fa-fw red: | :fas fa-times-square fa-fw red: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Arduino IDE | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Bootloader | Soft | Soft | Hard | Hard |
| Nút Boot | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Nút Reset | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| LED On-board | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Chân nối WCH-LinkE | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Giá thành | Siêu rẻ | Siêu rẻ | Rẻ | Hợp lý |