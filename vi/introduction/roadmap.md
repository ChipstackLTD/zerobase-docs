<br>
<br>
<br>

# Roadmap - Lộ trình phát triển

Danh sách tính năng cần phát triển
- [ ] Hỗ trợ lập trình Arduino IDE trên Linux và MacOS
- [ ] Tối ưu dung lượng trên Zerobase và Zerobase Core
- [ ] Trên Zerobase và Zerobase Core đang không dùng được Serial qua cổng USB trên mạch, do đó cần:
    - [ ] Porting USB stack CDC/HID lên Zerobase và Zerobase Core
    - [ ] Viết USB driver mới trên Windows thay cho driver USBSER. Driver mới này có thể nhận dạng đc USB CDC
    - [ ] Viết phần mềm logging thay cho Arduino Serial Monitor trong trường hợp dùng USB HID (nếu không thực hiện được USB CDC)
- [ ] Kiểm tra full tính năng trên tất cả phần cứng và đưa ra thư viện hỗ trợ