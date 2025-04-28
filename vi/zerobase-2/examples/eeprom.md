<br>
<br>
<br>

# Lưu trữ dữ liệu vào bộ nhớ EEPROM

![button-lcd](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách sử dụng bộ nhớ EEPROM trên Zerobase 2 để lưu trữ dữ liệu. Bạn có thể sử dụng bộ nhớ EEPROM để lưu trữ các giá trị mà bạn muốn giữ lại ngay cả khi tắt nguồn.

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

?> Trong bài này, chúng ta sẽ sử dụng một nút nhấn để đếm lên và một nút nhấn khác để reset lại giá trị đếm và 0. Mỗi lần nhấn nút đếm, giá trị sẽ được lưu vào bộ nhớ EEPROM. Khi bạn reset lại giá trị đếm, giá trị trong bộ nhớ EEPROM cũng sẽ được reset về 0.

?> Giá trị sau đó sẽ được hiển thị lên màn hình LCD.

?> Chúng ta sẽ sử dụng thư viện `EEPROM` có sẵn trong Arduino IDE để thực hiện lưu trữ dữ liệu vào bộ nhớ EEPROM.

## Sơ đồ kết nối

![button-lcd-zerobase2-pins](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-zerobase2-pins.png)

Sử dụng chân SDA (D18) và SCL (D19) để kết nối với chân SDA và SCL của LCD I2C. Sử dụng chân 5V để kết nối với chân VCC của LCD I2C. Sử dụng chân GND để kết nối với chân GND của LCD I2C. 

Sử dụng D1 để kết nối với với một chân với nút đếm, chân còn lại nối với GND của Zerobase 2. 

Sử dụng D0 để kết nối với một chân của nút reset và chân còn lại cũng nối với GND của Zerobase 2.

![button-lcd-schematic](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd-schematic.png)

![button-lcd](https://cdn.chipstack.vn/zerobase2/lcd-module/button-lcd.jpg)

## Code

```cpp
// Thêm các thư viện cần thiết
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển màn hình LCD qua I2C
#include <EEPROM.h>             // Thư viện để truy cập bộ nhớ EEPROM
#include <Adafruit_TinyUSB.h>   // Thư viện cho bộ vi điều khiển sử dụng TinyUSB

// Định nghĩa các chân kết nối
const int COUNT_BUTTON_PIN = 2;  // Chân kết nối nút đếm lên
const int RESET_BUTTON_PIN = 3;  // Chân kết nối nút reset bộ đếm
const int EEPROM_ADDRESS = 0;    // Địa chỉ EEPROM để lưu giá trị bộ đếm

// Khởi tạo màn hình LCD với địa chỉ I2C (thường là 0x27 hoặc 0x3F)
// Cài đặt 16 cột và 2 dòng
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Khai báo các biến
uint8_t counter = 0;               // Giá trị bộ đếm (0-255)
bool countButtonState = HIGH;      // Trạng thái hiện tại của nút đếm
bool lastCountButtonState = HIGH;  // Trạng thái trước đó của nút đếm
bool resetButtonState = HIGH;      // Trạng thái hiện tại của nút reset
bool lastResetButtonState = HIGH;  // Trạng thái trước đó của nút reset

void setup() {
  // Khởi tạo giao tiếp Serial để gỡ lỗi
  Serial.begin(9600);  // Thiết lập tốc độ giao tiếp là 9600 baud
  while (!Serial) {
    delay(10);  // Đợi kết nối cổng Serial
  }

  Serial.println("Counter with EEPROM Storage");  // In thông báo khởi động lên Serial Monitor

  // Khởi tạo màn hình LCD
  lcd.init();       // Khởi tạo màn hình LCD
  lcd.backlight();  // Bật đèn nền cho màn hình LCD

  // Hiển thị thông báo khởi động trên LCD
  lcd.setCursor(2, 0);         // Đặt con trỏ ở cột 2, dòng 0 (dòng đầu tiên)
  lcd.print("Zerobase 2!!!");  // Hiển thị tên thiết bị
  lcd.setCursor(3, 1);         // Đặt con trỏ ở cột 3, dòng 1 (dòng thứ hai)
  lcd.print("Starting...");    // Hiển thị thông báo đang khởi động
  delay(2000);                 // Chờ 2 giây để người dùng đọc thông báo

  // Thiết lập các nút nhấn với điện trở kéo lên
  pinMode(COUNT_BUTTON_PIN, INPUT_PULLUP);  // Cấu hình chân nút đếm với trở kéo lên
  pinMode(RESET_BUTTON_PIN, INPUT_PULLUP);  // Cấu hình chân nút reset với trở kéo lên

  // Khởi tạo EEPROM
  EEPROM.begin();  // Bắt đầu sử dụng EEPROM

  // Đọc giá trị bộ đếm từ EEPROM
  counter = EEPROM.read(EEPROM_ADDRESS);                               // Đọc giá trị từ địa chỉ EEPROM đã định nghĩa
  Serial.println("Reading stored counter value: " + String(counter));  // In giá trị đã đọc lên Serial

  // Hiển thị giá trị bộ đếm ban đầu
  updateDisplay();  // Gọi hàm cập nhật màn hình LCD
}

void loop() {
  // Đọc trạng thái nút đếm (do dùng INPUT_PULLUP nên LOW nghĩa là được nhấn)
  countButtonState = digitalRead(COUNT_BUTTON_PIN);  // Đọc trạng thái hiện tại của nút đếm

  // Nút đếm được nhấn (phát hiện cạnh xuống)
  if (countButtonState == LOW && lastCountButtonState == HIGH) {  // Kiểm tra xem nút vừa được nhấn xuống
    delay(50);                                                    // Chờ 50ms để chống dội phím
    // Kiểm tra xem nút vẫn còn được nhấn sau khi chống dội
    if (digitalRead(COUNT_BUTTON_PIN) == LOW) {  // Kiểm tra lại sau khoảng thời gian chống dội
      // Tăng bộ đếm, giữ trong phạm vi 0-255
      if (counter < 255) {  // Kiểm tra xem giá trị hiện tại có nhỏ hơn 255 không
        counter++;          // Tăng bộ đếm lên 1
      }
      // Lưu vào EEPROM
      EEPROM.write(EEPROM_ADDRESS, counter);  // Ghi giá trị counter vào địa chỉ EEPROM_ADDRESS
      // Thực hiện commit để đảm bảo dữ liệu được lưu vào bộ nhớ flash
      bool commitSuccess = EEPROM.commit();  // Gọi hàm commit() và lưu kết quả

      // Cập nhật hiển thị
      updateDisplay();  // Cập nhật giá trị mới lên màn hình LCD

      // In thông báo trạng thái lên Serial Monitor
      if (commitSuccess) {
        Serial.println("Counter incremented to: " + String(counter) + " and saved to EEPROM");  // Thông báo thành công
      } else {
        Serial.println("Counter incremented to: " + String(counter) + " but EEPROM save FAILED!");  // Thông báo lỗi
      }
    }
  }

  // Đọc trạng thái nút reset
  resetButtonState = digitalRead(RESET_BUTTON_PIN);  // Đọc trạng thái hiện tại của nút reset

  // Nút reset được nhấn (phát hiện cạnh xuống)
  if (resetButtonState == LOW && lastResetButtonState == HIGH) {  // Kiểm tra xem nút vừa được nhấn xuống
    delay(50);                                                    // Chờ 50ms để chống dội phím
    // Kiểm tra xem nút vẫn còn được nhấn sau khi chống dội
    if (digitalRead(RESET_BUTTON_PIN) == LOW) {  // Kiểm tra lại sau khoảng thời gian chống dội
      // Đặt lại bộ đếm về 0
      counter = 0;  // Reset giá trị counter về 0
      // Lưu vào EEPROM
      EEPROM.write(EEPROM_ADDRESS, counter);  // Ghi giá trị 0 vào địa chỉ EEPROM_ADDRESS
      // Thực hiện commit để đảm bảo dữ liệu được lưu vào bộ nhớ flash
      bool commitSuccess = EEPROM.commit();  // Gọi hàm commit() và lưu kết quả

      // Cập nhật hiển thị
      updateDisplay();  // Cập nhật giá trị mới lên màn hình LCD

      // In thông báo trạng thái lên Serial Monitor
      if (commitSuccess) {
        Serial.println("Counter reset to 0 and saved to EEPROM");  // Thông báo thành công
      } else {
        Serial.println("Counter reset to 0 but EEPROM save FAILED!");  // Thông báo lỗi
      }
    }
  }

  // Cập nhật trạng thái nút nhấn cho lần lặp tiếp theo
  lastCountButtonState = countButtonState;  // Lưu trạng thái hiện tại của nút đếm cho lần kiểm tra tiếp theo
  lastResetButtonState = resetButtonState;  // Lưu trạng thái hiện tại của nút reset cho lần kiểm tra tiếp theo

  // Độ trễ ngắn để tránh dội phím
  delay(10);  // Chờ 10ms giữa các lần kiểm tra trạng thái nút
}

// Hàm cập nhật hiển thị LCD
void updateDisplay() {
  lcd.setCursor(1, 0);          // Đặt con trỏ ở cột 1, dòng 0 (dòng đầu tiên)
  lcd.print("Press to Count");  // Hiển thị hướng dẫn sử dụng

  lcd.setCursor(3, 1);                 // Đặt con trỏ ở cột 3, dòng 1 (dòng thứ hai)
  lcd.print("Count: ");                // Hiển thị chữ "Count: "
  lcd.print("                     ");  // Xóa dữ liệu cũ trên màn hình bằng cách ghi đè khoảng trắng

  lcd.setCursor(11, 1);  // Đặt con trỏ ở cột 11, dòng 1
  lcd.print(counter);    // Hiển thị giá trị đếm hiện tại
}

```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![eeoprom-code](https://cdn.chipstack.vn/zerobase2/eeprom/eeprom-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

### Sơ lược về thư viện EEPROM.h

Thư viện EEPROM trong ứng dụng này là một phiên bản nâng cao cho các board Arduino, hỗ trợ cả Board Zerobase 2 và Board Zerobase. Dưới đây là giải thích các API mà ứng dụng đang sử dụng:

### 1. `EEPROM.begin()`

```cpp
EEPROM.begin();
```

- **Mục đích**: Khởi tạo và chuẩn bị bộ nhớ EEPROM cho việc sử dụng
- **Chi tiết**: Hàm này cấp phát bộ nhớ đệm trong RAM và đọc dữ liệu từ trang flash được chỉ định vào bộ đệm
- **Đặc điểm**: Cần gọi trước khi thực hiện bất kỳ thao tác EEPROM nào
- **Tham số**: Mặc định sẽ sử dụng kích thước 256 bytes cho board Zerobase 2 và 64 bytes cho board Zerobase

### 2. `EEPROM.read()`

```cpp
counter = EEPROM.read(EEPROM_ADDRESS);
```

- **Mục đích**: Đọc một byte dữ liệu từ EEPROM
- **Chi tiết**: Trả về giá trị byte tại địa chỉ được chỉ định từ bộ đệm trong RAM
- **Tham số**: idx - Chỉ số/địa chỉ của byte cần đọc (0-255 hoặc 0-63 tùy thuộc vào board)
- **Giá trị trả về**: uint8_t - Giá trị byte đọc được (0-255)

### 3. `EEPROM.write()`

```cpp
EEPROM.write(EEPROM_ADDRESS, counter);
```

- **Mục đích**: Ghi một byte dữ liệu vào EEPROM
- **Chi tiết**: Ghi giá trị vào bộ đệm RAM, không ghi trực tiếp vào flash
- **Lưu ý quan trọng**: Cần gọi `commit()` sau đó để thực sự lưu dữ liệu vào flash
- **Tham số**:
  - idx - Chỉ số/địa chỉ để ghi dữ liệu vào
  - val - Giá trị byte cần ghi (0-255)

### 4. `EEPROM.commit()`

```cpp
bool commitSuccess = EEPROM.commit();
```

- **Mục đích**: Lưu dữ liệu từ bộ đệm RAM vào bộ nhớ flash
- **Chi tiết**: Chỉ thực hiện ghi khi bộ đệm bị thay đổi (cờ _dirty == true)
- **Đặc điểm**: Xóa trang flash hiện tại và ghi lại toàn bộ nội dung bộ đệm
- **Giá trị trả về**: boolean - true nếu thành công, false nếu thất bại
- **Quan trọng**: Đây là API bắt buộc phải gọi để lưu dữ liệu vĩnh viễn, các thay đổi từ hàm write() sẽ bị mất khi mất điện nếu không commit

### Hoạt động bên trong

Thư viện EEPROM này mô phỏng EEPROM bằng cách sử dụng bộ nhớ flash:
- Dữ liệu được đọc từ flash vào một bộ đệm RAM khi gọi `begin()`
- Các hoạt động đọc/ghi được thực hiện trên bộ đệm này
- Chỉ khi gọi `commit()`, dữ liệu mới thực sự được ghi vào flash
- Board Zerobase 2 sử dụng 256 byte của bộ nhớ flash.
- Board Zerobase sử dụng 64 byte của bộ nhớ flash.

### Giải thích code

#### Phần thêm thư viện

```cpp
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <EEPROM.h>
#include <Adafruit_TinyUSB.h>  // Include if your board uses it
```

- `Wire.h`: Thư viện giao tiếp I2C, cần thiết cho việc điều khiển màn hình LCD qua giao thức I2C
- `LiquidCrystal_I2C.h`: Thư viện để điều khiển màn hình LCD thông qua giao tiếp I2C
- `EEPROM.h`: Thư viện để lưu trữ và đọc dữ liệu từ bộ nhớ EEPROM của vi điều khiển
- `Adafruit_TinyUSB.h`: Thư viện hỗ trợ giao tiếp USB cho một số board Arduino (tùy chọn)

#### Khai báo chân và biến

```cpp
const int COUNT_BUTTON_PIN = 2;  // Button for counting up
const int RESET_BUTTON_PIN = 3;  // Button for resetting the counter
const int EEPROM_ADDRESS = 0;    // EEPROM address to store the counter value
```

- `COUNT_BUTTON_PIN`: Chân kết nối với nút nhấn dùng để đếm lên (chân 2)
- `RESET_BUTTON_PIN`: Chân kết nối với nút nhấn dùng để reset bộ đếm (chân 3)
- `EEPROM_ADDRESS`: Địa chỉ trong bộ nhớ EEPROM để lưu trữ giá trị đếm (địa chỉ 0)

```cpp
LiquidCrystal_I2C lcd(0x27, 16, 2);
```

- Khởi tạo đối tượng LCD với địa chỉ I2C là 0x27 (phổ biến cho nhiều module LCD)
- 16: số cột của màn hình
- 2: số hàng của màn hình

```cpp
uint8_t counter = 0;               // Counter value (0-255)
bool countButtonState = HIGH;      // Current state of count button
bool lastCountButtonState = HIGH;  // Previous state of count button
bool resetButtonState = HIGH;      // Current state of reset button
bool lastResetButtonState = HIGH;  // Previous state of reset button
```

- `counter`: Biến lưu giá trị đếm, kiểu uint8_t giới hạn giá trị từ 0-255
- `countButtonState` và `lastCountButtonState`: Lưu trạng thái hiện tại và trước đó của nút đếm
- `resetButtonState` và `lastResetButtonState`: Lưu trạng thái hiện tại và trước đó của nút reset
- Giá trị mặc định HIGH vì ta sử dụng chế độ INPUT_PULLUP cho các nút nhấn

#### Hàm setup()

```cpp
Serial.begin(9600);
while (!Serial) {
  delay(10);  // Wait for serial port to connect
}
```

- Khởi tạo giao tiếp Serial với tốc độ 9600 baud
- Vòng lặp `while (!Serial)` đảm bảo đợi cho đến khi cổng Serial được kết nối

```cpp
lcd.init();
lcd.backlight();
```

- `lcd.init()`: Khởi tạo màn hình LCD
- `lcd.backlight()`: Bật đèn nền của màn hình LCD

```cpp
lcd.setCursor(2, 0);
lcd.print("Zerobase 2!!!");
lcd.setCursor(3, 1);
lcd.print("Starting...");
delay(2000);
```

- Hiển thị thông báo khởi động "Zerobase 2!!!" trên dòng đầu tiên và "Starting..." trên dòng thứ hai
- Đợi 2 giây (2000ms) để người dùng đọc thông báo

```cpp
pinMode(COUNT_BUTTON_PIN, INPUT_PULLUP);
pinMode(RESET_BUTTON_PIN, INPUT_PULLUP);
```

- Thiết lập chân nút đếm và nút reset là `INPUT_PULLUP`
- Chế độ này kích hoạt điện trở kéo lên nội bộ, giúp đơn giản hóa mạch kết nối (không cần điện trở ngoài)
- Khi nút nhấn được nhấn, trạng thái sẽ là LOW; khi không nhấn, trạng thái là HIGH

```cpp
EEPROM.begin();
```

- Khởi tạo bộ nhớ EEPROM, cần thiết cho các board như CH32V

```cpp
counter = EEPROM.read(EEPROM_ADDRESS);
Serial.println("Reading stored counter value: " + String(counter));
```

- Đọc giá trị đếm đã lưu trước đó từ EEPROM tại địa chỉ EEPROM_ADDRESS
- In giá trị đếm đã đọc được lên Serial Monitor để gỡ lỗi

```cpp
updateDisplay();
```

- Gọi hàm updateDisplay() để hiển thị giá trị đếm ban đầu lên màn hình LCD

#### Hàm loop()

```cpp
countButtonState = digitalRead(COUNT_BUTTON_PIN);
```

- Đọc trạng thái hiện tại của nút đếm
- Vì sử dụng INPUT_PULLUP, LOW có nghĩa là nút đang được nhấn

```cpp
if (countButtonState == LOW && lastCountButtonState == HIGH) {
  delay(50);  // Simple debounce delay
  if (digitalRead(COUNT_BUTTON_PIN) == LOW) {
    // Xử lý khi nút đếm được nhấn
  }
}
```

- Kiểm tra nếu nút đếm vừa mới được nhấn (phát hiện cạnh xuống)
  - `countButtonState == LOW`: Nút hiện đang được nhấn
  - `lastCountButtonState == HIGH`: Nút trước đó không được nhấn
- Sử dụng kỹ thuật chống dội phím:
  - Đợi 50ms sau khi phát hiện nhấn
  - Kiểm tra lại xem nút vẫn đang được nhấn hay không

```cpp
if (counter < 255) {
  counter++;
}
```

- Tăng biến đếm lên 1 nếu giá trị hiện tại nhỏ hơn 255
- Giới hạn giá trị đếm không vượt quá 255 (giới hạn của kiểu uint8_t)

```cpp
EEPROM.write(EEPROM_ADDRESS, counter);
bool commitSuccess = EEPROM.commit();
```

- Ghi giá trị đếm mới vào EEPROM tại địa chỉ EEPROM_ADDRESS
- Gọi `EEPROM.commit()` để đảm bảo dữ liệu được lưu vào bộ nhớ flash
- Lưu kết quả của phép commit để kiểm tra thành công hay thất bại

Đoạn mã tương tự được sử dụng cho nút reset, nhưng thay vì tăng giá trị đếm, nó đặt counter về 0.

#### Hàm updateDisplay()

```cpp
lcd.setCursor(1, 0);
lcd.print("Press to Count");
```

- Đặt con trỏ tại vị trí cột 1, hàng 0 (hàng đầu tiên)
- Hiển thị dòng chữ "Press to Count" làm hướng dẫn sử dụng

```cpp
lcd.setCursor(3, 1);
lcd.print("Count: ");
lcd.print("                     ");
```

- Đặt con trỏ tại vị trí cột 3, hàng 1 (hàng thứ hai)
- Hiển thị chữ "Count: "
- In một chuỗi khoảng trắng để xóa dữ liệu cũ trên màn hình
  - Điều này rất quan trọng vì màn hình LCD không tự động xóa ký tự cũ khi hiển thị giá trị mới
  - Nếu không xóa, khi giá trị đếm từ ba chữ số giảm xuống hai chữ số, chữ số thứ ba cũ vẫn sẽ còn trên màn hình

```cpp
lcd.setCursor(11, 1);
lcd.print(counter);
```

- Đặt con trỏ tại vị trí cột 11, hàng 1
- Hiển thị giá trị hiện tại của biến đếm

## Kết quả

?> Khi nút đếm được nhấn giá trị đếm sẽ tăng lên 1 đơn vị. Khi nút reset được nhấn giá trị đếm sẽ được đặt lại về 0. Khi bạn tắt nguồn và bật lại, giá trị đếm sẽ được giữ lại trong bộ nhớ EEPROM.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/eeprom/eeprom-res.gif" alt="eeprom-res">
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn chi tiết cách đếm số lần nhấn nút và hiển thị lên LCD với Zerobase 2 và cách lưu trữ giá trị đếm vào bộ nhớ EEPROM.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn chi tiết cách đếm số lần nhấn nút và hiển thị lên LCD với Zerobase 2 và cách lưu trữ giá trị đếm vào bộ nhớ EEPROM.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Thêm một nút nhấn khác để giảm giá trị đếm**: Tạo thêm chức năng đếm ngược bằng một nút nhấn thứ ba, với mã tương tự như nút đếm lên.

- **Hiển thị thêm thông tin trên LCD**: Bạn có thể mở rộng giao diện người dùng hiển thị thời gian chạy chương trình, số lần nhấn mỗi nút, hoặc thống kê sử dụng.

- **Lưu thêm thông tin vào EEPROM**: Lưu thời gian hoạt động, số lần khởi động thiết bị, hoặc các thông số cấu hình khác.

- **Thêm chức năng tự động lưu**: Tự động lưu giá trị sau một khoảng thời gian nhất định, không chỉ khi có sự thay đổi.

- **Tích hợp chức năng bảo mật**: Thêm mật khẩu hoặc mã khóa để hạn chế quyền reset bộ đếm.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)