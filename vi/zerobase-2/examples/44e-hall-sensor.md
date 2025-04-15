<br>
<br>
<br>

# Sử dụng cảm biến từ trường 44e với Zerobase 2

![44e-circuit](https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e-circuit.jpg)

## Tổng quan

Bài viết này sẽ hướng dẫn bạn cách sử dụng cảm biến từ trường 44e với board Zerobase 2. Khi phát hiện từ trường, cảm biến sẽ gửi tín hiệu LOW đến chân GPIO mà nó được kết nối. Bạn có thể sử dụng tín hiệu này để điều khiển các thiết bị khác như đèn LED, relay, hoặc bất kỳ thiết bị nào khác mà bạn muốn.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 |[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Điện trở 330Ω |[Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED |[Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Cảm biến từ trường 44e | [Mua ngay](https://chipstack.vn/san-pham/cam-bien-hall-44e/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase">
    <p><em>Board Zerobase 2</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/dien-tro-330-ohm.png" alt="dien-tro-330-ohm">
    <p><em>Điện trở 330Ω</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/led-do.png" alt="led-do">
    <p><em>LED</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="button-lcd-usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e.jpg" alt="44e-hall-sensor">
    <p><em>Cảm biến từ trường 44e</em></p>
</div>

## Nguyên lý hoạt động

?> Khi có từ trường, cảm biến sẽ gửi tín hiệu LOW đến chân GPIO mà nó được kết nối. Dựa vào đó board Zerobase 2 sẽ bật đèn LED.

?> Khi không có từ trường, cảm biến sẽ gửi tín hiệu HIGH đến chân GPIO mà nó được kết nối. Dựa vào đó board Zerobase 2 sẽ tắt đèn LED.

## Sơ đồ kết nối

![44e-pinout](https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/pinout-44e.jpg)

![44e-pins](https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e-pins.png)

Sử dụng chân D2 của Zerobase 2 để kết nối với chân OUT của cảm biến, chân D2 phải được cấu hình ở chế độ INPUT_PULLUP. Chân VCC của cảm biến kết nối với chân 3.3V của Zerobase 2, chân GND của cảm biến kết nối với chân GND của Zerobase 2.

Chân D3 của Zerobase 2 được kết nối với điện trở 330ohm nối tiếp với chân anode **(chân dài hơn là +)** của LED và GND để kết nối với chân cathode **( chân ngắn hơn là -)** của LED.

![44e-schemtatic](https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e-schemtatic.png)

![44e-circuit](https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e-circuit.jpg)

## Code

```cpp
const int hallPin = 2;  // Chân D2 đọc tín hiệu từ cảm biến Hall
const int ledPin = 3;   // Chân D3 điều khiển LED

void setup() {
  pinMode(hallPin, INPUT_PULLUP);  // Cảm biến Hall là ngõ vào với điện trở kéo lên
  pinMode(ledPin, OUTPUT);         // LED là ngõ ra
}

void loop() {
  int hallState = digitalRead(hallPin);  // Đọc trạng thái cảm biến Hall

  if (hallState == LOW) {        // Có từ trường (tùy loại cảm biến, có thể là LOW)
    digitalWrite(ledPin, HIGH);  // Bật LED
  } else {
    digitalWrite(ledPin, LOW);  // Tắt LED
  }

  delay(200);  // Chờ một chút để tránh nhiễu
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![44e-code](https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

### Giải thích code

Khai báo biến hằng số `hallPin` với giá trị là 2, chính là chân D2 trên board Zerobase.

```cpp
const int hallPin = 2; // Chân D2 đọc tín hiệu từ cảm biến Hall
```

Khai báo biến hằng số `ledPin` với giá trị là 3, chính là chân D3 trên board Zerobase.

```cpp
const int ledPin = 3;   // Chân D3 điều khiển LED
```

Trong hàm `setup()`, chúng ta sẽ thiết lập chân `hallPin` là ngõ vào với điện trở kéo lên và chân `ledPin` là ngõ ra.

```cpp
  pinMode(hallPin, INPUT_PULLUP);  // Cảm biến Hall là ngõ vào với điện trở kéo lên
  pinMode(ledPin, OUTPUT);         // LED là ngõ ra
```

Trong hàm `loop()`, sử dụng hàm `digitalRead()` để đọc trạng thái của cảm biến Hall và lưu vào biến `hallState`.

```cpp
  int hallState = digitalRead(hallPin);  // Đọc trạng thái cảm biến Hall
```

Sau đó nếu trạng thái của cảm biến là LOW (phát hiện từ trường) thì bật LED, ngược lại không có từ trường sẽ tắt LED.

```cpp
  if (hallState == LOW) {        // Có từ trường (tùy loại cảm biến, có thể là LOW)
    digitalWrite(ledPin, HIGH);  // Bật LED
  } else {
    digitalWrite(ledPin, LOW);  // Tắt LED
  }
```

## Kết quả

?> Khi có từ trường, đèn LED sẽ sáng lên. Khi không có từ trường, đèn LED sẽ tắt.

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase2/44e-hall-sensor/44e-result.gif" alt="44e-result">
</p>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách sử dụng cảm biến từ trường 44e với Zerobase 2.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Thay đổi chân kết nối cảm biến và LED để thử nghiệm với các chân khác trên board Zerobase 2.
- Thêm nhiều cảm biến từ trường 44e vào mạch và điều khiển nhiều LED khác nhau.
- Hiển thị trạng thái cảm biến lên LCD hoặc OLED.
- Sử dụng cảm biến từ trường để điều khiển một thiết bị khác, chẳng hạn như relay, dựa trên tín hiệu từ cảm biến.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)





