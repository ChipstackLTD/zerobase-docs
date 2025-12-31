<br>
<br>
<br>

# Roadmap - Lộ trình phát triển

Danh sách tính năng cần phát triển
- [ ] Tối ưu dung lượng flash
- [ ] Zerobase cần phát triển những tính năng sau:
    - [ ] Sau khi compile và upload code xong, Arduino IDE chủ động reset Zerobase về user code
    - [ ] Trên Zerobase đang không dùng được Serial qua cổng USB trên mạch, do đó cần:
        - [ ] Porting USB stack CDC/HID lên Zerobase.
        - [ ] Viết USB driver mới trên Windows thay cho driver USBSER. Driver mới này có thể nhận dạng được USB CDC.
        - [ ] Viết phần mềm logging thay cho Arduino Serial Monitor trong trường hợp dùng USB HID (nếu không thực hiện được USB CDC)
- [ ] Zerobase 2 cần phát triển những tính năng sau:
    - [ ] Đưa ra thư viện hỗ trợ các ngoại vi sau
        - [ ] USBFS
        - [ ] CAN
        - [ ] USART2 với chức năng đồng bộ (có sử dụng clock)
- [ ] Kiểm tra tính tương tích với các thư viện mã nguồn mở đã có
