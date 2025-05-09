<br>
<br>
<br>

# Lưu trữ dữ liệu sử dụng Module EEPROM AT24C256

![eeprom-at24c-circuit](https://cdn.chipstack.vn/zerobase/eeprom/eeprom-at24c-circuit.jpg)

## Tổng quan

?> Bài hướng dẫn này sẽ giúp bạn làm quen với việc sử dụng module EEPROM AT24C256 với Zerobase. Bạn sẽ học cách đọc và ghi dữ liệu vào EEPROM thông qua giao thức I2C.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase| [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard (tùy chọn) | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Module EEPROM AT24C256 | [Mua ngay](https://chipstack.vn/san-pham/module-eeprom-at24c256/) |
| Dây USB UART TTL PL2303HX | [Mua ngay](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="button-lcd-zerobase">
    <p><em>Board Zerobase</em></p>
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
    <img src="https://cdn.chipstack.vn/default/eeprom-at24c256.jpg" alt="eeprom-at24c256">
    <p><em>Module EEPROM AT24C256</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/uart/uart-ttl/PL2303HX.png" alt="usb-uart-ttl">
    <p><em>Dây USB UART TTL PL2303HX</em></p>
</div>

## Nguyên lý hoạt động

Module EEPROM AT24C256 là một bộ nhớ không bay hơi, có thể lưu trữ dữ liệu ngay cả khi nguồn điện bị ngắt. Nó sử dụng giao thức I2C để giao tiếp với vi điều khiển. Trong bài hướng dẫn này, chúng ta sẽ sử dụng Zerobase để đọc ghi, xoá dữ liệu trong EEPROM AT24C256.

## Sơ đồ kết nối

![eeprom-at24c-pins](https://cdn.chipstack.vn/zerobase/eeprom/eeprom-at24c-pins.png)

Sử dụng cặp chân SDA (D18) và SCL (D19) với bus Wire để kết nối với các chân SDA và SCL của module EEPROM AT24C256.

Sử dụng chân 3.3V3 để kết nối với chân VCC của Module EEPROM AT24C256. Sử dụng chân GND để kết nối với chân GND của Module EEPROM AT24C256.

![eeprom-at24c-schematic](https://cdn.chipstack.vn/zerobase/eeprom/eeprom-at24c-schematic.png)

![AT24C256](https://cdn.chipstack.vn/zerobase/eeprom/eeprom-at24c-circuit.jpg)

## Code

```cpp
/*
 * ╔════════════════════════════════════════════════════════╗
 * ║ BẢNG THÔNG TIN IC EEPROM                              ║
 * ╠═══════════════╦═══════════════════╦═══════════════════╣
 * ║ Tên IC        ║ Dung lượng        ║ Vùng địa chỉ      ║
 * ╠═══════════════╬═══════════════════╬═══════════════════╣
 * ║ 24C01         ║ 128 bytes         ║ 0 -> 127          ║
 * ║ 24C02         ║ 256 bytes         ║ 0 -> 255          ║
 * ║ 24C04         ║ 512 bytes         ║ 0 -> 511          ║
 * ║ 24C08         ║ 1024 bytes        ║ 0 -> 1023         ║
 * ║ 24C16         ║ 2 KB              ║ 0 -> 2047         ║
 * ║ 24C32         ║ 4 KB              ║ 0 -> 4095         ║
 * ║ 24C64         ║ 8 KB              ║ 0 -> 8191         ║
 * ║ 24C128        ║ 16 KB             ║ 0 -> 16383        ║
 * ║ 24C256        ║ 32 KB             ║ 0 -> 32767        ║
 * ║ 24C512        ║ 64,5 KB           ║ 0 -> 65535        ║
 * ╚═══════════════╩═══════════════════╩═══════════════════╝
 */

/*
 * ╔════════════════════════════════════════════════════════════════════════════╗
 * ║ LƯU Ý KHI SỬ DỤNG EEPROM                                                  ║
 * ╠════════════════════════════════════════════════════════════════════════════╣
 * ║ 1. Chỉ ghi vào EEPROM các số nguyên dương                                 ║
 * ║                                                                            ║
 * ║ 2. Cẩn thận tránh ghi đè lên các ô nhớ đã sử dụng:                        ║
 * ║    VD: biến b kiểu unsigned int (2 byte) ghi vào địa chỉ 56               ║
 * ║        => b chiếm ô nhớ 56 và 57                                          ║
 * ║        Nếu ghi biến M (2 byte) vào địa chỉ 57                             ║
 * ║        => M sẽ chiếm ô 57 và 58, gây đè lên 1 phần của biến b             ║
 * ╚════════════════════════════════════════════════════════════════════════════╝
 */

// Nhập các thư viện cần thiết
#include <ZBEeprom24Cxx.h>  // Thư viện tự tạo để giao tiếp với EEPROM 24Cxx

// Khởi tạo đối tượng EEPROM với tham số mặc định
ZBEeprom24Cxx eeprom;  // Sử dụng mặc định: AT24C256 (32KB) tại địa chỉ 0x50

// Định nghĩa các vị trí địa chỉ khác nhau để lưu trữ dữ liệu
#define ADDR_BYTE 0     // Vị trí lưu dữ liệu 1 byte (8 bit)
#define ADDR_INT 10     // Vị trí lưu dữ liệu 2 byte (16 bit)
#define ADDR_LONG 20    // Vị trí lưu dữ liệu 4 byte (32 bit)
#define ADDR_STRING 30  // Vị trí lưu chuỗi văn bản
#define ADDR_CLEAR 100  // Vị trí bắt đầu vùng nhớ sẽ xóa

void setup() {
  // Khởi tạo giao tiếp Serial1 với tốc độ 9600 baud
  Serial1.begin(9600);  // Cấu hình cổng Serial1 với tốc độ 9600 bps


  Serial1.println("EEPROM Complete Test");  // In tiêu đề chương trình

  // Khởi tạo EEPROM và giao tiếp I2C
  eeprom.begin();  // Tự động khởi tạo Wire và cấu hình giao tiếp

  // Kiểm tra kết nối với EEPROM
  if (!eeprom.isConnected()) {             // Kiểm tra xem EEPROM có phản hồi trên bus I2C không
    Serial1.println("EEPROM not found!");  // Thông báo lỗi nếu không tìm thấy EEPROM
    return;                                // Thoát hàm setup nếu không có kết nối
  }

  // In thông tin kích thước EEPROM
  Serial1.print("EEPROM size: ");
  Serial1.print(eeprom.length());  // Lấy kích thước của EEPROM đang sử dụng
  Serial1.println(" bytes");       // In đơn vị bytes

  // --------------------------
  // Ví dụ thao tác với dữ liệu 1 byte
  // --------------------------
  byte byte_val = 123;                       // Tạo biến 1 byte với giá trị 123
  eeprom.write_1_byte(ADDR_BYTE, byte_val);  // Ghi giá trị 1 byte vào EEPROM tại địa chỉ ADDR_BYTE

  byte read_byte = eeprom.read_1_byte(ADDR_BYTE);  // Đọc giá trị 1 byte từ EEPROM

  // In kết quả đọc/ghi 1 byte
  Serial1.print("1-byte: wrote ");
  Serial1.print(byte_val);  // In giá trị đã ghi
  Serial1.print(", read ");
  Serial1.println(read_byte);  // In giá trị đã đọc

  // --------------------------
  // Ví dụ thao tác với dữ liệu 2 byte
  // --------------------------
  int word_val = 0xABCD;                    // Tạo biến 2 byte với giá trị hex 0xABCD (43981 theo hệ thập phân)
  eeprom.write_2_byte(ADDR_INT, word_val);  // Ghi giá trị 2 byte vào EEPROM tại địa chỉ ADDR_INT

  int read_word = eeprom.read_2_byte(ADDR_INT);  // Đọc giá trị 2 byte từ EEPROM

  // In kết quả đọc/ghi 2 byte theo định dạng hex
  Serial1.print("2-byte: wrote 0x");
  Serial1.print(word_val, HEX);  // In giá trị đã ghi dưới dạng hex
  Serial1.print(", read 0x");
  Serial1.println(read_word, HEX);  // In giá trị đã đọc dưới dạng hex

  // --------------------------
  // Ví dụ thao tác với dữ liệu 4 byte
  // --------------------------
  long long_val = 0x12345678;                // Tạo biến 4 byte với giá trị hex phức tạp
  eeprom.write_4_byte(ADDR_LONG, long_val);  // Ghi giá trị 4 byte vào EEPROM

  long read_long = eeprom.read_4_byte(ADDR_LONG);  // Đọc giá trị 4 byte từ EEPROM

  // In kết quả đọc/ghi 4 byte theo định dạng hex
  Serial1.print("4-byte: wrote 0x");
  Serial1.print(long_val, HEX);  // In giá trị đã ghi dưới dạng hex
  Serial1.print(", read 0x");
  Serial1.println(read_long, HEX);  // In giá trị đã đọc dưới dạng hex

  // --------------------------
  // Ví dụ thao tác với chuỗi (sử dụng lớp String của Arduino)
  // --------------------------
  String test_string = "Hello EEPROM!";  // Tạo một chuỗi String để lưu trữ
  Serial1.print("Writing string: ");
  Serial1.println(test_string);  // In chuỗi sẽ ghi

  eeprom.writeString(ADDR_STRING, test_string);  // Ghi chuỗi vào EEPROM

  // Đọc chuỗi từ EEPROM sử dụng lớp String
  String read_string = eeprom.readString(ADDR_STRING);  // Hàm trả về trực tiếp đối tượng String

  // In chuỗi đã đọc
  Serial1.print("Read string: ");
  Serial1.println(read_string);  // In chuỗi đã đọc từ EEPROM

  // Kiểm tra chuỗi đã đọc có giống chuỗi đã ghi không
  if (test_string.equals(read_string)) {
    Serial1.println("String verification successful!");  // Thành công nếu trùng khớp
  } else {
    Serial1.println("String verification failed!");  // Thất bại nếu không khớp
  }

  // --------------------------
  // Ví dụ thao tác xóa vùng nhớ
  // --------------------------

  // Ví dụ 1: Xóa một vùng nhớ cụ thể
  Serial1.println("\nClearing 20 bytes at address 100");  // Thông báo sẽ xóa 20 byte

  // Xóa 20 byte bắt đầu từ địa chỉ ADDR_CLEAR với giá trị 0xFF (mặc định)
  eeprom.clearRange(ADDR_CLEAR, 20);  // Ghi giá trị 0xFF vào 20 ô nhớ liên tiếp

  // Ví dụ 2: Xóa toàn bộ EEPROM (đã bị comment do mất nhiều thời gian)
  //   Serial1.println("\nClearing entire EEPROM (0 to 32KB)");
  //   Serial1.println("This will take several seconds to complete!");

  // Lưu ý: Thao tác này sẽ mất nhiều thời gian (vài chục giây)
  // vì phải ghi vào từng ô nhớ trong toàn bộ 32KB

  //   unsigned long startTime = millis();  // Ghi lại thời điểm bắt đầu

  //   eeprom.clear();  // Xóa toàn bộ EEPROM (ghi 0xFF vào tất cả ô nhớ)

  //   unsigned long endTime = millis();  // Ghi lại thời điểm kết thúc
  //   Serial1.print("Full EEPROM clear complete! Time taken: ");
  //   Serial1.print((endTime - startTime) / 1000.0);  // Tính thời gian đã dùng (giây)
  //   Serial1.println(" seconds");

  // Đọc và hiển thị vùng nhớ đã xóa
  Serial1.println("Reading cleared area:");  // Thông báo sẽ đọc vùng nhớ đã xóa

  for (int i = 0; i < 20; i++) {                      // Lặp qua 20 byte đã xóa
    byte value = eeprom.read_1_byte(ADDR_CLEAR + i);  // Đọc giá trị tại mỗi địa chỉ

    // In địa chỉ và giá trị đọc được theo định dạng hex
    Serial1.print("Addr ");
    Serial1.print(ADDR_CLEAR + i);  // In địa chỉ đang đọc
    Serial1.print(": 0x");
    Serial1.println(value, HEX);  // In giá trị đọc được dưới dạng hex

    // Chỉ in 5 giá trị đầu tiên để tránh quá nhiều dữ liệu hiển thị
    if (i == 4) {
      Serial1.println("... (remaining values also 0xFF)");  // Thông báo các giá trị còn lại
      break;                                                // Thoát vòng lặp sau khi in 5 giá trị
    }
  }

  // Thông báo hoàn thành tất cả các bài kiểm tra
  Serial1.println("\nAll tests complete!");  // In thông báo kết thúc
}

void loop() {
  delay(1000);  // Tạm dừng 1 giây - không làm gì trong vòng lặp chính
}
```
Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![eeprom-at24c256-code](https://cdn.chipstack.vn/zerobase/eeprom/eeprom-at24c256-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

### Sơ lược về thư viện ZBEeprom24Cxx

#### Bảng thông tin IC EEPROM

| Tên IC | Dung lượng | Vùng địa chỉ |
|--------|------------|--------------|
| 24C01  | 128 bytes  | 0 → 127     |
| 24C02  | 256 bytes  | 0 → 255     |
| 24C04  | 512 bytes  | 0 → 511     |
| 24C08  | 1024 bytes | 0 → 1023    |
| 24C16  | 2 KB       | 0 → 2047    |
| 24C32  | 4 KB       | 0 → 4095    |
| 24C64  | 8 KB       | 0 → 8191    |
| 24C128 | 16 KB      | 0 → 16383   |
| 24C256 | 32 KB      | 0 → 32767   |
| 24C512 | 64,5 KB    | 0 → 65535   |

#### Lưu ý khi sử dụng EEPROM

1. Chỉ ghi vào EEPROM các số nguyên dương

2. Cẩn thận tránh ghi đè lên các ô nhớ đã sử dụng:
   - VD: biến b kiểu unsigned int (2 byte) ghi vào địa chỉ 56
   - → b chiếm ô nhớ 56 và 57
   - Nếu ghi biến M (2 byte) vào địa chỉ 57
   - → M sẽ chiếm ô 57 và 58, gây đè lên 1 phần của biến b

#### 1. Constructor

```cpp
ZBEeprom24Cxx(long deviceSize = AT24C256, byte deviceAddress = 0x50);
```

- **Mục đích**: Khởi tạo đối tượng EEPROM với cấu hình chỉ định
- **Chi tiết**: Cấu hình mặc định là IC 24C256 (32KB) với địa chỉ I²C 0x50
- **Tham số**:
  - `deviceSize`: Kích thước của IC EEPROM (mặc định là AT24C256 - 32KB)
  - `deviceAddress`: Địa chỉ I²C của IC EEPROM (mặc định là 0x50)

#### 2. `begin()`

```cpp
void begin(TwoWire &wirePort = Wire, bool initWire = true);
```

- **Mục đích**: Khởi tạo thư viện và giao diện I²C
- **Chi tiết**: Thiết lập kết nối với EEPROM thông qua giao tiếp I²C
- **Tham số**:
  - `wirePort`: Đối tượng giao tiếp I²C (mặc định là Wire)
  - `initWire`: Có khởi tạo giao diện Wire hay không (mặc định là true)
- **Lưu ý**: Cần gọi hàm này trước khi thực hiện bất kỳ thao tác nào với EEPROM

#### 3. Các hàm đọc/ghi cơ bản

##### 3.1 `write_1_byte()`

```cpp
bool write_1_byte(int address, byte data);
```

- **Mục đích**: Ghi một byte dữ liệu vào EEPROM
- **Chi tiết**: Ghi dữ liệu vào địa chỉ chỉ định trên IC EEPROM
- **Tham số**:
  - `address`: Địa chỉ trong EEPROM để ghi dữ liệu
  - `data`: Giá trị byte (0-255) cần ghi
- **Giá trị trả về**: `bool` - true nếu ghi thành công, false nếu thất bại

##### 3.2 `read_1_byte()`

```cpp
byte read_1_byte(int address);
```

- **Mục đích**: Đọc một byte dữ liệu từ EEPROM
- **Chi tiết**: Trả về giá trị byte tại địa chỉ được chỉ định
- **Tham số**: `address` - Địa chỉ của byte cần đọc
- **Giá trị trả về**: `byte` - Giá trị đọc được (0-255)

#### 4. Các hàm đọc/ghi nhiều byte

##### 4.1 `write_2_byte()`

```cpp
bool write_2_byte(int address, int data);
```

- **Mục đích**: Ghi 2 byte (kiểu int) vào EEPROM
- **Chi tiết**: Phân tách giá trị 16-bit thành 2 byte riêng biệt và ghi vào các địa chỉ liên tiếp
- **Tham số**:
  - `address`: Địa chỉ bắt đầu
  - `data`: Giá trị int (16-bit) cần ghi
- **Giá trị trả về**: `bool` - true nếu ghi thành công, false nếu thất bại
- **Lưu ý**: Chiếm 2 byte liên tiếp trong EEPROM (address và address+1)

##### 4.2 `read_2_byte()`

```cpp
int read_2_byte(int address);
```

- **Mục đích**: Đọc 2 byte từ EEPROM và ghép thành giá trị int (16-bit)
- **Chi tiết**: Đọc 2 byte liên tiếp và kết hợp chúng thành giá trị int
- **Tham số**: `address` - Địa chỉ bắt đầu để đọc
- **Giá trị trả về**: `int` - Giá trị 16-bit đọc được

##### 4.3 `write_4_byte()`

```cpp
bool write_4_byte(int address, long data);
```

- **Mục đích**: Ghi 4 byte (kiểu long) vào EEPROM
- **Chi tiết**: Phân tách giá trị 32-bit thành 4 byte riêng biệt và ghi vào các địa chỉ liên tiếp
- **Tham số**:
  - `address`: Địa chỉ bắt đầu
  - `data`: Giá trị long (32-bit) cần ghi
- **Giá trị trả về**: `bool` - true nếu ghi thành công, false nếu thất bại
- **Lưu ý**: Chiếm 4 byte liên tiếp trong EEPROM (từ address đến address+3)

##### 4.4 `read_4_byte()`

```cpp
long read_4_byte(int address);
```

- **Mục đích**: Đọc 4 byte từ EEPROM và ghép thành giá trị long (32-bit)
- **Chi tiết**: Đọc 4 byte liên tiếp và kết hợp chúng thành giá trị long
- **Tham số**: `address` - Địa chỉ bắt đầu để đọc
- **Giá trị trả về**: `long` - Giá trị 32-bit đọc được

#### 5. Các hàm đọc/ghi khối dữ liệu

##### 5.1 `writeBytes()`

```cpp
bool writeBytes(int address, byte *data, int length);
```

- **Mục đích**: Ghi một mảng các byte vào EEPROM
- **Chi tiết**: Ghi lần lượt các byte từ mảng vào EEPROM bắt đầu từ địa chỉ chỉ định
- **Tham số**:
  - `address`: Địa chỉ bắt đầu ghi
  - `data`: Con trỏ đến mảng dữ liệu cần ghi
  - `length`: Số lượng byte cần ghi
- **Giá trị trả về**: `bool` - true nếu ghi thành công, false nếu thất bại

##### 5.2 `readBytes()`

```cpp
int readBytes(int address, byte *data, int length);
```

- **Mục đích**: Đọc một chuỗi các byte từ EEPROM vào mảng
- **Chi tiết**: Đọc lần lượt các byte từ EEPROM vào mảng bắt đầu từ địa chỉ chỉ định
- **Tham số**:
  - `address`: Địa chỉ bắt đầu đọc
  - `data`: Con trỏ đến mảng để lưu dữ liệu đọc được
  - `length`: Số lượng byte cần đọc
- **Giá trị trả về**: `int` - Số byte đã đọc thành công

#### 6. Các hàm đọc/ghi chuỗi

##### 6.1 `writeString()`

```cpp
bool writeString(int address, const String &str);
bool writeString(int address, const char *data);
```

- **Mục đích**: Ghi một chuỗi ký tự vào EEPROM
- **Chi tiết**: Hỗ trợ cả đối tượng String của Arduino và chuỗi C kiểu char*
- **Tham số**:
  - `address`: Địa chỉ bắt đầu ghi
  - `str` hoặc `data`: Chuỗi cần ghi (kiểu String hoặc char*)
- **Giá trị trả về**: `bool` - true nếu ghi thành công, false nếu thất bại
- **Lưu ý**: Tự động ghi cả ký tự kết thúc chuỗi (null terminator)

##### 6.2 `readString()`

```cpp
String readString(int address, int maxLength = 100);
bool readString(int address, char *data, int maxLength);
```

- **Mục đích**: Đọc một chuỗi ký tự từ EEPROM
- **Chi tiết**: Hỗ trợ đọc vào đối tượng String hoặc mảng char*
- **Tham số**:
  - `address`: Địa chỉ bắt đầu đọc
  - `data`: (Cho phiên bản thứ hai) Mảng ký tự để lưu chuỗi đọc được
  - `maxLength`: Độ dài tối đa của chuỗi cần đọc
- **Giá trị trả về**: 
  - Phiên bản đầu: `String` - Chuỗi đọc được
  - Phiên bản hai: `bool` - true nếu đọc thành công, false nếu thất bại

#### 7. Các hàm tiện ích

##### 7.1 `clear()`

```cpp
bool clear(byte clearValue = 0xFF);
```

- **Mục đích**: Xóa toàn bộ EEPROM
- **Chi tiết**: Ghi một giá trị cố định lên tất cả các ô nhớ của EEPROM
- **Tham số**: `clearValue` - Giá trị để ghi (mặc định là 0xFF)
- **Giá trị trả về**: `bool` - true nếu xóa thành công, false nếu thất bại
- **Lưu ý**: Quá trình này có thể mất nhiều thời gian đối với EEPROM lớn

##### 7.2 `clearRange()`

```cpp
bool clearRange(int startAddress, int length, byte clearValue = 0xFF);
```

- **Mục đích**: Xóa một vùng nhớ cụ thể trong EEPROM
- **Chi tiết**: Ghi một giá trị cố định lên một đoạn liên tiếp của EEPROM
- **Tham số**:
  - `startAddress`: Địa chỉ bắt đầu vùng cần xóa
  - `length`: Độ dài của vùng cần xóa (tính theo byte)
  - `clearValue`: Giá trị để ghi (mặc định là 0xFF)
- **Giá trị trả về**: `bool` - true nếu xóa thành công, false nếu thất bại

##### 7.3 `length()`

```cpp
long length(void);
```

- **Mục đích**: Lấy kích thước của EEPROM
- **Chi tiết**: Trả về tổng dung lượng của IC EEPROM đang sử dụng
- **Giá trị trả về**: `long` - Kích thước EEPROM tính theo byte

##### 7.4 `isConnected()`

```cpp
bool isConnected(void);
```

- **Mục đích**: Kiểm tra EEPROM có được kết nối đúng cách hay không
- **Chi tiết**: Thực hiện kiểm tra thông qua giao tiếp I²C
- **Giá trị trả về**: `bool` - true nếu EEPROM được kết nối và hoạt động, false nếu không tìm thấy hoặc có lỗi

#### Hoạt động bên trong

Thư viện ZBEeprom24Cxx hoạt động theo nguyên tắc sau:

- **Giao tiếp I²C**: Thư viện sử dụng giao tiếp I²C để tương tác với IC EEPROM ngoại.
- **Phân trang**: Các IC EEPROM thường được tổ chức thành các trang (page), thư viện tự động xử lý việc ghi dữ liệu trên nhiều trang.
- **Địa chỉ 1 hoặc 2 byte**: Tùy thuộc vào dung lượng của IC EEPROM, thư viện sẽ tự động chọn cách gửi địa chỉ phù hợp (1 byte hoặc 2 byte).

### Giải thích code

Code này minh họa cách làm việc với bộ nhớ EEPROM thông qua giao tiếp I²C sử dụng thư viện tùy chỉnh `ZBEeprom24Cxx`. EEPROM (Electrically Erasable Programmable Read-Only Memory) là loại bộ nhớ không biến mất khi mất điện, thường được sử dụng để lưu trữ các thông số cấu hình hoặc dữ liệu quan trọng trong các hệ thống nhúng.

#### 1. Phần cấu hình và khai báo

```cpp
#include <ZBEeprom24Cxx.h>  // Thư viện tự tạo để giao tiếp với EEPROM 24Cxx

// Khởi tạo đối tượng EEPROM với tham số mặc định
ZBEeprom24Cxx eeprom;  // Sử dụng mặc định: AT24C256 (32KB) tại địa chỉ 0x50

// Định nghĩa các vị trí địa chỉ khác nhau để lưu trữ dữ liệu
#define ADDR_BYTE 0     // Vị trí lưu dữ liệu 1 byte (8 bit)
#define ADDR_INT 10     // Vị trí lưu dữ liệu 2 byte (16 bit)
#define ADDR_LONG 20    // Vị trí lưu dữ liệu 4 byte (32 bit)
#define ADDR_STRING 30  // Vị trí lưu chuỗi văn bản
#define ADDR_CLEAR 100  // Vị trí bắt đầu vùng nhớ sẽ xóa
```

- Code sử dụng thư viện `ZBEeprom24Cxx` - một thư viện tùy chỉnh dành cho IC EEPROM dòng 24Cxx
- Tạo một đối tượng EEPROM với tên `eeprom` sử dụng các tham số mặc định (AT24C256 - 32KB, địa chỉ I²C 0x50)
- Định nghĩa các hằng số đánh dấu vị trí lưu trữ cho các loại dữ liệu khác nhau trong EEPROM

#### 2. Khởi tạo kết nối trong hàm setup()

```cpp
void setup() {
  Serial1.begin(9600);
  Serial1.println("EEPROM Complete Test");
  
  eeprom.begin();  // Khởi tạo EEPROM và giao tiếp I2C
  
  if (!eeprom.isConnected()) {
    Serial1.println("EEPROM not found!");
    return;
  }
  
  Serial1.print("EEPROM size: ");
  Serial1.print(eeprom.length());
  Serial1.println(" bytes");
  
  // Các thao tác khác...
}
```

- Thiết lập giao tiếp Serial ở tốc độ 9600 bps để hiển thị thông tin debug
- Khởi tạo kết nối với EEPROM thông qua phương thức `begin()`
- Kiểm tra xem EEPROM có hoạt động không bằng phương thức `isConnected()`
- Hiển thị thông tin về kích thước của EEPROM đang sử dụng

#### 3. Thao tác với dữ liệu 1 byte

```cpp
byte byte_val = 123;
eeprom.write_1_byte(ADDR_BYTE, byte_val);

byte read_byte = eeprom.read_1_byte(ADDR_BYTE);

Serial1.print("1-byte: wrote ");
Serial1.print(byte_val);
Serial1.print(", read ");
Serial1.println(read_byte);
```

- Ghi một giá trị 1 byte (123) vào địa chỉ ADDR_BYTE (0)
- Đọc lại giá trị từ cùng địa chỉ
- Hiển thị cả giá trị đã ghi và giá trị đã đọc để kiểm tra tính chính xác

#### 4. Thao tác với dữ liệu 2 byte (int)

```cpp
int word_val = 0xABCD;
eeprom.write_2_byte(ADDR_INT, word_val);

int read_word = eeprom.read_2_byte(ADDR_INT);

Serial1.print("2-byte: wrote 0x");
Serial1.print(word_val, HEX);
Serial1.print(", read 0x");
Serial1.println(read_word, HEX);
```

- Ghi một giá trị 2 byte (0xABCD) vào EEPROM tại địa chỉ ADDR_INT (10)
- Đọc lại giá trị từ cùng địa chỉ
- Hiển thị cả giá trị đã ghi và giá trị đã đọc dưới dạng hexadecimal

#### 5. Thao tác với dữ liệu 4 byte (long)

```cpp
long long_val = 0x12345678;
eeprom.write_4_byte(ADDR_LONG, long_val);

long read_long = eeprom.read_4_byte(ADDR_LONG);

Serial1.print("4-byte: wrote 0x");
Serial1.print(long_val, HEX);
Serial1.print(", read 0x");
Serial1.println(read_long, HEX);
```

- Ghi một giá trị 4 byte (0x12345678) vào EEPROM tại địa chỉ ADDR_LONG (20)
- Đọc lại giá trị từ cùng địa chỉ
- Hiển thị cả giá trị đã ghi và giá trị đã đọc dưới dạng hexadecimal

#### 6. Thao tác với chuỗi

```cpp
String test_string = "Hello EEPROM!";
Serial1.print("Writing string: ");
Serial1.println(test_string);

eeprom.writeString(ADDR_STRING, test_string);

String read_string = eeprom.readString(ADDR_STRING);

Serial1.print("Read string: ");
Serial1.println(read_string);

if (test_string.equals(read_string)) {
  Serial1.println("String verification successful!");
} else {
  Serial1.println("String verification failed!");
}
```

- Ghi một chuỗi "Hello EEPROM!" vào EEPROM bắt đầu từ địa chỉ ADDR_STRING (30)
- Đọc lại chuỗi từ cùng địa chỉ
- So sánh chuỗi đã đọc với chuỗi gốc để xác minh tính toàn vẹn dữ liệu

#### 7. Thao tác xóa EEPROM

```cpp
Serial1.println("\nClearing 20 bytes at address 100");
eeprom.clearRange(ADDR_CLEAR, 20);

Serial1.println("Reading cleared area:");
for (int i = 0; i < 20; i++) {
  byte value = eeprom.read_1_byte(ADDR_CLEAR + i);
  
  Serial1.print("Addr ");
  Serial1.print(ADDR_CLEAR + i);
  Serial1.print(": 0x");
  Serial1.println(value, HEX);
  
  if (i == 4) {
    Serial1.println("... (remaining values also 0xFF)");
    break;
  }
}
```

- Xóa 20 byte EEPROM bắt đầu từ địa chỉ ADDR_CLEAR (100) bằng cách ghi giá trị 0xFF vào từng ô nhớ
- Đọc và hiển thị nội dung của 5 byte đầu tiên trong vùng nhớ đã xóa để xác nhận thao tác
- Phần xóa toàn bộ EEPROM đã bị comment vì mất quá nhiều thời gian

```cpp
  // Thông báo hoàn thành
  Serial1.println("\nAll tests complete!");  // In thông báo kết thúc
}
```

- Hiển thị thông báo hoàn thành

#### Hàm loop()

```cpp
void loop() {
  delay(1000);  // Tạm dừng 1 giây - không làm gì trong vòng lặp chính
}
```
- Hàm `loop()` trong chương trình này không thực hiện bất kỳ thao tác nào
- Chỉ đơn giản là tạm dừng 1 giây (1000ms) mỗi lần lặp
- Mọi chức năng chính đã được thực hiện trong hàm `setup()`

## Kết quả

?> Chương trình sẽ hiển thị các thông báo trên Serial Monitor để xác nhận việc ghi, đọc và xoá dữ liệu đã được thực hiện thành công hay chưa.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/eeprom/eeprom-at24c-result.png" alt="eeprom-at24c-result">
     <p><em>Kết quả ghi, đọc và xoá thành công trên Serial Monitor</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn các bạn cách sử dụng thư viện ZBEeprom24Cxx để tương tác với các IC EEPROM 24Cxx qua giao tiếp I²C. Chúng ta đã thực hiện các thao tác cơ bản như ghi, đọc và xóa dữ liệu, cũng như kiểm tra tính toàn vẹn của dữ liệu.

Để phát triển thêm từ bài học này, bạn có thể thử nghiệm các ý tưởng sau:

- **Lưu cấu hình hệ thống**: Sử dụng EEPROM để lưu các thông số như tốc độ, ngưỡng cảm biến, hoặc lựa chọn chế độ hoạt động, giúp thiết bị ghi nhớ cấu hình sau khi khởi động lại.
- **Tạo bộ đếm lưu trữ**: Thiết lập một bộ đếm số lần thiết bị được bật, mỗi lần khởi động thì giá trị được tăng lên và lưu vào EEPROM.
- **Ghi nhật ký sự kiện đơn giản**: Mỗi khi xảy ra một sự kiện quan trọng (ví dụ: cảm biến phát hiện chuyển động), hãy ghi một dòng dữ liệu (timestamp, loại sự kiện) vào EEPROM.
- **Kết hợp với cảm biến**: Thu thập dữ liệu cảm biến theo thời gian thực và lưu vào EEPROM để phân tích sau này, ví dụ như ghi nhiệt độ môi trường mỗi 10 phút.
- **Tạo menu cấu hình trên thiết bị**: Dùng nút nhấn hoặc màn hình để cho phép người dùng thay đổi giá trị và lưu trữ vĩnh viễn vào EEPROM.
- **Quản lý nhiều khối dữ liệu**: Học cách phân chia bộ nhớ EEPROM thành nhiều vùng (block) để lưu các loại dữ liệu khác nhau, ví dụ: thông tin người dùng, trạng thái hệ thống, cài đặt.

Đây là những bước đơn giản giúp bạn hiểu rõ hơn về cách EEPROM có thể hỗ trợ lưu trữ không mất dữ liệu trong các ứng dụng nhúng.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)