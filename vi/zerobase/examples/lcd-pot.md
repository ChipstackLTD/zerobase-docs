<br>
<br>
<br>

# Hiển thị giá trị ADC từ biến trở lên LCD

![lcd-pot-circuit](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-pot-circuit.jpg)

## Tổng quan

Bài hướng dẫn này sẽ giúp bạn hiển thị giá trị ADC từ biến trở lên LCD 16x2.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Biến trở 10kΩ | [Mua ngay](https://chipstack.vn/san-pham/bien-tro-wh148-3-chan-truc-15mm/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
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
    <img src="https://cdn.chipstack.vn/zerobase/potentiometer/potentiometer.jpg" alt="potentiometer">
    <p><em>Biến trở 10kΩ</em></p>
</div>

## Nguyên lý hoạt động 

?> Biến trở có ba chân: hai chân ngoài nối với nguồn và GND, chân giữa xuất ra điện áp thay đổi khi xoay biến trở. Board Zerobase đọc điện áp từ chân giữa của biến trở bằng cổng analog A1, sau đó chuyển đổi thành giá trị số (ADC) để vi điều khiển xử lý.

?> Giá trị ADC này được hiển thị lên LCD 16x2 thông qua giao thức I2C.

## Sơ đồ kết nối

![zerobase-lcd-pot-pins](https://cdn.chipstack.vn/zerobase/lcd-module/zerobase-lcd-pot-pins.png)

Sử dụng chân A2 của board Zerobase để nối với chân giữa của biến trở. Chân 5V nối với 1 trong 2 chân ngoài của biến trở, chân GND nối với chân còn lại của biến trở.

Chân SDA của board Zerobase nối với chân SDA của module I2C LCD, chân SCL nối với chân SCL của module I2C LCD. Chân VCC của module I2C LCD nối với chân 5V của board Zerobase, chân GND nối với chân GND của board Zerobase.

![lcd-pot-schematic](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-pot-schematic.png)

![lcd-pot-circuit](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-pot-circuit.jpg)

## Code

```cpp
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển màn hình LCD I2C

// Khai báo địa chỉ LCD 0x27 hoặc 0x3F (tùy vào module)
LiquidCrystal_I2C lcd(0x27, 16, 2);  // Khởi tạo đối tượng LCD với địa chỉ 0x27, kích thước 16x2

const int potPin = A2;  // Chân analog đọc giá trị từ biến trở

void setup() {
  lcd.init();                 // Khởi động màn hình LCD
  lcd.backlight();            // Bật đèn nền LCD
  lcd.setCursor(2, 0);        // Đặt con trỏ tại vị trí cột 2, dòng 0
  lcd.print("Zerobase ADC");  // In chuỗi "Zerobase ADC" lên LCD
}

void loop() {
  int value = analogRead(potPin);  // Đọc giá trị từ biến trở (0 - 1023)

  lcd.setCursor(2, 1);   // Đặt con trỏ tại vị trí cột 2, dòng 1
  lcd.print("Value: ");  // In chuỗi "Value: " lên LCD
  lcd.print(value);      // Hiển thị giá trị số đọc được từ biến trở
  lcd.print("   ");      // Xóa ký tự dư trên màn hình LCD (nếu giá trị nhỏ hơn giá trị trước đó)

  delay(500);  // Chờ 500ms trước khi cập nhật lại giá trị mới
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![lcd-pot-zerobase-code](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-pot-zerobase-code.png "lcd-zerobase-code]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

### Giải thích code

Khai báo thư viện `LiquidCrystal_I2C.h` để điều khiển màn hình LCD thông qua giao tiếp I2C. Thư viện này giúp đơn giản hóa việc giao tiếp giữa vi điều khiển và màn hình LCD, chỉ cần sử dụng hai chân SDA và SCL thay vì nhiều chân dữ liệu như khi sử dụng giao tiếp song song.

```cpp
#include <LiquidCrystal_I2C.h>  // Thư viện hỗ trợ giao tiếp LCD qua I2C
```

Khai báo địa chỉ I2C của module LCD. Địa chỉ này có thể là 0x27 hoặc 0x3F, tùy thuộc vào module bạn đang sử dụng. Bạn có thể kiểm tra địa chỉ I2C của module LCD bằng cách sử dụng một số công cụ quét I2C trên Arduino.

```cpp
LiquidCrystal_I2C lcd(0x27, 16, 2);  // Khởi tạo đối tượng LCD với địa chỉ 0x27, kích thước 16x2
```

Khai báo chân kết nối biến trở với chân A2 của board Zerobase. Chân này sẽ được sử dụng để đọc giá trị ADC từ biến trở.

```cpp
const int potPin = A2;  // Chân analog đọc giá trị từ biến trở
```

Trong hàm `setup()`:

- `lcd.init();` khởi tạo màn hình LCD.
- `lcd.backlight();` bật đèn nền của màn hình.
- `lcd.setCursor(2, 0);` đặt con trỏ tại vị trí cột 2, dòng 0.
- `lcd.print("Zerobase ADC");` in chuỗi "Zerobase ADC" lên màn hình LCD.

```cpp
  lcd.init();                 // Khởi động màn hình LCD
  lcd.backlight();            // Bật đèn nền LCD
  lcd.setCursor(2, 0);        // Đặt con trỏ tại vị trí cột 2, dòng 0
  lcd.print("Zerobase ADC");  // In chuỗi "Zerobase ADC" lên LCD
```

Trong hàm `loop()`:
- `int value = analogRead(potPin);` đọc giá trị từ chân A2 (biến trở) và lưu vào biến `value`. Giá trị này sẽ nằm trong khoảng từ 0 đến 1023.
- `lcd.setCursor(2, 1);` đặt con trỏ tại vị trí cột 2, dòng 1.
- `lcd.print(value);`: Hiển thị giá trị số đọc được từ biến trở.
- `lcd.print("   ");`: Xoá giá trị vừa in lên để cập nhật giá trị mới trên LCD. Nếu giá trị mới nhỏ hơn giá trị cũ, các ký tự dư sẽ không bị xóa đi. Do đó, cần phải in thêm một số khoảng trắng để xóa các ký tự dư này.
- `delay(500);`: Chờ 500ms trước khi cập nhật lại giá trị mới.

```cpp
  int value = analogRead(potPin);  // Đọc giá trị từ biến trở (0 - 1023)
  lcd.setCursor(2, 1);   // Đặt con trỏ tại vị trí cột 2, dòng 1
  lcd.print("Value: ");  // In chuỗi "Value: " lên LCD
  lcd.print(value);      // Hiển thị giá trị số đọc được từ biến trở
  lcd.print("   ");      // Xóa ký tự dư trên màn hình LCD (nếu giá trị nhỏ hơn giá trị trước đó)
  delay(500);  // Chờ 500ms trước khi cập nhật lại giá trị mới
```

## Kết quả

Nếu bạn đã thực hiện đúng các bước, giá trị ADC sẽ được hiển thị lên màn hình LCD.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/lcd-pot-zerobase-result.gif" alt="lcd-pot-zerobase-result">
    <p><em>Kết quả hiển thị trên LCD 16x2</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn cách sử dụng biến trở để điều chỉnh độ sáng của LED với vi điều khiển Zerobase, thông qua việc đọc tín hiệu từ biến trở và hiển thị lên màn hình LCD. Đây là một ứng dụng cơ bản nhưng rất hữu ích trong điều khiển điện tử.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- Thay đổi giá trị hiển thị trên LCD thành giá trị điện áp tương ứng với giá trị ADC.
- Thêm một nút nhấn để thay đổi giữa các chế độ hiển thị khác nhau (ví dụ: giá trị ADC, điện áp, hoặc một số thông tin khác).
- Kết hợp với các cảm biến khác để hiển thị nhiều thông tin hơn trên LCD.

**Chúc bạn thành công!**
