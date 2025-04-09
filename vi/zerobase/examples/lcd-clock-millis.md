<br>
<br>
<br>

# Làm đồng hồ đơn giản dùng millis hiển thị lên LCD

![lcd-clock-millis-circuit](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-clock-millis-circuit.jpg)

## Tổng quan

?> Bài viết này hướng dẫn các bạn làm một chiếc đồng hồ đơn giản sử dụng hàm millis() để lấy thời gian và hiển thị lên LCD 16x2. Điều chỉnh thời gian bằng nút nhấn.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="button-lcd-zerobase">
    <p><em>Board Zerobase</em></p>
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

?> Chương trình sẽ sử dụng hàm millis() để lấy thời gian từ lúc khởi động cho đến hiện tại. Sau đó, chương trình sẽ chuyển đổi thời gian này thành giờ, phút và giây. Cuối cùng, chương trình sẽ hiển thị thời gian lên LCD.

?> Sử dụng 3 nút nhấn để điều chỉnh giờ, phút và giây. Nút 1 (D2) sẽ chọn Mode (giờ, phút, giây, trở về đồng hồ), nút 2 (D3) sẽ điều chỉnh thời gian tăng lên và nút 3 (D10) sẽ điều chỉnh thời gian giảm xuống.

## Sơ đồ kết nối

![lcd-menu-pins](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-menu-pins.png)

Sử dụng chân SDA (D18) và SCL (D19) để kết nối với chân SDA và SCL của LCD I2C. Sử dụng chân 5V để kết nối với chân VCC của LCD I2C. Sử dụng chân GND để kết nối với chân GND của LCD I2C.

Chân D2 kết nối với 1 chân của nút nhấn, chân còn lại kết nối với GND. Chân D3, D10 kết nối tương tự.

![lcd-clock-millis-schematic](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-clock-millis-schematic.png)

![lcd-clock-millis-circuit](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-clock-millis-circuit.jpg)

## Code

