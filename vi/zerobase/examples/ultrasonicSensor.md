<br>
<br>
<br>

# Sử Dụng Cảm Biến Siêu Âm Với Zerobase

![ultrasonic-sensor-zerobase](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-zerobase.jpg "ultrasonic-sensor-zerobase")

## Tổng quan

?> Bài viết này hướng dẫn sử dụng cảm biến siêu âm với Zerobase để đo khoảng cách và hiển thị kết quả bằng cách bật/tắt dãy LED. 

## Chuẩn Bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Cảm biến siêu âm | [Mua ngay](https://chipstack.vn/san-pham/cam-bien-sieu-am/) |
| Điện trở 330Ω | [Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED | [Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor.png" alt="ultrasonic-sensor">
    <p><em>Cảm biến siêu âm</em></p>
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

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

## Nguyên Lý Hoạt Động

![ultrasonic-sensor-working-principle](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-working-principle.png "ultrasonic-sensor-working-principle")

?> Cảm biến siêu âm hoạt động bằng cách phát ra một xung siêu âm từ chân Trig (TX) trong 10 micro giây. Sau khi phát xung, chân Echo (RX) được kéo lên mức cao và giữ nguyên cho đến khi nhận được tín hiệu phản xạ từ vật cản. Thời gian chân Echo giữ mức cao chính là thời gian sóng siêu âm di chuyển đến vật và quay về. Dựa vào đó, vi điều khiển tính toán khoảng cách bằng công thức: `Khoảng cách = (Thời gian Echo × 0.034) / 2`. 

?> Sau khi đo khoảng cách, hệ thống sẽ bật số lượng đèn LED tương ứng: Nếu vật ở gần, nhiều đèn sáng lên; nếu vật ở xa, ít đèn sáng hơn; nếu không có vật trong phạm vi đo, tất cả đèn sẽ tắt.

> Xem thêm về LED [tại đây](https://chipstack.vn/uncategorized/diot-phat-quang-la-gi-nguyen-ly-hoat-dong-va-ung-dung-tiet-kiem-nang-luong/).

## Sơ Đồ Kết Nối

![ultrasonic-zerboase-pins](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-zerobase-pins.png "ultrasonic-zerboase-pins")

Sử dụng chân A0 (D14), A1 (D15), A2 (D16), A3 (D17), SDA (D18) và D3 để kết nối với các chân anode (+) của LED, chân cathode (-) của LED kết nối với điện trở 330Ω và nối xuống GND của Zerobase.

Chân Trig của cảm biến siêu âm kết nối với chân MO (D11), chân Echo kết nối với chân SS (D10).

Sử dụng chân GND và 5V để cấp nguồn cho cảm biến siêu âm.

![ultrasonic-sensor-zerobase-schematic](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-zerobase-schematic.png "ultrasonic-sensor-zerobase-schematic")

![ultrasonic-sensor-zerobase](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-zerobase.jpg "ultrasonic-sensor-zerobase")

![ultrasonic-sensor-zerobase-mat-sau](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-zerobase-mat-sau.jpg "ultrasonic-sensor-zerobase-mat-sau")

![ultrasonic-sensor-zerobase-mat-tren](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-zerobase-mat-tren.jpg "ultrasonic-sensor-zerobase-mat-tren")

## Code

```cpp
const int ledPins[] = { 3, 18, 17, 16, 15, 14 };  // Mảng chứa các chân kết nối LED

const int numLeds = sizeof(ledPins) / sizeof(ledPins[0]);  // Tính số lượng LED dựa trên kích thước mảng

const int trigPin = 11;  // Chân phát tín hiệu của cảm biến siêu âm

const int echoPin = 10;  // Chân nhận tín hiệu phản hồi của cảm biến siêu âm

const int distanceThreshold = 20;  // Ngưỡng khoảng cách để bật LED

void setup() {
  pinMode(trigPin, OUTPUT);  // Cấu hình chân trigPin là OUTPUT
  pinMode(echoPin, INPUT);   // Cấu hình chân echoPin là INPUT

  for (int i = 0; i < numLeds; i++) {
    pinMode(ledPins[i], OUTPUT);  // Thiết lập các chân LED là OUTPUT
  }
}

long getDistance() {
  digitalWrite(trigPin, LOW);  // Đảm bảo tín hiệu bắt đầu từ mức thấp
  delayMicroseconds(2);        // Chờ 2 micro giây để ổn định

  digitalWrite(trigPin, HIGH);  // Gửi xung tín hiệu kéo dài 10 micro giây
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);  // Kết thúc xung tín hiệu

  // Đo thời gian phản hồi từ cảm biến và tính toán khoảng cách (cm)
  return pulseIn(echoPin, HIGH) * 0.034 / 2;
}

void loop() {
  long distance = getDistance();  // Đọc khoảng cách từ cảm biến siêu âm

  if (distance <= distanceThreshold) {                             // Nếu khoảng cách nhỏ hơn hoặc bằng 20 cm
    int ledsOn = map(distance, 0, distanceThreshold, numLeds, 0);  // Chuyển đổi khoảng cách sang số LED cần bật
    ledsOn = constrain(ledsOn, 0, numLeds);         // Giới hạn giá trị trong khoảng hợp lệ

    for (int i = 0; i < numLeds; i++) {
      digitalWrite(ledPins[i], i < ledsOn ? HIGH : LOW);  // Bật số LED tương ứng với khoảng cách
    }
    delay(100);  // Giữ trạng thái LED trong 100ms
  }

  for (int i = 0; i < numLeds; i++) {
    digitalWrite(ledPins[i], LOW);  // Tắt tất cả LED khi không có vật trong phạm vi
  }
}
```
Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![ultrasonic-zerobase-code](https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-zerobase-code.png "ultrasonic-zerobase-code]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực Hiện Nạp Code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `ledPins`, `trigPin` hoặc `echoPin` trong code sau đó kết nối LED và cảm biến siêu âm với chân tương ứng.

```cpp
const int ledPins[] = { 3, 18, 17, 16, 15, 14 };  // Thay đổi chân kết nối LED
const int trigPin = 11;  // Thay đổi chân kết nối Trig
const int echoPin = 10;  // Thay đổi chân kết nối Echo
```

Nếu muốn thay đổi ngưỡng khoảng cách để bật LED, bạn chỉ cần sửa giá trị biến `distanceThreshold`.

```cpp
const int distanceThreshold = 20;  // Thay đổi ngưỡng khoảng cách để bật LED
```

### Giải Thích Code

Khai báo mảng `ledPins` chứa các chân kết nối LED.

```cpp
const int ledPins[] = { 3, 18, 17, 16, 15, 14 };
```
Tính số lượng LED dựa trên kích thước mảng.

```cpp
const int numLeds = sizeof(ledPins) / sizeof(ledPins[0]);
```

Khai báo chân `trigPin` là chân phát tín hiệu của cảm biến siêu âm và chân `echoPin` là chân nhận tín hiệu phản hồi của cảm biến siêu âm.

```cpp
const int trigPin = 11;
const int echoPin = 10;
```

Khai báo ngưỡng khoảng cách để bật LED.

```cpp
const int distanceThreshold = 20;  // Ngưỡng khoảng cách để bật LED
```

Cấu hình chân `trigPin` là OUTPUT, chân `echoPin` là INPUT và cấu hình các chân LED là OUTPUT.

```cpp
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  for (int i = 0; i < numLeds; i++) {
    pinMode(ledPins[i], OUTPUT);
  }
```

Hàm `getDistance()` dùng để đo khoảng cách từ cảm biến siêu âm.

```cpp
long getDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  return pulseIn(echoPin, HIGH) * 0.034 / 2;
}
```

Đọc khoảng cách từ cảm biến siêu âm.

```cpp
  long distance = getDistance();
```

Nếu khoảng cách nhỏ hơn hoặc bằng 20 cm:
- Hàm map(value, fromLow, fromHigh, toLow, toHigh) dùng để ánh xạ giá trị từ một khoảng sang một khoảng khác.
- Ở đây, distance (khoảng cách đo được) nằm trong khoảng 0-32 cm sẽ được ánh xạ sang số LED cần bật từ numLeds (6) đến 0.
- Khi distance = 0 cm (vật rất gần), tất cả numLeds LED (6 LED) sẽ sáng.
- Khi distance = 32 cm (xa hơn giới hạn), 0 LED sáng.

- Hàm constrain(value, min, max) dùng để giới hạn giá trị trong một khoảng hợp lệ.
- Ở đây, giá trị ledsOn sẽ được giới hạn trong khoảng 0-6.

Dùng vòng lặp để bật số LED tương ứng với khoảng cách:
- Nếu LED thứ i nhỏ hơn số LED cần bật, bật LED thứ i, ngược lại tắt LED thứ i.

```cpp
  if (distance <= distanceThreshold) {
    int ledsOn = map(distance, 0, distanceThreshold, numLeds, 0);
    ledsOn = constrain(ledsOn, 0, numLeds);

    for (int i = 0; i < numLeds; i++) {
      digitalWrite(ledPins[i], i < ledsOn ? HIGH : LOW);
    }
    delay(100);
  }
```

Tắt tất cả LED khi không có vật trong phạm vi 20 cm.

```cpp
  for (int i = 0; i < numLeds; i++) {
    digitalWrite(ledPins[i], LOW);
  }
```

## Kết quả

?> Khi có vật ở gần, nhiều LED sáng hơn, và khi vật ở xa, ít LED sáng hơn. Khi không có vật trong phạm vi 20 cm, tất cả LED sẽ tắt.

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor-zerobase-result.gif" alt="ultrasonic-sensor-zerobase-result">
</p>

## Kết Luận và Hướng Phát Triển

Bài viết đã hướng dẫn cách sử dụng cảm biến siêu âm với Zerobase để đo khoảng cách và hiển thị kết quả bằng cách bật/tắt dãy LED.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- Hiển thị khoảng cách trên màn hình LCD/OLED: Thay vì chỉ dùng LED, bạn có thể kết hợp màn hình để hiển thị chính xác khoảng cách đo được.
- Cảnh báo bằng âm thanh: Thêm còi buzzer để phát âm thanh khi vật đến gần một mức nguy hiểm.
- Điều khiển động cơ: Ứng dụng vào robot tránh vật cản bằng cách sử dụng khoảng cách đo được để thay đổi hướng di chuyển.
- Kết nối với IoT: Gửi dữ liệu khoảng cách lên một hệ thống IoT để giám sát từ xa.

**Chúc bạn thành công!** 

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)</span>