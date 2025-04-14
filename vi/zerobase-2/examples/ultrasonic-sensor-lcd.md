<br>
<br>
<br>

# Đo khoảng cách bằng cảm biến siêu âm hiển thị lên LCD

![ultrasonic-sensor-lcd-circuit](https://cdn.chipstack.vn/zerobase2/ultrasonic-sensor/ultrasonic-sensor-lcd-circuit.jpg)

## Tổng quan

?> Bài viết này hướng dẫn thực hiện đo khoảng cách bằng cảm biến siêu âm và hiển thị lên LCD sử dụng board Zerobase 2 trên Arduino IDE.

## Chuẩn Bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2| [Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Cảm biến siêu âm | [Mua ngay](https://chipstack.vn/san-pham/cam-bien-sieu-am/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/ultrasonic-sensor/ultrasonic-sensor.png" alt="ultrasonic-sensor">
    <p><em>Cảm biến siêu âm</em></p>
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

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/lcd-i2c.png" alt="lcd-i2c">
    <p><em>LCD Character 1602A nền xanh dương</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/module-i2c.png" alt="module-i2c">
    <p><em>Module I2C LCD 1602</em></p>
</div>

## Nguyên lý hoạt động

?> Cảm biến siêu âm sẽ phát ra sóng siêu âm và đo thời gian sóng phản hồi lại cảm biến. Từ đó, Zerobase 2 sẽ tính toán khoảng cách từ cảm biến đến vật thể và hiển thị khoảng cách lên LCD.

> Tìm hiểu thêm về cảm biến siêu âm [tại đây](vi/zerobase-2/examples/ultrasonicSensor.md).

## Sơ đồ kết nối
![ultrasonic-sensor-lcd-pins](https://cdn.chipstack.vn/zerobase2/ultrasonic-sensor/ultrasonic-sensor-lcd-pins.png)

Chân Trig của cảm biến siêu âm kết nối với chân MO (D11), chân Echo kết nối với chân SS (D10). Sử dụng chân GND và 5V để cấp nguồn cho cảm biến siêu âm.

Sử dụng chân 5V cấp nguồn cho LCD, chân GND nối với GND của board Zerobase 2. Chân SDA và SCL của LCD được kết nối với chân SDA (D18) và SCL (D19) của board Zerobase 2.

![ultrasonic-sensor-lcd-schematic](https://cdn.chipstack.vn/zerobase2/ultrasonic-sensor/ultrasonic-sensor-lcd-schematic.png)

![ultrasonic-sensor-lcd-circuit](https://cdn.chipstack.vn/zerobase2/ultrasonic-sensor/ultrasonic-sensor-lcd-circuit.jpg)

## Code

```cpp
#include <LiquidCrystal_I2C.h>       // Thư viện điều khiển LCD I2C

// Khởi tạo đối tượng LCD với địa chỉ I2C là 0x27 và kích thước 16x2
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Khai báo các chân kết nối với cảm biến siêu âm
const int trigPin = 11;              // Chân gửi tín hiệu (TRIG)
const int echoPin = 10;              // Chân nhận tín hiệu (ECHO)

void setup() {
  pinMode(trigPin, OUTPUT);          // Thiết lập trigPin là OUTPUT
  pinMode(echoPin, INPUT);           // Thiết lập echoPin là INPUT

  lcd.init();                        // Khởi tạo LCD
  lcd.backlight();                   // Bật đèn nền LCD

  // Hiển thị thông điệp khởi động
  lcd.setCursor(2, 0);               // Đặt con trỏ ở cột 2, dòng 0
  lcd.print("Zerobase 2!!!");          // In dòng chữ "Zerobase 2!!!"
  lcd.setCursor(2, 1);               // Đặt con trỏ ở cột 2, dòng 1
  lcd.print("Starting...");          // In dòng chữ "Starting..."
  delay(2000);                       // Chờ 2 giây để người dùng đọc

  lcd.clear();                       // Xóa màn hình LCD
  lcd.setCursor(4, 0);               // Đặt con trỏ ở cột 4, dòng 0
  lcd.print("Distance:");            // In tiêu đề "Distance:"
}

// Hàm đo khoảng cách bằng cảm biến siêu âm
long getDistance() {
  digitalWrite(trigPin, LOW);        // Đảm bảo tín hiệu bắt đầu ở mức thấp
  delayMicroseconds(2);              // Chờ 2 micro giây

  digitalWrite(trigPin, HIGH);       // Gửi xung siêu âm trong 10 micro giây
  delayMicroseconds(10);             
  digitalWrite(trigPin, LOW);        // Kết thúc xung

  long duration = pulseIn(echoPin, HIGH);   // Đo thời gian phản hồi
  long distance = duration * 0.034 / 2;     // Tính khoảng cách (cm)
  return distance;                          // Trả về kết quả
}

void loop() {
  long distance = getDistance();     // Gọi hàm đo khoảng cách

  lcd.setCursor(6, 1);               // Đặt con trỏ tại cột 6, dòng 1
  lcd.print("      ");               // Xóa giá trị cũ bằng khoảng trắng
  lcd.setCursor(6, 1);               // Đặt lại con trỏ tại vị trí in
  lcd.print(distance);              // In khoảng cách đo được
  lcd.print(" cm");                 // In đơn vị "cm"

  delay(500);                        // Chờ 500ms trước khi đo lại
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![ultrasonic-sensor-lcd-code](https://cdn.chipstack.vn/zerobase2/ultrasonic-sensor/ultrasonic-sensor-lcd-code.png "ultrasonic-sensor-lcd-code]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `trigPin` hoặc `echoPin` trong code sau đó kết nối LED và cảm biến siêu âm với chân tương ứng.

```cpp
const int trigPin = 11;  // Thay đổi chân kết nối Trig
const int echoPin = 10;  // Thay đổi chân kết nối Echo
```

### Giải thích code

Khai báo thư viện điều khiển LCD I2C và khởi tạo đối tượng LCD với địa chỉ I2C là 0x27 và kích thước 16x2:

```cpp
#include <LiquidCrystal_I2C.h>       // Thư viện điều khiển LCD I2C
LiquidCrystal_I2C lcd(0x27, 16, 2);
```

Khai báo các chân kết nối với cảm biến siêu âm:

```cpp
const int trigPin = 11;              // Chân gửi tín hiệu (TRIG)
const int echoPin = 10;              // Chân nhận tín hiệu (ECHO)
```

Trong hàm setup, thiết lập chân trigPin là OUTPUT và echoPin là INPUT. Khởi tạo LCD và bật đèn nền LCD. Hiển thị thông điệp khởi động "Zerobase 2!!!" và "Starting..." trong 2 giây:

```cpp
 pinMode(trigPin, OUTPUT);  // Thiết lập trigPin là OUTPUT
  pinMode(echoPin, INPUT);   // Thiết lập echoPin là INPUT

  lcd.init();       // Khởi tạo LCD
  lcd.backlight();  // Bật đèn nền LCD

  // Hiển thị thông điệp khởi động
  lcd.setCursor(2, 0);       // Đặt con trỏ ở cột 2, dòng 0
  lcd.print("Zerobase 2!!!");  // In dòng chữ "Zerobase 2!!!"
  lcd.setCursor(2, 1);       // Đặt con trỏ ở cột 2, dòng 1
  lcd.print("Starting...");  // In dòng chữ "Starting..."
  delay(2000);               // Chờ 2 giây để người dùng đọc
```

Sau đó ta xoá màn hình LCD và in tiêu đề "Distance:":
```cpp
  lcd.clear();             // Xóa màn hình LCD
  lcd.setCursor(4, 0);     // Đặt con trỏ ở cột 4, dòng 0
  lcd.print("Distance:");  // In tiêu đề "Distance:"
```

Hàm `getDistance()` dùng để đo khoảng cách từ cảm biến siêu âm.

Hàm này sẽ gửi một xung siêu âm từ chân trigPin và đo thời gian phản hồi từ chân echoPin. Từ đó, ta tính toán khoảng cách bằng công thức `distance = duration * 0.034 / 2`, trong đó 0.034 là tốc độ âm thanh trong không khí (cm/μs).

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

Trong hàm loop, ta gọi hàm `getDistance()` để đo khoảng cách và in kết quả lên LCD. Đặt con trỏ tại vị trí cột 6, dòng 1 và in khoảng cách đo được cùng với đơn vị "cm". Cuối cùng, chờ 500ms trước khi đo lại:

```cpp
void loop() {
  long distance = getDistance();     // Gọi hàm đo khoảng cách

  lcd.setCursor(6, 1);               // Đặt con trỏ tại cột 6, dòng 1
  lcd.print("      ");               // Xóa giá trị cũ bằng khoảng trắng
  lcd.setCursor(6, 1);               // Đặt lại con trỏ tại vị trí in
  lcd.print(distance);              // In khoảng cách đo được
  lcd.print(" cm");                 // In đơn vị "cm"

  delay(500);                        // Chờ 500ms trước khi đo lại
}
```

## Kết quả

?> Khi có vật cản, LCD sẽ hiển thị khoảng cách từ cảm biến đến vật thể.

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase2/ultrasonic-sensor/ultrasonic-sensor-lcd-res.gif" alt="ultrasonic-sensor-lcd-result">
</p>

## Kết luận và Hướng phát triển

Bài viết đã hướng dẫn cách đo khoảng cách bằng cảm biến siêu âm và hiển thị lên LCD sử dụng board Zerobase 2 trên Arduino IDE. Đây là bước khởi đầu giúp bạn làm quen với lập trình vi điều khiển và cách điều khiển thiết bị ngoại vi.

Để phát triển thêm từ bài học này, bạn có thể thực hiện các ý tưởng sau:

- Thay đổi khoảng cách đo được thành đơn vị khác như inch hoặc feet.
- Thêm âm thanh thông báo khi khoảng cách vượt quá một ngưỡng nhất định.
- Thực hiện điều khiển động cơ hoặc LED dựa trên khoảng cách đo được.
- Kết hợp với các cảm biến khác như cảm biến nhiệt độ, độ ẩm để tạo ra một hệ thống đo lường đa chức năng.
- Thực hiện lưu trữ dữ liệu khoảng cách vào thẻ nhớ SD hoặc gửi dữ liệu qua Wi-Fi hoặc Bluetooth.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)

