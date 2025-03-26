<br>
<br>
<br>

# Giao tiếp Serial Monitor bằng dây USB UART TTL PL2303HX

![uartttl-zerobase](../../../_media/uartttl-zerobase.jpg "uartttl-zerobase")

## Tổng quan

?> Bài viết này hướng dẫn cách giao tiếp với board Zerobase thông qua Serial Monitor bằng dây USB UART TTL.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |

<br>

<div align="center">
    <img src="../../../_media/zerobase-image.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<br>

<div align="center">
    <img src="../../../_media/usb-uart-PL2303HX.jpg" alt="usb-uart-PL2303HX">
    <p><em>Dây USB UART TTL PL2303HX</em></p>
</div>

<br>

<div align="center">
    <img src="../../../_media/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<div align="center">
    <img src="../../../_media/usb-type-c.jpg" alt="usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

<div align="center">
    <img src="../../../_media/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

## Nguyên lý hoạt động

Khi kết nối Zerobase với máy tính bằng USB UART TTL, bạn có thể xem dữ liệu từ board trên Serial Monitor và gửi lệnh từ máy tính để điều khiển Zerobase.

## Các chân kết nối

Sử dụng chân D1 (TX) kết nối với chân RX (màu trắng) của USB UART TTL và chân D0 (RX) kết nối với chân TX (màu xanh lá) của USB UART TTL.

Sử dụng chân GND của Zerobase kết nối với chân GND (màu đen) của USB UART TTL.

Sử dụng chân 5V của Zerobase kết nối với chân VCC (màu đỏ) của USB UART TTL.

## Sơ đồ kết nối

