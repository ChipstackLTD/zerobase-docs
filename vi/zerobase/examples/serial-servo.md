<br>
<br>
<br>

# Điều khiển động cơ Servo qua Serial Monitor

![zerobase-uartttl-servo-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-servo-circuit.jpg "zerobase-uartttl-servo-circuit")

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ Servo qua Serial Monitor bằng cách sử dụng UART TTL.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Động cơ Servo SG90 180 độ | [Mua ngay](https://chipstack.vn/san-pham/dong-co-servo-sg90-180-do/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |

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
    <img src="https://cdn.chipstack.vn/default/module-nguon-cho-breadboard-mb102-830.jpg" alt="module-nguon-cho-breadboard-mb102-830">
    <p><em>Module nguồn cho Breadboard MB102 830</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w.jpg" alt="nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w">
    <p><em>Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/servo/dong-co-servo-sg90-180-do.jpg" alt="dong-co-servo-sg90-180-do">
    <p><em>Động cơ Servo SG90 180 độ</em></p>
</div>

## Nguyên lý hoạt động

?> Bài viết này điều khiển 2 động cơ từ Serial Monitor thông qua giao thức UART. Động cơ Servo sẽ nhận các lệnh này và thực hiện xoay theo góc mà bạn đã chỉ định.

?> Các lệnh sử dụng trong bài viết này: `S1 <angle>`, `S2 <angle>`, `ALL <angle>`. Trong đó, `<angle>` là góc mà bạn muốn động cơ Servo xoay đến. Ví dụ: `S1 90` sẽ làm động cơ Servo thứ nhất xoay đến góc 90 độ.

?> Chương trình liên tục đọc dữ liệu từ Serial1 và ghép các ký tự thành chuỗi lệnh hoàn chỉnh. Khi nhận được chuỗi kết thúc bằng dấu xuống dòng `\n`, lệnh sẽ được xử lý. Tùy theo nội dung lệnh (`S1 <angle>`, `S2 <angle>`, `ALL <angle>`) mà động cơ Servo sẽ được điều khiển tương ứng.

## Sơ đồ kết nối

![zerobase-uartttl-led-pins](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-servo-pins.png "zerobase-uartttl-servo-pins")

Sử dụng chân D2 kết nối đến chân màu cam của servo, chân D3 kết nối chân màu cam Servo 2. Chân màu đỏ của servo nối với 5V của module nguồn và chân màu nâu nối với GND của module nguồn MB102 830.

Sử dụng chân D1 (TX) kết nối với chân RX (màu trắng) của USB UART TTL và chân D0 (RX) kết nối với chân TX (màu xanh lá) của USB UART TTL.

Sử dụng chân GND của Zerobase kết nối với chân GND (màu đen) của USB UART TTL và GND của module nguồn MB102 830.

![uartttl-servo-schematic](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-servo-schematic.png "uartttl-servo-schematic")

![zerobase-uartttl-servo-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-servo-circuit.jpg "zerobase-uartttl-servo-circuit")

!> **Ngắt nguồn trước khi nạp code**: Trước khi cắm dây USB vào để nạp code vào board Zerobase, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase và chạy code bình thường.

!> **Không dùng nguồn 5V từ Zerobase cho Servo**: Bạn không nên sử dụng nguồn 5V từ board Zerobase để cấp cho động cơ Servo, vì dòng điện của động cơ Servo có thể vượt quá dòng điện mà board Zerobase có thể cung cấp. Do đó sử dụng nguồn 5V từ module nguồn MB102 830 để cấp cho động cơ Servo là lựa chọn tốt nhất.

!> **Module nguồn MB102 830 ở chế độ 5V**: Bạn cần đảm bảo module nguồn MB102 830 đang ở chế độ 5V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 5V.

## Cài đặt driver USB UART TTL

> Nếu bạn chưa biết cách Giao tiếp Serial Monitor bằng dây USB UART TTL PL2303HX trên board Zerobase và chưa biết cách cài đặt driver, hãy tham khảo bài viết [tại đây](vi/zerobase/examples/uartttl.md).

## Code

```cpp
#include "ZBServo.h"  // Thư viện điều khiển servo cho Zerobase

ZBServo servo1;  // Đối tượng điều khiển servo thứ nhất
ZBServo servo2;  // Đối tượng điều khiển servo thứ hai

// Khai báo chân tín hiệu servo
const int servoPin1 = 2;  // Servo 1 gắn vào chân D2
const int servoPin2 = 3;  // Servo 2 gắn vào chân D3

String inputString = "";  // Biến lưu dữ liệu lệnh nhận từ Serial1

void setup() {
  servo1.attach(servoPin1);  // Gắn servo1 với chân D2
  servo2.attach(servoPin2);  // Gắn servo2 với chân D3

  Serial1.begin(9600);             // Khởi động Serial1 ở baudrate 9600
  Serial1.println("Servo ready");  // Thông báo sẵn sàng
}

void loop() {
  // Kiểm tra nếu có dữ liệu từ Serial1
  while (Serial1.available()) {
    char c = Serial1.read();  // Đọc từng ký tự

    if (c == '\n') {               // Nếu gặp ký tự xuống dòng, bắt đầu xử lý lệnh
      handleCommand(inputString);  // Gọi hàm xử lý lệnh
      inputString = "";            // Xoá chuỗi sau khi xử lý xong
    } else if (c != '\r') {        // Bỏ qua ký tự carriage return
      inputString += c;            // Thêm ký tự vào chuỗi lệnh
    }
  }
}

// Hàm xử lý chuỗi lệnh từ Serial1
void handleCommand(String cmd) {
  cmd.trim();         // Xoá khoảng trắng đầu/cuối lệnh
  cmd.toUpperCase();  // Chuyển lệnh thành chữ hoa để dễ so sánh

  if (cmd.startsWith("S1 ")) {             // Lệnh điều khiển servo 1
    int angle = cmd.substring(3).toInt();  // Lấy góc quay từ lệnh
    angle = constrain(angle, 0, 180);      // Giới hạn góc từ 0 đến 180 độ
    servo1.write(angle);                   // Gửi lệnh quay cho servo 1
    Serial1.print("Servo 1: ");
    Serial1.println(angle);  // Phản hồi lại góc đã quay

  } else if (cmd.startsWith("S2 ")) {  // Lệnh điều khiển servo 2
    int angle = cmd.substring(3).toInt();
    angle = constrain(angle, 0, 180);
    servo2.write(angle);  // Gửi lệnh quay cho servo 2
    Serial1.print("Servo 2: ");
    Serial1.println(angle);

  } else if (cmd.startsWith("ALL ")) {  // Lệnh điều khiển cả hai servo
    int angle = cmd.substring(4).toInt();
    angle = constrain(angle, 0, 180);
    servo1.write(angle);  // Quay servo 1
    servo2.write(angle);  // Quay servo 2
    Serial1.print("All servos: ");
    Serial1.println(angle);

  } else {
    Serial1.println("Invalid command");  // Lệnh không hợp lệ
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-servo-code](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-servo-code.png "uartttl-servo-code")

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

Nếu bạn muốn thay đổi chân điều khiển servo, bạn chỉ cần thay đổi giá trị của biến `servoPin1` hoặc `servoPin2` trong code.

```cpp
const int servoPin1 = 2;  // Servo 1 gắn vào chân D2
const int servoPin2 = 3;  // Servo 2 gắn vào chân D3
```

### Giải thích code

Khai báo thư viện điều khiển servo cho ZeroBase.

```cpp
#include "ZBServo.h"  // Thư viện điều khiển servo cho Zerobase
```

Khai báo chân kết nối servo và biến lưu dữ liệu lệnh nhận từ Serial1.

```cpp
const int servoPin1 = 2;  // Servo 1 gắn vào chân D2
const int servoPin2 = 3;  // Servo 2 gắn vào chân D3
String inputString = "";  // Biến lưu dữ liệu lệnh nhận từ Serial1
```

Khởi tạo servo từ thư viện ZBServo.

```cpp
ZBServo servo1;  // Đối tượng điều khiển servo thứ nhất
ZBServo servo2;  // Đối tượng điều khiển servo thứ hai
```
Gán chân Servo cho các đối tượng servo và khởi động Serial1.

```cpp
void setup() {
  servo1.attach(servoPin1);  // Gắn servo1 với chân D2
  servo2.attach(servoPin2);  // Gắn servo2 với chân D3

  Serial1.begin(9600);             // Khởi động Serial1 ở baudrate 9600
  Serial1.println("Servo ready");  // Thông báo sẵn sàng
}
```

Trong hàm `loop()`, chúng ta sẽ kiểm tra xem có dữ liệu nào từ Serial1 hay không. Nếu có, chúng ta sẽ đọc từng ký tự và thêm vào biến `inputString`. Khi gặp ký tự xuống dòng `\n`, chúng ta sẽ gọi hàm `handleCommand()` để xử lý lệnh. Ký tự carriage return `\r` sẽ bị bỏ qua.

```cpp
void loop() {
  // Kiểm tra nếu có dữ liệu từ Serial1
  while (Serial1.available()) {
    char c = Serial1.read();  // Đọc từng ký tự

    if (c == '\n') {               // Nếu gặp ký tự xuống dòng, bắt đầu xử lý lệnh
      handleCommand(inputString);  // Gọi hàm xử lý lệnh
      inputString = "";            // Xoá chuỗi sau khi xử lý xong
    } else if (c != '\r') {        // Bỏ qua ký tự carriage return
      inputString += c;            // Thêm ký tự vào chuỗi lệnh
    }
  }
}
```


Hàm `handleCommand()` sẽ xử lý các lệnh nhận được từ Serial1.

Đầu tiên là loại bỏ khoảng trắng đầu/cuối chuỗi lệnh và chuyển đổi lệnh sang chữ hoa để dễ xử lý hơn.

Sau đó, chúng ta sẽ kiểm tra xem lệnh bắt đầu bằng gì. Nếu lệnh bắt đầu bằng `S1 `, chúng ta sẽ lấy góc quay từ lệnh bằng cách sử dụng `substring()` và chuyển đổi nó thành số nguyên bằng `toInt()`. Sau đó, chúng ta sẽ giới hạn góc quay từ 0 đến 180 độ bằng cách sử dụng hàm `constrain()`. Cuối cùng, chúng ta sẽ gửi lệnh quay cho servo 1 và phản hồi lại góc đã quay.

```cpp
void handleCommand(String cmd) {
  cmd.trim();         // Xoá khoảng trắng đầu/cuối lệnh
  cmd.toUpperCase();  // Chuyển lệnh thành chữ hoa để dễ so sánh

  if (cmd.startsWith("S1 ")) {             // Lệnh điều khiển servo 1
    int angle = cmd.substring(3).toInt();  // Lấy góc quay từ lệnh
    angle = constrain(angle, 0, 180);      // Giới hạn góc từ 0 đến 180 độ
    servo1.write(angle);                   // Gửi lệnh quay cho servo 1
    Serial1.print("Servo 1: ");
    Serial1.println(angle);  // Phản hồi lại góc đã quay

  }
```

Các lệnh khác cũng tương tự như vậy, chỉ khác ở việc điều khiển servo 2 hoặc cả hai servo.

```cpp
  else if (cmd.startsWith("S2 ")) {  // Lệnh điều khiển servo 2
    int angle = cmd.substring(3).toInt();
    angle = constrain(angle, 0, 180);
    servo2.write(angle);  // Gửi lệnh quay cho servo 2
    Serial1.print("Servo 2: ");
    Serial1.println(angle);

  } else if (cmd.startsWith("ALL ")) {  // Lệnh điều khiển cả hai servo
    int angle = cmd.substring(4).toInt();
    angle = constrain(angle, 0, 180);
    servo1.write(angle);  // Quay servo 1
    servo2.write(angle);  // Quay servo 2
    Serial1.print("All servos: ");
    Serial1.println(angle);

  } else {
    Serial1.println("Invalid command");  // Lệnh không hợp lệ
  }
}
```
## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ điều khiển được Servo qua Serial Monitor.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-servo-result.gif" alt="uartttl-servo-result">
    <p><em>Điều khiển servo qua Serial Monitor</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách điều khiển LED qua Serial Monitor bằng cách sử dụng UART TTL. Bạn có thể áp dụng kiến thức này để thực hiện các dự án khác liên quan đến việc điều khiển thiết bị ngoại vi qua giao thức UART.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- **Điều khiển LED từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt LED hoặc thay đổi tốc độ nháy.
- **Điều khiển Motor DC từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển tốc độ quay của Motor DC.
- **Điều khiển Relay từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt Relay.
- **Điều khiển RGB LED từ Serial Monitor:** Nhập giá trị từ Serial Monitor để thay đổi màu sắc của RGB LED.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)