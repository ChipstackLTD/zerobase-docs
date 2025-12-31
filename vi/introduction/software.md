<br>
<br>
<br>

# Phần mềm

## Phần mềm lập trình

Các phần mềm được sử dụng khi lập trình Zerobase bao gồm
- [Arduino IDE](https://www.arduino.cc/en/software). Bạn nên sử dụng phiên bản Arduino IDE mới nhất. Các OS và kiến trúc host được hỗ trợ

| OS | Zerobase | Zerobase 2 | Zerobase 2W |
|---------|---------|-------|-------|
| Windows 10/11 (x64) | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| Linux (x64) | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |
| MacOSX (arm64) | :fas fa-times-square fa-fw red: | :fas fa-square-check fa-fw blue: | :fas fa-square-check fa-fw blue: |

- Các driver UART-to-USB: có thể là các driver PL2303HX/CH340/CP2102/TFDI UART-to-USB converter từ Zerobase đến máy tính.
- Phần mềm [Zadig](https://zadig.akeo.ie/): để cài USB driver cho Zerobase 2 và Zerobase 2W.

## Mã nguồn mở

- [Zerobase Arduino Core](https://github.com/ChipstackLTD/Zerobase)
- [Arduino Board Manager JSON file](https://github.com/ChipstackLTD/zerobase-board-manager)
- [Zerobase Documentation](https://github.com/ChipstackLTD/zerobase-docs)
- [Zerobase Uploader](https://github.com/ChipstackLTD/zerobase-minichlink)
- [Zerobase 2 & Zerobase 2W Uploader](https://github.com/ChipstackLTD/zerobase-wchisp)
- [Esptool ZB2W](https://cdn.chipstack.vn/zerobase2w/download-firmware/esptool_zb2w.zip)
- [ESP8285.bin](https://cdn.chipstack.vn/zerobase2w/download-firmware/ESP8285.bin)

## Mã nguồn đóng

Vì `CH32V003F4P6` không hỗ trợ phần cứng USB nên Chipstack phát triển **USB Bootloader** riêng cho Zerobase để giúp nạp binary từ Arduino IDE. Mã nguồn cho USB Bootloader của Zerobase đang là mã nguồn đóng sở hữu bởi [Chipstack Co., Ltd](https://chipstack.vn). Mọi phần cứng Zerobase đều được nạp USB Bootloader trước khi bán ra.

!> Nếu không được nạp USB Bootloader thích hợp, Zerobase sẽ không nạp được binary từ Arduino IDE