<br>
<br>
<br>

# Cài đặt Arduino IDE trên Linux

?> Bạn cần có kiến thức về Linux. Hướng dẫn sau được thực hiện trên Ubuntu


**Bước 1** Tải phần mềm Arduino IDE tại https://www.arduino.cc/en/software/ 
<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/install-arduino-ide/arduino-ide-linux-download.png" alt="Tải Arduino IDE cho Linux">
    <p>Tải Arduino IDE cho Linux.
</div>

**Bước 2** Cần đảm bảo đã cài đặt FUSE
```sh
sudo add-apt-repository universe
sudo apt install libfuse2
```

**Bước 3** Tải script tại [đây](https://github.com/ChipstackLTD/zerobase-beforeinstall) để cài đặt các dependency
```sh
sudo start.sh
```

**Bước 4** Cho phép Arduino IDE truy cập usb.
```sh
sudo usermod -a -G dialout <your_linux_username>
```
Sau đó tắt máy khởi động lại.

**Bước 5** Chạy AppImage.
```sh
chmox +x arduino-ide_2.3.7_Linux_64bit.AppImage
./arduino-ide_2.3.7_Linux_64bit.AppImage
```

**Một số lưu ý khi biên dịch (compile) và nạp (upload)**

!> Đối với Zerobase 2 và Zerobase 2W khi muốn in ra Serial Monitor dùng thư viện **ZBPrint** thì chọn thêm **Tools > USB Support > Adafruit TinyUSB with USBD**. Cổng Serial mà Zerobase 2 và Zerobase 2W taoj ra trên Windows sẽ có dạng `ttyUSBx` hoặc `ttyACMx` (Xem ở **Tools > Port > ttyUSBx hoặc ttyACMx**). Bạn cần bật **Tools > Serial Monitor** để xem dữ liệu từ cổng Serial.

!> Đối với Zerobase 2W khi dùng WiFi thì cài thêm thư viện **WifiEspAT**


