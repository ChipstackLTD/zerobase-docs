<br>
<br>
<br>

# Sử Dụng Module Thời GIan Thực RTC DS3231 Với Zerobase

![rtc-circuit](https://cdn.chipstack.vn/zerobase/rtc/rtc-circuit.jpg)

## Tổng quan

?> Bài viết này hướng dẫn bạn cách sử dụng module thời gian thực RTC DS3231 với bo mạch Zerobase. Module này giúp bạn theo dõi thời gian thực ngay cả khi mất điện.

## Chuẩn bị


| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Module RTC DS3231 | [Mua ngay](https://chipstack.vn/san-pham/module-thoi-gian-thuc-ds3231/) |

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
    <img src="https://cdn.chipstack.vn/rtc/rtc-ds3231.jpg" alt="button-lcd-rtc-ds3231">
    <p><em>Module RTC DS3231</em></p>
</div>


## Cài Đặt Thư Viện

Để sử dụng RTC DS3231, bạn cần cài đặt thư viện hỗ trợ. 

1. Truy cập [GitHub DS3231 Library](https://github.com/NorthernWidget/DS3231).
2. Tải về và giải nén thư viện.
3. Mở Arduino IDE, vào Sketch > Include Library > Add .ZIP Library....
4. Chọn file .zip vừa tải về để cài đặt thư viện.

## Sơ đồ kết nối

![rtc-pins](https://cdn.chipstack.vn/zerobase/rtc/rtc-pins.png)

Sử dụng chân SDA (D18) và SCL (D19) để kết nối với chân SDA và SCL của LCD I2C và RTC. Sử dụng chân 5V để kết nối với chân VCC của LCD I2C và RTC. Sử dụng chân GND để kết nối với chân GND của LCD I2C và RTC.

![rtc-schematic](https://cdn.chipstack.vn/zerobase/rtc/rtc-schematic.png)

![rtc-circuit](https://cdn.chipstack.vn/zerobase/rtc/rtc-circuit.jpg)

## Code

```cpp
// Thư viện I2C chuẩn của Arduino để giao tiếp với các thiết bị sử dụng giao thức I2C
#include <Wire.h>

// Thư viện điều khiển module thời gian thực DS3231
#include <DS3231.h>

// Thư viện điều khiển LCD sử dụng giao tiếp I2C
#include <LiquidCrystal_I2C.h>

// Khởi tạo đối tượng DS3231 để giao tiếp với module thời gian thực
DS3231 myRTC;

// Khởi tạo đối tượng LCD có địa chỉ I2C là 0x27, màn hình LCD có 16 cột và 2 hàng
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Các giá trị thời gian cần cài đặt khi bắt đầu chương trình
const byte setYear = 25;    // Năm 2025 (chỉ 2 chữ số cuối)
const byte setMonth = 4;    // Tháng 4
const byte setDate = 9;     // Ngày 9
const byte setDOW = 4;      // Thứ 4 (1 = Chủ Nhật, 2 = Thứ 2, ..., 7 = Thứ 7)
const byte setHour = 15;    // 15 giờ (3 giờ chiều)
const byte setMinute = 58;  // 58 phút
const byte setSecond = 0;   // 0 giây

// Biến để đảm bảo rằng thời gian chỉ được thiết lập một lần
bool timeIsSet = false;

void setup() {
  // Bắt đầu giao tiếp I2C
  Wire.begin();

  // Khởi động LCD với cấu hình 16x2
  lcd.begin(16, 2);

  // Bật đèn nền LCD
  lcd.backlight();

  // Thiết lập chế độ 24h cho DS3231 (false = 24h, true = 12h)
  myRTC.setClockMode(false);

  // Kiểm tra nếu thời gian chưa được cài thì tiến hành cài đặt
  if (!timeIsSet) {
    // Thiết lập từng thành phần của thời gian thực
    myRTC.setYear(setYear);      // Năm
    myRTC.setMonth(setMonth);    // Tháng
    myRTC.setDate(setDate);      // Ngày
    myRTC.setDoW(setDOW);        // Thứ trong tuần
    myRTC.setHour(setHour);      // Giờ
    myRTC.setMinute(setMinute);  // Phút
    myRTC.setSecond(setSecond);  // Giây

    // Đánh dấu thời gian đã được thiết lập
    timeIsSet = true;

    // Hiển thị thông điệp khởi động
    lcd.setCursor(2, 0);       // Cột 2, dòng 0
    lcd.print("Zerobase!!!");  // Dòng chữ đầu
    lcd.setCursor(2, 1);       // Cột 2, dòng 1
    lcd.print("Starting...");  // Dòng chữ thứ hai
    delay(2000);               // Dừng lại 2 giây để người dùng đọc

    lcd.clear();  // Xóa màn hình sau khi hiển thị
  }
}

void loop() {
  // Biến trạng thái cho chế độ 12h/24h và AM/PM, bắt buộc khai báo khi gọi getHour
  bool h12, PM;

  // Biến lưu trạng thái thế kỷ (dùng nếu năm > 2099, không cần thiết ở đây)
  bool century;

  // Đọc thời gian thực từ module DS3231
  byte second = myRTC.getSecond();       // Giây hiện tại
  byte minute = myRTC.getMinute();       // Phút hiện tại
  byte hour = myRTC.getHour(h12, PM);    // Giờ hiện tại
  byte date = myRTC.getDate();           // Ngày hiện tại
  byte month = myRTC.getMonth(century);  // Tháng hiện tại
  byte year = myRTC.getYear();           // Năm hiện tại (2 chữ số cuối)
  byte dow = myRTC.getDoW();             // Thứ trong tuần

  // Mảng chứa tên viết tắt các ngày trong tuần
  const char* daysOfWeek[] = {
    "Err",  // Vị trí 0 không sử dụng (do DOW bắt đầu từ 1)
    "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
  };

  // Hiển thị ngày trong tuần lên LCD
  lcd.setCursor(1, 0);         // Đặt con trỏ tại hàng 0, cột 1
  lcd.print(daysOfWeek[dow]);  // In thứ (ví dụ: Mon)
  lcd.print(" ");

  // In ngày với định dạng 2 chữ số
  if (date < 10) lcd.print("0");
  lcd.print(date);
  lcd.print("/");

  // In tháng với định dạng 2 chữ số
  if (month < 10) lcd.print("0");
  lcd.print(month);
  lcd.print("/20");

  // In năm với định dạng 2 chữ số
  if (year < 10) lcd.print("0");
  lcd.print(year);

  // Hiển thị giờ ở dòng thứ 2
  lcd.setCursor(4, 1);  // Đặt con trỏ tại hàng 1, cột 4

  // In giờ với định dạng 2 chữ số
  if (hour < 10) lcd.print("0");
  lcd.print(hour);
  lcd.print(":");

  // In phút
  if (minute < 10) lcd.print("0");
  lcd.print(minute);
  lcd.print(":");

  // In giây
  if (second < 10) lcd.print("0");
  lcd.print(second);

  // Cập nhật màn hình mỗi giây
  delay(1000);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![rtc-code](https://cdn.chipstack.vn/zerobase/rtc/rtc-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Bạn có thể đổi thứ/ngày/tháng/năm/giờ/phút/giây trong code theo các biến sau:

```cpp
// Các giá trị thời gian cần cài đặt khi bắt đầu chương trình
const byte setYear = 25;    // Năm 2025 (chỉ 2 chữ số cuối)
const byte setMonth = 4;    // Tháng 4
const byte setDate = 9;     // Ngày 9
const byte setDOW = 4;      // Thứ 4 (1 = Chủ Nhật, 2 = Thứ 2, ..., 7 = Thứ 7)
const byte setHour = 15;    // 15 giờ (3 giờ chiều)
const byte setMinute = 58;  // 58 phút
const byte setSecond = 0;   // 0 giây
```

### Giải thích code

Khai báo các thư viện cần thiết cho việc sử dụng module DS3231 và LCD I2C. Thư viện `Wire.h` là thư viện chuẩn của Arduino để giao tiếp với các thiết bị sử dụng giao thức I2C. Thư viện `DS3231.h` là thư viện điều khiển module thời gian thực DS3231. Thư viện `LiquidCrystal_I2C.h` là thư viện điều khiển LCD sử dụng giao tiếp I2C.

```cpp
#include <Wire.h>                // Thư viện I2C chuẩn của Arduino
#include <DS3231.h>              // Thư viện điều khiển DS3231
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển LCD I2C
```

Khởi tạo đối tượng để giao tiếp với DS3231 và LCD:
```cpp
DS3231 myRTC;                                   // Đối tượng giao tiếp với module DS3231
LiquidCrystal_I2C lcd(0x27, 16, 2);             // LCD I2C địa chỉ 0x27, 16 cột, 2 dòng
```

Cài đặt giá trị thời gian sẽ được thiết lập cho DS3231 khi chương trình bắt đầu chạy:
```cpp
const byte setYear = 25;    // Năm 2025
const byte setMonth = 4;    // Tháng 4
const byte setDate = 9;     // Ngày 9
const byte setDOW = 4;      // Thứ 4
const byte setHour = 15;    // 15 giờ
const byte setMinute = 58;  // 58 phút
const byte setSecond = 0;   // 0 giây
```

Biến `timeIsSet` đảm bảo việc thiết lập thời gian chỉ thực hiện một lần trong `setup()`:
```cpp
bool timeIsSet = false;
```

Khởi tạo I2C, LCD, thiết lập chế độ đồng hồ 24h và cài đặt thời gian thực nếu chưa cài đặt:
```cpp
void setup() {
  Wire.begin();                     // Bắt đầu giao tiếp I2C
  lcd.begin(16, 2);                 // Khởi động LCD với kích thước 16x2
  lcd.backlight();                 // Bật đèn nền LCD

  myRTC.setClockMode(false);       // Đặt chế độ 24 giờ cho DS3231

  if (!timeIsSet) {
    myRTC.setYear(setYear);
    myRTC.setMonth(setMonth);
    myRTC.setDate(setDate);
    myRTC.setDoW(setDOW);
    myRTC.setHour(setHour);
    myRTC.setMinute(setMinute);
    myRTC.setSecond(setSecond);

    timeIsSet = true;              // Đánh dấu thời gian đã được cài đặt

    lcd.setCursor(2, 0);
    lcd.print("Zerobase!!!");      // Thông báo khởi động dòng 1
    lcd.setCursor(2, 1);
    lcd.print("Starting...");      // Thông báo dòng 2
    delay(2000);                   // Đợi 2 giây để người dùng đọc

    lcd.clear();                   // Xóa màn hình sau khi hiển thị
  }
}
```

Đọc thời gian từ DS3231, hiển thị ngày/tháng/năm và thời gian hiện tại trên LCD mỗi giây:
```cpp
void loop() {
  bool h12, PM;
  bool century;

  byte second = myRTC.getSecond();
  byte minute = myRTC.getMinute();
  byte hour = myRTC.getHour(h12, PM);
  byte date = myRTC.getDate();
  byte month = myRTC.getMonth(century);
  byte year = myRTC.getYear();
  byte dow = myRTC.getDoW();
```

Mảng chứa các ký hiệu cho thứ trong tuần:
```cpp
  const char* daysOfWeek[] = {
    "Err", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
  };
```

Hiển thị dòng đầu tiên: thứ + ngày/tháng/năm
```cpp
  lcd.setCursor(1, 0);
  lcd.print(daysOfWeek[dow]); lcd.print(" ");
  if (date < 10) lcd.print("0"); lcd.print(date); lcd.print("/");
  if (month < 10) lcd.print("0"); lcd.print(month); lcd.print("/20");
  if (year < 10) lcd.print("0"); lcd.print(year);
```

Hiển thị dòng thứ hai: giờ:phút:giây
```cpp
  lcd.setCursor(4, 1);
  if (hour < 10) lcd.print("0"); lcd.print(hour); lcd.print(":");
  if (minute < 10) lcd.print("0"); lcd.print(minute); lcd.print(":");
  if (second < 10) lcd.print("0"); lcd.print(second);

  delay(1000); // Cập nhật mỗi giây
}
```

## Kết quả

?> Sau khi đã nạp code xong, LCD sẽ hiển thị thời gian thực (thứ, ngày, tháng, năm, giờ, phút, giây) mà module DS3231 đã cài đặt.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/rtc/rtc-result.gif" alt="rtc-result">
    <p><em>Kết quả hiển thị trên LCD</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách sử dụng module thời gian thực DS3231 với bo mạch Zerobase. Bạn có thể mở rộng ứng dụng của module này bằng cách kết hợp với các cảm biến khác hoặc điều khiển thiết bị dựa trên thời gian thực.

Để phát triển thêm từ bài học này, bạn có thể thực hiện thêm các ý tưởng sau:

- Tạo một đồng hồ báo thức sử dụng module DS3231 và buzzer.
- Kết hợp với cảm biến nhiệt độ và độ ẩm để hiển thị thời gian và thông tin môi trường.
- Kết hợp với nút nhấn để tạo ra menu chọn thời gian báo thức hoặc cài đặt thời gian.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)