![uartttl-zerobase-connection](https://cdn.chipstack.vn/uart/uart-ttl/uartttl-connection-zerobase.png "uartttl-zerobase-connection")

## Cài đặt driver

Nếu bạn sử dụng PL2303, hãy cài đặt driver cho nó trước khi sử dụng.

Bạn vào link sau để tải driver: [PL2303 Driver](https://drive.google.com/drive/folders/133aIUo-5l22TIXZL1MJhJfVzBwmQy_dI)

![download-pl2303-driver](https://cdn.chipstack.vn/uart/uart-ttl/download-pl2303-driver.png "download-pl2303-driver")

Sau khi tải xong, bạn giải nén file ra.

Sau đó mở Device Manager.

![device-manager](https://cdn.chipstack.vn/uart/uart-ttl/device-manager.png "device-manager")

Chọn Port (COM & LPT) thì sẽ thấy hiển thị "PL2303XHA PHASED OUT SINCE 2012. PLEASE CONTACT YOUR SUPPLIER".

![port-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/port-pl2303.png "port-pl2303")

![pl2303-phase-out](https://cdn.chipstack.vn/uart/uart-ttl/pl2303-phase-out.png "pl2303-phase-out")


Nhấn chuột phải vào "PL2303XHA PHASED OUT SINCE 2012. PLEASE CONTACT YOUR SUPPLIER" và chọn Update driver.

![update-driver-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/update-driver-pl2303.png "update-driver-pl2303")

Chọn "Browse my computer for drivers".

![browse-computer-drivers-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/browse-computer-drivers-pl2303.png "browse-computer-drivers-pl2303")

Chọn "Let me pick from a list of available drivers on my computer".

![pick-driver-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/pick-driver-pl2303.png "pick-driver-pl2303")

Chọn "Have Disk...".

![have-disk-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/have-disk-pl2303.png "have-disk-pl2303")

Chọn "Browse...".

![browse-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/browse-pl2303.png "browse-pl2303")

Chọn đến thư mục chứa driver vừa giải nén, chọn file "ser2pl.inf" và nhấn Open.

![ser2pl-inf-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/ser2pl-inf-pl2303.png "ser2pl-inf-pl2303")

Chọn OK.

![ok-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/ok-pl2303.png "ok-pl2303")

Chọn "Prolific USB-to-Serial Comm Port" và nhấn Next.

![prolific-usb-to-serial-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/prolific-usb-to-serial-pl2303.png "prolific-usb-to-serial-pl2303")

Sau đó driver sẽ được cài đặt, sau khi cài đặt xong, bạn nhấn Close.

![close-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/close-pl2303.png "close-pl2303")

Bạn sẽ thấy hiển thị "Prolific USB-to-Serial Comm Port (COMX)" trong Device Manager, ở ví dụ này sẽ là "Prolific USB-to-Serial Comm Port (COM14)".

![com-pl2303](https://cdn.chipstack.vn/uart/uart-ttl/com-pl2303.png "com-pl2303")

Như vậy, bạn đã cài đặt driver cho PL2303 thành công.

## Code

Dưới đây là đoạn code mẫu để giao tiếp với Zerobase thông qua Serial Monitor:

```cpp
void setup() {
  Serial1.begin(9600);  // Khởi tạo cổng Serial1 với baudrate 9600
}

void loop() {
  if (Serial1.available() > 0) {           // Nếu có dữ liệu đến từ Serial1
    String data = Serial1.readString();    // Đọc toàn bộ chuỗi dữ liệu nhận được
    data.trim();                           // Xóa ký tự xuống dòng (\r, \n) được nhập từ bàn phím (Do khi nhấn Enter, sẽ có ký tự xuống dòng được gửi kèm theo)
    Serial1.println("Received: " + data);  // Phản hồi lại dữ liệu đã nhận được
  } else {
    Serial1.println("No data received!");  // Nếu không có dữ liệu, in ra thông báo
  }

  delay(1000);  // Chờ 1 giây trước khi thực hiện vòng lặp tiếp theo
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-zerobase-code](https://cdn.chipstack.vn/uart/uart-ttl/uartttl-zerobase-code.png "uartttl-zerobase-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/verify-code.png "verify-code]")

### Thực hiện Nạp Code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Sau khi nạp code thành công, chọn **Tools > Port > COMX (ở ví dụ này sẽ là COM14)** để chọn cổng COM tương ứng với USB UART TTL.

![select-com-port](https://cdn.chipstack.vn/uart/uart-ttl/select-com-port.png "select-com-port")

Sau đó, để mở Serial Monitor, chọn **Tools > Serial Monitor** hoặc nhấn tổ hợp phím `Ctrl + Shift + M`.

![open-serial-monitor](https://cdn.chipstack.vn/uart/uart-ttl/open-serial-monitor.png "open-serial-monitor")

Quan sát dữ liệu từ Serial Monitor, nếu bạn thấy hiển thị ký tự lạ như hình bên dưới:

![weird-characters-serial-monitor](https://cdn.chipstack.vn/uart/uart-ttl/weird-characters-serial-monitor.png "weird-characters-serial-monitor")

Bạn cần kiểm tra lại cài đặt baudrate của Serial Monitor, và chọn lại 9600 theo như trong code.

![uartttl-serial-monitor](https://cdn.chipstack.vn/uart/uart-ttl/uartttl-serial-monitor.png "uartttl-serial-monitor")

Nếu muốn thay đổi tốc độ baudrate, bạn chỉ cần sửa giá trị tham số trong hàm `Serial1.begin()` và chọn tốc độ baudrate tương ứng ở Serial Monitor.

```cpp
Serial1.begin(9600);  // Thay đổi 9600 thành giá trị khác để thay đổi tốc độ baudrate
```

## Giải Thích Code

Khai báo cổng Serial1 với baudrate 9600.

```cpp
void setup() {
  Serial1.begin(9600);  // Khởi tạo cổng Serial1 với baudrate 9600
}
```

Trong hàm `loop()`, kiểm tra xem có dữ liệu đến từ Serial1 không.

```cpp
  if (Serial1.available() > 0)          // Nếu có dữ liệu đến từ Serial1
```

Nếu có dữ liệu đến, đọc toàn bộ chuỗi dữ liệu nhận được được gửi từ Serial Monitor.

```cpp
    String data = Serial1.readString();  // Đọc toàn bộ chuỗi dữ liệu nhận được
```

Sau đó, chúng ta xóa ký tự xuống dòng (\r, \n) được nhập từ bàn phím (Do khi nhấn Enter, sẽ có ký tự xuống dòng được gửi kèm theo).

```cpp
    data.trim();                         // Xóa ký tự xuống dòng (\r, \n) được nhập từ bàn phím (Do khi nhấn Enter, sẽ có ký tự xuống dòng được gửi kèm theo)
```

Phản hồi lại dữ liệu đã nhận được.

```cpp
    Serial1.println("Received: " + data);  // Phản hồi lại dữ liệu đã nhận được
```

Nếu không có dữ liệu, in ra thông báo.

```cpp
  } else {
    Serial1.println("No data received!");  // Nếu không có dữ liệu, in ra thông báo
  }
```

Cuối cùng, chờ 1 giây trước khi thực hiện vòng lặp tiếp theo.

```cpp
  delay(1000);  // Chờ 1 giây trước khi thực hiện vòng lặp tiếp theo
```

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ thấy dữ liệu từ Serial Monitor như hình dưới.

Nhập `Hello Zerobase!` từ Serial Monitor.

![uartttl-serial-monitor-result](https://cdn.chipstack.vn/uart/uart-ttl/uartttl-serial-monitor-result.png "uartttl-serial-monitor-result")

Bạn sẽ thấy dữ liệu `Received: Hello Zerobase!` được phản hồi lại từ Zerobase.

![uartttl-serial-monitor-result-2](https://cdn.chipstack.vn/uart/uart-ttl/uartttl-serial-monitor-result-2.png "uartttl-serial-monitor-result-2")

## Kết luận và Hướng phát triển

Bài viết đã hướng dẫn cách giao tiếp với board Zerobase thông qua Serial Monitor bằng dây USB UART TTL PL2303HX.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Điều khiển LED từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt LED hoặc thay đổi tốc độ nháy.
- **Điều khiển Servo từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển góc quay của Servo.
- **Điều khiển Motor DC từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển tốc độ quay của Motor DC.
- **Điều khiển Relay từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt Relay.
- **Điều khiển RGB LED từ Serial Monitor:** Nhập giá trị từ Serial Monitor để thay đổi màu sắc của RGB LED.

Những ý tưởng này sẽ giúp bạn mở rộng hiểu biết về lập trình vi điều khiển và ứng dụng thực tế trong các dự án IoT. Hãy thử nghiệm và sáng tạo với Zerobase!

**Chúc bạn thành công!**