```cpp
// Thư viện điều khiển LCD sử dụng I2C
#include <LiquidCrystal_I2C.h>

// Khởi tạo đối tượng LCD với địa chỉ I2C là 0x27, LCD 16 cột 2 dòng
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Định nghĩa chân nút nhấn
const int btnMode = 2;
const int btnUp = 3;
const int btnDown = 10;

// Biến lưu trữ thời gian
int hours = 0, minutes = 0, seconds = 0;

// Biến lưu thời điểm trước đó để đo khoảng thời gian trôi qua
unsigned long previousMillis = 0;
// Khoảng thời gian chờ giữa mỗi lần tăng giây (1000ms = 1 giây)
const long interval = 1000;

// Chế độ chỉnh giờ
enum EditMode {
  NONE,        // Không chỉnh (chế độ chạy bình thường)
  SET_HOUR,    // Chỉnh giờ
  SET_MINUTE,  // Chỉnh phút
  SET_SECOND   // Chỉnh giây
};
EditMode mode = NONE;  // Khởi đầu ở chế độ bình thường

// Trạng thái trước đó của các nút nhấn (dùng để phát hiện cạnh xuống)
bool lastBtnModeState = HIGH;
bool lastBtnUpState = HIGH;
bool lastBtnDownState = HIGH;

void setup() {
  // Khởi tạo LCD
  lcd.init();
  lcd.backlight();  // Bật đèn nền

  // Thiết lập các chân nút nhấn là INPUT_PULLUP (mức HIGH mặc định)
  pinMode(btnMode, INPUT_PULLUP);
  pinMode(btnUp, INPUT_PULLUP);
  pinMode(btnDown, INPUT_PULLUP);

  // Hiển thị thông điệp khởi động
  lcd.setCursor(2, 0);       // Cột 2, dòng 0
  lcd.print("Zerobase!!!");  // Dòng chữ đầu
  lcd.setCursor(2, 1);       // Cột 2, dòng 1
  lcd.print("Starting...");  // Dòng chữ thứ hai
  delay(2000);               // Dừng lại 2 giây để người dùng đọc

  lcd.clear();  // Xóa màn hình sau khi hiển thị
}

void loop() {
  unsigned long currentMillis = millis();  // Lấy thời gian hiện tại

  // Nếu không ở chế độ chỉnh và đã trôi qua 1 giây
  if (mode == NONE && currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;  // Cập nhật thời điểm
    seconds++;                       // Tăng giây

    // Cập nhật phút và giờ nếu cần
    if (seconds >= 60) {
      seconds = 0;
      minutes++;
      if (minutes >= 60) {
        minutes = 0;
        hours++;
        if (hours >= 24) hours = 0;
      }
    }
  }

  // Xử lý nút nhấn
  handleButtons();

  // Hiển thị thời gian lên LCD
  displayTime();
}

// Hàm xử lý nút nhấn
void handleButtons() {
  // Đọc trạng thái hiện tại của các nút
  bool btnModeState = digitalRead(btnMode);
  bool btnUpState = digitalRead(btnUp);
  bool btnDownState = digitalRead(btnDown);

  // Nếu nút Mode vừa được nhấn (cạnh xuống)
  if (lastBtnModeState == HIGH && btnModeState == LOW) {
    // Chuyển sang chế độ tiếp theo (vòng tròn)
    mode = (EditMode)((mode + 1) % 4);
  }

  // Nếu nút Up vừa được nhấn
  if (btnUpState == LOW && lastBtnUpState == HIGH) {
    if (mode == SET_HOUR) hours = (hours + 1) % 24;
    else if (mode == SET_MINUTE) minutes = (minutes + 1) % 60;
    else if (mode == SET_SECOND) seconds = (seconds + 1) % 60;
  }

  // Nếu nút Down vừa được nhấn
  if (btnDownState == LOW && lastBtnDownState == HIGH) {
    if (mode == SET_HOUR) hours = (hours + 23) % 24;             // Giảm giờ
    else if (mode == SET_MINUTE) minutes = (minutes + 59) % 60;  // Giảm phút
    else if (mode == SET_SECOND) seconds = (seconds + 59) % 60;  // Giảm giây
  }

  // Cập nhật trạng thái trước đó cho lần lặp sau
  lastBtnModeState = btnModeState;
  lastBtnUpState = btnUpState;
  lastBtnDownState = btnDownState;
}

// Hàm hiển thị thời gian và thông tin chỉnh sửa lên LCD
void displayTime() {
  switch (mode) {
    case SET_HOUR:
      lcd.setCursor(0, 0);
      lcd.print("   ");
      lcd.setCursor(3, 0);
      lcd.print("Edit: Hour              ");
      break;
    case SET_MINUTE:
      lcd.setCursor(0, 0);
      lcd.print("  ");
      lcd.setCursor(2, 0);
      lcd.print("Edit: Minute          ");
      break;
    case SET_SECOND:
      lcd.setCursor(0, 0);
      lcd.print("  ");
      lcd.setCursor(2, 0);
      lcd.print("Edit: Second          ");
      break;
    case NONE:
      lcd.setCursor(0, 0);
      lcd.print(" Zerobase clock            ");
      break;
  }

  // Hiển thị thời gian dưới dòng thứ hai
  lcd.setCursor(4, 1);
  printDigits(hours);
  lcd.print(":");
  printDigits(minutes);
  lcd.print(":");
  printDigits(seconds);
}

// Hàm in số có định dạng 2 chữ số (ví dụ: 01, 09, 12,...)
void printDigits(int digits) {
  if (digits < 10)
    lcd.print("0");  // Thêm số 0 phía trước nếu nhỏ hơn 10
  lcd.print(digits);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![lcd-clock-millis-code](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-clock-millis-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu bạn muốn thay đổi chân kết nối nút nhấn, hãy thay đổi các biến `btnMode`, `btnUp`, `btnDown` trong code cho phù hợp với chân mà bạn đã kết nối.

```cpp
// Định nghĩa chân nút nhấn
const int btnMode = 2;
const int btnUp = 3;
const int btnDown = 10;
```

Giải thích chi tiết từng dòng trong đoạn code đồng hồ điều chỉnh bằng nút nhấn:

---

### Giải thích code

#### Khai báo thư viện và đối tượng LCD

Khai báo thư viện điều khiển LCD sử dụng giao tiếp I2C:
```cpp
#include <LiquidCrystal_I2C.h>
```

Khởi tạo đối tượng LCD với địa chỉ I2C là `0x27`, LCD có 16 cột và 2 dòng:
```cpp
LiquidCrystal_I2C lcd(0x27, 16, 2);
```

---

#### Khai báo chân nút nhấn

Khai báo chân nối nút nhấn "Mode":
```cpp
const int btnMode = 2;
```

Khai báo chân nối nút nhấn "Up":
```cpp
const int btnUp = 3;
```

Khai báo chân nối nút nhấn "Down":
```cpp
const int btnDown = 10;
```

---

#### Biến thời gian

Khai báo biến lưu trữ giá trị giờ, phút, giây:
```cpp
int hours = 0, minutes = 0, seconds = 0;
```

Khai báo biến lưu thời điểm trước đó để đo thời gian trôi qua:
```cpp
unsigned long previousMillis = 0;
```

Đặt khoảng thời gian giữa mỗi lần tăng giây là 1000 mili giây:
```cpp
const long interval = 1000;
```

---

#### Khai báo chế độ chỉnh giờ

Định nghĩa enum cho các chế độ chỉnh giờ:
```cpp
enum EditMode {
  NONE,        // Không chỉnh
  SET_HOUR,    // Chỉnh giờ
  SET_MINUTE,  // Chỉnh phút
  SET_SECOND   // Chỉnh giây
};
```

Biến `mode` lưu chế độ hiện tại, mặc định là `NONE` (không chỉnh):
```cpp
EditMode mode = NONE;
```

---

#### Biến trạng thái nút nhấn

Các biến lưu trạng thái trước đó của nút nhấn, phục vụ việc phát hiện cạnh xuống:
```cpp
bool lastBtnModeState = HIGH;
bool lastBtnUpState = HIGH;
bool lastBtnDownState = HIGH;
```

---

#### setup()

Khởi động LCD và bật đèn nền:
```cpp
lcd.init();
lcd.backlight();
```

Cấu hình các chân nút nhấn là INPUT_PULLUP:
```cpp
pinMode(btnMode, INPUT_PULLUP);
pinMode(btnUp, INPUT_PULLUP);
pinMode(btnDown, INPUT_PULLUP);
```

Hiển thị dòng chữ khởi động:
```cpp
lcd.setCursor(2, 0);
lcd.print("Zerobase!!!");
lcd.setCursor(2, 1);
lcd.print("Starting...");
delay(2000);
```

Xóa màn hình sau khi hiển thị:
```cpp
lcd.clear();
```

---

#### loop()

Lấy thời gian hiện tại:
```cpp
unsigned long currentMillis = millis();
```

Nếu không ở chế độ chỉnh và đã trôi qua 1 giây, tiến hành tăng thời gian:
```cpp
if (mode == NONE && currentMillis - previousMillis >= interval) {
  previousMillis = currentMillis;
  seconds++;
```

Nếu giây >= 60 thì tăng phút:
```cpp
  if (seconds >= 60) {
    seconds = 0;
    minutes++;
```

Nếu phút >= 60 thì tăng giờ:
```cpp
    if (minutes >= 60) {
      minutes = 0;
      hours++;
      if (hours >= 24) hours = 0;
    }
  }
}
```

Xử lý nút nhấn:
```cpp
handleButtons();
```

Hiển thị thời gian lên LCD:
```cpp
displayTime();
```

---

#### handleButtons()

Đọc trạng thái các nút:
```cpp
bool btnModeState = digitalRead(btnMode);
bool btnUpState = digitalRead(btnUp);
bool btnDownState = digitalRead(btnDown);
```

Nếu phát hiện cạnh xuống nút Mode thì chuyển sang chế độ tiếp theo:
```cpp
if (lastBtnModeState == HIGH && btnModeState == LOW) {
  mode = (EditMode)((mode + 1) % 4);
}
```

Nếu phát hiện cạnh xuống nút Up, tăng giá trị tương ứng với chế độ:
```cpp
if (btnUpState == LOW && lastBtnUpState == HIGH) {
  if (mode == SET_HOUR) hours = (hours + 1) % 24;
  else if (mode == SET_MINUTE) minutes = (minutes + 1) % 60;
  else if (mode == SET_SECOND) seconds = (seconds + 1) % 60;
}
```

Nếu phát hiện cạnh xuống nút Down, giảm giá trị tương ứng với chế độ:
```cpp
if (btnDownState == LOW && lastBtnDownState == HIGH) {
  if (mode == SET_HOUR) hours = (hours + 23) % 24;
  else if (mode == SET_MINUTE) minutes = (minutes + 59) % 60;
  else if (mode == SET_SECOND) seconds = (seconds + 59) % 60;
}
```

Cập nhật lại trạng thái trước đó:
```cpp
lastBtnModeState = btnModeState;
lastBtnUpState = btnUpState;
lastBtnDownState = btnDownState;
```

---

#### displayTime()

Hiển thị nội dung tùy theo chế độ:
```cpp
switch (mode) {
  case SET_HOUR:
    lcd.setCursor(0, 0);
    lcd.print("   ");
    lcd.setCursor(3, 0);
    lcd.print("Edit: Hour              ");
    break;
  case SET_MINUTE:
    lcd.setCursor(0, 0);
    lcd.print("  ");
    lcd.setCursor(2, 0);
    lcd.print("Edit: Minute          ");
    break;
  case SET_SECOND:
    lcd.setCursor(0, 0);
    lcd.print("  ");
    lcd.setCursor(2, 0);
    lcd.print("Edit: Second          ");
    break;
  case NONE:
    lcd.setCursor(0, 0);
    lcd.print(" Zerobase clock            ");
    break;
}
```

Hiển thị thời gian dòng thứ hai:
```cpp
lcd.setCursor(4, 1);
printDigits(hours);
lcd.print(":");
printDigits(minutes);
lcd.print(":");
printDigits(seconds);
```

---

#### printDigits()

Hàm in số có 2 chữ số:
```cpp
void printDigits(int digits) {
  if (digits < 10)
    lcd.print("0");
  lcd.print(digits);
}
```

## Kết quả

?> Khi khởi động bạn sẽ thấy đồng hồ sẽ chạy lúc `00:00:00` và hiển thị dòng chữ "Zerobase clock". Bạn có thể điều chỉnh giờ, phút, giây bằng các nút nhấn tương ứng. Nhấn nút Mode để chuyển chế độ chỉnh sửa, nhấn nút Up để tăng giá trị và nhấn nút Down để giảm giá trị.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/lcd-clock-millis-result.gif" alt="lcd-clock-millis">
    <p><em>Kết quả hiển thị trên LCD</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn bạn cách tạo đồng hồ đơn giản sử dụng hàm millis() và hiển thị lên LCD.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- Phát triển thêm các tính năng như báo thức
- Đồng hồ bấm giờ
- Đồng hồ đếm ngược

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)