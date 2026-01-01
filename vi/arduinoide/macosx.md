<br>
<br>
<br>

# Cài đặt Arduino IDE trên Mac OS X

**Bước 1** Tải phần mềm Arduino IDE tại https://www.arduino.cc/en/software/ 
<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/install-arduino-ide/arduino-ide-macosx-download.png" alt="Tải Arduino IDE cho Mac OS X">
    <p>Tải Arduino IDE cho Mac OS X.
</div>

**Bước 2** Để cài đặt Arduino IDE 2.x trên máy tính macOS, chỉ cần sao chép tệp đã tải xuống vào thư mục ứng dụng của bạn. Giờ đây bạn đã có thể sử dụng Arduino IDE 2 trên máy tính macOS của mình!
<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/install-arduino-ide/macosx-installing.png" alt="Sao chép tệp đã tải xuống vào thư mục ứng dụng của bạn">
</div>

**Bước 3** Cần đảm bảo đã cài đặt libusb
```sh
brew install libusb
```

**Một số lưu ý khi biên dịch (compile) và nạp (upload)**

!> Đối với Zerobase 2 và Zerobase 2W khi muốn in ra Serial Monitor dùng thư viện **ZBPrint** thì chọn thêm **Tools > USB Support > Adafruit TinyUSB with USBD**. Cổng Serial mà Zerobase 2 và Zerobase 2W taoj ra trên Windows sẽ có dạng `/dev/cu.usb-modemx` (Xem ở **Tools > Port > /dev/cu.usb-modemx**). Bạn cần bật **Tools > Serial Monitor** để xem dữ liệu từ cổng Serial

!> Đối với Zerobase 2W khi dùng WiFi thì cài thêm thư viện **WifiEspAT**. Vào **Tools > Manage Libraries** để cài thêm thư viện đó.


