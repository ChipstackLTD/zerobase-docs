<br>
<br>
<br>

# Điều khiển động cơ Servo qua Serial Monitor

![zerobase2-uartttl-servo-circuit](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/zerobase2-uartttl-servo-circuit.jpg "zerobase2-uartttl-servo-circuit")

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ Servo qua Serial Monitor bằng cách sử dụng UART TTL.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2| [Mua ngay](https://chipstack.vn/san-pham/zerobas-2/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Động cơ Servo SG90 180 độ | [Mua ngay](https://chipstack.vn/san-pham/dong-co-servo-sg90-180-do/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |

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

?> Chương trình liên tục đọc dữ liệu từ Serial và ghép các ký tự thành chuỗi lệnh hoàn chỉnh. Khi nhận được chuỗi kết thúc bằng dấu xuống dòng `\n`, lệnh sẽ được xử lý. Tùy theo nội dung lệnh (`S1 <angle>`, `S2 <angle>`, `ALL <angle>`) mà động cơ Servo sẽ được điều khiển tương ứng.

## Sơ đồ kết nối

![zerobase2-uartttl-led-pins](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/zerobase2-uartttl-dc-pins.png "zerobase2-uartttl-dc-pins")

Sử dụng chân D2 kết nối đến chân màu cam của servo, chân D3 kết nối chân màu cam Servo 2. Chân màu đỏ của servo nối với 5V của module nguồn và chân màu nâu nối với GND của module nguồn MB102 830.

Sử dụng chân GND của Zerobase kết nối với chân GND của module nguồn MB102 830.

![uartttl-servo-schematic](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uartttl-servo-schematic.png "uartttl-servo-schematic")

![zerobase2-uartttl-servo-circuit](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/zerobase2-uartttl-servo-circuit.jpg "zerobase2-uartttl-servo-circuit")

!> **Ngắt nguồn trước khi nạp code**: Trước khi cắm dây USB vào để nạp code vào board Zerobase 2, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase 2 và chạy code bình thường.

!> **Không dùng nguồn 5V từ Zerobase 2 cho servo**: Tuyệt đối không nối 5V trực tiếp của board Zerobase 2 vào servo, vì servo có thể tiêu tốn dòng điện lớn hơn mức cho phép của board Zerobase 2, dẫn đến hỏng board.

!> **Cấp nguồn cho Zerobase 2 bằng USB type-C để giao tiếp Serial Monitor**: Bạn cần cấp nguồn cho board Zerobase 2 bằng dây USB để giao tiếp với Serial Monitor.

!> **Cấp nguồn cho servo với 5V**: Bạn cần đảm bảo bên còn lại của module nguồn MB102 830 đang ở chế độ 5V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 5V.

## Code

```cpp
#include <Adafruit_TinyUSB.h> // Thư viện hỗ trợ USB để giao tiếp Serial
#include "ZBServo.h"  // Thư viện điều khiển servo cho Zerobase 2

ZBServo servo1;  // Đối tượng điều khiển servo thứ nhất
ZBServo servo2;  // Đối tượng điều khiển servo thứ hai

// Khai báo chân tín hiệu servo
const int servoPin1 = 2;  // Servo 1 gắn vào chân D2
const int servoPin2 = 3;  // Servo 2 gắn vào chân D3

String inputString = "";  // Biến lưu dữ liệu lệnh nhận từ Serial

void setup() {
  servo1.attach(servoPin1);  // Gắn servo1 với chân D2
  servo2.attach(servoPin2);  // Gắn servo2 với chân D3

  Serial.begin(9600);             // Khởi động Serial ở baudrate 9600
  Serial.println("Servo ready");  // Thông báo sẵn sàng
}

void loop() {
  // Kiểm tra nếu có dữ liệu từ Serial
  while (Serial.available()) {
    char c = Serial.read();  // Đọc từng ký tự

    if (c == '\n') {               // Nếu gặp ký tự xuống dòng, bắt đầu xử lý lệnh
      handleCommand(inputString);  // Gọi hàm xử lý lệnh
      inputString = "";            // Xoá chuỗi sau khi xử lý xong
    } else if (c != '\r') {        // Bỏ qua ký tự carriage return
      inputString += c;            // Thêm ký tự vào chuỗi lệnh
    }
  }
}

// Hàm xử lý chuỗi lệnh từ Serial
void handleCommand(String cmd) {
  cmd.trim();         // Xoá khoảng trắng đầu/cuối lệnh
  cmd.toUpperCase();  // Chuyển lệnh thành chữ hoa để dễ so sánh

  if (cmd.startsWith("S1 ")) {             // Lệnh điều khiển servo 1
    int angle = cmd.substring(3).toInt();  // Lấy góc quay từ lệnh
    angle = constrain(angle, 0, 180);      // Giới hạn góc từ 0 đến 180 độ
    servo1.write(angle);                   // Gửi lệnh quay cho servo 1
    Serial.print("Servo 1: ");
    Serial.println(angle);  // Phản hồi lại góc đã quay

  } else if (cmd.startsWith("S2 ")) {  // Lệnh điều khiển servo 2
    int angle = cmd.substring(3).toInt();
    angle = constrain(angle, 0, 180);
    servo2.write(angle);  // Gửi lệnh quay cho servo 2
    Serial.print("Servo 2: ");
    Serial.println(angle);

  } else if (cmd.startsWith("ALL ")) {  // Lệnh điều khiển cả hai servo
    int angle = cmd.substring(4).toInt();
    angle = constrain(angle, 0, 180);
    servo1.write(angle);  // Quay servo 1
    servo2.write(angle);  // Quay servo 2
    Serial.print("All servos: ");
    Serial.println(angle);

  } else {
    Serial.println("Invalid command");  // Lệnh không hợp lệ
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-servo-code](https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uartttl-servo-code.png "uartttl-servo-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện Nạp Code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Sau khi nạp code thành công, chọn **Tools > Port > COMX** để chọn cổng COM tương ứng với USB UART TTL.

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

Nếu bạn muốn thay đổi chân điều khiển servo, bạn chỉ cần thay đổi giá trị của biến `servoPin1` hoặc `servoPin2` trong code.

```cpp
const int servoPin1 = 2;  // Servo 1 gắn vào chân D2
const int servoPin2 = 3;  // Servo 2 gắn vào chân D3
```

### Giải thích code

Khai báo thư viện hỗ trợ USB để giao tiếp Serial.

```cpp
#include <Adafruit_TinyUSB.h> // Thư viện hỗ trợ USB để giao tiếp Serial
```

Khai báo thư viện điều khiển servo cho ZeroBase 2.

```cpp
#include "ZBServo.h"  // Thư viện điều khiển servo cho Zerobase 2
```

Khai báo chân kết nối servo và biến lưu dữ liệu lệnh nhận từ Serial.

```cpp
const int servoPin1 = 2;  // Servo 1 gắn vào chân D2
const int servoPin2 = 3;  // Servo 2 gắn vào chân D3
String inputString = "";  // Biến lưu dữ liệu lệnh nhận từ Serial
```

Khởi tạo servo từ thư viện ZBServo.

```cpp
ZBServo servo1;  // Đối tượng điều khiển servo thứ nhất
ZBServo servo2;  // Đối tượng điều khiển servo thứ hai
```
Gán chân Servo cho các đối tượng servo và khởi động Serial.

```cpp
void setup() {
  servo1.attach(servoPin1);  // Gắn servo1 với chân D2
  servo2.attach(servoPin2);  // Gắn servo2 với chân D3

  Serial.begin(9600);             // Khởi động Serial ở baudrate 9600
  Serial.println("Servo ready");  // Thông báo sẵn sàng
}
```

Trong hàm `loop()`, chúng ta sẽ kiểm tra xem có dữ liệu nào từ Serial hay không. Nếu có, chúng ta sẽ đọc từng ký tự và thêm vào biến `inputString`. Khi gặp ký tự xuống dòng `\n`, chúng ta sẽ gọi hàm `handleCommand()` để xử lý lệnh. Ký tự carriage return `\r` sẽ bị bỏ qua.

```cpp
void loop() {
  // Kiểm tra nếu có dữ liệu từ Serial
  while (Serial.available()) {
    char c = Serial.read();  // Đọc từng ký tự

    if (c == '\n') {               // Nếu gặp ký tự xuống dòng, bắt đầu xử lý lệnh
      handleCommand(inputString);  // Gọi hàm xử lý lệnh
      inputString = "";            // Xoá chuỗi sau khi xử lý xong
    } else if (c != '\r') {        // Bỏ qua ký tự carriage return
      inputString += c;            // Thêm ký tự vào chuỗi lệnh
    }
  }
}
```


Hàm `handleCommand()` sẽ xử lý các lệnh nhận được từ Serial.

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
    Serial.print("Servo 1: ");
    Serial.println(angle);  // Phản hồi lại góc đã quay

  }
```

Các lệnh khác cũng tương tự như vậy, chỉ khác ở việc điều khiển servo 2 hoặc cả hai servo.

```cpp
  else if (cmd.startsWith("S2 ")) {  // Lệnh điều khiển servo 2
    int angle = cmd.substring(3).toInt();
    angle = constrain(angle, 0, 180);
    servo2.write(angle);  // Gửi lệnh quay cho servo 2
    Serial.print("Servo 2: ");
    Serial.println(angle);

  } else if (cmd.startsWith("ALL ")) {  // Lệnh điều khiển cả hai servo
    int angle = cmd.substring(4).toInt();
    angle = constrain(angle, 0, 180);
    servo1.write(angle);  // Quay servo 1
    servo2.write(angle);  // Quay servo 2
    Serial.print("All servos: ");
    Serial.println(angle);

  } else {
    Serial.println("Invalid command");  // Lệnh không hợp lệ
  }
}
```
## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ điều khiển được Servo qua Serial Monitor.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/uart/uart-ttl/uartttl-servo-result.gif" alt="uartttl-servo-result">
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

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)