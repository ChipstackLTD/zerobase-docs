<br>
<br>
<br>

# Điều khiển động cơ DC qua Serial Monitor

![zerobase-uartttl-dc-motor-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-dc-motor-circuit.jpg "zerobase-uartttl-dc-motor-circuit")

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ DC qua Serial Monitor bằng cách sử dụng UART TTL.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |
| Động cơ DC 2 trục tỷ lệ 1:120 | [Mua ngay](https://chipstack.vn/san-pham/dong-co-dc-2-truc-ty-le-1120/) |
| Bánh xe 68mm (Tuỳ chọn) | [Mua ngay](https://chipstack.vn/san-pham/banh-xe-68mm/) |

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
    <img src="https://cdn.chipstack.vn/default/dong-co-dc.jpg" alt="dong-co-dc">
    <p><em>Động cơ DC 2 trục tỷ lệ 1:120</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/banh-xe-68mm.jpg" alt="banh-xe-68mm">
    <p><em>Bánh xe 68mm</em></p>
</div>

## Nguyên lý hoạt động

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ DC qua Serial Monitor bằng cách sử dụng UART TTL.

?> Các lệnh sử dụng trong bài viết này: `F <speed>`, `R <speed>`, `S`. Trong đó:

?> - `F <speed>`: Chạy động cơ theo chiều thuận với tốc độ từ 0 đến 4095.

?> - `R <speed>`: Chạy động cơ theo chiều ngược với tốc độ từ 0 đến 4095.

?> - `S`: Dừng động cơ.

?> Chương trình liên tục đọc dữ liệu từ Serial1 và ghép các ký tự thành chuỗi lệnh hoàn chỉnh. Khi nhận được chuỗi kết thúc bằng dấu xuống dòng `\n`, lệnh sẽ được xử lý. Tuỳ vào lệnh mà động cơ sẽ chạy theo chiều thuận, ngược lại với tốc độ được chỉ định hoặc dừng lại.

> Tìm hiểu thêm cách điều khiển động cơ DC [tại đây](vi/zerobase/examples/potentiometer-dc-motor.md).

## Sơ đồ kết nối

![zerobase-uartttl-led-pins](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-servo-pins.png "zerobase-uartttl-servo-pins")

Sử dụng chân D1 (TX) kết nối với chân RX (màu trắng) của USB UART TTL và chân D0 (RX) kết nối với chân TX (màu xanh lá) của USB UART TTL.

Chân D3 được kết nối với chân IN1 của module cầu H, chân D2 được kết nối với chân IN2 của module cầu H.

Một chân MOTOR A của module cầu H được nối với cực dương của động cơ DC, chân còn lại nối với cực âm của động cơ DC.

Chân GND của module cầu H được nối với GND của board Zerobase, USB UART TTL và nguồn. Chân 5V của module cầu H được nối với chân 5V của board Zerobase, và nguồn.

![uartttl-dc-motor-schematic](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-dc-motor-schematic.png "uartttl-dc-motor-schematic")

![zerobase-uartttl-dc-motor-circuit](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-dc-motor-circuit.jpg "zerobase-uartttl-dc-motor-circuit")

!> **Ngắt nguồn trước khi nạp code**: Trước khi cắm dây USB vào để nạp code vào board Zerobase, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase và chạy code bình thường.

!> **Không dùng nguồn 5V từ Zerobase cho động cơ**: Tuyệt đối không nối 5V trực tiếp của board Zerobase vào động cơ DC, vì động cơ DC có thể tiêu tốn dòng điện lớn hơn mức cho phép của board Zerobase, dẫn đến hỏng board.

!> **Module nguồn MB102 830 ở chế độ 5V**: Bạn cần đảm bảo module nguồn MB102 830 đang ở chế độ 5V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 5V.

## Cài đặt driver USB UART TTL

> Nếu bạn chưa biết cách Giao tiếp Serial Monitor bằng dây USB UART TTL PL2303HX trên board Zerobase và chưa biết cách cài đặt driver, hãy tham khảo bài viết [tại đây](vi/zerobase/examples/uartttl.md).

## Code

```cpp
// Khai báo chân điều khiển động cơ
const int IN1 = 3;  // D3 nối IN1 (PWM)
const int IN2 = 2;  // D2 nối IN2 (PWM)

// Biến lưu chuỗi lệnh nhận từ Serial1
String inputString = "";

void setup() {
  // Thiết lập hai chân là OUTPUT
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);

  // Khởi tạo trạng thái ban đầu là dừng động cơ
  analogWrite(IN1, 0);
  analogWrite(IN2, 0);

  Serial1.begin(9600);             // Khởi động Serial1 ở baudrate 9600
  Serial1.println("Motor ready");  // Thông báo sẵn sàng
}

void loop() {
  // Đọc dữ liệu từ Serial1 nếu có
  while (Serial1.available()) {
    char c = Serial1.read();  // Đọc từng ký tự

    if (c == '\n') {  // Khi gặp xuống dòng, xử lý lệnh
      handleCommand(inputString);
      inputString = "";      // Xoá chuỗi sau khi xử lý
    } else if (c != '\r') {  // Bỏ qua carriage return
      inputString += c;      // Thêm ký tự vào chuỗi
    }
  }
}

// Hàm xử lý lệnh nhận từ Serial1
void handleCommand(String cmd) {
  cmd.trim();         // Xoá khoảng trắng đầu/cuối
  cmd.toUpperCase();  // Chuyển lệnh sang chữ hoa

  if (cmd.startsWith("F ")) {              // Quay thuận
    int speed = cmd.substring(2).toInt();  // Lấy giá trị tốc độ
    speed = constrain(speed, 0, 4095);     // Giới hạn trong 12-bit
    analogWrite(IN1, speed);
    analogWrite(IN2, 0);
    Serial1.print("Forward: ");
    Serial1.println(speed);

  } else if (cmd.startsWith("R ")) {  // Quay ngược
    int speed = cmd.substring(2).toInt();
    speed = constrain(speed, 0, 4095);
    analogWrite(IN1, 0);
    analogWrite(IN2, speed);
    Serial1.print("Reverse: ");
    Serial1.println(speed);

  } else if (cmd == "S") {  // Dừng
    analogWrite(IN1, 0);
    analogWrite(IN2, 0);
    Serial1.println("Stop");

  } else {
    Serial1.println("Invalid command");  // Lệnh không hợp lệ
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![uartttl-dc-motor-code](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-dc-motor-code.png "uartttl-dc-motor-code")

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

Nếu bạn muốn thay đổi chân PWM, bạn chỉ cần thay đổi giá trị của biến `IN1` và `IN2` trong code.

```cpp
const int IN1 = 3;  // D3 nối IN1 (PWM)
const int IN2 = 2;  // D2 nối IN2 (PWM)
```

### Giải thích code

Khai báo chân điều khiển động cơ DC là `IN1` và `IN2` với giá trị lần lượt là 3 và 2, tương ứng với chân D3 và D2 trên board Zerobase.

```cpp
const int IN1 = 3;  // D3 nối IN1 (PWM)
const int IN2 = 2;  // D2 nối IN2 (PWM)
```
Khai báo biến `inputString` để lưu chuỗi lệnh nhận từ Serial1.

```cpp
String inputString = "";
```

Hàm `setup()` chỉ chạy một lần khi vi điều khiển khởi động hoặc reset. Trong hàm này, chúng ta thiết lập hai chân `IN1` và `IN2` là OUTPUT, khởi tạo trạng thái ban đầu là dừng động cơ và khởi động Serial1 với tốc độ 9600 baud.

```cpp
void setup() {
  // Thiết lập hai chân là OUTPUT
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);

  // Khởi tạo trạng thái ban đầu là dừng động cơ
  analogWrite(IN1, 0);
  analogWrite(IN2, 0);

  Serial1.begin(9600);             // Khởi động Serial1 ở baudrate 9600
  Serial1.println("Motor ready");  // Thông báo sẵn sàng
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

Hàm `handleCommand()` sẽ xử lý lệnh nhận từ Serial1. Đầu tiên, chúng ta sẽ loại bỏ khoảng trắng đầu/cuối và chuyển lệnh sang chữ hoa.

```cpp
void handleCommand(String cmd) {
  cmd.trim();         // Xoá khoảng trắng đầu/cuối
  cmd.toUpperCase();  // Chuyển lệnh sang chữ hoa
```

Nếu lệnh bắt đầu bằng `F `, chúng ta sẽ tách số sau chữ `F` và chuyển đổi thành số nguyên bằng hàm `substring()` và chuyển sang số nguyên bằng hàm `toInt()`. Sau đó, chúng ta sẽ giới hạn giá trị tốc độ trong khoảng từ 0 đến 4095 bằng hàm `constrain()` và lưu vào biến `speed`. Cuối cùng, chúng ta sẽ điều khiển động cơ quay theo chiều thuận bằng cách sử dụng hàm `analogWrite()`.

```cpp
 if (cmd.startsWith("F ")) {              // Quay thuận
    int speed = cmd.substring(2).toInt();  // Lấy giá trị tốc độ
    speed = constrain(speed, 0, 4095);     // Giới hạn trong 12-bit
    analogWrite(IN1, speed);
    analogWrite(IN2, 0);
    Serial1.print("Forward: ");
    Serial1.println(speed);
  }
```

Nếu lệnh bắt đầu bằng `R `, chúng ta sẽ làm tương tự như trên nhưng điều khiển động cơ quay theo chiều ngược lại.

```cpp
else if (cmd.startsWith("R ")) {  // Quay ngược
    int speed = cmd.substring(2).toInt();
    speed = constrain(speed, 0, 4095);
    analogWrite(IN1, 0);
    analogWrite(IN2, speed);
    Serial1.print("Reverse: ");
    Serial1.println(speed);
  }
```

Nếu lệnh là `S`, chúng ta sẽ dừng động cơ bằng cách đưa cả hai chân `IN1` và `IN2` về mức 0.

```cpp
else if (cmd == "S") {  // Dừng
    analogWrite(IN1, 0);
    analogWrite(IN2, 0);
    Serial1.println("Stop");
  }
```

Nếu lệnh không hợp lệ, chúng ta sẽ thông báo cho người dùng biết.

```cpp
else {
    Serial1.println("Invalid command");  // Lệnh không hợp lệ
  }
}
```

## Kết quả

?> Khi bạn nhập lệnh `F <speed>` vào Serial Monitor, động cơ sẽ quay theo chiều thuận với tốc độ từ 0 đến 4095. Khi bạn nhập lệnh `R <speed>`, động cơ sẽ quay theo chiều ngược lại với tốc độ từ 0 đến 4095. Khi bạn nhập lệnh `S`, động cơ sẽ dừng lại.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/zerobase-uartttl-dc-motor-result.gif" alt="zerobase-uartttl-dc-motor-result">
    <p><em>Điều khiển động cơ DC qua Serial Monitor</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách điều khiển LED qua Serial Monitor bằng cách sử dụng UART TTL. Bạn có thể áp dụng kiến thức này để thực hiện các dự án khác liên quan đến việc điều khiển thiết bị ngoại vi qua giao thức UART.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- **Điều khiển LED từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt LED hoặc thay đổi tốc độ nháy.
- **Điều khiển Servo từ Serial Monitor:** Nhập giá trị từ Serial Monitor để điều khiển góc quay của Servo.
- **Điều khiển Relay từ Serial Monitor:** Nhập lệnh từ Serial Monitor để bật/tắt Relay.
- **Điều khiển RGB LED từ Serial Monitor:** Nhập giá trị từ Serial Monitor để thay đổi màu sắc của RGB LED.

**Chúc bạn thành công!**