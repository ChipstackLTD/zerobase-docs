<br>
<br>
<br>

# Điều khiển LED qua Serial Monitor

![uartttl-led-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-led-circuit.png "uartttl-led-circuit")

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển LED qua Serial Monitor bằng cách sử dụng UART TTL.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| LED 5mm | [Mua ngay](https://chipstack.vn/san-pham/led-5mm/) |
| Điện trở 330Ω |[Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |

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
    <img src="https://cdn.chipstack.vn/default/dien-tro-330-ohm.png" alt="dien-tro-330-ohm">
    <p><em>Điện trở 330Ω</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/led-do.png" alt="led-do">
    <p><em>LED</em></p>
</div>

## Nguyên lý hoạt động

?> Bài hướng dẫn này điều khiển 5 đèn LED thông qua cổng Serial1 bằng cách gửi lệnh từ Serial Monitor. Các chân D2, D3, D10, D11 và D12 được khai báo và cấu hình làm đầu ra để điều khiển LED.

?> Các lệnh sử dụng trong bài viết này: `ON <pin>`, `OFF <pin>`, `ON ALL`, `OFF ALL`. Trong đó `<pin>` là chân điều khiển (2, 3, 10, 11 hoặc 12).

?> Chương trình liên tục đọc dữ liệu từ Serial1 và ghép các ký tự thành chuỗi lệnh hoàn chỉnh. Khi nhận được chuỗi kết thúc bằng dấu xuống dòng `\n`, lệnh sẽ được xử lý. Tùy theo nội dung lệnh (`ON`, `OFF`, `ALL` hoặc số chân), chương trình sẽ bật hoặc tắt LED tương ứng. Nếu lệnh không hợp lệ hoặc chân không đúng, chương trình sẽ gửi phản hồi lỗi qua Serial1.

## Sơ đồ kết nối

![zerobase-uartttl-led-pins](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-led-pins.png "zerobase-uartttl-led-pins")

Sử dụng chân D2, D3, D10, D11 và D12 để kết nối với cực (+) của LED. Chân GND của LED được nối với 1 chân của điện trở 330Ω, chân còn lại của điện trở nối với GND của board Zerobase.

Sử dụng chân D1 (TX) kết nối với chân RX (màu trắng) của USB UART TTL và chân D0 (RX) kết nối với chân TX (màu xanh lá) của USB UART TTL.

Sử dụng chân GND của Zerobase kết nối với chân GND (màu đen) của USB UART TTL.

Sử dụng chân 5V của Zerobase kết nối với chân VCC (màu đỏ) của USB UART TTL.

![uartttl-led-schematic](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-led-schematic.png "uartttl-led-schematic")

![uartttl-led-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-led-circuit.png "uartttl-led-circuit")

## Cài đặt driver USB UART TTL

> Nếu bạn chưa biết cách Giao tiếp Serial Monitor bằng dây USB UART TTL PL2303HX trên board Zerobase và chưa biết cách cài đặt driver, hãy tham khảo bài viết [tại đây](vi/zerobase/examples/uartttl.md).

## Code

```cpp
// Khai báo các chân LED
const int ledPins[] = { 2, 3, 10, 11, 12 };  // Mảng chứa các chân LED: D2, D3, D10, D11, D12

const int ledCount = sizeof(ledPins) / sizeof(ledPins[0]);  // Tính số lượng LED dựa trên kích thước mảng

String inputString = "";  // Biến lưu chuỗi lệnh nhận được từ Serial1

void setup() {
  // Thiết lập các chân LED là OUTPUT và tắt LED ban đầu
  for (int i = 0; i < ledCount; i++) {
    pinMode(ledPins[i], OUTPUT);    // Cấu hình chân LED là OUTPUT
    digitalWrite(ledPins[i], LOW);  // Tắt LED ở trạng thái ban đầu
  }

  Serial1.begin(9600);  // Khởi động giao tiếp Serial1 với baudrate 9600
}

void loop() {
  // Nếu có dữ liệu từ Serial1 thì đọc và xử lý
  while (Serial1.available()) {
    char c = Serial1.read();  // Đọc từng ký tự từ Serial1

    if (c == '\n') {               // Nếu gặp ký tự xuống dòng '\n', bắt đầu xử lý lệnh
      handleCommand(inputString);  // Gọi hàm xử lý lệnh
      inputString = "";            // Xoá chuỗi sau khi xử lý xong
    } else if (c != '\r') {        // Bỏ qua ký tự carriage return '\r'
      inputString += c;            // Thêm ký tự vào chuỗi lệnh
    }
  }
}

// Hàm xử lý lệnh điều khiển từ Serial1
void handleCommand(String cmd) {
  cmd.trim();         // Xoá khoảng trắng đầu/cuối chuỗi lệnh
  cmd.toUpperCase();  // Chuyển lệnh sang chữ hoa để xử lý dễ hơn

  if (cmd == "ON ALL") {
    // Bật tất cả LED
    for (int i = 0; i < ledCount; i++) {
      digitalWrite(ledPins[i], HIGH);  // Bật từng LED
    }
    Serial1.println("All LEDs ON");  // Phản hồi qua Serial1
  } else if (cmd == "OFF ALL") {
    // Tắt tất cả LED
    for (int i = 0; i < ledCount; i++) {
      digitalWrite(ledPins[i], LOW);  // Tắt từng LED
    }
    Serial1.println("All LEDs OFF");  // Phản hồi qua Serial1
  } else if (cmd.startsWith("ON ")) {
    // Bật LED theo số chân
    int pin = cmd.substring(3).toInt();  // Lấy phần số sau "ON "
    setLed(pin, true);                   // Gọi hàm bật LED tương ứng
  } else if (cmd.startsWith("OFF ")) {
    // Tắt LED theo số chân
    int pin = cmd.substring(4).toInt();  // Lấy phần số sau "OFF "
    setLed(pin, false);                  // Gọi hàm tắt LED tương ứng
  } else {
    // Nếu lệnh không hợp lệ
    Serial1.println("Invalid command");  // Thông báo lỗi
  }
}

// Hàm bật/tắt LED theo số chân cụ thể
void setLed(int pin, bool state) {
  for (int i = 0; i < ledCount; i++) {
    if (ledPins[i] == pin) {
      digitalWrite(pin, state ? HIGH : LOW);  // Bật hoặc tắt LED tuỳ theo trạng thái

      Serial1.print("LED on D");                // Phản hồi chân LED
      Serial1.print(pin);                       //
      Serial1.println(state ? " ON" : " OFF");  // Phản hồi trạng thái

      return;  // Thoát khỏi hàm sau khi xử lý xong
    }
  }

  // Nếu không tìm thấy chân LED hợp lệ
  Serial1.println("Invalid pin");  // Thông báo lỗi
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-led-code](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-led-code.png "uartttl-led-code")

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

Nếu bạn muốn thay đổi chân LED, bạn chỉ cần thay đổi giá trị của biến `ledPins` trong code.

```cpp
const int ledPins[] = { 2, 3, 10, 11, 12 };  // Mảng chứa các chân LED: D2, D3, D10, D11, D12
```

### Giải thích code

Khai báo các chân LED trong mảng `ledPins` với các giá trị là 2, 3, 10, 11 và 12. Mỗi giá trị trong mảng này tương ứng với một chân trên board Zerobase mà bạn đã kết nối với LED.

```cpp
const int ledPins[] = { 2, 3, 10, 11, 12 };  // Mảng chứa các chân LED: D2, D3, D10, D11, D12
```

Tính số lượng LED dựa trên kích thước của mảng `ledPins` và lưu vào biến `ledCount`.

```cpp
const int ledCount = sizeof(ledPins) / sizeof(ledPins[0]);  // Tính số lượng LED dựa trên kích thước mảng
```

Khai báo biến inputString để lưu chuỗi lệnh nhận được từ Serial1.

```cpp
String inputString = "";  // Biến lưu chuỗi lệnh nhận được từ Serial1
```

Trong hàm `setup()`, chúng ta sẽ thiết lập các chân LED là đầu ra và tắt tất cả LED ban đầu.

```cpp
void setup() {
  // Thiết lập các chân LED là OUTPUT và tắt LED ban đầu
  for (int i = 0; i < ledCount; i++) {
    pinMode(ledPins[i], OUTPUT);    // Cấu hình chân LED là OUTPUT
    digitalWrite(ledPins[i], LOW);  // Tắt LED ở trạng thái ban đầu
  }

  Serial1.begin(9600);  // Khởi động giao tiếp Serial1 với baudrate 9600
}
```

Trong hàm `loop()`, chúng ta sẽ kiểm tra xem có dữ liệu nào từ Serial1 hay không. Nếu có, chúng ta sẽ đọc từng ký tự và thêm vào biến `inputString`. Khi gặp ký tự xuống dòng `\n`, chúng ta sẽ gọi hàm `handleCommand()` để xử lý lệnh. Ký tự carriage return `\r` sẽ bị bỏ qua.

```cpp
void loop() {
  while (Serial1.available()) {
    char c = Serial1.read();           // Đọc ký tự từ Serial1
    if (c == '\n') {                   // Nếu gặp ký tự kết thúc dòng
      handleCommand(inputString);     // Gọi hàm xử lý lệnh
      inputString = "";               // Reset chuỗi lệnh
    } else if (c != '\r') {           // Bỏ qua ký tự carriage return
      inputString += c;               // Thêm ký tự vào chuỗi
    }
  }
}
```

Hàm `handleCommand()` sẽ xử lý các lệnh nhận được từ Serial1.

Đầu tiên là loại bỏ khoảng trắng đầu/cuối chuỗi lệnh và chuyển đổi lệnh sang chữ hoa để dễ xử lý hơn.

Sau đó nếu lệnh là "ON ALL", chúng ta sẽ bật tất cả LED bằng cách lặp qua từng chân trong mảng `ledPins` và bật LED tương ứng. Khi hoàn tất, chúng ta sẽ thông báo qua Serial1 rằng tất cả LED đã được bật với thông điệp "All LEDs ON".

```cpp
if (cmd == "ON ALL") {
    // Bật tất cả LED
    for (int i = 0; i < ledCount; i++) {
      digitalWrite(ledPins[i], HIGH);  // Bật từng LED
    }
    Serial1.println("All LEDs ON");  // Phản hồi qua Serial1
  }
```

Nếu lệnh là "OFF ALL", chúng ta sẽ tắt tất cả LED bằng cách lặp qua từng chân trong mảng `ledPins` và tắt LED tương ứng. Khi hoàn tất, chúng ta sẽ thông báo qua Serial1 rằng tất cả LED đã được tắt với thông điệp "All LEDs OFF".

```cpp
else if (cmd == "OFF ALL") {
    // Tắt tất cả LED
    for (int i = 0; i < ledCount; i++) {
      digitalWrite(ledPins[i], LOW);  // Tắt từng LED
    }
    Serial1.println("All LEDs OFF");  // Phản hồi qua Serial1
  }
```

Nếu lệnh bắt đầu bằng "ON ", ta sẽ lấy phần số sau "ON " và chuyển đổi nó thành số nguyên. Sau đó gọi hàm `setLed()` để bật LED tương ứng với chân đã chỉ định.

Ví dụ như lệnh "ON 2" sẽ bật LED ở chân D2.

```cpp
else if (cmd.startsWith("ON ")) {
    // Bật LED theo số chân
    int pin = cmd.substring(3).toInt();  // Lấy phần số sau "ON "
    setLed(pin, true);                   // Gọi hàm bật LED tương ứng
  }
```

Nếu lệnh bắt đầu bằng "OFF ", ta sẽ lấy phần số sau "OFF " và chuyển đổi nó thành số nguyên. Sau đó gọi hàm `setLed()` để tắt LED tương ứng với chân đã chỉ định.
Ví dụ như lệnh "OFF 2" sẽ tắt LED ở chân D2.

```cpp
else if (cmd.startsWith("OFF ")) {
    // Tắt LED theo số chân
    int pin = cmd.substring(4).toInt();  // Lấy phần số sau "OFF "
    setLed(pin, false);                  // Gọi hàm tắt LED tương ứng
  }
```

Nếu lệnh không hợp lệ, chúng ta sẽ thông báo lỗi qua Serial1 với thông điệp "Invalid command".

```cpp
else {
    // Nếu lệnh không hợp lệ
    Serial1.println("Invalid command");  // Thông báo lỗi
  }
```

Hàm `setLed()` sẽ bật hoặc tắt LED theo số chân cụ thể. Nếu chân LED hợp lệ, chúng ta sẽ bật hoặc tắt LED tương ứng và thông báo qua Serial1 với thông điệp "LED on D" và chân điều khiển LED. Nếu chân không hợp lệ, chúng ta sẽ thông báo lỗi qua Serial1 với thông điệp "Invalid pin".

```cpp
void setLed(int pin, bool state) {
  for (int i = 0; i < ledCount; i++) {
    if (ledPins[i] == pin) {
      digitalWrite(pin, state ? HIGH : LOW); // Bật hoặc tắt LED

      Serial1.print("LED on D");
      Serial1.print(pin);
      Serial1.println(state ? " ON" : " OFF");
      return;
    }
  }

  Serial1.println("Invalid pin"); // Nếu không tìm thấy chân hợp lệ
}
```

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ điều khiển được LED qua Serial Monitor.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-led-result.gif" alt="uartttl-led-result">
    <p><em>Điều khiển LED qua Serial Monitor</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách điều khiển LED qua Serial Monitor bằng cách sử dụng UART TTL. Bạn có thể áp dụng kiến thức này để thực hiện các dự án khác liên quan đến việc điều khiển thiết bị ngoại vi qua giao thức UART.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- **Điều khiển Servo từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển góc quay của Servo.
- **Điều khiển Motor DC từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển tốc độ quay của Motor DC.
- **Điều khiển Relay từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt Relay.
- **Điều khiển RGB LED từ Serial Monitor:** Nhập giá trị từ Serial Monitor để thay đổi màu sắc của RGB LED.

**Chúc bạn thành công!**





