<br>
<br>
<br>

# Hiển thị giá trị ADC từ biến trở lên Serial Monitor

![uartttl-pot-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uuartttl-pot-circuit.png "uartttl-zerobase-connection")

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách hiển thị giá trị ADC từ biến trở lên Serial Monitor bằng cách sử dụng UART TTL.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Biến trở 10K | [Mua ngay](https://chipstack.vn/san-pham/bien-tro-10k/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/PL2303HX.png" alt="usb-uart-ttl">
    <p><em>Dây USB UART TTL PL2303HX</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg">
    <p><em>Dây USB Type C</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/potentiometer/potentiometer.jpg" alt="potentiometer">
    <p><em>Biến trở 10kΩ</em></p>
</div>

## Nguyên lý hoạt động

Khi bạn xoay biến trở, giá trị điện áp đầu ra của biến trở sẽ thay đổi. Giá trị điện áp này sẽ được đọc bởi chân ADC của board Zerobase. Sau đó, giá trị ADC sẽ được gửi đến Serial Monitor thông qua giao thức UART TTL.

## Sơ đồ kết nối

![zerobase-uartttl-pot-pins](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-pot-pins.png "zerobase-uartttl-pot-pins")

Sử dụng chân A3 để kết nối với chân giữa của biến trở, một chân của biến trở nối với nguồn 5V và chân còn lại nối với GND của board Zerobase.

Sử dụng chân D1 (TX) kết nối với chân RX (màu trắng) của USB UART TTL và chân D0 (RX) kết nối với chân TX (màu xanh lá) của USB UART TTL.

Sử dụng chân GND của Zerobase kết nối với chân GND (màu đen) của USB UART TTL.

Sử dụng chân 5V của Zerobase kết nối với chân VCC (màu đỏ) của USB UART TTL.

![uartttl-pot-schematic](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-pot-schematic.png "uartttl-pot-schematic")

![uartttl-pot-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-pot-circuit.png "uartttl-pot-circuit")

## Cài đặt driver USB UART TTL

> Nếu bạn chưa biết cách Giao tiếp Serial Monitor bằng dây USB UART TTL PL2303HX trên board Zerobase và chưa biết cách cài đặt driver, hãy tham khảo bài viết [tại đây](vi/zerobase/examples/uartttl.md).

## Code

```cpp
// Khai báo hằng số adcPin là chân A3 để sử dụng cho việc đọc giá trị analog (ADC)
const int adcPin = A3;  // Chân analog để đọc ADC

// Hàm setup() chỉ chạy một lần khi vi điều khiển khởi động hoặc reset
void setup() {
  // Khởi tạo giao tiếp Serial1 với tốc độ truyền là 9600 baud
  Serial1.begin(9600);
}

// Hàm loop() chạy lặp liên tục sau khi setup() hoàn tất
void loop() {
  // Đọc giá trị điện áp analog tại chân adcPin (A3)
  // Kết quả trả về là một số nguyên từ 0 đến 1023 (đối với độ phân giải 10 bit)
  int adcValue = analogRead(adcPin);

  // Gửi chuỗi "ADC Value: " qua cổng Serial1 để gợi ý tên giá trị đang được gửi
  Serial1.print("ADC Value: ");

  // Gửi giá trị adcValue vừa đọc được, kèm ký tự xuống dòng (println tự động thêm '\n')
  Serial1.println(adcValue);

  // Dừng chương trình trong 500 mili giây trước khi thực hiện vòng lặp tiếp theo
  // Giúp tránh việc gửi dữ liệu quá nhanh gây quá tải hoặc khó đọc trên terminal
  delay(500);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-pot-code](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-pot-code.png "uartttl-pot-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện Nạp Code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Sau khi nạp code thành công, chọn **Tools > Port > COMX (ở ví dụ này sẽ là COM14)** để chọn cổng COM tương ứng với USB UART TTL.

![select-com-port](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/select-com-port.png "select-com-port")

Sau đó, để mở Serial Monitor, chọn **Tools > Serial Monitor** hoặc nhấn tổ hợp phím `Ctrl + Shift + M`.

![open-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/open-serial-monitor.png "open-serial-monitor")

Quan sát dữ liệu từ Serial Monitor, nếu bạn thấy hiển thị ký tự lạ như hình bên dưới:

![weird-characters-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/weird-characters-serial-monitor.png "weird-characters-serial-monitor")

Bạn cần kiểm tra lại cài đặt baudrate của Serial Monitor, và chọn lại 9600 theo như trong code.

![uartttl-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-serial-monitor.png "uartttl-serial-monitor")

Nếu muốn thay đổi tốc độ baudrate, bạn chỉ cần sửa giá trị tham số trong hàm `Serial1.begin()` và chọn tốc độ baudrate tương ứng ở Serial Monitor.

```cpp
Serial1.begin(9600);  // Thay đổi 9600 thành giá trị khác để thay đổi tốc độ baudrate
```

Nếu bạn muốn thay đổi chân ADC, bạn chỉ cần thay đổi giá trị của biến `adcPin` trong code.

```cpp
const int adcPin = A3;  // Thay đổi A3 thành chân ADC khác nếu cần
```

### Giải thích code

Khai báo hằng số `adcPin` là chân A3 để sử dụng cho việc đọc giá trị analog (ADC).

```cpp
const int adcPin = A3;  // Chân analog để đọc ADC
```

Hàm `setup()` chỉ chạy một lần khi vi điều khiển khởi động hoặc reset. Trong hàm này, chúng ta khởi tạo giao tiếp Serial1 với tốc độ truyền là 9600 baud.

```cpp
void setup() {
  Serial1.begin(9600);
}
```

Hàm `loop()` chạy lặp liên tục sau khi `setup()` hoàn tất. Trong hàm này, chúng ta đọc giá trị điện áp analog tại chân `adcPin` (A3).

```cpp
void loop() {
  int adcValue = analogRead(adcPin);  // Đọc giá trị ADC từ chân A3
```

Sau đó, chúng ta gửi chuỗi "ADC Value: " qua cổng Serial1 để gợi ý tên giá trị đang được gửi, và gửi giá trị `adcValue` vừa đọc được, kèm ký tự xuống dòng (println tự động thêm '\n').

```cpp
  Serial1.print("ADC Value: ");  // Gửi chuỗi "ADC Value: "
  Serial1.println(adcValue);  // Gửi giá trị adcValue
```

Dừng chương trình trong 500 mili giây trước khi thực hiện vòng lặp tiếp theo

```cpp
  delay(500);  // Dừng chương trình trong 500 mili giây
}
```

## Kết quả

?> Khi bạn xoay biến trở, giá trị ADC sẽ thay đổi và được hiển thị trên Serial Monitor. Bạn có thể quan sát giá trị ADC thay đổi theo giá trị điện áp đầu ra của biến trở.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-pot-serial-monitor-result.gif" alt="uartttl-pot-serial-monitor-result">

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách hiển thị giá trị ADC từ biến trở lên Serial Monitor bằng cách sử dụng UART TTL. Bạn có thể áp dụng kiến thức này để thực hiện các dự án khác liên quan đến việc đọc giá trị analog và truyền dữ liệu qua giao thức UART.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Điều khiển LED từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt LED hoặc thay đổi tốc độ nháy.
- **Điều khiển Servo từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển góc quay của Servo.
- **Điều khiển Motor DC từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển tốc độ quay của Motor DC.
- **Điều khiển Relay từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt Relay.
- **Điều khiển RGB LED từ Serial Monitor:** Nhập giá trị từ Serial Monitor để thay đổi màu sắc của RGB LED.

Những ý tưởng này sẽ giúp bạn mở rộng hiểu biết về lập trình vi điều khiển và ứng dụng thực tế trong các dự án IoT. Hãy thử nghiệm và sáng tạo với Zerobase!

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)
