<br>
<br>
<br>

# Phần mềm

## Phần mềm lập trình

Các phần mềm được sử dụng khi lập trình Zerobase bao gồm
- [Arduino IDE](https://www.arduino.cc/en/software). Hiện Zerobase đang hỗ trợ lập trình bằng Arduino IDE trên Windows. Các hệ điều hành khác sẽ được hỗ trợ trong thời gian đến. Xem thêm lộ trình phát triển ([roadmap](vi/introduction/roadmap.md)) của Zerobase 
- Driver USBSER: dành cho Zerobase và Zerobase Core
- Các driver UART-to-USB: PL2303HX/CH340/CP2102/TFDI để nối cổng Serial (UART) của Zerobase đến máy tính
- Phần mềm Zadig để cài USB driver cho Zerobase 2

## Mã nguồn mở

- [Zerobase Arduino Core](https://github.com/ChipstackLTD/Zerobase)
- [Arduino Board Manager JSON file](https://github.com/ChipstackLTD/zerobase-board-manager)
- [Zerobase Documentation](https://github.com/ChipstackLTD/zerobase-docs)
- [Zerobase Uploader](https://github.com/ChipstackLTD/zerobase-minichlink)
- [Zerobase 2 Uploader](https://github.com/ChipstackLTD/zerobase-wchisp)

## Mã nguồn đóng

Vì `CH32V003F4P6` không hỗ trợ phần cứng USB nên Chipstack đang phát triển **USB Bootloader** riêng cho Zerobase để giúp nạp binary từ Arduino IDE. Mã nguồn cho USB Bootloader của Zerobase đang là mã nguồn đóng sở hữu bởi Chipstack Ltd. Mọi phần cứng Zerobase và Zerobase Core đều được nạp USB Bootloader trước khi bán ra.

!> Nếu không được nạp USB Bootloader thích hợp, Zerobase hoặc Zerobase Core sẽ không nạp được binary từ Arduino IDE