<br>
<br>
<br>

# Tạo menu trên LCD với nút nhấn

![lcd-menu-circuit](https://cdn.chipstack.vn/zerobase2/lcd-module/lcd-menu-circuit.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách tạo menu trên LCD sử dụng 3 nút nhấn: nút lên, nút xuống và nút chọn. Bạn có thể sử dụng các nút nhấn này để điều hướng qua các mục trong menu và chọn một mục để thực hiện hành động tương ứng.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 | [Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
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

## Sơ đồ kết nối

![lcd-menu-pins](https://cdn.chipstack.vn/zerobase2/lcd-module/lcd-menu-pins.png)

Sử dụng chân SDA (D18) và SCL (D19) để kết nối với chân SDA và SCL của LCD I2C. Sử dụng chân 5V để kết nối với chân VCC của LCD I2C. Sử dụng chân GND để kết nối với chân GND của LCD I2C.

Chân D2 kết nối với 1 chân của nút nhấn, chân còn lại kết nối với GND. Chân D3, D10 kết nối tương tự.

![lcd-menu-schematic](https://cdn.chipstack.vn/zerobase2/lcd-module/lcd-menu-schematic.png)

![lcd-menu-circuit](https://cdn.chipstack.vn/zerobase2/lcd-module/lcd-menu-circuit.jpg)

## Code

```cpp
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển LCD dùng I2C

// Khởi tạo đối tượng LCD 16x2 với địa chỉ I2C là 0x27
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Khai báo các chân nút bấm
const int btnDown = 2;     // Nút "Xuống" nối với chân D2
const int btnUp = 3;       // Nút "Lên" nối với chân D3
const int btnSelect = 10;  // Nút "Chọn" nối với chân D10

// Danh sách các mục trong menu
const char* menuItems[] = {
  "1. Start",     // Mục 1
  "2. Setting",  // Mục 2
  "3. About",     // Mục 3
  "4. Exit"       // Mục 4
};

// Tính số lượng mục menu (tổng số phần tử trong mảng)
const int menuLength = sizeof(menuItems) / sizeof(menuItems[0]);

int currentIndex = 0;   // Vị trí hiện tại trong menu (bắt đầu từ 0)
bool selected = false;  // Biến trạng thái khi chọn mục (chưa dùng)

void setup() {
  lcd.init();       // Khởi động LCD
  lcd.backlight();  // Bật đèn nền LCD

  // Cấu hình các chân nút bấm ở chế độ INPUT_PULLUP
  pinMode(btnUp, INPUT_PULLUP);      // Nút "Lên" kéo lên nội bộ
  pinMode(btnDown, INPUT_PULLUP);    // Nút "Xuống" kéo lên nội bộ
  pinMode(btnSelect, INPUT_PULLUP);  // Nút "Chọn" kéo lên nội bộ

  // Hiển thị thông điệp khởi động lên LCD
  lcd.setCursor(2, 0);       // Di chuyển con trỏ đến cột 2, dòng 0
  lcd.print("Zerobase 2!!!");  // In ra "Zerobase 2!!!"
  lcd.setCursor(2, 1);       // Di chuyển con trỏ đến cột 2, dòng 1
  lcd.print("Starting...");  // In ra "Starting..."
  delay(2000);               // Tạm dừng 2 giây

  showMenu();  // Hiển thị menu lần đầu
}

void loop() {
  // Xử lý khi nhấn nút "Lên"
  if (!digitalRead(btnUp)) {                                      // Nếu nút "Lên" được nhấn (LOW)
    currentIndex = (currentIndex - 1 + menuLength) % menuLength;  // Lùi một mục, quay vòng nếu < 0
    showMenu();                                                   // Cập nhật hiển thị menu
    delay(200);                                                   // Chống dội nút
  }

  // Xử lý khi nhấn nút "Xuống"
  if (!digitalRead(btnDown)) {                       // Nếu nút "Xuống" được nhấn
    currentIndex = (currentIndex + 1) % menuLength;  // Tăng một mục, quay vòng nếu vượt quá
    showMenu();                                      // Cập nhật hiển thị menu
    delay(200);                                      // Chống dội nút
  }

  // Xử lý khi nhấn nút "Chọn"
  if (!digitalRead(btnSelect)) {         // Nếu nút "Chọn" được nhấn
    lcd.clear();                         // Xóa màn hình
    lcd.setCursor(0, 0);                 // Di chuyển con trỏ đến đầu dòng
    lcd.print("Selected:");              // In ra "Selected:"
    lcd.setCursor(0, 1);                 // Di chuyển xuống dòng 2
    lcd.print(menuItems[currentIndex]);  // In mục hiện tại được chọn
    delay(1000);                         // Đợi 1 giây
    showMenu();                          // Quay lại menu
  }
}

// Hàm hiển thị menu
void showMenu() {
  lcd.clear();                         // Xóa màn hình LCD
  lcd.setCursor(0, 0);                 // Con trỏ đầu dòng đầu tiên
  lcd.print("> ");                     // In dấu ">" chỉ mục được chọn
  lcd.print(menuItems[currentIndex]);  // In mục hiện tại

  // Hiển thị mục tiếp theo (nếu có) ở dòng thứ hai
  int nextIndex = (currentIndex + 1) % menuLength;  // Tính mục tiếp theo theo kiểu vòng tròn
  lcd.setCursor(0, 1);                              // Con trỏ đầu dòng thứ hai
  lcd.print("  ");                                  // In khoảng trắng để căn chỉnh
  lcd.print(menuItems[nextIndex]);                  // In mục tiếp theo
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![lcd-menu-code](https://cdn.chipstack.vn/zerobase2/lcd-module/lcd-menu-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu bạn muốn thay đổi chân kết nối nút nhấn, bạn có thể thay đổi các biến `btnUp`, `btnDown`, `btnSelect` trong code.

```cpp
const int btnDown = 2;     // Nút "Xuống" nối với chân D2
const int btnUp = 3;       // Nút "Lên" nối với chân D3
const int btnSelect = 10;  // Nút "Chọn" nối với chân D10
```

Nếu muốn thay đổi nội dung các mục trong menu, bạn có thể thay đổi các biến `menuItems` trong code.

```cpp
const char* menuItems[] = {
  "1. Start",     // Mục 1
  "2. Setting",  // Mục 2
  "3. About",     // Mục 3
  "4. Exit"       // Mục 4
};
```

### Giải thích code

Khai báo thư viện `LiquidCrystal_I2C` để điều khiển màn hình LCD sử dụng giao tiếp I2C.

```cpp
#include <LiquidCrystal_I2C.h>
```

Khởi tạo đối tượng `lcd` với địa chỉ I2C là `0x27` và màn hình có kích thước 16x2 ký tự.

```cpp
LiquidCrystal_I2C lcd(0x27, 16, 2);
```

Khai báo các chân kết nối nút nhấn:
- `btnDown`: nút "Xuống" nối với chân D2
- `btnUp`: nút "Lên" nối với chân D3
- `btnSelect`: nút "Chọn" nối với chân D10

```cpp
const int btnDown = 2;
const int btnUp = 3;
const int btnSelect = 10;
```

Tạo mảng `menuItems` chứa các chuỗi đại diện cho từng mục menu.

```cpp
const char* menuItems[] = {
  "1. Start",
  "2. Setting",
  "3. About",
  "4. Exit"
};
```

Tính tổng số mục menu bằng cách chia kích thước toàn bộ mảng cho kích thước một phần tử.

```cpp
const int menuLength = sizeof(menuItems) / sizeof(menuItems[0]);
```

Biến `currentIndex` để lưu chỉ số của mục hiện tại đang được chọn.

```cpp
int currentIndex = 0;
```

Biến `selected` là cờ trạng thái cho việc chọn mục (chưa sử dụng trong logic chính).

```cpp
bool selected = false;
```

Trong hàm `setup()`, ta khởi tạo LCD, bật đèn nền, cấu hình các chân nút nhấn ở chế độ `INPUT_PULLUP`, hiển thị thông báo khởi động và cuối cùng là hiển thị menu ban đầu.

```cpp
void setup() {
  lcd.init();
  lcd.backlight();

  pinMode(btnUp, INPUT_PULLUP);
  pinMode(btnDown, INPUT_PULLUP);
  pinMode(btnSelect, INPUT_PULLUP);

  lcd.setCursor(2, 0);
  lcd.print("Zerobase 2!!!");
  lcd.setCursor(2, 1);
  lcd.print("Starting...");
  delay(2000);

  showMenu();
}
```

Trong hàm `loop()`, ta kiểm tra từng nút bấm:

Xử lý nút "Lên": nếu được nhấn, lùi về một mục trong menu. Sử dụng công thức `(currentIndex - 1 + menuLength) % menuLength` để đảm bảo quay vòng.

```cpp
if (!digitalRead(btnUp)) {
  currentIndex = (currentIndex - 1 + menuLength) % menuLength;
  showMenu();
  delay(200);
}
```

Xử lý nút "Xuống": nếu được nhấn, tiến đến mục tiếp theo. Dùng công thức `(currentIndex + 1) % menuLength` để quay vòng.

```cpp
if (!digitalRead(btnDown)) {
  currentIndex = (currentIndex + 1) % menuLength;
  showMenu();
  delay(200);
}
```

Xử lý nút "Chọn": nếu được nhấn, hiển thị mục hiện tại được chọn, chờ 1 giây, sau đó quay lại menu.

```cpp
if (!digitalRead(btnSelect)) {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Selected:");
  lcd.setCursor(0, 1);
  lcd.print(menuItems[currentIndex]);
  delay(1000);
  showMenu();
}
```

Hàm `showMenu()` có nhiệm vụ hiển thị mục hiện tại và mục kế tiếp trên màn hình LCD:

```cpp
void showMenu() {
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("> ");
  lcd.print(menuItems[currentIndex]);

  int nextIndex = (currentIndex + 1) % menuLength;
  lcd.setCursor(0, 1);
  lcd.print("  ");
  lcd.print(menuItems[nextIndex]);
}
```

- Dòng đầu tiên hiển thị mục đang chọn với dấu `>`
- Dòng thứ hai hiển thị mục tiếp theo trong danh sách
- Sử dụng quay vòng để đảm bảo không bị tràn mảng khi đến cuối danh sách

## Kết Quả

?> Khi nhấn nút "Lên" hoặc "Xuống", bạn sẽ thấy các mục trong menu thay đổi. Khi nhấn nút "Chọn", LCD sẽ hiển thị mục hiện tại được chọn.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/lcd-module/lcd-menu-result.gif" alt="lcd-menu-result">
    <p><em>Kết quả hiển thị trên LCD</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn bạn cách tạo menu trên LCD sử dụng nút nhấn.

Để phát triển thêm từ bài học này, bạn có thể thực hiện thêm các ý tưởng sau:
- Thêm các chức năng cho từng mục trong menu, chẳng hạn như điều chỉnh độ sáng LED, thay đổi tốc độ động cơ DC, v.v.
- Thêm âm thanh cho từng mục khi chọn bằng cách sử dụng còi buzzer.
- Thêm tính năng lưu trữ trạng thái của menu vào bộ nhớ EEPROM để khi khởi động lại, menu sẽ hiển thị ở vị trí cuối cùng mà người dùng đã chọn.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)