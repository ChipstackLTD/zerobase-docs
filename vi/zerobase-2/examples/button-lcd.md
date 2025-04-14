<br>
<br>
<br>

# Đếm số lần nhấn nút và hiển thị lên LCD

![button-lcd](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-zerobase2.png)

## Tổng quan

?> Bài viết này hướng dẫn đếm số lần nhấn nút và hiển thị lên LCD với Zerobase 2.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2| [Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="button-lcd-zerobase2">
    <p><em>Board Zerobase 2</em></p>
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

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/jumper-wire.png" alt="button-lcd-jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="button-lcd-usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="button-lcd-breadboard">
    <p><em>Breadboard</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/button/push-button.png" alt="button-lcd-button">
    <p><em>Nút nhấn</em></p>
</div>

## Nguyên lý hoạt động

?> Sử dụng 2 nút nhấn, nút đếm và nút reset. Khi nhấn nút đếm, vi điều khiển Zerobase 2 sẽ phát hiện tín hiệu và tăng giá trị biến đếm lên 1 đơn vị. Giá trị này được gửi đến màn hình LCD qua giao tiếp I2C để hiển thị số lần nhấn. Nếu nhấn nút reset, biến đếm sẽ được đặt lại về 0 và màn hình LCD cũng cập nhật lại giá trị. Hệ thống đảm bảo mỗi lần nhấn nút chỉ được tính một lần bằng cách sử dụng kỹ thuật chống dội (debounce). Việc sử dụng hai nút giúp người dùng có thể dễ dàng theo dõi số lần nhấn và đặt lại khi cần thiết.

> Để tìm hiểu thêm kỹ thuật chống dội, bạn có thể xem [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/examples/debounce-button).

## Sơ đồ kết nối

![button-lcd-zerobase2-pins](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-zerobase2-pins.png)

Sử dụng chân SDA (D18) và SCL (D19) để kết nối với chân SDA và SCL của LCD I2C. Sử dụng chân 5V để kết nối với chân VCC của LCD I2C. Sử dụng chân GND để kết nối với chân GND của LCD I2C. 

Sử dụng D1 để kết nối với với một chân với nút đếm, chân còn lại nối với GND của Zerobase 2. 

Sử dụng D0 để kết nối với một chân của nút reset và chân còn lại cũng nối với GND của Zerobase 2.

![button-lcd-schematic](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-schematic.png)

![button-lcd](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-zerobase2.png)

## Code

```cpp
#include <LiquidCrystal_I2C.h>

// Khai báo chân kết nối của các nút bấm
const int btn_count_pin = 1;  // Nút đếm ở chân 1
const int btn_reset_pin = 0;  // Nút reset ở chân 0

// Thời gian chống dội phím (debounce)
const int debounce_time = 150;  // Đơn vị: mili giây

// Khởi tạo màn hình LCD I2C với địa chỉ 0x27, 16 cột và 2 hàng
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Biến lưu giá trị đếm
int count = 0;

// Biến trạng thái của các nút bấm
bool lastBtnCountState = HIGH;
bool lastBtnResetState = HIGH;

// Biến lưu thời gian lần cuối nhấn nút
unsigned long lastBtnCountTime = 0;
unsigned long lastBtnResetTime = 0;

void setup() {
  // Khởi động LCD
  lcd.init();
  lcd.backlight();

  // Thiết lập chế độ cho các chân nút bấm
  pinMode(btn_count_pin, INPUT_PULLUP);
  pinMode(btn_reset_pin, INPUT_PULLUP);

  // Hiển thị thông báo khởi động trên LCD
  lcd.setCursor(3, 0);
  lcd.print("Zerobase 2!!!");
  lcd.setCursor(3, 1);
  lcd.print("Starting...");
  delay(2000);

  // Xóa màn hình và cập nhật giá trị ban đầu
  lcd.clear();
  updateLCD();
}

void loop() {
  unsigned long currentMillis = millis();  // Lấy thời gian hiện tại

  // Đọc trạng thái nút đếm
  bool btnCountState = digitalRead(btn_count_pin);
  if (btnCountState == LOW && lastBtnCountState == HIGH && (currentMillis - lastBtnCountTime) > debounce_time) {
    count++;                           // Tăng giá trị đếm
    updateLCD();                       // Cập nhật màn hình LCD
    lastBtnCountTime = currentMillis;  // Lưu thời gian nhấn nút
  }
  lastBtnCountState = btnCountState;  // Cập nhật trạng thái nút

  // Đọc trạng thái nút reset
  bool btnResetState = digitalRead(btn_reset_pin);
  if (btnResetState == LOW && lastBtnResetState == HIGH && (currentMillis - lastBtnResetTime) > debounce_time) {
    count = 0;                         // Reset giá trị đếm
    updateLCD();                       // Cập nhật màn hình LCD
    lastBtnResetTime = currentMillis;  // Lưu thời gian nhấn nút
  }
  lastBtnResetState = btnResetState;  // Cập nhật trạng thái nút
}

// Cập nhật giá trị hiển thị trên LCD
void updateLCD() {
  lcd.setCursor(1, 0);
  lcd.print("Press to Count");  // Hiển thị hướng dẫn sử dụng

  lcd.setCursor(3, 1);
  lcd.print("Count: ");                // Hiển thị chữ "Count"
  lcd.print("                     ");  // Xóa dữ liệu cũ để tránh lỗi hiển thị

  lcd.setCursor(11, 1);
  lcd.print(count);  // Hiển thị giá trị đếm
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![button-lcd-zerobase2-code](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-zerobase2-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `btn_count_pin` hoặc `btn_reset_pin` trong code sau đó kết nối nút nhấn với chân tương ứng.

```cpp
const int btn_count_pin = 1;  // Thay đổi chân nút đếm
const int btn_reset_pin = 0;  // Thay đổi chân nút reset
```

Nếu muốn thay đổi thời gian chống dội, bạn chỉ cần sửa lại giá trị biến `debounce_time` trong code.

```cpp
const int debounce_time = 150;  // Thay đổi thời gian chống dội
```

### Giải Thích Code

Thêm thư viện cho màn hình LCD I2C:

```cpp
#include <LiquidCrystal_I2C.h>
```

Khai báo chân kết nối của các nút bấm:

```cpp
const int btn_count_pin = 1;  // Nút đếm ở chân 1
const int btn_reset_pin = 0;  // Nút reset ở chân 0
```

Khi nhấn nút, tín hiệu có thể bị nhiễu (dội phím). Ta cần đợi 150ms để đảm bảo chỉ nhận một lần nhấn hợp lệ:

```cpp
const int debounce_time = 150;  // Đơn vị: mili giây
```

Khởi tạo màn hình LCD I2C với 0x27: Địa chỉ I2C của màn hình LCD (có thể thay đổi tùy loại màn hình) và 16, 2: Màn hình có 16 cột và 2 hàng.

```cpp
LiquidCrystal_I2C lcd(0x27, 16, 2);
```

Lưu giá trị số lần nhấn nút.

```cpp
int count = 0;
```


Vấn đề: Khi bạn giữ nút lâu, chương trình sẽ liên tục tăng count ở mỗi vòng lặp loop(), thay vì chỉ tăng một lần cho mỗi lần nhấn. Do đó ta sử dụng 2 biến `lastBtnCountState`: Lưu trạng thái trước đó của nút đếm. `lastBtnResetState`: Lưu trạng thái trước đó của nút reset. Mặc định ban đầu là HIGH do các nút sử dụng chế độ `INPUT_PULLUP`.

```cpp
bool lastBtnCountState = HIGH;
bool lastBtnResetState = HIGH;
```

`lastBtnCountTime`: Lưu thời gian lần cuối bấm nút đếm. `lastBtnResetTime`: Lưu thời gian lần cuối bấm nút reset. Dùng unsigned long vì hàm `millis()` trả về giá trị lớn.
  
  ```cpp
unsigned long lastBtnCountTime = 0;
unsigned long lastBtnResetTime = 0;
```

`lcd.init()`: Khởi tạo màn hình LCD. `lcd.backlight()`: Bật đèn nền màn hình LCD.

```cpp
lcd.init();
lcd.backlight();
```

Thiết lập chân nút đếm và nút reset là INPUT_PULLUP để sử dụng điện trở kéo lên nội bộ của vi điều khiển.

```cpp
pinMode(btn_count_pin, INPUT_PULLUP);
pinMode(btn_reset_pin, INPUT_PULLUP);
```

Hiển thị thông báo khởi động trên LCD: `lcd.setCursor(x, y)`: Di chuyển con trỏ đến hàng x và cột y. `lcd.print("Zerobase 2!!!")`: In dòng chữ "Zerobase 2!!!" trên hàng đầu. `delay(2000)`: Dừng chương trình trong 2 giây.

```cpp
lcd.setCursor(3, 0);
lcd.print("Zerobase 2!!!");
lcd.setCursor(3, 1);
lcd.print("Starting...");
delay(2000);
```

Xóa màn hình và hiển thị giá trị ban đầu:

```cpp
lcd.clear();
updateLCD();
```

Hàm `updateLCD()` - Cập nhật hiển thị LCD: 

```cpp
void updateLCD()
```

Trong hàm `updateLCD()`: Hiển thị dòng chữ "Press to Count" trên hàng đầu.

```cpp
lcd.setCursor(1, 0);
lcd.print("Press to Count");  // Hiển thị hướng dẫn sử dụng
```

Hiển thị chữ "Count" tại cột thứ ba và hàng thứ hai.

```cpp
lcd.setCursor(3, 1);
lcd.print("Count: ");                // Hiển thị chữ "Count"
```

Màn hình LCD không tự động xóa ký tự cũ khi in dữ liệu mới. Để tránh lỗi hiển thị, ta xóa dữ liệu cũ trước khi in giá trị mới của biến `count`.

```cpp
lcd.print("                     ");  // Xóa dữ liệu cũ để tránh lỗi hiển thị
```

Hiển thị giá trị của biến `count` tại cột thứ 11 và hàng thứ hai.

```cpp
lcd.setCursor(11, 1);
lcd.print(count);  // Hiển thị giá trị đếm
```

Trong hàm `loop()`: Lấy thời gian hiện tại.

```cpp
unsigned long currentMillis = millis();  // Lấy thời gian hiện tại
```

Đọc trạng thái nút đếm:

```cpp
bool btnCountState = digitalRead(btn_count_pin);
```

Nếu nút đếm được nhấn và trạng thái trước đó là không nhấn và thời gian từ lần nhấn trước đó đến lần nhấn hiện tại lớn hơn thời gian chống dội:

```cpp
if (btnCountState == LOW && lastBtnCountState == HIGH && (currentMillis - lastBtnCountTime) > debounce_time)
```

Tăng giá trị đếm lên 1 đơn vị:

```cpp
count++;                           // Tăng giá trị đếm
```

Cập nhật lại màn hình LCD:

```cpp
updateLCD();
```

Lưu thời gian lần nhấn nút:

```cpp
lastBtnCountTime = currentMillis;  // Lưu thời gian nhấn nút
```

Cập nhật trạng thái nút:

```cpp
lastBtnCountState = btnCountState;  // Cập nhật trạng thái nút
```

Đọc trạng thái nút reset:

```cpp
bool btnResetState = digitalRead(btn_reset_pin);
```

Nếu nút reset được nhấn và trạng thái trước đó là không nhấn và thời gian từ lần nhấn trước đó đến lần nhấn hiện tại lớn hơn thời gian chống dội:

```cpp
if (btnResetState == LOW && lastBtnResetState == HIGH && (currentMillis - lastBtnResetTime) > debounce_time)
```

Reset giá trị đếm về 0 và cập nhật lại màn hình LCD:

```cpp
count = 0;                         // Reset giá trị đếm
    updateLCD();                       // Cập nhật màn hình LCD
```

Lưu thời gian lần nhấn nút:

```cpp
lastBtnResetTime = currentMillis;  // Lưu thời gian nhấn nút
```

Cập nhật trạng thái nút:

```cpp
lastBtnResetState = btnResetState;  // Cập nhật trạng thái nút
```

## Kết quả

?> Khi nút đếm được nhấn giá trị đếm sẽ tăng lên 1 đơn vị. Khi nút reset được nhấn giá trị đếm sẽ được đặt lại về 0.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-result.gif" alt="button-lcd-result">
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn chi tiết cách đếm số lần nhấn nút và hiển thị lên LCD với Zerobase 2.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Thêm nút giảm giá trị đếm**: Thêm một nút để giảm giá trị đếm.
- **Hiển thị thông báo khi đạt giá trị nhất định**: Hiển thị thông báo hoặc thực hiện một hành động khi giá trị đếm đạt giá trị nhất định.
- **Lưu giá trị đếm vào EEPROM**: Lưu giá trị đếm vào bộ nhớ EEPROM để giữ giá trị khi tắt nguồn.
- **Kết nối IOT**: Kết nối Zerobase 2 với Internet để gửi giá trị đếm lên Cloud.

Với những gợi ý trên, bạn có thể tiếp tục mở rộng dự án để tạo ra nhiều ứng dụng thực tế hơn.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)