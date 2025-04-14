<br>
<br>
<br>

# Hiển thị giá trị ADC từ biến trở lên Serial Monitor

![uartttl-pot-circuit](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uuartttl-pot-circuit.jpg "uartttl-zerobase2-connection")

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách hiển thị giá trị ADC từ biến trở lên Serial Monitor.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2| [Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Biến trở 10K | [Mua ngay](https://chipstack.vn/san-pham/bien-tro-10k/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
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

?> Khi bạn xoay biến trở, giá trị điện áp đầu ra của biến trở sẽ thay đổi. Giá trị điện áp này sẽ được đọc bởi chân ADC của board Zerobase 2. Sau đó, giá trị ADC sẽ được gửi đến Serial Monitor.

## Sơ đồ kết nối

![zerobase2-uartttl-pot-pins](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/zerobase2-uartttl-pot-pins.png "zerobase2-uartttl-pot-pins")

Sử dụng chân A3 để kết nối với chân giữa của biến trở, một chân của biến trở nối với nguồn 3.3V và chân còn lại nối với GND của board Zerobase 2.

![uartttl-pot-schematic](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uartttl-pot-schematic.png "uartttl-pot-schematic")

![uartttl-pot-circuit](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uuartttl-pot-circuit.jpg "uartttl-zerobase2-connection")

## Code

```cpp
#include <Adafruit_TinyUSB.h>
// Khai báo hằng số adcPin là chân A3 để sử dụng cho việc đọc giá trị analog (ADC)
const int adcPin = A3;  // Chân analog để đọc ADC

// Hàm setup() chỉ chạy một lần khi vi điều khiển khởi động hoặc reset
void setup() {
  // Khởi tạo giao tiếp Serial với tốc độ truyền là 9600 baud
  Serial.begin(9600);
}

// Hàm loop() chạy lặp liên tục sau khi setup() hoàn tất
void loop() {
  // Đọc giá trị điện áp analog tại chân adcPin (A3)
  // Kết quả trả về là một số nguyên từ 0 đến 4095 (đối với độ phân giải 12 bit)
  int adcValue = analogRead(adcPin);

  // Gửi chuỗi "ADC Value: " qua cổng Serial để gợi ý tên giá trị đang được gửi
  Serial.print("ADC Value: ");

  // Gửi giá trị adcValue vừa đọc được, kèm ký tự xuống dòng (println tự động thêm '\n')
  Serial.println(adcValue);

  // Dừng chương trình trong 500 mili giây trước khi thực hiện vòng lặp tiếp theo
  // Giúp tránh việc gửi dữ liệu quá nhanh gây quá tải hoặc khó đọc trên terminal
  delay(500);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-pot-code](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uartttl-pot-code.png "uartttl-pot-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện Nạp Code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Sau khi nạp code thành công, chọn **Tools > Port > COMX** để chọn cổng COM tương ứng.

![select-com-port](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/select-com-port.png "select-com-port")

Sau đó, để mở Serial Monitor, chọn **Tools > Serial Monitor** hoặc nhấn tổ hợp phím `Ctrl + Shift + M`.

![open-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/open-serial-monitor.png "open-serial-monitor")

Quan sát dữ liệu từ Serial Monitor, nếu bạn thấy hiển thị ký tự lạ như hình bên dưới:

![weird-characters-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/weird-characters-serial-monitor.png "weird-characters-serial-monitor")

Bạn cần kiểm tra lại cài đặt baudrate của Serial Monitor, và chọn lại 9600 theo như trong code.

![uartttl-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-serial-monitor.png "uartttl-serial-monitor")

Nếu muốn thay đổi tốc độ baudrate, bạn chỉ cần sửa giá trị tham số trong hàm `Serial.begin()` và chọn tốc độ baudrate tương ứng ở Serial Monitor.

```cpp
Serial.begin(9600);  // Thay đổi 9600 thành giá trị khác để thay đổi tốc độ baudrate
```

Nếu bạn muốn thay đổi chân ADC, bạn chỉ cần thay đổi giá trị của biến `adcPin` trong code.

```cpp
const int adcPin = A3;  // Thay đổi A3 thành chân ADC khác nếu cần
```

### Giải thích code

Khai báo thư viện `Adafruit_TinyUSB.h` để sử dụng giao thức USB cho việc truyền dữ liệu qua Serial.

```cpp
#include <Adafruit_TinyUSB.h>  // Thư viện hỗ trợ giao thức USB cho việc truyền dữ liệu qua Serial
```

Khai báo hằng số `adcPin` là chân A3 để sử dụng cho việc đọc giá trị analog (ADC).

```cpp
const int adcPin = A3;  // Chân analog để đọc ADC
```

Hàm `setup()` chỉ chạy một lần khi vi điều khiển khởi động hoặc reset. Trong hàm này, chúng ta khởi tạo giao tiếp Serial với tốc độ truyền là 9600 baud.

```cpp
void setup() {
  Serial.begin(9600);
}
```

Hàm `loop()` chạy lặp liên tục sau khi `setup()` hoàn tất. Trong hàm này, chúng ta đọc giá trị điện áp analog tại chân `adcPin` (A3).

```cpp
void loop() {
  int adcValue = analogRead(adcPin);  // Đọc giá trị ADC từ chân A3
```

Sau đó, chúng ta gửi chuỗi "ADC Value: " qua cổng Serial để gợi ý tên giá trị đang được gửi, và gửi giá trị `adcValue` vừa đọc được, kèm ký tự xuống dòng (println tự động thêm '\n').

```cpp
  Serial.print("ADC Value: ");  // Gửi chuỗi "ADC Value: "
  Serial.println(adcValue);  // Gửi giá trị adcValue
```

Dừng chương trình trong 500 mili giây trước khi thực hiện vòng lặp tiếp theo

```cpp
  delay(500);  // Dừng chương trình trong 500 mili giây
}
```

## Kết quả

?> Khi bạn xoay biến trở, giá trị ADC sẽ thay đổi và được hiển thị trên Serial Monitor. Bạn có thể quan sát giá trị ADC thay đổi theo giá trị điện áp đầu ra của biến trở.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uartttl-pot-serial-monitor-result.gif" alt="uartttl-pot-serial-monitor-result">
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách hiển thị giá trị ADC từ biến trở lên Serial Monitor bằng cách sử dụng UART TTL. Bạn có thể áp dụng kiến thức này để thực hiện các dự án khác liên quan đến việc đọc giá trị analog và truyền dữ liệu qua giao thức UART.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Điều khiển LED từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt LED hoặc thay đổi tốc độ nháy.
- **Điều khiển Servo từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển góc quay của Servo.
- **Điều khiển Motor DC từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển tốc độ quay của Motor DC.
- **Điều khiển Relay từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt Relay.
- **Điều khiển RGB LED từ Serial Monitor:** Nhập giá trị từ Serial Monitor để thay đổi màu sắc của RGB LED.

Những ý tưởng này sẽ giúp bạn mở rộng hiểu biết về lập trình vi điều khiển và ứng dụng thực tế trong các dự án IoT. Hãy thử nghiệm và sáng tạo với Zerobase 2!

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)
