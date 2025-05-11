<br>
<br>
<br>

# Đọc và ghi file trên thẻ nhớ SD Card

![sdcard-circuit](https://cdn.chipstack.vn/zerobase/sdcard/sdcard-circuit.jpg)

## Tổng quan

?> Bài này sẽ hướng dẫn bạn cách đọc và ghi file trên thẻ nhớ SD Card với Zerobase sử dụng Module Micro SD.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase|[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |
| Module thẻ nhớ SD Card |[Mua ngay](https://chipstack.vn/san-pham/breakout-micro-sd/) |
| Thẻ nhớ Micro SD ||
| Đầu đọc thẻ nhớ Micro SD ||

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase2">
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
    <img src="https://cdn.chipstack.vn/default/module-sdcard.jpg" alt="module-sdcard">
    <p><em>Module thẻ nhớ Micro SD</em></p>
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
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/PL2303HX.png" alt="usb-uart-ttl">
    <p><em>Dây USB UART TTL PL2303HX</em></p>
</div>

## Nguyên lý hoạt động

?> Module Micro SD Card là một module giúp bạn có thể đọc và ghi dữ liệu lên thẻ nhớ Micro SD. Module này sử dụng giao thức SPI để giao tiếp với vi điều khiển. Bạn có thể sử dụng thư viện ZBSdCard.h để đọc và ghi dữ liệu lên thẻ nhớ Micro SD. Thư viện này được tích hợp sẵn trong thư viện Zerobase.

## Format thẻ nhớ SD Card

Để sử dụng thẻ nhớ SD Card với module, bạn cần định dạng thẻ nhớ SD Card với định dạng FAT32.

Bạn có thể sử dụng phần mềm [Rufus](https://rufus.ie/en/) để định dạng thẻ nhớ SD Card.

Sau khi cài đặt phần mềm, bạn mở phần mềm lên, giao diện sẽ hiển thị như hình dưới.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/rufus.png" alt="rufus" width="300px" height="auto">
    <p><em>Giao diện Rufus</em></p>
</div>

Bạn cắm thẻ nhớ vào đầu đọc thẻ nhớ, sau đó kết nối với máy tính. Chọn các thông số như sau:

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/rufus-settings.png" alt="rufus-settings" width="300px" height="auto">
    <p><em>Chọn các thông số trong Rufus</em></p>
</div>

Sau đó bạn nhấn nút Start để bắt đầu định dạng thẻ nhớ.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/rufus-start.png" alt="rufus-start" width="300px" height="auto">
    <p><em>Nhấn nút Start để bắt đầu định dạng thẻ nhớ</em></p>
</div>

Tiếp theo bạn sẽ thấy một thông báo hỏi bạn có muốn định dạng thẻ nhớ không, bạn chọn OK.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/rufus-ok.png" alt="rufus-ok" width="300px" height="auto">
    <p><em>Nhấn OK để xác nhận định dạng thẻ nhớ</em></p>
</div>

Đợi cho đến khi quá trình định dạng hoàn tất, bạn sẽ thấy thông báo `Ready` như hình dưới.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/rufus-ready.png" alt="rufus-ready" width="300px" height="auto">
    <p><em>Thông báo Ready</em></p>
</div>

Như vậy là bạn đã định dạng thẻ nhớ SD Card thành công.

## Sơ đồ kết nối

![sdcard-pins](https://cdn.chipstack.vn/zerobase/sdcard/sdcard-pins.png)

Module Micro SD:

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-attach.jpg" alt="sdcard-attach.jpg">
    <p><em>Gắn thẻ nhớ Micro SD vào Module Micro SD Card</em></p>
</div>

- 3V3 kết nối với 3V3 của Zerobase
- GND kết nối với GND của Zerobase
- CS kết nối với SS của Zerobase
- MOSI kết nối với MO của Zerobase
- MISO kết nối với MI của Zerobase
- CLK kết nối với SCK của Zerobase

Dây USB UART TTL PL2303HX:

- TX kết nối với RX của Zerobase
- RX kết nối với TX của Zerobase
- GND kết nối với GND của Zerobase

![sdcard-schematic](https://cdn.chipstack.vn/zerobase/sdcard/sdcard-schematic.png)

![sdcard-circuit](https://cdn.chipstack.vn/zerobase/sdcard/sdcard-circuit.jpg)

## Code

```cpp
#include <SPI.h>       // Thư viện giao tiếp SPI chuẩn của Arduino
#include "ZBSdCard.h"  // Thư viện điều khiển thẻ SD tùy chỉnh (Enhanced ZBSdCard)

#define SD_CS_PIN 10         // Định nghĩa chân CS cho thẻ SD là chân số 10
#define LED_PIN LED_BUILTIN  // Sử dụng đèn LED tích hợp trên bo mạch (thường là chân 13)

ZBSdCard sdCard(SD_CS_PIN);  // Tạo đối tượng sdCard từ lớp ZBSdCard với chân CS đã định nghĩa

void setup() {
  pinMode(LED_PIN, OUTPUT);  // Thiết lập chân LED làm đầu ra
  Serial1.begin(115200);     // Khởi động giao tiếp Serial1 với tốc độ baud 115200
  delay(1000);               // Đợi 1 giây để ổn định

  Serial1.println("===== Deep Directory Test =====");  // In tiêu đề bài kiểm tra ra serial

  // Bước 1: Khởi động thẻ SD
  Serial1.println("1. Initializing SD card");
  if (!sdCard.begin()) {                           // Nếu khởi động thất bại
    Serial1.println("SD initialization failed!");  // In thông báo lỗi
    blinkError(10);                                // Nhấp nháy đèn LED báo lỗi 10 lần rồi dừng
    return;
  }
  Serial1.println("SD initialized successfully");  // Thông báo thành công
  blinkProgress(1);                                // Nhấp nháy đèn LED 1 lần báo tiến trình
  delay(500);

  // Bước 2: Tạo thư mục cấp 1 có tên "TEST"
  Serial1.println("2. Creating TEST directory");
  if (!createDirIfNeeded("TEST")) {  // Nếu không tạo được thì dừng
    return;
  }
  blinkProgress(2);  // Nhấp nháy LED 2 lần
  delay(500);

  // Bước 3: Tạo file ở thư mục gốc
  Serial1.println("3. Creating file in root");
  if (!sdCard.writeFile("ROOT.TXT", "Root level file")) {  // Tạo file ROOT.TXT với nội dung mẫu
    Serial1.println("Failed to create root file");         // Thông báo lỗi nếu không tạo được
    blinkError(3);                                         // Nhấp nháy báo lỗi
    return;
  }
  Serial1.println("Root file created successfully");  // Thông báo thành công
  blinkProgress(3);
  delay(500);

  // Bước 4: Tạo thư mục cấp 2: TEST/SUB
  Serial1.println("4. Creating TEST/SUB directory");
  if (!createDirIfNeeded("TEST/SUB")) {
    return;
  }
  blinkProgress(4);
  delay(500);

  // Bước 5: Tạo file trong thư mục TEST/SUB
  Serial1.println("5. Creating file in TEST/SUB");
  if (!sdCard.writeFile("TEST/SUB/L2.TXT", "Level 2 file")) {
    Serial1.println("Failed to create L2 file");
    blinkError(5);
    return;
  }
  Serial1.println("Level 2 file created successfully");
  blinkProgress(5);
  delay(500);

  // Bước 6: Tạo thư mục cấp 3: TEST/SUB/NEW
  Serial1.println("6. Creating TEST/SUB/NEW directory");
  if (!createDirIfNeeded("TEST/SUB/NEW")) {
    return;
  }
  blinkProgress(6);
  delay(500);

  // Bước 7: Tạo file trong thư mục TEST/SUB/NEW
  Serial1.println("7. Creating file in TEST/SUB/NEW");
  if (!sdCard.writeFile("TEST/SUB/NEW/L3.TXT", "Level 3 file")) {
    Serial1.println("Failed to create L3 file");
    blinkError(7);
    return;
  }
  Serial1.println("Level 3 file created successfully");
  blinkProgress(7);
  delay(500);

  // Bước 8: Kiểm tra đọc lại các file đã tạo
  Serial1.println("8. Verifying files by reading them");
  verifyFile("ROOT.TXT");             // Đọc file ROOT.TXT
  verifyFile("TEST/SUB/L2.TXT");      // Đọc file cấp 2
  verifyFile("TEST/SUB/NEW/L3.TXT");  // Đọc file cấp 3
  blinkProgress(8);

  // Báo hiệu hoàn thành bằng cách nhấp nháy LED nhanh 10 lần
  Serial1.println("===== All Tests Passed =====");
  for (int i = 0; i < 10; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(100);
    digitalWrite(LED_PIN, LOW);
    delay(100);
  }
}

// Hàm tạo thư mục nếu chưa tồn tại
bool createDirIfNeeded(const char* dirname) {
  if (sdCard.dirExists(dirname)) {  // Nếu thư mục đã tồn tại
    Serial1.print(dirname);
    Serial1.println(" already exists");
    return true;
  }

  Serial1.print("Creating ");
  Serial1.println(dirname);

  if (!sdCard.createDirectory(dirname)) {  // Tạo thư mục, nếu thất bại thì báo lỗi
    Serial1.print("Failed to create ");
    Serial1.println(dirname);
    blinkError(3);
    return false;
  }

  Serial1.print(dirname);
  Serial1.println(" created successfully");
  return true;
}

// Hàm kiểm tra nội dung file bằng cách đọc
void verifyFile(const char* filename) {
  char buffer[64];  // Bộ nhớ đệm chứa dữ liệu đọc
  uint16_t bytesRead;

  Serial1.print("Reading ");
  Serial1.println(filename);

  if (sdCard.readFile(filename, buffer, sizeof(buffer), &bytesRead)) {
    Serial1.print("Content: ");
    Serial1.println(buffer);
    Serial1.print("Bytes read: ");
    Serial1.println(bytesRead);
  } else {
    Serial1.print("Failed to read ");
    Serial1.println(filename);
  }
}

// Hàm nhấp nháy LED báo hiệu tiến trình (mỗi bước 1 lần nhấp nháy)
void blinkProgress(int count) {
  for (int i = 0; i < count; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(50);
    digitalWrite(LED_PIN, LOW);
    delay(100);
  }
}

// Hàm nhấp nháy LED báo lỗi và lặp vô hạn
void blinkError(int count) {
  while (1) {
    for (int i = 0; i < count; i++) {
      digitalWrite(LED_PIN, HIGH);
      delay(200);
      digitalWrite(LED_PIN, LOW);
      delay(200);
    }
    delay(1000);  // Nghỉ giữa mỗi chu kỳ nhấp nháy
  }
}

void loop() {
  // Nhấp nháy LED định kỳ như nhịp tim để thể hiện chương trình đang chạy
  digitalWrite(LED_PIN, HIGH);
  delay(50);
  digitalWrite(LED_PIN, LOW);
  delay(1950);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![sdcard-code](https://cdn.chipstack.vn/zerobase/sdcard/sdcard-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

### Sơ lược về thư viện ZBSdCard

Thư viện ZBSdCard là thư viện mở rộng cho phép bạn đọc và ghi dữ liệu lên thẻ nhớ SD Card. Thư viện này được xây dựng dựa trên thư viện SD chuẩn của Arduino.

### Sơ lược về thư viện ZBSdCard

ZBSdCard là thư viện làm việc với thẻ SD thông qua giao tiếp SPI, cho phép thao tác với hệ thống tập tin FAT32.

#### 1. Constructor

```cpp
ZBSdCard(uint8_t csPin);
```

- **Mục đích**: Khởi tạo đối tượng ZBSdCard với chân CS được chỉ định

#### 2. `begin()`

```cpp
bool begin();
```

- **Mục đích**: Khởi tạo và kết nối với thẻ SD
- **Giá trị trả về**: `bool` - true nếu khởi tạo thành công, false nếu thất bại

#### 3. Các hàm thao tác tập tin

##### 3.1 `writeFile()`

```cpp
bool writeFile(const char* filename, const char* data);
```

- **Mục đích**: Tạo và ghi dữ liệu vào tập tin
- **Tham số**:
  - `filename`: Tên tập tin cần tạo/ghi
  - `data`: Dữ liệu cần ghi vào tập tin
- **Giá trị trả về**: `bool` - true nếu ghi thành công, false nếu thất bại

##### 3.2 `createFile()` 

```cpp
bool createFile(const char* filename, const char* data, uint16_t len);
```

- **Mục đích**: Tạo tập tin với độ dài dữ liệu được chỉ định rõ ràng
- **Tham số**:
  - `filename`: Tên tập tin cần tạo
  - `data`: Dữ liệu cần ghi vào tập tin
  - `len`: Độ dài dữ liệu
- **Giá trị trả về**: `bool` - true nếu tạo thành công, false nếu thất bại

##### 3.3 `readFile()`

```cpp
bool readFile(const char* filename, char* data, uint16_t maxLen, uint16_t* bytesRead);
```

- **Mục đích**: Đọc nội dung từ một tập tin
- **Tham số**:
  - `filename`: Tên tập tin cần đọc
  - `data`: Buffer để lưu dữ liệu đọc được
  - `maxLen`: Kích thước tối đa của buffer
  - `bytesRead`: Con trỏ để lưu số byte thực tế đã đọc
- **Giá trị trả về**: `bool` - true nếu đọc thành công, false nếu thất bại

##### 3.4 `fileExists()`

```cpp
bool fileExists(const char* filename);
```

- **Mục đích**: Kiểm tra tập tin có tồn tại không
- **Tham số**: `filename` - Tên tập tin cần kiểm tra
- **Giá trị trả về**: `bool` - true nếu tập tin tồn tại, false nếu không tồn tại

##### 3.5 `deleteFile()`

```cpp
bool deleteFile(const char* filename);
```

- **Mục đích**: Xóa một tập tin từ thẻ SD
- **Tham số**: `filename` - Tên tập tin cần xóa
- **Giá trị trả về**: `bool` - true nếu xóa thành công, false nếu thất bại

#### 4. Các hàm thao tác thư mục

##### 4.1 `createDirectory()`

```cpp
bool createDirectory(const char* dirname);
```

- **Mục đích**: Tạo một thư mục mới
- **Tham số**: `dirname` - Tên thư mục cần tạo
- **Giá trị trả về**: `bool` - true nếu tạo thành công, false nếu thất bại

##### 4.2 `dirExists()`

```cpp
bool dirExists(const char* dirname);
```

- **Mục đích**: Kiểm tra thư mục có tồn tại không
- **Tham số**: `dirname` - Tên thư mục cần kiểm tra
- **Giá trị trả về**: `bool` - true nếu thư mục tồn tại, false nếu không tồn tại

##### 4.3 `deleteDirectory()`

```cpp
bool deleteDirectory(const char* dirname);
```

- **Mục đích**: Xóa một thư mục từ thẻ SD
- **Tham số**: `dirname` - Tên thư mục cần xóa
- **Giá trị trả về**: `bool` - true nếu xóa thành công, false nếu thất bại

### Giải thích code

Đoạn code sau đây là một ví dụ hoàn chỉnh về cách sử dụng thư viện ZBSdCard để tương tác với thẻ SD card trên nền tảng vi điều khiển. Chương trình thực hiện kiểm tra khả năng tạo và truy cập các thư mục nhiều cấp, tạo và đọc tập tin ở các cấp thư mục khác nhau, đồng thời báo cáo trạng thái thông qua Serial và đèn LED.

#### Phần khai báo thư viện và cấu hình

```cpp
#include <SPI.h>       // Thư viện giao tiếp SPI chuẩn của Arduino
#include "ZBSdCard.h"  // Thư viện điều khiển thẻ SD tùy chỉnh (Enhanced ZBSdCard)

#define SD_CS_PIN 10         // Định nghĩa chân CS cho thẻ SD là chân số 10
#define LED_PIN LED_BUILTIN  // Sử dụng đèn LED tích hợp trên bo mạch (thường là chân 13)

ZBSdCard sdCard(SD_CS_PIN);  // Tạo đối tượng sdCard từ lớp ZBSdCard với chân CS đã định nghĩa
```

- `SPI.h`: Thư viện chuẩn của Arduino để giao tiếp qua giao thức SPI, cần thiết để làm việc với thẻ SD
- `ZBSdCard.h`: Thư viện chính để quản lý thẻ SD và thao tác với các tập tin/thư mục
- Chân CS (Chip Select) được thiết lập là chân 10 thông qua hằng số `SD_CS_PIN`
- Sử dụng đèn LED tích hợp trên board Arduino (thường là chân 13) để báo hiệu trạng thái
- Khởi tạo đối tượng `sdCard` từ lớp ZBSdCard với chân CS đã được định nghĩa

#### Hàm setup() - Thực hiện các bước kiểm tra

```cpp
void setup() {
  pinMode(LED_PIN, OUTPUT);  // Thiết lập chân LED làm đầu ra
  Serial1.begin(115200);     // Khởi động giao tiếp Serial1 với tốc độ baud 115200
  delay(1000);               // Đợi 1 giây để ổn định

  Serial1.println("===== Deep Directory Test =====");  // In tiêu đề bài kiểm tra ra serial
```

- Cấu hình chân LED là đầu ra để điều khiển đèn LED
- Khởi tạo giao tiếp Serial1 với tốc độ baud 115200 để hiển thị thông báo
- Chờ 1 giây để đảm bảo Serial đã sẵn sàng và ổn định
- In tiêu đề của bài kiểm tra

```cpp
  // Bước 1: Khởi động thẻ SD
  Serial1.println("1. Initializing SD card");
  if (!sdCard.begin()) {                           // Nếu khởi động thất bại
    Serial1.println("SD initialization failed!");  // In thông báo lỗi
    blinkError(10);                                // Nhấp nháy đèn LED báo lỗi 10 lần rồi dừng
    return;
  }
  Serial1.println("SD initialized successfully");  // Thông báo thành công
  blinkProgress(1);                                // Nhấp nháy đèn LED 1 lần báo tiến trình
  delay(500);
```

- Bước đầu tiên là khởi tạo thẻ SD với hàm `begin()`
- Nếu khởi tạo thất bại, in thông báo lỗi, nhấp nháy đèn LED để báo lỗi và kết thúc chương trình
- Nếu thành công, in thông báo xác nhận và nhấp nháy đèn LED 1 lần để báo tiến trình
- Chờ 0.5 giây trước khi chuyển sang bước tiếp theo

```cpp
  // Bước 2: Tạo thư mục cấp 1 có tên "TEST"
  Serial1.println("2. Creating TEST directory");
  if (!createDirIfNeeded("TEST")) {  // Nếu không tạo được thì dừng
    return;
  }
  blinkProgress(2);  // Nhấp nháy LED 2 lần
  delay(500);
```

- Bước thứ hai là tạo thư mục cấp 1 với tên "TEST"
- Sử dụng hàm hỗ trợ `createDirIfNeeded()` để tạo thư mục nếu nó chưa tồn tại
- Nếu không tạo được thư mục, kết thúc chương trình
- Nếu thành công, nhấp nháy đèn LED 2 lần báo tiến trình và chờ 0.5 giây

```cpp
  // Bước 3: Tạo file ở thư mục gốc
  Serial1.println("3. Creating file in root");
  if (!sdCard.writeFile("ROOT.TXT", "Root level file")) {  // Tạo file ROOT.TXT với nội dung mẫu
    Serial1.println("Failed to create root file");         // Thông báo lỗi nếu không tạo được
    blinkError(3);                                         // Nhấp nháy báo lỗi
    return;
  }
  Serial1.println("Root file created successfully");  // Thông báo thành công
  blinkProgress(3);
  delay(500);
```

- Bước thứ ba là tạo một tập tin ở thư mục gốc với tên "ROOT.TXT"
- Sử dụng hàm `writeFile()` để tạo và ghi nội dung "Root level file" vào tập tin
- Nếu thất bại, in thông báo lỗi, nhấp nháy đèn LED và kết thúc chương trình
- Nếu thành công, in thông báo xác nhận, nhấp nháy đèn LED 3 lần và chờ 0.5 giây

```cpp
  // Bước 4: Tạo thư mục cấp 2: TEST/SUB
  Serial1.println("4. Creating TEST/SUB directory");
  if (!createDirIfNeeded("TEST/SUB")) {
    return;
  }
  blinkProgress(4);
  delay(500);
```

- Bước thứ tư là tạo thư mục cấp 2 với đường dẫn "TEST/SUB"
- Tương tự như trước, sử dụng hàm `createDirIfNeeded()` và báo hiệu tiến trình

```cpp
  // Bước 5: Tạo file trong thư mục TEST/SUB
  Serial1.println("5. Creating file in TEST/SUB");
  if (!sdCard.writeFile("TEST/SUB/L2.TXT", "Level 2 file")) {
    Serial1.println("Failed to create L2 file");
    blinkError(5);
    return;
  }
  Serial1.println("Level 2 file created successfully");
  blinkProgress(5);
  delay(500);
```

- Bước thứ năm là tạo một tập tin trong thư mục cấp 2 với đường dẫn "TEST/SUB/L2.TXT"
- Sử dụng hàm `writeFile()` để tạo tập tin và ghi nội dung "Level 2 file"
- Xử lý lỗi và báo hiệu tiến trình tương tự các bước trước

```cpp
  // Bước 6: Tạo thư mục cấp 3: TEST/SUB/NEW
  Serial1.println("6. Creating TEST/SUB/NEW directory");
  if (!createDirIfNeeded("TEST/SUB/NEW")) {
    return;
  }
  blinkProgress(6);
  delay(500);
```

- Bước thứ sáu là tạo thư mục cấp 3 với đường dẫn "TEST/SUB/NEW"
- Tiếp tục mô hình tạo thư mục và báo hiệu tiến trình

```cpp
  // Bước 7: Tạo file trong thư mục TEST/SUB/NEW
  Serial1.println("7. Creating file in TEST/SUB/NEW");
  if (!sdCard.writeFile("TEST/SUB/NEW/L3.TXT", "Level 3 file")) {
    Serial1.println("Failed to create L3 file");
    blinkError(7);
    return;
  }
  Serial1.println("Level 3 file created successfully");
  blinkProgress(7);
  delay(500);
```

- Bước thứ bảy là tạo một tập tin trong thư mục cấp 3 với đường dẫn "TEST/SUB/NEW/L3.TXT"
- Ghi nội dung "Level 3 file" vào tập tin và xử lý kết quả

```cpp
  // Bước 8: Kiểm tra đọc lại các file đã tạo
  Serial1.println("8. Verifying files by reading them");
  verifyFile("ROOT.TXT");             // Đọc file ROOT.TXT
  verifyFile("TEST/SUB/L2.TXT");      // Đọc file cấp 2
  verifyFile("TEST/SUB/NEW/L3.TXT");  // Đọc file cấp 3
  blinkProgress(8);
```

- Bước thứ tám là kiểm tra lại các tập tin đã tạo bằng cách đọc chúng
- Sử dụng hàm hỗ trợ `verifyFile()` để đọc và hiển thị nội dung của từng tập tin
- Đọc tập tin ở thư mục gốc, tập tin ở thư mục cấp 2 và tập tin ở thư mục cấp 3
- Nhấp nháy đèn LED 8 lần để báo hiệu hoàn thành bước này

```cpp
  // Báo hiệu hoàn thành bằng cách nhấp nháy LED nhanh 10 lần
  Serial1.println("===== All Tests Passed =====");
  for (int i = 0; i < 10; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(100);
    digitalWrite(LED_PIN, LOW);
    delay(100);
  }
}
```

- Sau khi tất cả các bước đã hoàn thành thành công, in thông báo "All Tests Passed"
- Nhấp nháy đèn LED nhanh 10 lần để báo hiệu hoàn thành toàn bộ bài kiểm tra

#### Các hàm hỗ trợ

```cpp
// Hàm tạo thư mục nếu chưa tồn tại
bool createDirIfNeeded(const char* dirname) {
  if (sdCard.dirExists(dirname)) {  // Nếu thư mục đã tồn tại
    Serial1.print(dirname);
    Serial1.println(" already exists");
    return true;
  }

  Serial1.print("Creating ");
  Serial1.println(dirname);

  if (!sdCard.createDirectory(dirname)) {  // Tạo thư mục, nếu thất bại thì báo lỗi
    Serial1.print("Failed to create ");
    Serial1.println(dirname);
    blinkError(3);
    return false;
  }

  Serial1.print(dirname);
  Serial1.println(" created successfully");
  return true;
}
```

- Hàm `createDirIfNeeded()` kiểm tra xem một thư mục đã tồn tại chưa và tạo nó nếu cần
- Đầu tiên, kiểm tra bằng hàm `dirExists()` để xem thư mục đã tồn tại hay chưa
- Nếu đã tồn tại, in thông báo và trả về true
- Nếu chưa tồn tại, thử tạo thư mục bằng hàm `createDirectory()`
- Nếu tạo thất bại, in thông báo lỗi, nhấp nháy đèn LED báo lỗi và trả về false
- Nếu tạo thành công, in thông báo xác nhận và trả về true

```cpp
// Hàm kiểm tra nội dung file bằng cách đọc
void verifyFile(const char* filename) {
  char buffer[64];  // Bộ nhớ đệm chứa dữ liệu đọc
  uint16_t bytesRead;

  Serial1.print("Reading ");
  Serial1.println(filename);

  if (sdCard.readFile(filename, buffer, sizeof(buffer), &bytesRead)) {
    Serial1.print("Content: ");
    Serial1.println(buffer);
    Serial1.print("Bytes read: ");
    Serial1.println(bytesRead);
  } else {
    Serial1.print("Failed to read ");
    Serial1.println(filename);
  }
}
```

- Hàm `verifyFile()` đọc và hiển thị nội dung của một tập tin
- Tạo một buffer 64 byte để lưu dữ liệu đọc được
- Sử dụng hàm `readFile()` để đọc nội dung tập tin vào buffer
- Nếu đọc thành công, hiển thị nội dung đọc được và số byte đã đọc
- Nếu đọc thất bại, in thông báo lỗi

```cpp
// Hàm nhấp nháy LED báo hiệu tiến trình (mỗi bước 1 lần nhấp nháy)
void blinkProgress(int count) {
  for (int i = 0; i < count; i++) {
    digitalWrite(LED_PIN, HIGH);
    delay(50);
    digitalWrite(LED_PIN, LOW);
    delay(100);
  }
}
```

- Hàm `blinkProgress()` nhấp nháy đèn LED để báo hiệu tiến trình
- Nhấp nháy đèn LED số lần bằng với tham số `count` được truyền vào
- Mỗi lần nhấp nháy bật đèn trong 50ms và tắt trong 100ms

```cpp
// Hàm nhấp nháy LED báo lỗi và lặp vô hạn
void blinkError(int count) {
  while (1) {
    for (int i = 0; i < count; i++) {
      digitalWrite(LED_PIN, HIGH);
      delay(200);
      digitalWrite(LED_PIN, LOW);
      delay(200);
    }
    delay(1000);  // Nghỉ giữa mỗi chu kỳ nhấp nháy
  }
}
```

- Hàm `blinkError()` nhấp nháy đèn LED để báo hiệu lỗi
- Lặp vô hạn (không bao giờ trở về) với vòng lặp `while (1)`
- Nhấp nháy đèn LED số lần bằng với tham số `count` được truyền vào
- Mỗi lần nhấp nháy bật đèn trong 200ms và tắt trong 200ms
- Sau mỗi chu kỳ nhấp nháy đủ số lần, chờ thêm 1000ms (1 giây) trước khi lặp lại

#### Hàm loop()

```cpp
void loop() {
  // Nhấp nháy LED định kỳ như nhịp tim để thể hiện chương trình đang chạy
  digitalWrite(LED_PIN, HIGH);
  delay(50);
  digitalWrite(LED_PIN, LOW);
  delay(1950);
}
```

- Hàm `loop()` chạy liên tục sau khi `setup()` hoàn thành
- Nhấp nháy đèn LED như nhịp tim (bật 50ms, tắt 1950ms) để thể hiện rằng chương trình vẫn đang chạy
- Tổng thời gian của mỗi chu kỳ nhấp nháy là 2 giây (50ms + 1950ms)

## Kết quả

?> Khi nạp code thành công, bạn sẽ thấy các thông báo trên Serial Monitor như hình dưới.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/sdcard/sdcard-result.png" alt="sdcard-serial" width="600px" height="auto">
    <p><em>Thông báo trên Serial Monitor</em></p>
</div>

?> Bạn mở thẻ nhớ bằng đầu đọc thẻ nhớ SD Card trên máy tính và kiểm tra các file đã tạo ra như hình dưới hay chưa

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/sdcard/sdcard-file1.png" alt="sdcard-file1" width="600px" height="auto">
    <p><em>File đã tạo ra trên thẻ nhớ SD Card ở thư mục gốc</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/sdcard/sdcard-file2.png" alt="sdcard-file2" width="600px" height="auto">
    <p><em>File đã tạo ra trên thẻ nhớ SD Card ở thư mục TEST</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/sdcard/sdcard-file3.png" alt="sdcard-file3" width="600px" height="auto">
    <p><em>File đã tạo ra trên thẻ nhớ SD Card ở thư mục TEST/SUB</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/sdcard/sdcard-file4.png" alt="sdcard-file4" width="600px" height="auto">
    <p><em>File đã tạo ra trên thẻ nhớ SD Card ở thư mục TEST/SUB/NEW</em></p>
</div>

## Kết luận

Trong bài viết này, bạn đã tìm hiểu cách sử dụng thư viện ZBSdCard để làm việc với thẻ SD card trên nền tảng vi điều khiển. Bạn đã thực hiện các bước tạo thư mục và tập tin, đọc nội dung của chúng, cũng như báo hiệu trạng thái thông qua Serial Monitor và đèn LED. Hy vọng rằng bài viết này sẽ giúp bạn trong việc phát triển các ứng dụng liên quan đến thẻ SD card trong tương lai.

Để phát triển thêm từ bài học này, bạn có thể thực hiện các ý tưởng sau:

* **Sử dụng chức năng xoá tập tin và thư mục:** Giúp giải phóng bộ nhớ và làm sạch dữ liệu không còn cần thiết.

* **Kết hợp với cảm biến để ghi dữ liệu vào thẻ SD:** Ví dụ như ghi dữ liệu nhiệt độ, độ ẩm, hoặc gia tốc theo thời gian thực để phục vụ các ứng dụng giám sát môi trường hoặc theo dõi chuyển động.

* **Tạo một giao diện người dùng để quản lý tập tin trên thẻ SD:** Giao diện có thể là menu hiển thị trên màn hình LCD hoặc qua Serial, cho phép người dùng duyệt, tạo, hoặc xoá tệp và thư mục.

* **Thực hiện các thao tác nâng cao như nén dữ liệu trước khi ghi vào thẻ SD:** Giảm dung lượng lưu trữ và tăng hiệu quả sử dụng thẻ nhớ bằng cách tích hợp thuật toán nén như Run-Length Encoding (RLE) hoặc LZ77.

* **Tìm hiểu về các định dạng tập tin khác nhau mà thẻ SD hỗ trợ:** Không chỉ FAT16/FAT32, mà còn có thể là exFAT hoặc định dạng tùy chỉnh cho các ứng dụng đặc biệt yêu cầu hiệu suất cao hoặc bảo mật.

* **Ghi dữ liệu dưới định dạng CSV hoặc JSON để dễ phân tích:** Thích hợp cho các ứng dụng thu thập dữ liệu cần xử lý trên máy tính, chẳng hạn như dùng Excel hoặc các công cụ phân tích dữ liệu.

* **Tích hợp chức năng đồng bộ thời gian (RTC) để ghi log có dấu thời gian:** Ghi nhận dữ liệu với timestamp sẽ rất hữu ích trong các hệ thống giám sát lâu dài.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)
