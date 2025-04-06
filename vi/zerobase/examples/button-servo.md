<br>
<br>
<br>

# Điều khiển động cơ Servo bằng nút nhấn hiển thị lên LCD

![button-servo-circuit](https://cdn.chipstack.vn/zerobase/servo/button-servo-circuit.jpg)

## Tổng quan

?> Bài viết này hướng dẫn sử dụng nút nhấn để điều khiển động cơ Servo với Zerobase và hiển thị lên LCD 16x2.

## Chuẩn bị

| Linh kiện | Link mua |
|--- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |
| Động cơ Servo SG90 180 độ | [Mua ngay](https://chipstack.vn/san-pham/dong-co-servo-sg90-180-do/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="button-lcd-usb-type-c">
    <p><em>Dây USB Type C</em></p>
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

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/lcd-i2c.png" alt="lcd-i2c">
    <p><em>LCD Character 1602A nền xanh dương</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/module-i2c.png" alt="module-i2c">
    <p><em>Module I2C LCD 1602</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/button/push-button.png" alt="button-lcd-button">
    <p><em>Nút nhấn</em></p>
</div>

## Nguyên lý hoạt động

?> Sử dụng 2 nút để tăng hoặc giảm góc của động cơ Servo. Khi nhấn nút tăng, động cơ sẽ quay theo chiều kim đồng hồ và ngược lại. Giá trị góc sẽ được hiển thị lên LCD 16x2.

?> Mỗi lân nhấn nút, động cơ sẽ tăng hoặc giảm 10 độ.

## Sơ đồ kết nối

![zerobase-button-servo-pins.png](https://cdn.chipstack.vn/zerobase/servo/zerobase-button-servo-pins.png)

Sử dụng chân D10 để kết nối dây cam của động cơ Servo. Chân 5V của module nguồn sẽ được kết nối với chân màu đỏ của Servo. Chân GND của module nguồn sẽ được kết nối với chân màu nâu của Servo.

Chân D2 và D3 sẽ được kết nối với 2 chân của nút nhấn. 2 còn lại được nối với GND của module nguồn.

Chân SDA và SCL của module I2C LCD sẽ được kết nối với chân chân SDA (D18) và SCL (D19) của Zerobase. Chân VCC của module I2C LCD sẽ được kết nối với chân 5V của module nguồn. Chân GND của module I2C LCD sẽ được kết nối với chân GND của module nguồn.

5V của module nguồn sẽ được kết nối với chân 5V của Zerobase. Chân GND của module nguồn sẽ được kết nối với chân GND của Zerobase.

![button-servo-schematic.jpg](https://cdn.chipstack.vn/zerobase/servo/button-servo-schematic.png)

![button-servo-circuit](https://cdn.chipstack.vn/zerobase/servo/button-servo-circuit.jpg)

> Để tìm hiểu thêm về LCD, bạn có thể tham khảo bài viết [tại đây](vi/zerobase/examples/button-lcd.md).

> Tìm hiểu thêm ví dụ về động cơ Servo [tại đây](vi/zerobase/examples/serial-servo.mds).

!> **Ngắt nguồn trước khi nạp code**: Trước khi cắm dây USB vào để nạp code vào board Zerobase, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase và chạy code bình thường.

!> **Không dùng nguồn 5V từ Zerobase cho Servo**: Bạn không nên sử dụng nguồn 5V từ board Zerobase để cấp cho động cơ Servo, vì dòng điện của động cơ Servo có thể vượt quá dòng điện mà board Zerobase có thể cung cấp. Do đó sử dụng nguồn 5V từ module nguồn MB102 830 để cấp cho động cơ Servo là lựa chọn tốt nhất.

!> **Module nguồn MB102 830 ở chế độ 5V**: Bạn cần đảm bảo module nguồn MB102 830 đang ở chế độ 5V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 5V.

## Code

```cpp
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển màn hình LCD giao tiếp I2C
#include <ZBServo.h>            // Thư viện điều khiển servo của Zerobase

// Khởi tạo LCD địa chỉ 0x27 (tuỳ màn hình có thể là 0x3F), với kích thước 16x2
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Khởi tạo đối tượng servo
ZBServo myServo;

// Khai báo các chân kết nối nút nhấn và servo
const int buttonUpPin = 2;    // Nút tăng góc servo
const int buttonDownPin = 3;  // Nút giảm góc servo
const int servoPin = 10;      // Chân điều khiển servo

// Biến lưu trữ góc servo, bắt đầu từ 90 độ (trung vị)
int angle = 90;

void setup() {
  // Khởi động màn hình LCD
  lcd.init();
  lcd.backlight();  // Bật đèn nền LCD

  lcd.clear();               // Xoá màn hình hiển thị
  lcd.setCursor(4, 0);       // Đặt con trỏ tại cột 4, hàng 0
  lcd.print("Zerobase");     // In dòng chữ "Zerobase"
  lcd.setCursor(3, 1);       // Đặt con trỏ tại cột 3, hàng 1
  lcd.print("Starting...");  // In dòng chữ "Starting..."
  delay(2000);               // Dừng 2 giây để hiển thị

  lcd.clear();  // Xoá màn hình

  lcd.setCursor(4, 0);    // Đặt con trỏ
  lcd.print("ZB Servo");  // In tiêu đề

  // Hiển thị góc servo ban đầu
  lcd.setCursor(0, 1);
  lcd.print("Servo Angle: ");
  lcd.print(angle);

  // Gán servo vào chân điều khiển
  myServo.attach(servoPin);
  myServo.write(angle);  // Di chuyển servo tới góc ban đầu

  // Cấu hình các chân nút bấm là đầu vào và bật điện trở kéo lên nội bộ
  pinMode(buttonUpPin, INPUT_PULLUP);
  pinMode(buttonDownPin, INPUT_PULLUP);
}

void loop() {
  // Đọc trạng thái nút tăng góc
  bool upPressed = digitalRead(buttonUpPin) == LOW;

  // Đọc trạng thái nút giảm góc
  bool downPressed = digitalRead(buttonDownPin) == LOW;

  // Nếu nút tăng được nhấn
  if (upPressed) {
    angle += 10;                       // Tăng góc thêm 10 độ
    angle = constrain(angle, 0, 180);  // Giới hạn góc trong khoảng 0-180 độ
    updateServo();                     // Cập nhật servo và hiển thị
    delay(100);                        // Chống rung nút nhấn
  }

  // Nếu nút giảm được nhấn
  if (downPressed) {
    angle -= 10;                       // Giảm góc đi 10 độ
    angle = constrain(angle, 0, 180);  // Giới hạn góc trong khoảng 0-180 độ
    updateServo();                     // Cập nhật servo và hiển thị
    delay(100);                        // Chống rung nút nhấn
  }
}

// Hàm cập nhật vị trí servo và hiển thị lên LCD
void updateServo() {
  myServo.write(angle);  // Di chuyển servo tới góc mới

  lcd.setCursor(4, 0);    // Đặt con trỏ LCD
  lcd.print("ZB Servo");  // In tiêu đề

  lcd.setCursor(0, 1);          // Đặt con trỏ LCD
  lcd.print("Servo Angle: ");   // In dòng chữ
  lcd.print(angle);             // In giá trị góc servo
  lcd.print("              ");  // In thêm khoảng trắng để xoá dữ liệu cũ
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![button-servo-code](https://cdn.chipstack.vn/zerobase/servo/button-servo-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện Nạp Code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

### Giải thích code

Khai báo thư viện LCD và ZBServo để điều khiển LCD và Servo.

```cpp
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển màn hình LCD giao tiếp I2C
#include <ZBServo.h>            // Thư viện điều khiển servo của Zerobase
```

Khởi tạo đối tượng LCD với địa chỉ I2C 0x27, màn hình 16x2 ký tự.

```cpp
LiquidCrystal_I2C lcd(0x27, 16, 2);
```

Khởi tạo đối tượng servo để điều khiển servo motor.

```cpp
ZBServo myServo;
```

Khai báo các chân nút nhấn và chân điều khiển servo.

```cpp
const int buttonUpPin = 2;      // Nút tăng góc servo
const int buttonDownPin = 3;    // Nút giảm góc servo
const int servoPin = 10;        // Chân điều khiển servo
```

Khởi tạo biến góc servo với giá trị ban đầu là 90 độ.

```cpp
int angle = 90;  // Góc bắt đầu là 90 độ
```

Trong hàm `setup()`, khởi tạo và cấu hình LCD.

```cpp
lcd.init();  // Khởi động LCD
lcd.backlight();  // Bật đèn nền LCD
```

Xóa màn hình LCD và hiển thị thông báo khởi động ban đầu.

```cpp
lcd.clear();
lcd.setCursor(4, 0);
lcd.print("Zerobase");
lcd.setCursor(3, 1);
lcd.print("Starting...");
delay(2000);  // Đợi 2 giây
```

Xóa màn hình và hiển thị tiêu đề cùng với góc servo hiện tại.

```cpp
lcd.clear();
lcd.setCursor(4, 0);
lcd.print("ZB Servo");
lcd.setCursor(0, 1);
lcd.print("Servo Angle: ");
lcd.print(angle);
```

Gán servo vào chân điều khiển và di chuyển servo tới vị trí góc ban đầu.

```cpp
myServo.attach(servoPin);
myServo.write(angle);
```

Cấu hình các chân nút bấm là đầu vào với điện trở kéo lên nội bộ.

```cpp
pinMode(buttonUpPin, INPUT_PULLUP);
pinMode(buttonDownPin, INPUT_PULLUP);
```

Trong hàm `loop()`, đọc trạng thái của nút tăng góc.

```cpp
bool upPressed = digitalRead(buttonUpPin) == LOW;
```

Đọc trạng thái của nút giảm góc.

```cpp
bool downPressed = digitalRead(buttonDownPin) == LOW;
```

Nếu nút tăng được nhấn, tăng góc servo thêm 10 độ, giới hạn trong khoảng 0-180 độ, cập nhật servo và chờ 100ms.

```cpp
if (upPressed) {
  angle += 10;
  angle = constrain(angle, 0, 180);
  updateServo();
  delay(100);
}
```

Nếu nút giảm được nhấn, giảm góc servo đi 10 độ, giới hạn trong khoảng 0-180 độ, cập nhật servo và chờ 100ms.

```cpp
if (downPressed) {
  angle -= 10;
  angle = constrain(angle, 0, 180);
  updateServo();
  delay(100);
}
```

Hàm `updateServo()` để cập nhật vị trí servo và hiển thị lên LCD.

```cpp
myServo.write(angle);  // Di chuyển servo tới góc mới

lcd.setCursor(4, 0);
lcd.print("ZB Servo");

lcd.setCursor(0, 1);
lcd.print("Servo Angle: ");
lcd.print(angle);
lcd.print("              ");  // Xóa ký tự thừa trên LCD
```

## Kết quả

?> Khi nhấn nút tăng, động cơ Servo sẽ quay theo chiều kim đồng hồ và ngược lại. Giá trị góc sẽ được hiển thị lên LCD 16x2.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/servo/button-servo-result.gif" alt="button-servo-gif">
    <p><em>Điều khiển động cơ Servo bằng nút nhấn hiển thị lên LCD</em></p>
</div>

Mình đã tạo thêm phần "Kết luận và hướng phát triển" như bạn yêu cầu. Dưới đây là nội dung chi tiết:

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn bạn cách điều khiển động cơ Servo bằng nút nhấn và hiển thị lên LCD 16x2.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Sử dụng nhiều servo:** Thêm điều khiển cho nhiều servo và điều chỉnh đồng thời nhiều góc, có thể dùng thêm nút nhấn hoặc cảm biến để điều khiển các servo theo yêu cầu.
- **Cải thiện giao diện người dùng:** Thêm các thông báo chi tiết hơn trên LCD, chẳng hạn như thông báo về trạng thái hoặc góc điều khiển của từng servo.
- **Điều khiển từ xa:** Bạn có thể thêm chức năng điều khiển servo từ xa qua Bluetooth hoặc Wi-Fi, sử dụng một ứng dụng di động hoặc máy tính để điều khiển servo qua giao diện người dùng.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)