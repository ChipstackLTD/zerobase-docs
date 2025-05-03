# Điều khiển LED bằng thẻ RFID với Zerobase 2

![rfid-circuit](https://cdn.chipstack.vn/zerobase2/rfid/rfid-circuit.jpg)

## Tổng quan

?> Bài hướng dẫn này sẽ giúp bạn sử dụng module RFID RC522 kết hợp với Zerobase 2 để điều khiển LED. Bạn sẽ học cách sử dụng hai thẻ RFID khác nhau: một thẻ để bật LED và một thẻ khác để tắt LED.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 |[Mua ngay](https://chipstack.vn/san-pham/zerobase-2) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Điện trở 330Ω |[Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED |[Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Module RFID RC522 13.56Mhz | [Mua ngay](https://chipstack.vn/san-pham/module-rfid-rc522/) |
| Thẻ từ RFID 13.56MHz | [Mua ngay](https://chipstack.vn/san-pham/the-tu-rfid-13-56mhz/) |
| Thẻ từ móc khoá RFID 13.56MHz | [Mua ngay](https://chipstack.vn/san-pham/the-tu-rfid-13-56mhz-moc-khoa/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase">
    <p><em>Board Zerobase 2</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/dien-tro-330-ohm.png" alt="dien-tro-330-ohm">
    <p><em>Điện trở 330Ω</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/led-do.png" alt="led-do">
    <p><em>LED</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="button-lcd-usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2-overview">
    <p><em>Board Zerobase 2</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/rfid/rfid-rc522.jpg" alt="rfid-rc522">
    <p><em>Module RFID RC522</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/rfid/rfid-card.jpg" alt="rfid-card">
    <p><em>Thẻ từ RFID 13.56MHz</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/rfid/rfid-keychain.jpg" alt="rfid-keychain">
    <p><em>Thẻ từ móc khoá RFID 13.56MHz</em></p>
</div>

## Nguyên lý hoạt động

Module RFID RC522 sử dụng công nghệ RFID (Radio-Frequency Identification) để đọc thông tin từ các thẻ RFID. Mỗi thẻ RFID có một mã định danh duy nhất (UID). Trong dự án này, chúng ta sẽ lập trình Zerobase 2 để:

1. Đọc UID của thẻ RFID khi nó được đưa đến gần module đọc.
2. So sánh UID đọc được với các mã đã được lưu trữ trong chương trình.
3. Bật LED khi phát hiện thẻ "bật đèn".
4. Tắt LED khi phát hiện thẻ "tắt đèn".

## Sơ đồ kết nối

![rfid-pins](https://cdn.chipstack.vn/zerobase2/rfid/rfid-pins.png)

| Module RFID RC522 | Zerobase 2 |
| --- | --- |
| 3.3V | 3V3 |
| RST | A0 |
| GND | GND |
| IRQ | Không kết nối |
| MISO | D12 (MI) |
| MOSI | D11 (MO) |
| SCK | D13 (SCK) |
| SDA (SS) | D10 |

- Chân anode (+) của LED → D2 trên Zerobase 2
- Chân cathode (-) của LED → Điện trở 330Ω → GND trên Zerobase 2


![rfid-schematic](https://cdn.chipstack.vn/zerobase2/rfid/rfid-schematic.png)

![rfid-circuit](https://cdn.chipstack.vn/zerobase2/rfid/rfid-circuit.jpg)


## Code

```cpp
// Thêm thư viện SPI để giao tiếp với module RFID qua giao thức SPI
#include <SPI.h>
// Thêm thư viện MFRC522 để điều khiển module đọc thẻ RFID RC522
#include <MFRC522.h>

// Định nghĩa chân Reset cho module RFID RC522
#define RST_PIN A0
// Định nghĩa chân SS (Slave Select) cho module RFID RC522
#define SS_PIN 10
// Định nghĩa chân LED
#define LED_PIN D2

// Khai báo mảng lưu giá trị UID của thẻ đọc được, có 4 byte
int UID[4], i;

// Khai báo mảng ID1 với giá trị UID cụ thể - thẻ được sử dụng để bật đèn
// Lưu ý: Thay giá trị này bằng UID thực của thẻ bạn muốn sử dụng để bật đèn
int ID1[4] = { 243, 248, 222, 41 };  //Thẻ mở đèn
// Khai báo mảng ID2 với giá trị UID cụ thể - thẻ được sử dụng để tắt đèn
// Lưu ý: Thay giá trị này bằng UID thực của thẻ bạn muốn sử dụng để tắt đèn
int ID2[4] = { 225, 78, 243, 123 };  //Thẻ tắt đèn

// Khởi tạo đối tượng mfrc522 từ lớp MFRC522 với các tham số SS_PIN và RST_PIN
MFRC522 mfrc522(SS_PIN, RST_PIN);

// Hàm kiểm tra xem UID đọc được có khớp với ID được lưu hay không
bool compareUID(int uid[], int id[]) {
  for (byte i = 0; i < 4; i++) {
    if (uid[i] != id[i]) {
      return false; // Nếu có bất kỳ byte nào không khớp, trả về false
    }
  }
  return true; // Nếu tất cả các byte đều khớp, trả về true
}

// Hàm setup() - chạy một lần khi Arduino khởi động
void setup() {
  // Khởi tạo giao tiếp Serial với tốc độ baud 9600 để hiển thị thông tin
  Serial.begin(9600);
  while (!Serial) delay(10); // Chờ kết nối Serial được thiết lập

  Serial.println("Hệ thống điều khiển LED bằng thẻ RFID");
  Serial.println("---------------------------------------");

  // Cấu hình chân LED là OUTPUT để điều khiển đèn LED
  pinMode(LED_PIN, OUTPUT);
  // Tắt đèn LED khi khởi động (mức LOW)
  digitalWrite(LED_PIN, LOW);

  // Khởi tạo giao tiếp SPI
  SPI.begin();
  // Khởi tạo module RFID RC522
  mfrc522.PCD_Init();
  
  Serial.println("Đã khởi tạo module RFID RC522");
  Serial.println("Vui lòng quét thẻ để điều khiển LED");
}

// Hàm loop() - chạy lặp lại liên tục sau khi setup() hoàn thành
void loop() {
  // Kiểm tra xem có thẻ mới xuất hiện hay không
  // Nếu không có thẻ mới, thoát khỏi vòng lặp hiện tại
  if (!mfrc522.PICC_IsNewCardPresent()) {
    return;
  }

  // Đọc dữ liệu từ thẻ
  // Nếu không đọc được, thoát khỏi vòng lặp hiện tại
  if (!mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  // In dòng chữ "UID của thẻ: " ra Serial Monitor
  Serial.print("UID của thẻ: ");

  // Vòng lặp để đọc và hiển thị từng byte của UID thẻ
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    // Thêm khoảng trắng và số 0 đứng trước nếu giá trị byte nhỏ hơn 0x10 (16)
    Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
    // Lưu giá trị byte UID vào mảng UID
    UID[i] = mfrc522.uid.uidByte[i];
    // In giá trị byte ra Serial Monitor
    Serial.print(UID[i]);
  }

  // Xuống dòng sau khi in xong UID
  Serial.println("   ");

  // So sánh UID đọc được với ID1 (thẻ mở đèn)
  if (compareUID(UID, ID1)) {
    // Nếu trùng với ID1, bật đèn LED
    digitalWrite(LED_PIN, HIGH);
    // In thông báo ra Serial Monitor
    Serial.println("Thẻ mở đèn - ĐÈN ON");
  }
  // So sánh UID đọc được với ID2 (thẻ tắt đèn)
  else if (compareUID(UID, ID2)) {
    // Nếu trùng với ID2, tắt đèn LED
    digitalWrite(LED_PIN, LOW);
    // In thông báo ra Serial Monitor
    Serial.println("Thẻ tắt đèn - ĐÈN OFF");
  }
  // Trường hợp UID không trùng với ID1 và ID2
  else {
    // In thông báo ra Serial Monitor
    Serial.println("Sai thẻ - Không thực hiện hành động");
  }

  // Dừng giao tiếp với thẻ hiện tại
  mfrc522.PICC_HaltA();
  // Dừng mã hóa để chuẩn bị cho lần đọc thẻ tiếp theo
  mfrc522.PCD_StopCrypto1();
  
  // Chờ một khoảng thời gian ngắn trước khi đọc thẻ tiếp theo
  delay(1000);
}
```

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

## Giải thích code

### 1. Các thư viện

```cpp
#include <SPI.h>
#include <MFRC522.h>
```

- **Thư viện SPI**: Cung cấp giao tiếp SPI (Serial Peripheral Interface) để kết nối với module RFID
- **Thư viện MFRC522**: Chứa các hàm để điều khiển module đọc thẻ RFID RC522

### 2. Định nghĩa chân kết nối

```cpp
#define RST_PIN A0
#define SS_PIN 10
#define LED_PIN D2
```

- **RST_PIN**: Chân Reset kết nối với module RFID, được định nghĩa là chân A0
- **SS_PIN**: Chân Slave Select kết nối với module RFID, được định nghĩa là chân 10
- **LED_PIN**: Chân điều khiển LED, được định nghĩa là chân D2

### 3. Khai báo biến

```cpp
int UID[4], i;
int ID1[4] = { 243, 248, 222, 41 };  //Thẻ mở đèn
int ID2[4] = { 225, 78, 243, 123 };  //Thẻ tắt đèn
```

- **UID[4]**: Mảng lưu UID của thẻ đang quét (4 byte)
- **ID1[4]**: Mảng lưu UID của thẻ bật đèn (cần thay thế bằng UID của thẻ thực tế)
- **ID2[4]**: Mảng lưu UID của thẻ tắt đèn (cần thay thế bằng UID của thẻ thực tế)

### 4. Khởi tạo đối tượng MFRC522

```cpp
MFRC522 mfrc522(SS_PIN, RST_PIN);
```

- Tạo đối tượng `mfrc522` từ lớp MFRC522 với tham số là các chân kết nối SS_PIN và RST_PIN

### 5. Hàm compareUID()

```cpp
bool compareUID(int uid[], int id[]) {
  for (byte i = 0; i < 4; i++) {
    if (uid[i] != id[i]) {
      return false;
    }
  }
  return true;
}
```

- **Chức năng**: So sánh hai mảng UID để xác định thẻ
- **Tham số**:
  - `uid[]`: Mảng UID của thẻ đang quét
  - `id[]`: Mảng ID đã lưu trữ (ID1 hoặc ID2)
- **Hoạt động**: So sánh từng byte của hai mảng
- **Giá trị trả về**: 
  - `true` nếu tất cả 4 byte đều giống nhau
  - `false` nếu có ít nhất một byte khác nhau

### 6. Hàm setup()

```cpp
void setup() {
  // Khởi tạo Serial
  Serial.begin(9600);
  while (!Serial) delay(10);
  
  // Thông báo khởi động
  Serial.println("Hệ thống điều khiển LED bằng thẻ RFID");
  
  // Cấu hình LED
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, LOW);
  
  // Khởi tạo SPI và module RFID
  SPI.begin();
  mfrc522.PCD_Init();
}
```

- **Chức năng**: Thiết lập các cấu hình ban đầu cho hệ thống
- **Các bước thực hiện**:
  1. Khởi tạo giao tiếp Serial với tốc độ 9600 baud
  2. Chờ cho kết nối Serial được thiết lập (quan trọng với các board sử dụng USB)
  3. Hiển thị thông báo khởi động hệ thống
  4. Cấu hình chân LED là OUTPUT và mặc định tắt LED
  5. Khởi tạo giao tiếp SPI bằng hàm `SPI.begin()`
  6. Khởi tạo module RFID bằng hàm `mfrc522.PCD_Init()`

### 7. Hàm loop()

```cpp
void loop() {
  // Các lệnh trong hàm loop()
}
```

- **Chức năng**: Thực hiện vòng lặp chính của chương trình, liên tục kiểm tra thẻ RFID
- **Hoạt động**: Bao gồm các phần sau (được giải thích chi tiết bên dưới)

### 8. Hàm PICC_IsNewCardPresent()

```cpp
if (!mfrc522.PICC_IsNewCardPresent()) {
  return;
}
```

- **Chức năng**: Kiểm tra xem có thẻ RFID mới trong vùng đọc hay không
- **Giá trị trả về**: 
  - `true` nếu phát hiện thẻ mới
  - `false` nếu không có thẻ mới
- **Hoạt động**: Nếu không có thẻ mới, thoát khỏi vòng lặp hiện tại và quay lại đầu hàm loop()

### 9. Hàm PICC_ReadCardSerial()

```cpp
if (!mfrc522.PICC_ReadCardSerial()) {
  return;
}
```

- **Chức năng**: Đọc dữ liệu từ thẻ RFID đã được phát hiện
- **Giá trị trả về**: 
  - `true` nếu đọc thành công
  - `false` nếu có lỗi khi đọc
- **Hoạt động**: Nếu không đọc được dữ liệu, thoát khỏi vòng lặp hiện tại

### 10. Đọc và lưu UID

```cpp
Serial.print("UID của thẻ: ");

for (byte i = 0; i < mfrc522.uid.size; i++) {
  Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
  UID[i] = mfrc522.uid.uidByte[i];
  Serial.print(UID[i]);
}

Serial.println("   ");
```

- **Chức năng**: Đọc từng byte của UID từ thẻ và lưu vào mảng UID
- **Hoạt động**:
  1. In ra thông báo "UID của thẻ: "
  2. Lặp qua mỗi byte trong UID của thẻ
  3. Định dạng xuất để có khoảng trắng và số 0 đứng trước nếu giá trị byte < 16
  4. Lưu giá trị byte vào mảng UID
  5. In giá trị byte ra Serial Monitor

### 11. Hàm digitalWrite() - Điều khiển LED

```cpp
if (compareUID(UID, ID1)) {
  digitalWrite(LED_PIN, HIGH);
  Serial.println("Thẻ mở đèn - ĐÈN ON");
}
else if (compareUID(UID, ID2)) {
  digitalWrite(LED_PIN, LOW);
  Serial.println("Thẻ tắt đèn - ĐÈN OFF");
}
else {
  Serial.println("Sai thẻ - Không thực hiện hành động");
}
```
- **Chức năng**: Điều khiển trạng thái LED dựa trên UID của thẻ
- **Hoạt động**:
  - Kiểm tra xem UID có trùng với ID1 (thẻ bật đèn) không:
     - Nếu trùng: Bật LED bằng `digitalWrite(LED_PIN, HIGH)` và hiển thị thông báo
  - Kiểm tra xem UID có trùng với ID2 (thẻ tắt đèn) không:
     - Nếu trùng: Tắt LED bằng `digitalWrite(LED_PIN, LOW)` và hiển thị thông báo
  - Nếu không trùng với cả ID1 và ID2:
     - Hiển thị thông báo "Sai thẻ"

### 12. Các hàm kết thúc quét thẻ

```cpp
mfrc522.PICC_HaltA();
mfrc522.PCD_StopCrypto1();
  
delay(1000);
```

- **Hàm PICC_HaltA()**: Dừng giao tiếp với thẻ hiện tại
- **Hàm PCD_StopCrypto1()**: Tắt mã hóa để chuẩn bị cho lần đọc thẻ tiếp theo
- **Hàm delay(1000)**: Tạm dừng 1 giây (1000ms) trước khi quét thẻ tiếp theo

## Tìm UID của thẻ RFID

Khi bạn mới sử dụng thẻ RFID, bạn cần biết UID của thẻ để có thể sử dụng nó trong chương trình. Để làm điều này, bạn có thể sử dụng chương trình đơn giản sau để đọc và hiển thị UID của thẻ:

```cpp
#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN A0
#define SS_PIN 10

MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(9600);
  while (!Serial) delay(10);
  
  SPI.begin();
  mfrc522.PCD_Init();
  
  Serial.println("Chương trình đọc UID thẻ RFID");
  Serial.println("Quét thẻ để hiển thị UID");
}

void loop() {
  if (!mfrc522.PICC_IsNewCardPresent()) {
    return;
  }

  if (!mfrc522.PICC_ReadCardSerial()) {
    return;
  }

  Serial.print("UID của thẻ: { ");
  
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    Serial.print(mfrc522.uid.uidByte[i]);
    if (i < mfrc522.uid.size - 1) {
      Serial.print(", ");
    }
  }
  
  Serial.println(" }");
  
  mfrc522.PICC_HaltA();
  mfrc522.PCD_StopCrypto1();
  
  delay(1000);
}
```

## Kết quả

?> Khi nạp code thành công và quét thẻ RFID, bạn sẽ thấy LED bật khi quét thẻ "bật đèn" và tắt khi quét thẻ "tắt đèn". Thông tin về UID và trạng thái LED sẽ được hiển thị trên Serial Monitor.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/rfid/rfid-result.gif" alt="rfid-led-control-result">
    <p><em>Kết quả khi quét thẻ RFID</em></p>
</div>

## Kết luận và hướng phát triển

Bài hướng dẫn này đã giúp bạn tạo một hệ thống điều khiển LED đơn giản bằng thẻ RFID sử dụng board Zerobase 2. Dựa trên kiến thức này, bạn có thể phát triển các ứng dụng phức tạp hơn như:

1. **Hệ thống khóa điện tử**: Sử dụng relay để điều khiển khóa điện từ.
2. **Hệ thống điểm danh**: Lưu trữ và theo dõi thời gian quét thẻ của nhiều người dùng.
3. **Hệ thống điều khiển thiết bị**: Điều khiển nhiều thiết bị khác nhau dựa trên thẻ RFID được quét.
4. **Hệ thống thanh toán**: Tạo một hệ thống thanh toán đơn giản bằng cách liên kết thẻ RFID với tài khoản người dùng.
5. **Hệ thống kiểm soát truy cập**: Chỉ cho phép người dùng được ủy quyền truy cập vào các khu vực hoặc chức năng nhất định.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)