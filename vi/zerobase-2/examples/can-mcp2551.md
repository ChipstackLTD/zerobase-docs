<br>
<br>
<br>

# Giao tiếp CAN Bus sử dụng module MCP2551

![can-mcp2551-circuit](https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-circuit.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách giao tiếp CAN Bus sử dụng module MCP2551 với Zerobase 2.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase 2|[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| LCD Character 1602A nền xanh dương | [Mua ngay](https://chipstack.vn/san-pham/lcd-character-1602a-nen-xanh-duong/) |
| Module I2C LCD 1602 | [Mua ngay](https://chipstack.vn/san-pham/module-chuyen-doi-i2c-cho-lcd/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Cảm biến nhiệt độ DS18B20 | [Mua ngay](https://chipstack.vn/san-pham/cam-bien-nhiet-do-ds18b20/) |
| Điện trở 4.7kΩ | [Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| Điện trở 120Ω| [Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| Module RTC DS3231 | [Mua ngay](https://chipstack.vn/san-pham/module-thoi-gian-thuc-ds3231/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |
| Module CAN MCP2551 | [Mua ngay](https://chipstack.vn/san-pham/module-can-mcp2551/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/mcp2551.jpg" alt="mcp2551">
    <p><em>Module CAN MCP2551</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/rtc/rtc-ds3231.jpg" alt="button-lcd-rtc-ds3231">
    <p><em>Module RTC DS3231</em></p>
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
    <img src="https://cdn.chipstack.vn/zerobase2/ds18b20/ds18b20.png" alt="ds18b20">
    <p><em>Cảm biến nhiệt độ DS18B20</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/dien-tro-4-7k-ohm.png" alt="dien-tro-330-ohm">
    <p><em>Điện trở 4.7kΩ</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/dien-tro-120-ohm.png" alt="dien-tro-120-ohm">
    <p><em>Điện trở 120Ω</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/module-nguon-cho-breadboard-mb102-830.jpg" alt="module-nguon-cho-breadboard-mb102-830">
    <p><em>Module nguồn cho Breadboard MB102 830</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w.jpg" alt="nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w">
    <p><em>Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W</em></p>
</div>

## Nguyên lý hoạt động

?> Bài hướng dẫn này sử dụng 3 board Zerobase 2 để giao tiếp CAN Bus với nhau.

?> 1 Board sẽ sử dụng để đọc nhiệt độ từ cảm biến DS18B20.

?> 1 Board sẽ sử dụng để đọc thời gian từ module RTC DS3231.

?> Sau đó Board còn lại sẽ yêu cầu 2 Board trên gửi dữ liệu về cho nó và sau khi nhận dữ liệu, board này sẽ hiển thị lên LCD 1602A.

## Sơ đồ kết nối

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/ds18b20-zerobase2-pins.png">
    <p><em>Chân kết nối của Zerobase thứ nhất</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/ds3231-zerobase2-pins.png">
    <p><em>Chân kết nối của Zerobase thứ hai</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/lcd-zerobase2-pins.png">
    <p><em>Chân kết nối của Zerobase thứ ba</em></p>
</div>

!> Lưu ý quan trọng
* Phải cấp nguồn 5V cho module CAN MCP2551, nếu không module sẽ không hoạt động
* Cần kết nối chân GND của tất cả các module với nhau để tạo điểm tham chiếu chung

### Nguồn cung cấp
* **Nguồn 5V:** Module CAN MCP2551 và LCD 1602A
* **Nguồn 3.3V:** Board Zerobase 2, module RTC DS3231 và cảm biến DS18B20

### Sơ đồ kết nối chi tiết

#### 1. Cảm biến nhiệt độ DS18B20 với Zerobase 2 thứ nhất
![ds18b20-pinout](https://cdn.chipstack.vn/zerobase2/ds18b20/pinout-ds18b20.jpg)

| Cảm biến DS18B20 | Zerobase 2 #1 | Lưu ý |
|-----------------|---------------|-------|
| DQ | A0 | Cần thêm điện trở pull-up |
| VCC | 3.3V | |
| GND | GND | |

* **Điện trở pull-up:** Kết nối điện trở 4.7kΩ giữa chân DQ và VCC

#### 2. Module RTC DS3231 với Zerobase 2 thứ hai

<div align="center">
    <img src="https://cdn.chipstack.vn/default/ds3231-pinout.png" alt="module-i2c">
</div>

| Module RTC DS3231 | Zerobase 2 #2 |
|------------------|---------------|
| SDA | SDA |
| SCL | SCL |
| VCC | 3.3V |
| GND | GND |

#### 3. LCD 1602A (qua I2C) với Zerobase 2 thứ ba

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/lcd-module/module-i2c.png" alt="module-i2c">
</div>

| Module I2C LCD 1602A | Zerobase 2 #3 |
|---------------------|---------------|
| SDA | SDA |
| SCL | SCL |
| VCC | 5V |
| GND | GND |

#### 4. Module CAN MCP2551 với mỗi Zerobase 2

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/mcp2551.jpg" alt="mcp2551">
</div>

| Module CAN MCP2551 | Zerobase 2 |
|-------------------|-----------|
| CTX | CTX |
| CRX | CRX |
| VCC | 5V |
| GND | GND |

#### KẾT NỐI MẠNG CAN BUS
* Kết nối tất cả các module CAN MCP2551 với nhau theo chuẩn mạng CAN:
  * Nối các chân CANH của các module với nhau
  * Nối các chân CANL của các module với nhau
  * **Về điện trở đầu cuối:**
    * Lắp 1 điện trở 120Ω giữa chân CANH và CANL tại module CAN đầu tiên trong mạng
    * Lắp 1 điện trở 120Ω giữa chân CANH và CANL tại module CAN cuối cùng trong mạng
    * Hai điện trở 120Ω này đóng vai trò là điện trở đầu cuối (termination resistors) giúp ngăn phản xạ tín hiệu và đảm bảo truyền dữ liệu ổn định

![can-mcp2551-schematic](https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-schematic.png) 

![can-mcp2551-circuit](https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-circuit.jpg)

## Code

### Code cho Zerobase 2 thứ nhất (đọc nhiệt độ từ cảm biến DS18B20)

```cpp
/**********************************
* CAN_Temperature.ino
* Temperature sensor node
**********************************/

#include <Arduino.h>            // Thư viện cơ bản của Arduino
#include <ZBCan.h>              // Thư viện giao tiếp CAN trên Zerobase
#include <OneWire.h>            // Thư viện giao tiếp với thiết bị OneWire
#include <DallasTemperature.h>  // Thư viện đọc nhiệt độ từ cảm biến DS18B20
#include <ZBPrint.h>            // Thư viện in ấn cho Zerobase

#define ONE_WIRE_BUS A0         // Định nghĩa chân A0 để kết nối với cảm biến DS18B20

OneWire oneWire(ONE_WIRE_BUS);  // Khởi tạo đối tượng OneWire trên chân A0
DallasTemperature sensors(&oneWire); // Khởi tạo đối tượng cảm biến DS18B20 qua giao tiếp OneWire

int lastTemperature = 0;        // Biến lưu trữ giá trị nhiệt độ gần nhất đọc được

volatile bool tempRequested = false; // Cờ đánh dấu có yêu cầu đọc nhiệt độ từ node khác

void canMessageReceived() {     // Hàm callback được gọi khi nhận được tin nhắn CAN
 uint32_t rxId = ZBCan1.getRxId(); // Lấy ID của node gửi tin nhắn

 if (rxId == 0x7 && ZBCan1.isString()) { // Kiểm tra nếu tin nhắn từ node chính (ID 0x7) và là dạng chuỗi
   String message = ZBCan1.getLastStringMessage(); // Lấy nội dung chuỗi tin nhắn
   Serial.print("Message received: ");    // In ra Serial để debug
   Serial.println(message);               // In nội dung tin nhắn

   if (message == "GET_TEMP") {          // Nếu tin nhắn yêu cầu nhiệt độ
     tempRequested = true;               // Đặt cờ yêu cầu nhiệt độ thành true
   }
 }
}

void readTemperature() {                  // Hàm đọc nhiệt độ từ cảm biến
 sensors.requestTemperatures();          // Yêu cầu cảm biến đo nhiệt độ
 lastTemperature = sensors.getTempCByIndex(0); // Đọc nhiệt độ từ cảm biến đầu tiên (index 0), đơn vị độ C

 if (lastTemperature == DEVICE_DISCONNECTED_C || lastTemperature < -50) { // Kiểm tra nếu đọc lỗi hoặc giá trị bất thường
   lastTemperature = 1000;                 // Gán giá trị mặc định là 1000°C
   Serial.println("Sensor error - using default temperature"); // Thông báo lỗi cảm biến
 }
}

void setup() {                           // Hàm thiết lập chạy một lần khi khởi động
 Serial.begin(115200);                  // Khởi tạo giao tiếp Serial với tốc độ 115200 baud
 Serial.println("Temperature Node Starting"); // In thông báo khởi động

 sensors.begin();                       // Khởi tạo cảm biến nhiệt độ

 readTemperature();                     // Đọc nhiệt độ lần đầu

 ZBCan1.begin();                        // Khởi tạo giao tiếp CAN

 ZBCan1.setTxId(0x2);                   // Đặt ID của node này là 0x2 khi gửi tin nhắn

 uint32_t acceptedIds[] = { 0x1, 0x7 }; // Node chính có 2 ID: ID 0x1 sẽ gửi đến cả node xử lý nhiệt độ và node xử lý thời gian, ID 0x7 chỉ gửi đến node xử lý nhiệt độ
 ZBCan1.configureMultipleFilters(acceptedIds, 2); // Cấu hình bộ lọc chỉ nhận tin nhắn từ các ID đã chọn

 ZBCan1.onReceive(canMessageReceived);  // Thiết lập hàm callback để xử lý khi có tin nhắn CAN đến.

 Serial.println("Temperature Node Ready"); // In thông báo sẵn sàng
}

void loop() {                            // Hàm vòng lặp chính, chạy liên tục
 readTemperature();                     // Đọc nhiệt độ định kỳ
 Serial.print("Temperature: ");         // In thông tin nhiệt độ ra Serial
 Serial.println(lastTemperature);       // In giá trị nhiệt độ

 if (tempRequested) {                   // Kiểm tra nếu có yêu cầu gửi nhiệt độ
   ZBCan1.send(lastTemperature);        // Gửi giá trị nhiệt độ qua CAN
   Serial.println("Temperature sent");  // In thông báo đã gửi nhiệt độ
   tempRequested = false;               // Đặt lại cờ yêu cầu
 }

 delay(500);                            // Tạm dừng 500ms để ổn định
}
```

### Code cho Zerobase 2 thứ hai (đọc thời gian từ module RTC DS3231)

```cpp
/**********************************
* CAN_RTC.ino
* Real-time clock node with DS3231
**********************************/

#include <Arduino.h>            // Thư viện cơ bản của Arduino
#include <ZBCan.h>              // Thư viện giao tiếp CAN trên Zerobase
#include <Wire.h>               // Thư viện giao tiếp I2C
#include <DS3231.h>             // Thư viện giao tiếp với module RTC DS3231
#include <ZBPrint.h>            // Thư viện in ấn cho Zerobase

DS3231 rtc;                     // Khởi tạo đối tượng RTC DS3231

bool timeIsSet = false;         // Biến đánh dấu thời gian đã được cài đặt chưa (chỉ cài đặt một lần)

char dateTimeStr[17];           // Buffer lưu chuỗi ngày/giờ

bool timeRequested = false;     // Cờ đánh dấu có yêu cầu đọc thời gian từ node khác

void canMessageReceived() {     // Hàm callback được gọi khi nhận được tin nhắn CAN
 uint32_t rxId = ZBCan1.getRxId(); // Lấy ID của node gửi tin nhắn

 if (rxId == 0x8 && ZBCan1.isString()) { // Kiểm tra nếu tin nhắn từ node chính (ID 0x8) và là dạng chuỗi
   String message = ZBCan1.getLastStringMessage(); // Lấy nội dung chuỗi tin nhắn
   Serial.print("Message received: ");    // In ra Serial để debug
   Serial.println(message);               // In nội dung tin nhắn

   if (message == "GET_TIME") {          // Nếu tin nhắn yêu cầu thời gian
     timeRequested = true;               // Đặt cờ yêu cầu thời gian thành true
   }
 }
}

void readDateTime() {           // Hàm đọc ngày giờ hiện tại từ RTC
 bool h12, PM, century;        // Các biến cần thiết cho các hàm đọc RTC

 // Đọc các thành phần thời gian
 byte month = rtc.getMonth(century);    // Đọc tháng
 byte day = rtc.getDate();              // Đọc ngày
 byte year = rtc.getYear();             // Đọc năm
 byte hour = rtc.getHour(h12, PM);      // Đọc giờ
 byte minute = rtc.getMinute();         // Đọc phút
 byte second = rtc.getSecond();         // Đọc giây

 // Định dạng chuỗi ngày/giờ: DD/MM/YY HH:MM:SS
 sprintf(dateTimeStr, "%d/%d/%02d %02d:%02d:%02d",
         day, month, year, hour, minute, second);
}

void setup() {                  // Hàm thiết lập chạy một lần khi khởi động
 Serial.begin(115200);         // Khởi tạo giao tiếp Serial với tốc độ 115200 baud
 Serial.println("RTC Node Starting"); // In thông báo khởi động

 Wire.begin();                 // Khởi tạo giao tiếp I2C cho RTC

 if (!timeIsSet) {             // Nếu thời gian chưa được đặt
   // Cài đặt thời gian ban đầu (chỉ cần làm một lần)
   // 5 tháng 5, 2026, Thứ 2, 17:00:00
   rtc.setYear(26);            // Đặt năm: 2026 (chỉ 2 số cuối)
   rtc.setMonth(5);            // Đặt tháng: tháng 5
   rtc.setDate(5);             // Đặt ngày: ngày 5
   rtc.setDoW(2);              // Đặt thứ: thứ 2
   rtc.setHour(17);            // Đặt giờ: 17 giờ
   rtc.setMinute(0);           // Đặt phút: 0 phút
   rtc.setSecond(0);           // Đặt giây: 0 giây

   rtc.setClockMode(false);    // Đặt chế độ 24 giờ (false = 24h, true = 12h)

   timeIsSet = true;           // Đánh dấu đã cài đặt thời gian
   Serial.println("Time set successfully"); // Thông báo cài đặt thành công
 }

 readDateTime();               // Đọc thời gian lần đầu

 ZBCan1.begin();               // Khởi tạo giao tiếp CAN

 ZBCan1.setTxId(0x3);          // Đặt ID của node này là 0x3 khi gửi tin nhắn

 uint32_t acceptedIds[] = { 0x1, 0x8 }; // Node chính có 2 ID: ID 0x1 sẽ gửi đến cả node nhiệt độ và node thời gian, ID 0x8 chỉ gửi đến node thời gian
 ZBCan1.configureMultipleFilters(acceptedIds, 2); // Cấu hình bộ lọc chỉ nhận tin nhắn từ các ID đã chọn

 ZBCan1.onReceive(canMessageReceived); //Thiết lập hàm callback để xử lý khi có tin nhắn CAN đến.

 Serial.println("RTC Node Ready"); // In thông báo sẵn sàng
}

void loop() {                   // Hàm vòng lặp chính, chạy liên tục
 readDateTime();               // Đọc thời gian hiện tại

 if (timeRequested) {          // Nếu có yêu cầu thời gian
   ZBCan1.send(dateTimeStr);   // Gửi chuỗi thời gian qua CAN
   Serial.print("Time sent: ");// In thông báo đã gửi thời gian
   Serial.println(dateTimeStr);// In chuỗi thời gian đã gửi
   timeRequested = false;      // Đặt lại cờ yêu cầu
 }

 delay(1000);                  // Tạm dừng 1000ms để ổn định
}
```

### Code cho Zerobase 2 thứ ba (hiển thị nhiệt độ và thời gian lên LCD 1602A)

```cpp
/**********************************
* CAN_Display.ino
* Display node with LCD I2C
**********************************/

#include <Arduino.h>            // Thư viện cơ bản của Arduino
#include <ZBCan.h>              // Thư viện giao tiếp CAN trên Zerobase
#include <Wire.h>               // Thư viện giao tiếp I2C
#include <LiquidCrystal_I2C.h>  // Thư viện điều khiển LCD qua I2C
#include <ZBPrint.h>            // Thư viện in ấn cho Zerobase

LiquidCrystal_I2C lcd(0x27, 16, 2); // Tạo đối tượng LCD (địa chỉ 0x27, 16 cột, 2 dòng)

int temperature = 0;            // Biến lưu giá trị nhiệt độ nhận được
char dateTime[17] = "00/00/00 00:00"; // Biến lưu chuỗi ngày giờ, định dạng: MM/DD/YY HH:MM

void canMessageReceived() {     // Hàm callback được gọi khi nhận được tin nhắn CAN
 uint32_t rxId = ZBCan1.getRxId(); // Lấy ID của node đã gửi tin nhắn

 if (rxId == 0x2) {            // Nếu tin nhắn từ node nhiệt độ (ID 0x2)
   if (ZBCan1.isInt()) {       // Kiểm tra nếu tin nhắn là kiểu số nguyên
     temperature = ZBCan1.getLastIntValue(); // Lấy giá trị nhiệt độ
     Serial.print("Temperature received: "); // In thông báo nhận nhiệt độ
     Serial.print(temperature);         // In giá trị nhiệt độ
     Serial.println("°C");              // In đơn vị độ C
   }
 } else if (rxId == 0x3) {     // Nếu tin nhắn từ node thời gian (ID 0x3)
   if (ZBCan1.isString()) {    // Kiểm tra nếu tin nhắn là kiểu chuỗi
     strcpy(dateTime, ZBCan1.getLastStringMessage()); // Sao chép chuỗi thời gian nhận được
     Serial.print("DateTime received: "); // In thông báo nhận thời gian
     Serial.println(dateTime);         // In chuỗi thời gian
   }
 }
}

void updateDisplay() {          // Hàm cập nhật màn hình LCD
 lcd.clear();                  // Xóa màn hình LCD

 lcd.setCursor(0, 0);          // Đặt vị trí con trỏ (dòng 1, cột 1)
 lcd.print(dateTime);          // Hiển thị ngày giờ ở dòng 1

 lcd.setCursor(3, 1);          // Đặt vị trí con trỏ (dòng 2, cột 4)
 lcd.print("Temp: ");          // Hiển thị chữ "Temp: "
 lcd.print(temperature);       // Hiển thị giá trị nhiệt độ
 lcd.print(" C");              // Hiển thị đơn vị độ C
}

void setup() {                  // Hàm thiết lập chạy một lần khi khởi động
 Serial.begin(115200);         // Khởi tạo giao tiếp Serial với tốc độ 115200 baud
 Serial.println("Display Node Starting"); // In thông báo khởi động

 Wire.begin();                 // Khởi tạo giao tiếp I2C
 lcd.begin(16, 2);             // Khởi tạo LCD 16x2
 lcd.backlight();              // Bật đèn nền LCD
 lcd.clear();                  // Xóa màn hình LCD
 lcd.print("Initializing..."); // Hiển thị thông báo đang khởi tạo

 ZBCan1.begin();               // Khởi tạo giao tiếp CAN

 ZBCan1.setTxId(0x1);          // Đặt ID của node này là 0x1 khi gửi tin nhắn

 uint32_t acceptedIds[] = { 0x2, 0x3 }; // Chỉ nhận tin nhắn từ node nhiệt độ (ID 0x2) và node thời gian (ID 0x3)
 ZBCan1.configureMultipleFilters(acceptedIds, 2); // Cấu hình bộ lọc

 ZBCan1.onReceive(canMessageReceived); // Thiết lập hàm callback để xử lý khi có tin nhắn CAN đến.

}

void loop() {                   // Hàm vòng lặp chính, chạy liên tục
 ZBCan1.send("GET_TIME", 0x8); // Gửi tin nhắn "GET_TIME" và đặt ID tin nhắn thành 0x8 để node thời gian nhận biết
 Serial.println("Requesting time update"); // In thông báo yêu cầu cập nhật thời gian

 ZBCan1.send("GET_TEMP", 0x7); // Gửi tin nhắn "GET_TEMP" và đặt ID tin nhắn thành 0x7 để node nhiệt độ nhận biết
 Serial.println("Requesting temperature update"); // In thông báo yêu cầu cập nhật nhiệt độ

 updateDisplay();              // Cập nhật màn hình LCD

 delay(1000);                  // Tạm dừng 1000ms để ổn định
}
```

Copy 3 đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![can-mcp2551-code](https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

### Sơ lược về thư viện ZBCan

#### Bảng thông tin hằng số CAN Mode

| Chế độ | Mô tả |
|--------|-------|
| ZBCAN_MODE_NORMAL | Chế độ hoạt động bình thường |
| ZBCAN_MODE_LOOPBACK | Chế độ kiểm tra vòng lặp (tự gửi nhận) |
| ZBCAN_MODE_SILENT | Chế độ im lặng (chỉ nghe) |
| ZBCAN_MODE_SILENT_LOOPBACK | Kết hợp chế độ im lặng và vòng lặp |

#### Bảng thông tin định dạng khung

| Định dạng | Mô tả |
|-----------|-------|
| ZBCAN_STANDARD_FRAME | Khung chuẩn (ID 11-bit) |
| ZBCAN_EXTENDED_FRAME | Khung mở rộng (ID 29-bit) |

#### Lưu ý khi sử dụng ZBCan

1. Mỗi node trên mạng CAN cần có một ID duy nhất
2. Tất cả node phải thiết lập cùng một tốc độ truyền (baudrate)

#### 1. Khởi tạo giao tiếp CAN

```cpp
bool begin();
bool begin(uint32_t baud, uint8_t mode = ZBCAN_MODE_NORMAL, 
           uint32_t txId = 0x100, uint8_t frameFormat = ZBCAN_STANDARD_FRAME);
```

- **Mục đích**: Khởi tạo giao tiếp CAN
- **Chi tiết**: 
  - Phiên bản đơn giản không cần tham số, sử dụng cấu hình mặc định (500kbps, chế độ bình thường)
  - Phiên bản đầy đủ cho phép cấu hình chi tiết
- **Tham số**:
  - `baud`: Tốc độ truyền (bit/giây, ví dụ: 500000 cho 500kbps)
  - `mode`: Chế độ hoạt động (ZBCAN_MODE_NORMAL, ZBCAN_MODE_LOOPBACK...)
  - `txId`: ID của node khi gửi tin nhắn
  - `frameFormat`: Định dạng khung (ZBCAN_STANDARD_FRAME hoặc ZBCAN_EXTENDED_FRAME)
- **Giá trị trả về**: `bool` - true nếu khởi tạo thành công, false nếu thất bại

#### 2. Cấu hình tốc độ và chế độ

```cpp
bool setSpeed(uint32_t baud);
bool setMode(uint8_t mode);
```

- **Mục đích**: Thay đổi tốc độ truyền hoặc chế độ hoạt động sau khi đã khởi tạo
- **Chi tiết**:
  - `setSpeed`: Đặt tốc độ truyền mới cho CAN
  - `setMode`: Thay đổi chế độ hoạt động của CAN
- **Tham số**:
  - `baud`: Tốc độ truyền (bit/giây, ví dụ: 500000 cho 500kbps)
  - `mode`: Chế độ hoạt động (ZBCAN_MODE_NORMAL, ZBCAN_MODE_LOOPBACK...)
- **Giá trị trả về**: `bool` - true nếu thành công, false nếu thất bại
- **Lưu ý**: Cần gọi sau khi đã khởi tạo CAN bằng hàm begin()

#### 3. Thiết lập ID và bộ lọc

```cpp
void setTxId(uint32_t id);
bool configureMultipleFilters(uint32_t* ids, uint8_t count);
bool acceptAllIds();
```

- **Mục đích**: Cấu hình ID gửi và bộ lọc ID nhận
- **Chi tiết**:
  - `setTxId`: Đặt ID cho node khi gửi tin nhắn
  - `configureMultipleFilters`: Chỉ nhận tin nhắn từ danh sách ID cụ thể
  - `acceptAllIds`: Nhận tất cả tin nhắn trên mạng CAN không lọc
- **Tham số**:
  - `id`: ID của node khi gửi tin nhắn
  - `ids`: Mảng các ID được chấp nhận
  - `count`: Số lượng ID trong mảng
- **Giá trị trả về**: Tùy thuộc vào hàm

#### 4. Gửi tin nhắn

```cpp
uint8_t send(const char *message, uint32_t id = 0);
uint8_t send(int value, uint32_t id = 0);
uint8_t send(unsigned int value, uint32_t id = 0);
```

- **Mục đích**: Gửi tin nhắn qua mạng CAN
- **Chi tiết**: Hỗ trợ nhiều kiểu dữ liệu (chuỗi, số nguyên, số không dấu...)
- **Tham số**:
  - `message`: Chuỗi cần gửi
  - `value`: Giá trị số cần gửi
  - `id`: ID tùy chọn (nếu khác 0 sẽ ghi đè ID mặc định đã đặt)
- **Giá trị trả về**: `uint8_t` - 0 nếu gửi thành công, 1 nếu thất bại

#### 5. Thiết lập hàm callback để xử lý khi có tin nhắn CAN đến.

```cpp
void onReceive(ZBCanCallback callback);
void onString(ZBCanCallback callback);
void onInt(ZBCanCallback callback);
```

- **Mục đích**: Thiết lập hàm callback để xử lý khi có tin nhắn CAN đến.
- **Chi tiết**: 
  - `onReceive`: Gọi khi nhận bất kỳ tin nhắn nào
  - `onString`: Chỉ gọi khi nhận tin nhắn dạng chuỗi
  - `onInt`: Chỉ gọi khi nhận tin nhắn dạng số nguyên
- **Tham số**:
  - `callback`: Hàm được gọi khi nhận tin nhắn
- **Lưu ý**: Callback không có tham số, phải sử dụng các getter để lấy dữ liệu

#### 6. Kiểm tra kiểu tin nhắn

```cpp
bool isString();
bool isInt();
bool isUint();
```

- **Mục đích**: Kiểm tra kiểu của tin nhắn vừa nhận
- **Chi tiết**: Xác định kiểu dữ liệu của tin nhắn cuối cùng được nhận
- **Giá trị trả về**: `bool` - true nếu tin nhắn có kiểu tương ứng

#### 7. Lấy dữ liệu từ tin nhắn đã nhận

```cpp
const char* getLastStringMessage();
int32_t getLastIntValue();
uint32_t getLastUintValue();
uint32_t getRxId();
```

- **Mục đích**: Lấy dữ liệu từ tin nhắn đã nhận
- **Chi tiết**:
  - `getLastStringMessage`: Lấy nội dung chuỗi từ tin nhắn cuối
  - `getLastIntValue`: Lấy giá trị số nguyên từ tin nhắn cuối
  - `getLastUintValue`: Lấy giá trị số không dấu từ tin nhắn cuối
  - `getRxId`: Lấy ID của node đã gửi tin nhắn cuối
- **Giá trị trả về**: Tùy thuộc vào kiểu dữ liệu

### Giải thích code

Hệ thống gồm 3 node Zerobase 2 giao tiếp qua mạng CAN để hiển thị nhiệt độ và thời gian. Mỗi node có ID và vai trò riêng trong mạng.

#### 1. Node chính (Zerobase 2 thứ ba) - Hiển thị dữ liệu

Node chính điều khiển hệ thống, gửi yêu cầu và hiển thị dữ liệu lên màn hình LCD.

##### Thiết lập ban đầu (hàm setup)

```cpp
void setup() {
 Serial.begin(115200);         // Khởi tạo Serial
 Serial.println("Display Node Starting");

 Wire.begin();                 // Khởi tạo I2C
 lcd.begin(16, 2);             // Khởi tạo LCD 16x2
 lcd.backlight();              // Bật đèn nền LCD
 lcd.clear();                  // Xóa màn hình
 // Hiển thị thông điệp khởi động
  lcd.setCursor(2, 0);       // Cột 2, dòng 0
  lcd.print("Zerobase 2!!!");  // Dòng chữ đầu
  lcd.setCursor(2, 1);       // Cột 2, dòng 1
  lcd.print("Starting...");  // Dòng chữ thứ hai
  delay(2000);               // Dừng lại 2 giây để người dùng đọc

  lcd.clear();  // Xóa màn hình sau khi hiển thị

 ZBCan1.begin();               // Khởi tạo CAN
 ZBCan1.setTxId(0x1);          // Đặt ID gửi tin nhắn là 0x1

 uint32_t acceptedIds[] = { 0x2, 0x3 }; // Chỉ nhận tin nhắn từ node nhiệt độ và thời gian
 ZBCan1.configureMultipleFilters(acceptedIds, 2);

 ZBCan1.onReceive(canMessageReceived); // Đăng ký hàm callback
}
```

- `Serial.begin(115200)`: Khởi tạo giao tiếp Serial với tốc độ 115200 bits/giây để gửi thông tin debug ra máy tính
- `Wire.begin()`: Khởi tạo giao thức I2C, cần thiết cho giao tiếp với LCD 1602A
- `lcd.begin(16, 2)`: Khởi tạo màn hình LCD với 16 cột và 2 dòng
- `lcd.backlight()`: Bật đèn nền màn hình LCD, giúp đọc được nội dung trong điều kiện thiếu ánh sáng
- `lcd.clear()`: Xóa toàn bộ nội dung hiển thị trên màn hình LCD
- `lcd.print("Initializing...")`: Hiển thị thông báo đang khởi tạo trên màn hình
- `ZBCan1.begin()`: Khởi tạo giao tiếp CAN với các thiết lập mặc định (500kbps)
- `ZBCan1.setTxId(0x1)`: Đặt ID gửi tin nhắn của node là 0x1
- `ZBCan1.configureMultipleFilters(acceptedIds, 2)`: Cấu hình bộ lọc để chỉ nhận tin nhắn từ node có ID 0x2 (nhiệt độ) và 0x3 (thời gian)
- `ZBCan1.onReceive(canMessageReceived)`: Đăng ký hàm callback được gọi mỗi khi nhận được tin nhắn CAN

##### Gửi tin nhắn (trong vòng lặp loop)

```cpp
void loop() {
 ZBCan1.send("GET_TIME", 0x8); // Gửi tin nhắn "GET_TIME" với ID 0x8 đến node thời gian
 Serial.println("Requesting time update");

 ZBCan1.send("GET_TEMP", 0x7); // Gửi tin nhắn "GET_TEMP" với ID 0x7 đến node nhiệt độ
 Serial.println("Requesting temperature update");

 updateDisplay();              // Cập nhật màn hình LCD
 delay(1000);                  // Tạm dừng 1 giây
}
```

- `ZBCan1.send("GET_TIME", 0x8)`: Gửi chuỗi "GET_TIME" qua mạng CAN với ID gửi là 0x8
  - Tham số đầu tiên: Dữ liệu cần gửi (chuỗi "GET_TIME")
  - Tham số thứ hai: ID của tin nhắn (0x8), node thời gian được cấu hình để lắng nghe ID này
- `ZBCan1.send("GET_TEMP", 0x7)`: Tương tự, gửi chuỗi "GET_TEMP" với ID 0x7 để node nhiệt độ nhận được
- `updateDisplay()`: Gọi hàm cập nhật hiển thị lên màn hình LCD
- `delay(1000)`: Tạm dừng chương trình 1000ms (1 giây) trước khi lặp lại vòng loop

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-main-node-send.png" alt="module-i2c">
        <p><em>Kết quả khi node chính gửi tin nhắn đến node xử lý nhiệt độ và node xử lý thời gian</em></p>
</div>

##### Nhận tin nhắn (hàm callback)

```cpp
void canMessageReceived() {
 uint32_t rxId = ZBCan1.getRxId(); // Lấy ID của node gửi tin nhắn

 if (rxId == 0x2) {            // Nếu tin nhắn từ node nhiệt độ (ID 0x2)
   if (ZBCan1.isInt()) {       // Kiểm tra kiểu dữ liệu số nguyên
     temperature = ZBCan1.getLastIntValue(); // Lấy giá trị nhiệt độ
     Serial.print("Temperature received: ");
     Serial.print(temperature);
     Serial.println("°C");
   }
 } else if (rxId == 0x3) {     // Nếu tin nhắn từ node thời gian (ID 0x3)
   if (ZBCan1.isString()) {    // Kiểm tra kiểu dữ liệu chuỗi
     strcpy(dateTime, ZBCan1.getLastStringMessage()); // Sao chép chuỗi thời gian
     Serial.print("DateTime received: ");
     Serial.println(dateTime);
   }
 }
}
```

- `ZBCan1.getRxId()`: Lấy ID của node đã gửi tin nhắn hiện tại
- `ZBCan1.isInt()`: Kiểm tra nếu tin nhắn nhận được có kiểu dữ liệu số nguyên 
- `ZBCan1.getLastIntValue()`: Lấy giá trị số nguyên từ tin nhắn vừa nhận
- `ZBCan1.isString()`: Kiểm tra nếu tin nhắn nhận được có kiểu dữ liệu chuỗi
- `strcpy(dateTime, ZBCan1.getLastStringMessage())`: Sao chép chuỗi thời gian từ tin nhắn vào biến `dateTime`
  - Hàm `strcpy` là hàm chuẩn của ngôn ngữ C, sao chép toàn bộ nội dung từ chuỗi nguồn sang chuỗi đích
  - Tham số thứ nhất: Chuỗi đích (biến `dateTime` để lưu kết quả)
  - Tham số thứ hai: Chuỗi nguồn (dữ liệu từ tin nhắn CAN)

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-main-node-receive.png" alt="module-i2c">
        <p><em>Kết quả khi node chính nhận được tin nhắn trả về từ node xử lý nhiệt độ và node xử lý thời gian</em></p>
</div>

##### Hiển thị dữ liệu (hàm updateDisplay)

```cpp
void updateDisplay() {
 lcd.clear();                  // Xóa màn hình LCD

 lcd.setCursor(0, 0);          // Đặt vị trí con trỏ (dòng 1, cột 1)
 lcd.print(dateTime);          // Hiển thị ngày giờ ở dòng 1

 lcd.setCursor(3, 1);          // Đặt vị trí con trỏ (dòng 2, cột 4)
 lcd.print("Temp: ");          // Hiển thị chữ "Temp: "
 lcd.print(temperature);       // Hiển thị giá trị nhiệt độ
 lcd.print(" C");              // Hiển thị đơn vị độ C
}
```

- `lcd.clear()`: Xóa toàn bộ nội dung trên màn hình LCD
- `lcd.setCursor(0, 0)`: Đặt vị trí con trỏ LCD tại cột 0, dòng 0 (dòng đầu tiên)
- `lcd.print(dateTime)`: Hiển thị chuỗi thời gian tại vị trí con trỏ
- `lcd.setCursor(3, 1)`: Đặt vị trí con trỏ LCD tại cột 3, dòng 1 (dòng thứ hai)
- `lcd.print("Temp: ")`: Hiển thị chuỗi "Temp: " tại vị trí con trỏ
- `lcd.print(temperature)`: Hiển thị giá trị nhiệt độ, tự động chuyển đổi số nguyên thành chuỗi
- `lcd.print(" C")`: Hiển thị đơn vị độ C sau giá trị nhiệt độ

#### 2. Node xử lý nhiệt độ (Zerobase 2 thứ nhất)

Node này đọc nhiệt độ từ cảm biến DS18B20 và gửi về node chính khi có yêu cầu.

##### Thiết lập ban đầu (hàm setup)

```cpp
void setup() {
 Serial.begin(115200);                  // Khởi tạo Serial
 Serial.println("Temperature Node Starting");

 sensors.begin();                       // Khởi tạo cảm biến nhiệt độ

 readTemperature();                     // Đọc nhiệt độ lần đầu

 ZBCan1.begin();                        // Khởi tạo CAN
 ZBCan1.setTxId(0x2);                   // Đặt ID gửi tin nhắn là 0x2

 uint32_t acceptedIds[] = { 0x1, 0x7 }; // Chỉ nhận tin nhắn từ node chính
 ZBCan1.configureMultipleFilters(acceptedIds, 2);

 ZBCan1.onReceive(canMessageReceived);  // Đăng ký hàm callback

 Serial.println("Temperature Node Ready");
}
```

- `sensors.begin()`: Khởi tạo thư viện DallasTemperature để giao tiếp với cảm biến DS18B20
- `readTemperature()`: Gọi hàm đọc nhiệt độ lần đầu để kiểm tra cảm biến
- `ZBCan1.setTxId(0x2)`: Đặt ID gửi tin nhắn của node là 0x2
- `ZBCan1.configureMultipleFilters(acceptedIds, 2)`: Cấu hình bộ lọc để chỉ nhận tin nhắn có ID 0x1 (từ node chính) và 0x7 (yêu cầu nhiệt độ)


##### Đọc nhiệt độ

```cpp
void readTemperature() {
 sensors.requestTemperatures();          // Yêu cầu cảm biến đo nhiệt độ
 lastTemperature = sensors.getTempCByIndex(0); // Đọc nhiệt độ, đơn vị độ C

 if (lastTemperature == DEVICE_DISCONNECTED_C || lastTemperature < -50) { // Kiểm tra lỗi
   lastTemperature = 1000;               // Gán giá trị mặc định nếu lỗi
   Serial.println("Sensor error - using default temperature");
 }
}
```

- `sensors.requestTemperatures()`: Yêu cầu tất cả cảm biến DS18B20 trên bus OneWire thực hiện đo nhiệt độ
- `sensors.getTempCByIndex(0)`: Đọc nhiệt độ từ cảm biến đầu tiên (index 0) trên bus, đơn vị độ C
- `DEVICE_DISCONNECTED_C`: Hằng số đặc biệt (-127°C) trả về khi không thể đọc được cảm biến
- `lastTemperature < -50`: Kiểm tra thêm giá trị bất thường (nhiệt độ quá thấp)
- `lastTemperature = 1000`: Đặt giá trị mặc định là 1000°C khi có lỗi

##### Nhận tin nhắn

```cpp
void canMessageReceived() {
 uint32_t rxId = ZBCan1.getRxId();

 if (rxId == 0x7 && ZBCan1.isString()) { // Kiểm tra tin nhắn từ node chính với ID 0x7
   String message = ZBCan1.getLastStringMessage();
   Serial.print("Message received: ");
   Serial.println(message);

   if (message == "GET_TEMP") {          // Nếu tin nhắn yêu cầu nhiệt độ
     tempRequested = true;               // Đặt cờ yêu cầu nhiệt độ
   }
 }
}
```

- `String message = ZBCan1.getLastStringMessage()`: Lấy nội dung chuỗi từ tin nhắn CAN vừa nhận
  - Hàm này trả về con trỏ char* từ bộ đệm nội bộ của thư viện ZBCan
  - Chuyển đổi thành đối tượng String của Arduino để dễ so sánh
- `message == "GET_TEMP"`: So sánh nội dung tin nhắn với chuỗi "GET_TEMP"
- `tempRequested = true`: Đặt cờ báo hiệu có yêu cầu gửi nhiệt độ

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-temperature-node-receive.png" alt="can-mcp2551-temperature-node-receive">
        <p><em>Kết quả khi node xử lý nhiệt độ nhận được tin nhắn yêu cầu gửi nhiệt độ từ node chính</em></p>
</div>

##### Gửi tin nhắn

```cpp
void loop() {
 readTemperature();                     // Đọc nhiệt độ định kỳ
 Serial.print("Temperature: ");
 Serial.println(lastTemperature);

 if (tempRequested) {                   // Kiểm tra nếu có yêu cầu gửi nhiệt độ
   ZBCan1.send(lastTemperature);        // Gửi giá trị nhiệt độ qua CAN
   Serial.println("Temperature sent");
   tempRequested = false;               // Đặt lại cờ yêu cầu
 }

 delay(500);                            // Tạm dừng 500ms
}
```

- `ZBCan1.send(lastTemperature)`: Gửi giá trị nhiệt độ (kiểu số nguyên) qua mạng CAN
  - Chỉ gọi khi biến `tempRequested` là true (có yêu cầu từ node chính)
  - Tự động sử dụng ID 0x2 đã đặt trong setup
- `tempRequested = false`: Đặt lại cờ yêu cầu sau khi đã gửi dữ liệu


<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-temperature-node-send.png" alt="can-mcp2551-temperature-node-send">
        <p><em>Kết quả khi node xử lý nhiệt độ gửi tin nhắn về node chính</em></p>
</div>

#### 3. Node xử lý thời gian (Zerobase 2 thứ hai)

Node này đọc thời gian từ module RTC DS3231 và gửi về node chính khi có yêu cầu.

##### Thiết lập ban đầu (hàm setup)

```cpp
void setup() {
 Serial.begin(115200);         // Khởi tạo Serial
 Serial.println("RTC Node Starting");

 Wire.begin();                 // Khởi tạo I2C cho RTC

 if (!timeIsSet) {             // Nếu thời gian chưa được đặt
   // Cài đặt thời gian ban đầu (chỉ làm một lần)
   rtc.setYear(26);            // Năm 2026
   rtc.setMonth(5);            // Tháng 5
   rtc.setDate(5);             // Ngày 5
   rtc.setDoW(2);              // Thứ 2
   rtc.setHour(17);            // 17 giờ
   rtc.setMinute(0);           // 0 phút
   rtc.setSecond(0);           // 0 giây
   rtc.setClockMode(false);    // Chế độ 24 giờ

   timeIsSet = true;
   Serial.println("Time set successfully");
 }

 readDateTime();               // Đọc thời gian lần đầu

 ZBCan1.begin();               // Khởi tạo CAN
 ZBCan1.setTxId(0x3);          // Đặt ID gửi tin nhắn là 0x3

 uint32_t acceptedIds[] = { 0x1, 0x8 }; // Chỉ nhận tin nhắn từ node chính
 ZBCan1.configureMultipleFilters(acceptedIds, 2);

 ZBCan1.onReceive(canMessageReceived);

 Serial.println("RTC Node Ready");
}
```

- `Wire.begin()`: Khởi tạo giao thức I2C để giao tiếp với module RTC DS3231
- Khối lệnh điều kiện `if (!timeIsSet)`: Chỉ cài đặt thời gian ban đầu nếu biến `timeIsSet` là false
  - Trong thực tế, có thể sử dụng EEPROM để lưu trạng thái này giữa các lần khởi động
- Các hàm `rtc.setXXX()`: Cài đặt các thành phần thời gian cho module RTC
- `rtc.setClockMode(false)`: Cài đặt chế độ 24 giờ (false = 24h, true = 12h AM/PM)
- `ZBCan1.setTxId(0x3)`: Đặt ID gửi tin nhắn của node là 0x3
- `ZBCan1.configureMultipleFilters(acceptedIds, 2)`: Cấu hình bộ lọc để chỉ nhận tin nhắn có ID 0x1 (từ node chính) và 0x8 (yêu cầu thời gian)

##### Đọc thời gian

```cpp
void readDateTime() {
 bool h12, PM, century;        // Biến hỗ trợ cho các hàm đọc RTC

 // Đọc các thành phần thời gian
 byte month = rtc.getMonth(century);
 byte day = rtc.getDate();
 byte year = rtc.getYear();
 byte hour = rtc.getHour(h12, PM);
 byte minute = rtc.getMinute();
 byte second = rtc.getSecond();

 // Định dạng chuỗi: DD/MM/YY HH:MM:SS
 sprintf(dateTimeStr, "%d/%d/%02d %02d:%02d:%02d",
         day, month, year, hour, minute, second);
}
```

- Biến `h12`, `PM` và `century`: Tham số đầu ra bắt buộc cho một số hàm của thư viện DS3231
- Các hàm `rtc.getXXX()`: Đọc các thành phần thời gian từ module RTC
- `sprintf(dateTimeStr, "...")`: Hàm định dạng chuỗi từ thư viện C chuẩn
  - Tham số đầu tiên: Chuỗi đích để lưu kết quả (mảng `dateTimeStr`)
  - Tham số thứ hai: Chuỗi định dạng với các đặc tả chuyển đổi
    - `%d`: Hiển thị số nguyên thập phân
    - `%02d`: Hiển thị số nguyên thập phân với ít nhất 2 chữ số, thêm số 0 ở đầu nếu cần
  - Các tham số tiếp theo: Các giá trị sẽ được chèn vào chuỗi theo thứ tự

##### Nhận tin nhắn

```cpp
void canMessageReceived() {
 uint32_t rxId = ZBCan1.getRxId();

 if (rxId == 0x8 && ZBCan1.isString()) { // Kiểm tra tin nhắn từ node chính với ID 0x8
   String message = ZBCan1.getLastStringMessage();
   Serial.print("Message received: ");
   Serial.println(message);

   if (message == "GET_TIME") {          // Nếu tin nhắn yêu cầu thời gian
     timeRequested = true;               // Đặt cờ yêu cầu thời gian
   }
 }
}
```

- Tương tự như node nhiệt độ, nhưng lắng nghe ID 0x8 thay vì 0x7
- `message == "GET_TIME"`: So sánh nội dung tin nhắn với chuỗi "GET_TIME"
- `timeRequested = true`: Đặt cờ báo hiệu có yêu cầu gửi thời gian

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-rtc-node-receive-msg.png" alt="can-mcp2551-rtc-node-receive">
        <p><em>Kết quả khi node xử lý thời gian nhận được tin nhắn yêu cầu gửi thời gian từ node chính</em></p>
</div>

##### Gửi tin nhắn

```cpp
void loop() {
 readDateTime();               // Đọc thời gian hiện tại

 if (timeRequested) {          // Nếu có yêu cầu thời gian
   ZBCan1.send(dateTimeStr);   // Gửi chuỗi thời gian qua CAN
   Serial.print("Time sent: ");
   Serial.println(dateTimeStr);
   timeRequested = false;      // Đặt lại cờ yêu cầu
 }

 delay(1000);                  // Tạm dừng 1 giây
}
```

- `ZBCan1.send(dateTimeStr)`: Gửi chuỗi thời gian qua mạng CAN
  - Tham số là mảng ký tự `dateTimeStr` chứa chuỗi thời gian đã định dạng
  - Tự động sử dụng ID 0x3 đã đặt trong setup
- `timeRequested = false`: Đặt lại cờ yêu cầu sau khi đã gửi dữ liệu

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-rtc-node-send-msg.png" alt="can-mcp2551-rtc-node-send">
        <p><em>Kết quả khi node xử lý thời gian gửi tin nhắn về node chính</em></p>
</div>

#### Tổng quan hệ thống CAN Bus

Hệ thống sử dụng giao thức CAN để trao đổi dữ liệu giữa các node với mô hình yêu cầu-phản hồi:

##### Luồng dữ liệu
1. Node chính gửi yêu cầu với ID riêng (0x7 cho nhiệt độ, 0x8 cho thời gian)
2. Các node cảm biến nhận yêu cầu, xử lý và gửi dữ liệu về node chính
3. Node chính nhận dữ liệu từ các node (ID 0x2 cho nhiệt độ, ID 0x3 cho thời gian)
4. Node chính hiển thị dữ liệu lên màn hình LCD

##### Bảng ID CAN
| Node           | TX ID | RX ID                      | Chức năng                            |
|----------------|-------|----------------------------|--------------------------------------|
| Node chính     | 0x1/0x7/0x8 | 0x2, 0x3             | Gửi yêu cầu, hiển thị dữ liệu       |
| Node nhiệt độ  | 0x2   | 0x1, 0x7                   | Đọc nhiệt độ, gửi khi có yêu cầu    |
| Node thời gian | 0x3   | 0x1, 0x8                   | Đọc thời gian, gửi khi có yêu cầu   |

## Kết quả

?> Kết quả cuối cùng là nhiệt độ và thời gian được hiển thị trên màn hình màn hình lcd

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/can/can-mcp2551-result.gif" alt="can-mcp2551-result">
        <p><em>Kết quả cuối cùng được hiển thị lên màn hình LCD</em></p>
</div>

## Kết luận và hướng phát triển

Hệ thống sử dụng giao thức CAN để giao tiếp giữa các node Zerobase 2, cho phép truyền tải dữ liệu nhanh chóng và hiệu quả. Việc sử dụng thư viện ZBCan giúp đơn giản hóa quá trình lập trình và quản lý giao tiếp CAN.

Để phát triển thêm từ bài học này, bạn có thể thực hiện các ý tưởng sau:

- Thêm nhiều node cảm biến khác nhau (ví dụ: cảm biến độ ẩm, áp suất) vào mạng CAN
- Thêm chức năng lưu trữ dữ liệu lịch sử vào thẻ SD card hoặc EEPROM ngoại
- Phát triển tính năng cảnh báo khi nhiệt độ vượt ngưỡng (buzzer, đèn LED)
- Nâng cấp giao diện hiển thị sang màn hình OLED hoặc màn hình màu TFT
- Tạo giao diện điều khiển từ xa qua ESP8266/ESP32 để theo dõi dữ liệu qua mạng WiFi
- Thêm chức năng điều khiển thiết bị dựa trên dữ liệu nhiệt độ (ví dụ: bật/tắt quạt)
- Cải thiện khả năng tiết kiệm năng lượng bằng cách đưa các node vào chế độ ngủ

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)


