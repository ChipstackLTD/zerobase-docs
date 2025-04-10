<br>
<br>
<br>

# Điều khiển LCD 16x2

![lcd-16x2](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-16x2.jpg)

## Tổng quan

Bài hướng dẫn này sẽ thực hiện hiển thị chữ thường, chữ hoa, số, ký tự tuỳ chỉnh, các hiệu ứng trên LCD 16x2. Chúng ta sẽ sử dụng thư viện LiquidCrystal_I2C để điều khiển LCD 16x2 qua giao thức I2C.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |

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

## Cài Đặt Thư Viện
Truy cập [LiquidCrystal_I2C](https://github.com/johnrickman/LiquidCrystal_I2C).

Tải thư viện về máy tính dưới dạng file .zip bằng cách nhấn vào nút **Code** và chọn **Download ZIP**.

![down-zip.png](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-i2c-down.png)

Mở Arduino IDE, vào Sketch > Include Library > Add .ZIP Library....

![lcd-i2c-add-zip](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-i2c-add-zip.png)

Chọn file .zip vừa tải về để cài đặt thư viện.

![lcd-i2c-open-zip](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-i2c-open-zip.png)

Bạn chờ một chút để Arduino IDE cài đặt thư viện. Sau khi cài xong, bạn sẽ thấy thư viện thông báo **library installed**.

![lcd-i2c-lib-installed](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-i2c-lib-installed.png)

## Nguyên lý hoạt động

?> LCD 16x2 được điều khiển thông qua giao thức I2C, giúp giảm số lượng chân kết nối so với giao tiếp song song. 

?>Thư viện LiquidCrystal_I2C hỗ trợ các chức năng cơ bản như in ký tự, điều chỉnh con trỏ, xóa màn hình và tạo ký tự tùy chỉnh. 

?> Khi chương trình chạy, LCD sẽ hiển thị chữ thường, chữ hoa, số, ký tự đặc biệt và các hiệu ứng như nhấp nháy, cuộn chữ. Các ký tự tùy chỉnh được lưu vào bộ nhớ CGRAM của LCD để hiển thị theo yêu cầu. Ngoài ra, chương trình còn điều khiển bật/tắt đèn nền, hiển thị con trỏ và hiệu ứng cuộn chữ.

## Sơ đồ kết nối

![zerobase-lcd-16x2-pins](https://cdn.chipstack.vn/zerobase/lcd-module/zerobase-lcd-16x2-pins.png)

Sử dụng chân 5V cấp nguồn cho LCD, chân GND nối với GND của board Zerobase. Chân SDA và SCL của LCD được kết nối với chân SDA (D18) và SCL (D19) của board Zerobase.

![zerobase-lcd-16x2-schematic](https://cdn.chipstack.vn/zerobase/lcd-module/zerobase-lcd-16x2-schematic.png)

![lcd-16x2](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-16x2.jpg)

## Code

```cpp
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển LCD qua I2C

// Khai báo đối tượng LCD với địa chỉ 0x27, màn hình 16x2
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Định nghĩa các ký tự tùy chỉnh để hiển thị trên LCD
uint8_t HeartChar[] = { 0x00, 0x00, 0x0a, 0x15, 0x11, 0x0a, 0x04, 0x00 };  // Biểu tượng trái tim
uint8_t SpeakerChar[] = { 0x01, 0x03, 0x07, 0x1f, 0x1f, 0x07, 0x03, 0x01 };  // Biểu tượng loa
uint8_t SmileyFaceChar[] = { 0x00, 0x00, 0x0a, 0x00, 0x1f, 0x11, 0x0e, 0x00 };  // Mặt cười
uint8_t BellChar[] = { 0x04, 0x0e, 0x0a, 0x0a, 0x0a, 0x1f, 0x00, 0x04 };  // Chuông
uint8_t Battery1Char[] = { 0x0e, 0x1b, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1f };  // Pin mức 1
uint8_t Battery2Char[] = { 0x0e, 0x1b, 0x11, 0x11, 0x11, 0x11, 0x1f, 0x1f };  // Pin mức 2
uint8_t Battery3Char[] = { 0x0e, 0x1b, 0x11, 0x11, 0x11, 0x1f, 0x1f, 0x1f };  // Pin mức 3
uint8_t Battery4Char[] = { 0x0e, 0x1b, 0x11, 0x1f, 0x1f, 0x1f, 0x1f, 0x1f };  // Pin mức 4

// Hàm hiển thị một chuỗi tại vị trí (col, row) trong một khoảng thời gian nhất định
void showMessage(const char *msg, int delayTime, int col, int row) {
  lcd.clear();
  lcd.setCursor(col, row);  // Đặt con trỏ tại vị trí mong muốn
  lcd.print(msg);  // In chuỗi ra màn hình LCD
  delay(delayTime);  // Dừng trong khoảng thời gian chỉ định
}

// Hàm nhấp nháy một đoạn văn bản tại hàng row, số lần times
void blinkText(String text, int row, int times) {
  for (int i = 0; i < times; i++) {
    lcd.setCursor(4, row);
    lcd.print(text);
    delay(500);
    lcd.setCursor(4, row);
    lcd.print("                ");  // Xóa chữ
    delay(500);
  }
}

void setup() {
  lcd.init();       // Khởi tạo LCD
  lcd.backlight();  // Bật đèn nền

  // Lưu các ký tự tùy chỉnh vào bộ nhớ LCD
  lcd.createChar(0, HeartChar);
  lcd.createChar(1, SpeakerChar);
  lcd.createChar(2, SmileyFaceChar);
  lcd.createChar(3, BellChar);
  lcd.createChar(4, Battery1Char);
  lcd.createChar(5, Battery2Char);
  lcd.createChar(6, Battery3Char);
  lcd.createChar(7, Battery4Char);
}

void loop() {
  lcd.clear();
  lcd.setCursor(4, 0);
  lcd.print("Zerobase");
  lcd.setCursor(3, 1);
  lcd.print("Starting...");
  delay(2000);
  lcd.clear();


  // Hiển thị chữ thường, chữ hoa và số
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Lowercase: abcdef");
  lcd.setCursor(0, 1);
  lcd.print("Uppercase: ABCDEF");
  delay(2000);

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Numbers: 1234567890");
  delay(2000);

  // Hiển thị các ký tự tùy chỉnh
  lcd.clear();
  lcd.print("Custom Characters:");
  lcd.setCursor(0, 1);
  lcd.write(byte(0));
  lcd.setCursor(2, 1);
  lcd.write(byte(1));
  lcd.setCursor(4, 1);
  lcd.write(byte(2));
  lcd.setCursor(6, 1);
  lcd.write(byte(3));
  lcd.setCursor(8, 1);
  lcd.write(byte(4));
  lcd.setCursor(10, 1);
  lcd.write(byte(5));
  lcd.setCursor(12, 1);
  lcd.write(byte(6));
  lcd.setCursor(14, 1);
  lcd.write(byte(7));
  delay(2000);

  // Hiển thị và nhấp nháy con trỏ
  String cursorOn = "Cursor ON";
  showMessage(cursorOn.c_str(), 1000, 0, 0);
  // Nhấp nháy con trỏ
  lcd.cursor();
  for (int i = 0; i < cursorOn.length(); i++) {
    lcd.setCursor(i, 1);
    lcd.print(cursorOn[i]);
    delay(120);
  }
  delay(2000);
  lcd.noCursor();
  showMessage("Cursor OFF", 2000, 0, 0);

  String blinkOn = "Blink ON";
  showMessage("Blink ON", 1000, 0, 0);
  lcd.blink();
  for (int i = 0; i < blinkOn.length(); i++) {
    lcd.setCursor(i, 1);
    lcd.print(blinkOn[i]);
    delay(120);
  }
  delay(2000);
  lcd.noBlink();
  showMessage("Blink OFF", 2000, 0, 0);

  // Cuộn chữ qua lại
  showMessage("Scrolling Left", 0, 0, 0);
  for (int i = 0; i < 16; i++) {
    lcd.scrollDisplayLeft();
    delay(300);
  }
  showMessage("Scrolling Right", 0, 0, 0);
  for (int i = 0; i < 16; i++) {
    lcd.scrollDisplayRight();
    delay(300);
  }

  // Tắt/bật đèn nền
  showMessage("Backlight OFF", 0, 2, 0);
  lcd.noBacklight();
  delay(2000);
  lcd.backlight();
  showMessage("Backlight ON", 2000, 2, 0);

  lcd.clear();
  blinkText("Blinking!", 0, 5);
  delay(1000);
  lcd.clear();

  // Hoàn tất chương trình
  showMessage("Done!", 3000, 5, 0);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![lcd-zerobase-code](https://cdn.chipstack.vn/zerobase/lcd-module/lcd-zerobase-code.png "lcd-zerobase-code]")

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

Định nghĩa các ký tự tùy chỉnh để hiển thị trên LCD. Màn hình LCD có bộ nhớ CGRAM (Character Generator RAM) cho phép lưu trữ tối đa 8 ký tự tùy chỉnh (từ địa chỉ 0 đến 7). Dữ liệu của mỗi ký tự được định nghĩa bằng mảng 8 byte, trong đó mỗi byte đại diện cho một hàng điểm ảnh (5x8 pixel).

```cpp
uint8_t HeartChar[] = { 0x00, 0x00, 0x0A, 0x15, 0x11, 0x0A, 0x04, 0x00 };  // Biểu tượng trái tim
uint8_t SpeakerChar[] = { 0x01, 0x03, 0x07, 0x1F, 0x1F, 0x07, 0x03, 0x01 };  // Biểu tượng loa
uint8_t SmileyFaceChar[] = { 0x00, 0x00, 0x0A, 0x00, 0x1F, 0x11, 0x0E, 0x00 };  // Mặt cười
uint8_t BellChar[] = { 0x04, 0x0E, 0x0A, 0x0A, 0x0A, 0x1F, 0x00, 0x04 };  // Chuông
uint8_t Battery1Char[] = { 0x0E, 0x1B, 0x11, 0x11, 0x11, 0x11, 0x11, 0x1F };  // Pin mức 1
uint8_t Battery2Char[] = { 0x0E, 0x1B, 0x11, 0x11, 0x11, 0x11, 0x1F, 0x1F };  // Pin mức 2
uint8_t Battery3Char[] = { 0x0E, 0x1B, 0x11, 0x11, 0x11, 0x1F, 0x1F, 0x1F };  // Pin mức 3
uint8_t Battery4Char[] = { 0x0E, 0x1B, 0x11, 0x1F, 0x1F, 0x1F, 0x1F, 0x1F };  // Pin mức 4
```

Hàm `showMessage()` dùng để hiển thị một chuỗi ký tự trên màn hình LCD tại vị trí chỉ định trong một khoảng thời gian nhất định. Trước khi hiển thị, màn hình LCD sẽ được xóa để tránh hiển thị nội dung cũ.

```cpp
void showMessage(const char *msg, int delayTime, int col, int row) {
  lcd.clear();  // Xóa màn hình LCD
  lcd.setCursor(col, row);  // Đặt con trỏ tại vị trí mong muốn
  lcd.print(msg);  // In chuỗi ra màn hình LCD
  delay(delayTime);  // Chờ trong khoảng thời gian chỉ định
}
```

Hàm `blinkText()` làm nhấp nháy một đoạn văn bản tại hàng `row` với số lần `times` được chỉ định. Quá trình này được thực hiện bằng cách hiển thị và xóa văn bản xen kẽ với khoảng thời gian trễ.

```cpp
void blinkText(String text, int row, int times) {
  for (int i = 0; i < times; i++) {
    lcd.setCursor(4, row);
    lcd.print(text);
    delay(500);
    lcd.setCursor(4, row);
    lcd.print("                ");  // Xóa chữ
    delay(500);
  }
}
```

Hàm `setup()` được sử dụng để khởi tạo màn hình LCD, bật đèn nền và lưu các ký tự tùy chỉnh vào bộ nhớ CGRAM.

```cpp
lcd.init();  // Khởi tạo LCD
lcd.backlight();  // Bật đèn nền

// Lưu các ký tự tùy chỉnh vào bộ nhớ CGRAM
lcd.createChar(0, HeartChar);
lcd.createChar(1, SpeakerChar);
lcd.createChar(2, SmileyFaceChar);
lcd.createChar(3, BellChar);
lcd.createChar(4, Battery1Char);
lcd.createChar(5, Battery2Char);
lcd.createChar(6, Battery3Char);
lcd.createChar(7, Battery4Char);
```

Trong `loop()`, chương trình thực hiện các chức năng như hiển thị chữ thường, chữ hoa, số, và các ký tự tùy chỉnh.

```cpp
lcd.clear();
lcd.setCursor(0, 0);
lcd.print("Lowercase: abcdef");
lcd.setCursor(0, 1);
lcd.print("Uppercase: ABCDEF");
delay(2000);
```

Chương trình cũng hiển thị các ký tự tùy chỉnh đã được lưu trước đó.

```cpp
lcd.clear();
lcd.print("Custom Characters:");
lcd.setCursor(0, 1);
lcd.write(byte(0));
lcd.setCursor(2, 1);
lcd.write(byte(1));
lcd.setCursor(4, 1);
lcd.write(byte(2));
lcd.setCursor(6, 1);
lcd.write(byte(3));
lcd.setCursor(8, 1);
lcd.write(byte(4));
lcd.setCursor(10, 1);
lcd.write(byte(5));
lcd.setCursor(12, 1);
lcd.write(byte(6));
lcd.setCursor(14, 1);
lcd.write(byte(7));
delay(2000);
```

Đoạn code dưới đây bật chế độ con trỏ `lcd.cursor()` và hiển thị chữ "Cursor ON". Sau đó, từng ký tự trong chuỗi "Cursor ON" sẽ được in ra màn hình với hiệu ứng gõ từng ký tự một (mỗi ký tự xuất hiện sau 120ms). Sau khi hoàn tất, chương trình tắt con trỏ `lcd.noCursor()` và hiển thị thông báo "Cursor OFF".

Tiếp theo, hiển thị con trỏ.

```cpp
  // Hiển thị và nhấp nháy con trỏ
  String cursorOn = "Cursor ON";
  showMessage(cursorOn.c_str(), 1000, 0, 0);
  // Nhấp nháy con trỏ
  lcd.cursor();
  for (int i = 0; i < cursorOn.length(); i++) {
    lcd.setCursor(i, 1);
    lcd.print(cursorOn[i]);
    delay(120);
  }
  delay(2000);
  lcd.noCursor();
  showMessage("Cursor OFF", 2000, 0, 0);
```
Tương tự như con trỏ, đoạn code dưới đây bật chế độ nhấp nháy chữ `lcd.blink()` và hiển thị chữ "Blink ON". Sau đó, chương trình gõ từng ký tự trong chuỗi "Blink ON" với hiệu ứng từng ký tự xuất hiện sau 120ms. Sau khi hoàn tất, chương trình tắt chế độ nhấp nháy `lcd.noBlink()` và hiển thị thông báo "Blink OFF".

```cpp
  String blinkOn = "Blink ON";
  showMessage("Blink ON", 1000, 0, 0);
  lcd.blink();
  for (int i = 0; i < blinkOn.length(); i++) {
    lcd.setCursor(i, 1);
    lcd.print(blinkOn[i]);
    delay(120);
  }
  delay(2000);
  lcd.noBlink();
  showMessage("Blink OFF", 2000, 0, 0);
```

Lệnh lcd.scrollDisplayLeft() sẽ cuộn nội dung trên màn hình LCD sang bên trái một ký tự mỗi lần gọi. Đoạn code dưới đây sẽ cuộn chữ "Scrolling Left" sang trái 16 lần, mỗi lần cách nhau 300ms. Tương tự, đoạn code sau sẽ cuộn chữ "Scrolling Right" sang phải 16 lần.

```cpp
  // Cuộn chữ qua lại
  showMessage("Scrolling Left", 0, 0, 0);
  for (int i = 0; i < 16; i++) {
    lcd.scrollDisplayLeft();
    delay(300);
  }
  showMessage("Scrolling Right", 0, 0, 0);
  for (int i = 0; i < 16; i++) {
    lcd.scrollDisplayRight();
    delay(300);
  }
```

Cuối cùng, đoạn code dưới đây sẽ tắt đèn nền LCD bằng lệnh `lcd.noBacklight()` và hiển thị thông báo "Backlight OFF". Sau 2 giây, đèn nền sẽ được bật lại bằng lệnh `lcd.backlight()` và hiển thị thông báo "Backlight ON".

```cpp
  // Tắt/bật đèn nền
  showMessage("Backlight OFF", 0, 2, 0);
  lcd.noBacklight();
  delay(2000);
  lcd.backlight();
  showMessage("Backlight ON", 2000, 2, 0);
```

Chương trình nhấp nháy chữ "Blinking!" và hiển thị "Done!" trước khi kết thúc vòng lặp.

```cpp
lcd.clear();
blinkText("Blinking!", 0, 5);
delay(1000);
showMessage("Done!", 3000, 5, 0);
```

Mỗi đoạn code đều có mục đích cụ thể để hiển thị nội dung trên LCD, đồng thời giúp người dùng làm quen với các chức năng điều khiển LCD qua giao tiếp I2C một cách trực quan.

## Kết quả

Nếu bạn đã thực hiện đúng các bước, bạn sẽ thấy LCD 16x2 hiển thị các ký tự thường, ký tự hoa, số, ký tự tùy chỉnh và các hiệu ứng như nhấp nháy, cuộn chữ.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/lcd-zerobase-result.gif" alt="lcd-zerobase-result">
    <p><em>Kết quả hiển thị trên LCD 16x2</em></p>
</div>

## Kết luận và Hướng phát triển

Bài viết đã hướng dẫn cách điều khiển LCD 16x2 bằng Arduino IDE.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- Thay đổi nội dung hiển thị trên LCD theo thời gian thực, chẳng hạn như nhiệt độ, độ ẩm hoặc thông tin từ cảm biến khác.
- Kết hợp với các cảm biến khác để hiển thị thông tin từ cảm biến trên LCD.
- Tạo một ứng dụng di động hoặc web để điều khiển nội dung hiển thị trên LCD từ xa.
- Tạo các hiệu ứng như Progress Bar, hiển thị thời gian thực, hoặc các hiệu ứng động khác.

***Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)