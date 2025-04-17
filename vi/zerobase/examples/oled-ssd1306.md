<br>
<br>
<br>

# Điều khiển màn hình OLED

![oled-ssd1306-circuit](https://cdn.chipstack.vn/zerobase/oled-ssd1306/oled-ssd1306-circuit.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển màn hình OLED SSD1306.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase|[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
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

## Cài Đặt Thư Viện

Bạn vào menu Tools > Manage Libraries.

![manage-lib](https://cdn.chipstack.vn/zerobase2/oled-ssd1306/manage-lib.png)

Tìm kiếm thư viện `SSD1306Ascii`, chọn version mới nhất và nhấn Install.

![install-ssd1306ascii](https://cdn.chipstack.vn/zerobase/oled-ssd1306/install-ssd1306ascii.png)

Chờ cho đến khi xuất hiện thông báo cài đặt xong như hình bên dưới.

![install-ssd1306ascii-done](https://cdn.chipstack.vn/zerobase/oled-ssd1306/install-ssd1306ascii-done.png)

## Sơ đồ kết nối

![zerobase-lcd-16x2-pins](https://cdn.chipstack.vn/zerobase/lcd-module/zerobase-lcd-16x2-pins.png)

Sử dụng chân 5V cấp nguồn cho Oled, chân GND nối với GND của board Zerobase. Chân SDA và SCL của Oled được kết nối với chân SDA (D18) và SCL (D19) của board Zerobase.

![oled-ssd1306-schematic](https://cdn.chipstack.vn/zerobase/oled-ssd1306/oled-ssd1306-schematic.png)

![oled-ssd1306-circuit](https://cdn.chipstack.vn/zerobase/oled-ssd1306/oled-ssd1306-circuit.jpg)

## Code

```cpp
// Thêm thư viện Wire.h để hỗ trợ giao tiếp I2C
#include <Wire.h>
// Thêm thư viện cơ bản SSD1306Ascii để điều khiển màn hình OLED
#include "SSD1306Ascii.h"
// Thêm thư viện SSD1306AsciiWire để điều khiển màn hình OLED qua giao tiếp I2C
#include "SSD1306AsciiWire.h"

// Định nghĩa địa chỉ I2C của màn hình OLED (0X3C+SA0 - có thể là 0x3C hoặc 0x3D)
#define I2C_ADDRESS 0x3C

// Định nghĩa chân RST, -1 nghĩa là không sử dụng chân reset riêng
#define RST_PIN -1

// Tạo một đối tượng oled từ lớp SSD1306AsciiWire để điều khiển màn hình
SSD1306AsciiWire oled;

// Khai báo chuỗi văn bản cần hiển thị
const char message[] = "Hello World, this is Zerobase using OLED SSD1306. ";
// Vị trí bắt đầu hiển thị văn bản (cho chức năng cuộn)
int position = 0;
// Biến lưu thời gian của lần cuộn trước đó
unsigned long previousMillis = 0;
// Khoảng thời gian giữa các lần cuộn (150ms)
const long scrollInterval = 150;  // Adjust for scroll speed (milliseconds)
// Số ký tự có thể hiển thị trên màn hình
const int displayWidth = 21;  // Number of characters that fit on the display

// Hàm setup() chạy một lần khi khởi động
void setup() {
  // Khởi tạo giao tiếp I2C
  Wire.begin();
  // Thiết lập tốc độ I2C (400kHz)
  Wire.setClock(400000L);

// Kiểm tra nếu có định nghĩa chân RST
#if RST_PIN >= 0
  // Khởi tạo màn hình OLED với chân RST được chỉ định
  oled.begin(&Adafruit128x64, I2C_ADDRESS, RST_PIN);
#else   // RST_PIN >= 0
  // Khởi tạo màn hình OLED không có chân RST
  oled.begin(&Adafruit128x64, I2C_ADDRESS);
#endif  // RST_PIN >= 0

  // Thiết lập font chữ System5x7
  oled.setFont(System5x7);
  // Xóa màn hình
  oled.clear();
  // Thiết lập kích thước chữ gấp đôi
  oled.set2X();
}

// Hàm loop() chạy lặp đi lặp lại
void loop() {
  // Lấy độ dài của chuỗi văn bản
  int messageLength = strlen(message);

  // Nếu độ dài văn bản lớn hơn độ rộng màn hình, thực hiện cuộn văn bản
  if (messageLength > displayWidth) {
    // Lấy thời gian hiện tại tính bằng mili giây
    unsigned long currentMillis = millis();

    // Kiểm tra nếu đã đến thời điểm cần cuộn văn bản
    if (currentMillis - previousMillis >= scrollInterval) {
      // Cập nhật thời gian cuộn cuối cùng
      previousMillis = currentMillis;

      // Đặt vị trí con trỏ tại cột 0, hàng 3
      // Lưu ý:
      // Số cột x từ 0 - 127
      // Số hàng y từ 0 - 7.
      oled.setCursor(0, 3);

      // Tạo chuỗi để hiển thị trên màn hình
      String displayText = "";

      // Tính toán phần văn bản cần hiển thị
      for (int i = 0; i < displayWidth; i++) {
        // Tính vị trí ký tự dựa trên vị trí hiện tại và độ dài văn bản
        int charPosition = (position + i) % messageLength;
        // Thêm ký tự vào chuỗi hiển thị
        displayText += message[charPosition];
      }

      // Hiển thị văn bản mà không xóa màn hình trước
      oled.print(displayText);

      // Tăng vị trí cho bước cuộn tiếp theo, quay về đầu nếu đến cuối chuỗi
      position = (position + 1) % messageLength;
    }
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![oled-ssd1306-code](https://cdn.chipstack.vn/zerobase/oled-ssd1306/oled-ssd1306-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

### Giải thích code

Khai báo thư viện `Wire.h` để hỗ trợ giao tiếp I2C, thư viện `SSD1306Ascii` để hiển thị chữ lên màn hình, thư viện `SSD1306AsciiWire` để điều khiển màn hình OLED qua giao tiếp I2C.

```cpp
#include <Wire.h>
#include "SSD1306Ascii.h"
#include "SSD1306AsciiWire.h"
```

Khai báo địa chỉ I2C của màn hình OLED là `0x3C` và chân RST là `-1` (không sử dụng chân reset riêng). Nếu địa chỉ I2C `0x3C` không hoạt động, bạn có thể thử với địa chỉ `0x3D`.

```cpp
#define I2C_ADDRESS 0x3C
#define RST_PIN -1
```

Tạo một đối tượng `oled` từ lớp `SSD1306AsciiWire`.

```cpp
SSD1306AsciiWire oled;
```

Khai báo chuỗi văn bản cần hiển thị và các biến `position`, `previousMillis`, `scrollInterval`, `displayWidth` để điều khiển việc cuộn văn bản.

```cpp
const char message[] = "Hello World, this is Zerobase using OLED SSD1306. ";
int position = 0;
unsigned long previousMillis = 0;
const long scrollInterval = 150;  // Adjust for scroll speed (milliseconds)
const int displayWidth = 21;  // Number of characters that fit on the display
```

Trong hàm `setup()`, khởi tạo giao tiếp I2C, thiết lập tốc độ I2C là 400kHz.

```cpp
Wire.begin();
Wire.setClock(400000L);
```

Kiểm tra nếu có định nghĩa chân RST, thì khởi tạo màn hình với chân RST được chỉ định, nếu không thì khởi tạo màn hình không có chân RST.

```cpp
// Kiểm tra nếu có định nghĩa chân RST
#if RST_PIN >= 0
  // Khởi tạo màn hình OLED với chân RST được chỉ định
  oled.begin(&Adafruit128x64, I2C_ADDRESS, RST_PIN);
#else   // RST_PIN >= 0
  // Khởi tạo màn hình OLED không có chân RST
  oled.begin(&Adafruit128x64, I2C_ADDRESS);
#endif  // RST_PIN >= 0
```
Thiết lập font chữ là `System5x7`, sau đó sử dụng `oled.clear()` để xóa màn hình, và thiết lập kích thước chữ gấp đôi với `oled.set2X()`.

```cpp
oled.setFont(System5x7);
oled.clear();
oled.set2X();
```

Trong hàm `loop()`, lấy độ dài của chuỗi văn bản và kiểm tra nếu độ dài văn bản lớn hơn độ rộng của màn hình, thực hiện cuộn văn bản.

```cpp
int messageLength = strlen(message);
if (messageLength > displayWidth)
```

Mỗi lần cuộn văn bản sẽ là 150ms đã được định nghĩa ở biến `scrollInterval`.

- Hàm millis() trả về thời gian đã trôi qua (tính bằng mili giây) kể từ khi chương trình bắt đầu chạy.

- Gán nó vào biến currentMillis để chúng ta biết bây giờ là lúc nào.

- previousMillis: là thời điểm mà lần cuộn cuối cùng đã xảy ra

- currentMillis - previousMillis: là thời gian đã trôi qua từ lần cuộn trước

- Nếu thời gian này lớn hơn hoặc bằng scrollInterval (150ms), nghĩa là: đã đến lúc cuộn tiếp.

- Ghi nhận rằng: cuộn đã xảy ra vào thời điểm hiện tại bằng cách gán `previousMillis = currentMillis;`.

```cpp
// Lấy thời gian hiện tại tính bằng mili giây
unsigned long currentMillis = millis();
if (currentMillis - previousMillis >= scrollInterval) {
      // Cập nhật thời gian cuộn cuối cùng
      previousMillis = currentMillis;
```

Ta đặt vị trí con trỏ tại cột 0, hàng 3.

!> Lưu ý rằng số cột x kéo dài từ 0 - 127 và số hàng y kéo dài từ 0 - 7.

```cpp
// Đặt vị trí con trỏ tại cột 0, hàng 3
oled.setCursor(0, 3);
```

Tạo chuỗi để hiển thị trên màn hình

```cpp
String displayText = "";
```

Vòng lặp chạy từ 0 đến displayWidth - 1, mỗi vòng lặp sẽ lấy ra 1 ký tự trong chuỗi cần hiển thị.

```cpp
 for (int i = 0; i < displayWidth; i++)
```

Dòng tiếp theo tính vị trí ký tự dựa trên vị trí hiện tại và độ dài văn bản.

- position: là vị trí bắt đầu hiển thị (vị trí đầu tiên của chuỗi cuộn).

- i: giúp chuỗi có thể cuộn được từ 0 đến displayWidth - 1.

- position + i: Là vị trí thật sự của từng chữ trong chuỗi gốc (message).

- % messageLength: giúp cho vị trí cuộn về đầu nếu đến cuối chuỗi.

- charPosition: là vị trí của từng chữ trong chuỗi gốc (message) mà ta sẽ hiển thị lên

```cpp
int charPosition = (position + i) % messageLength;
```

Cuối cùng, ta thêm ký tự vào chuỗi hiển thị.

```cpp
displayText += message[charPosition];
```

Sau đó ta in ra màn hình đoạn văn bản đã được cuộn.

```cpp
oled.print(displayText);
```

Và cuối cùng là tăng vị trí cho bước cuộn tiếp theo, quay về đầu nếu đến cuối chuỗi.

```cpp
position = (position + 1) % messageLength;
```

## Kết quả

?> Sau khi nạp code thành công, bạn sẽ thấy chuỗi "Hello World, this is Zerobase using OLED SSD1306." được cuộn từ trái sang phải.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/oled-ssd1306/oled-ssd1306-result.gif" alt="oled-ssd1306-result">
    <p><em>Chuỗi được cuộn từ trái sang phải</em></p>
</div>

### Kết luận và hướng phát triển

Trong bài viết này, bạn đã tìm hiểu cách sử dụng OLED SSD1306 với board Zerobase để cuộn chữ sử dụng thư viện `SSD1306Ascii`.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Thay đổi nội dung văn bản hiển thị.
- Thay đổi tốc độ cuộn văn bản bằng cách điều chỉnh giá trị của `scrollInterval`.
- Thay đổi vị trí hiển thị văn bản.
- Thay đổi font chữ hiển thị bằng cách sử dụng các font chữ khác trong thư viện `SSD1306Ascii`.
- Sử dụng các cảm biến để hiển thị dữ liệu lên màn hình.

**Chúc bạn thành công**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)