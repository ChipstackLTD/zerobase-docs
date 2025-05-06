<br>
<br>
<br>

# Đọc và hiển thị file từ SD Card lên màn hình OLED SSD1306

![sdcard-circuit](https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-circuit.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách tạo file và folder trên thẻ nhớ SD Card sau đó đọc file và hiển thị nội dung lên màn hình OLED SSD1306.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase 2|[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Module thẻ nhớ SD Card |[Mua ngay](https://chipstack.vn/san-pham/breakout-micro-sd/) |
| Thẻ nhớ Micro SD ||
| Đầu đọc thẻ nhớ Micro SD ||

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
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
    <img src="https://cdn.chipstack.vn/default/oled-ssd1306.jpg" alt="oled-ssd1306">
    <p><em>OLED SSD1306</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/module-sdcard.jpg" alt="module-sdcard">
    <p><em>Module thẻ nhớ Micro SD</em></p>
</div>

## Nguyên lý hoạt động

?> Đầu tiên ta cần tạo file và folder trên thẻ nhớ SD Card. Sau đó sử dụng thư viện ZBSdCard (Đã có sẵn, không cần cài đặt thêm) để đọc file và hiển thị nội dung lên màn hình OLED SSD1306.

## Cài đặt thư viện OLED SSD1306

Bạn có thể tham khảo cách cài đặt thư viện trong bài viết [Cài đặt thư viện OLED SSD1306 cho Zerobase 2](https://zerobase.chipstack.vn/#/vi/zerobase-2/examples/oled-ssd1306).

?> Đối với các thư viện có chữ `ZB` ở đầu tên thư viện, bạn không cần cài đặt thêm vì đã được tích hợp sẵn trong thư viện Zerobase và Zerobase 2.

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

![sdcard-pins](https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-pins.png)

Các nút nhấn:
- D2: Nút nhấn lên
- D3: Nút nhấn xuống
- D4: Nút nhấn chọn
- D5: Nút nhấn quay lại

I2C OLED SSD1306:
- SDA kết nối với SDA của Zerobase 2
- SCL kết nối với SCL của Zerobase 2
- GND kết nối với GND của Zerobase 2
- VCC kết nối với 5V của Zerobase 2

!> Chú ý kết nối đúng chân VCC và GND của OLED SSD1306, một số module có chân VCC và GND ngược với ví dụ của bài viết này.

Module SD Card:
- 3V3 kết nối với 3V3 của Zerobase 2
- GND kết nối với GND của Zerobase 2
- CS kết nối với SS của Zerobase 2
- MOSI kết nối với MO của Zerobase 2
- MISO kết nối với MI của Zerobase 2
- CLK kết nối với SCK của Zerobase 2


![sdcard-schematic](https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-schematic.png)

![sdcard-circuit](https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-circuit.jpg)

## Code

### Code kiểm tra chức năng

?>  Đoạn code sau dùng để kiểm tra các chức năng: Tạo file, tạo folder, viết nội dung vào file, đọc file, xóa file, liệt kê file trong folder.

```cpp
/**
 * Kiểm tra đầy đủ API ZBSdCard
 * 
 * Sketch này kiểm tra tất cả các chức năng có sẵn trong thư viện ZBSdCard.
 * Nó cung cấp tổng quan đầy đủ về khả năng của thư viện,
 * kiểm tra có hệ thống từng tính năng và báo cáo kết quả.
 * 
 * Các chức năng được kiểm tra:
 * - begin() - Khởi tạo thẻ SD
 * - createFile() - Tạo tập tin trong thư mục gốc
 * - readFile() - Đọc nội dung tập tin
 * - appendFile() - Thêm dữ liệu vào tập tin hiện có
 * - deleteFile() - Xóa tập tin
 * - createDirectory() - Tạo thư mục
 * - listDirectory() - Liệt kê nội dung thư mục
 * - createDirectoryPath() - Tạo cấu trúc thư mục lồng nhau
 * - createFileInPath() - Tạo tập tin trong thư mục con
 */

#include <SPI.h>                      // Bao gồm thư viện SPI cho giao tiếp với thẻ SD
#include <ZBSdCard.h>                 // Bao gồm thư viện ZBSdCard
#include <ZBPrint.h>                  // Bao gồm thư viện ZBPrint để in thông tin

// Tạo một đối tượng của lớp ZBSdCard
ZBSdCard sdCard;                      // Khởi tạo đối tượng sdCard để làm việc với thẻ SD

// Định nghĩa chân chip select cho thiết lập của bạn
const int SD_CS_PIN = 10;             // Thay đổi nếu cần thiết - Chân kết nối CS với thẻ SD

// Buffer cho các thao tác tập tin
char readBuffer[256];                 // Khai báo buffer để đọc dữ liệu từ tập tin

// Bộ đếm kiểm tra và theo dõi trạng thái
int testsRun = 0;                     // Đếm số lượng kiểm tra đã chạy
int testsPassed = 0;                  // Đếm số lượng kiểm tra đã vượt qua

// Hàm để in tiêu đề kiểm tra
void beginTest(const char* testName) {  // Hàm bắt đầu một bài kiểm tra mới với tên được cung cấp
  testsRun++;                         // Tăng bộ đếm bài kiểm tra
  Serial.println();                   // In xuống dòng
  Serial.print("TEST ");              // In chữ "TEST"
  Serial.print(testsRun);             // In số thứ tự bài kiểm tra
  Serial.print(": ");                 // In dấu hai chấm và khoảng trắng
  Serial.println(testName);           // In tên bài kiểm tra
  Serial.println("----------------------------------------"); // In đường phân cách
}

// Hàm để báo cáo kết quả kiểm tra
void endTest(bool success) {          // Hàm kết thúc bài kiểm tra với kết quả thành công hay thất bại
  if (success) {                      // Nếu bài kiểm tra thành công
    testsPassed++;                    // Tăng bộ đếm bài kiểm tra vượt qua
    Serial.println("RESULT: PASS ✓"); // In thông báo kiểm tra vượt qua
  } else {                            // Nếu bài kiểm tra thất bại
    Serial.println("RESULT: FAIL ✗"); // In thông báo kiểm tra thất bại
  }
  Serial.println("----------------------------------------"); // In đường phân cách
}

// Kiểm tra 1: Các thao tác tập tin cơ bản trong thư mục gốc
void testBasicFileOperations() {      // Hàm kiểm tra các thao tác tập tin cơ bản
  beginTest("Basic File Operations"); // Bắt đầu bài kiểm tra thao tác tập tin cơ bản
  bool success = true;                // Khởi tạo biến theo dõi trạng thái thành công

  // Tạo một tập tin kiểm tra
  Serial.println("1.1: Creating file 'test1.txt'"); // In thông báo đang tạo tập tin
  if (!sdCard.createFile("test1.txt", "This is test file #1 content.")) { // Tạo tập tin với nội dung
    Serial.println("Failed to create file!"); // In thông báo nếu tạo tập tin thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Đọc tập tin
  Serial.println("1.2: Reading file 'test1.txt'"); // In thông báo đang đọc tập tin
  memset(readBuffer, 0, sizeof(readBuffer)); // Xóa bộ đệm đọc
  uint32_t bytesRead = sdCard.readFile("test1.txt", readBuffer, sizeof(readBuffer)); // Đọc tập tin vào buffer

  if (bytesRead > 0) {                // Nếu đọc được dữ liệu
    Serial.print("Read ");            // In "Read"
    Serial.print(bytesRead);          // In số byte đã đọc
    Serial.println(" bytes:");        // In "bytes:"
    Serial.println(readBuffer);       // In nội dung đã đọc được

    // Xác minh nội dung
    if (strcmp(readBuffer, "This is test file #1 content.") != 0) { // So sánh nội dung đọc được với nội dung mong đợi
      Serial.println("File content doesn't match!"); // In thông báo nếu nội dung không khớp
      success = false;                // Đánh dấu kiểm tra là thất bại
    }
  } else {                            // Nếu không đọc được dữ liệu
    Serial.println("Failed to read file!"); // In thông báo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Thêm vào tập tin
  Serial.println("1.3: Appending to file 'test1.txt'"); // In thông báo đang thêm nội dung vào tập tin
  if (!sdCard.appendFile("test1.txt", "\nThis is appended content.")) { // Thêm nội dung vào tập tin
    Serial.println("Failed to append to file!"); // In thông báo nếu thêm thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Đọc lại tập tin để xác minh việc thêm
  Serial.println("1.4: Reading file after append"); // In thông báo đang đọc tập tin sau khi thêm
  memset(readBuffer, 0, sizeof(readBuffer)); // Xóa bộ đệm đọc
  bytesRead = sdCard.readFile("test1.txt", readBuffer, sizeof(readBuffer)); // Đọc lại tập tin

  if (bytesRead > 0) {                // Nếu đọc được dữ liệu
    Serial.print("Read ");            // In "Read"
    Serial.print(bytesRead);          // In số byte đã đọc
    Serial.println(" bytes:");        // In "bytes:"
    Serial.println(readBuffer);       // In nội dung đã đọc được

    // Xác minh nội dung bao gồm dữ liệu đã thêm
    if (strstr(readBuffer, "This is appended content.") == NULL) { // Tìm chuỗi đã thêm trong nội dung
      Serial.println("Appended content not found!"); // In thông báo nếu không tìm thấy
      success = false;                // Đánh dấu kiểm tra là thất bại
    }
  } else {                            // Nếu không đọc được dữ liệu
    Serial.println("Failed to read file after append!"); // In thông báo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục gốc để xác minh việc tạo tập tin
  Serial.println("1.5: Listing root directory"); // In thông báo đang liệt kê thư mục gốc
  if (!sdCard.listDirectory("/")) {   // Liệt kê nội dung thư mục gốc
    Serial.println("Failed to list directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  endTest(success);                   // Kết thúc bài kiểm tra với kết quả
}

// Kiểm tra 2: Tạo và liệt kê thư mục
void testDirectoryOperations() {      // Hàm kiểm tra các thao tác thư mục
  beginTest("Directory Operations");  // Bắt đầu bài kiểm tra thao tác thư mục
  bool success = true;                // Khởi tạo biến theo dõi trạng thái thành công

  // Tạo một thư mục
  Serial.println("2.1: Creating directory 'testdir'"); // In thông báo đang tạo thư mục
  if (!sdCard.createDirectory("testdir")) { // Tạo thư mục "testdir"
    Serial.println("Failed to create directory!"); // In thông báo nếu tạo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục gốc để xác minh việc tạo thư mục
  Serial.println("2.2: Listing root directory to verify directory creation"); // In thông báo xác minh tạo thư mục
  if (!sdCard.listDirectory("/")) {   // Liệt kê nội dung thư mục gốc
    Serial.println("Failed to list directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Tạo một tập tin trong thư mục
  Serial.println("2.3: Creating file in directory"); // In thông báo đang tạo tập tin trong thư mục
  if (!sdCard.createFileInPath("/testdir/test2.txt", "This is test file #2 in testdir.")) { // Tạo tập tin trong thư mục con
    Serial.println("Failed to create file in directory!"); // In thông báo nếu tạo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục để xác minh việc tạo tập tin
  Serial.println("2.4: Listing directory content"); // In thông báo đang liệt kê nội dung thư mục
  if (!sdCard.listDirectory("/testdir")) { // Liệt kê nội dung thư mục "testdir"
    Serial.println("Failed to list directory content!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Đọc tập tin trong thư mục
  Serial.println("2.5: Reading file from directory"); // In thông báo đang đọc tập tin từ thư mục
  memset(readBuffer, 0, sizeof(readBuffer)); // Xóa bộ đệm đọc
  uint32_t bytesRead = sdCard.readFile("/testdir/test2.txt", readBuffer, sizeof(readBuffer)); // Đọc tập tin từ thư mục con

  if (bytesRead > 0) {                // Nếu đọc được dữ liệu
    Serial.print("Read ");            // In "Read"
    Serial.print(bytesRead);          // In số byte đã đọc
    Serial.println(" bytes:");        // In "bytes:"
    Serial.println(readBuffer);       // In nội dung đã đọc được

    // Xác minh nội dung
    if (strcmp(readBuffer, "This is test file #2 in testdir.") != 0) { // So sánh nội dung đọc được với nội dung mong đợi
      Serial.println("File content doesn't match!"); // In thông báo nếu nội dung không khớp
      success = false;                // Đánh dấu kiểm tra là thất bại
    }
  } else {                            // Nếu không đọc được dữ liệu
    Serial.println("Failed to read file from directory!"); // In thông báo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  endTest(success);                   // Kết thúc bài kiểm tra với kết quả
}

// Kiểm tra 3: Thư mục lồng nhau và thao tác tập tin
void testNestedDirectories() {        // Hàm kiểm tra thư mục lồng nhau
  beginTest("Nested Directories");    // Bắt đầu bài kiểm tra thư mục lồng nhau
  bool success = true;                // Khởi tạo biến theo dõi trạng thái thành công

  // Tạo một cấu trúc thư mục lồng nhau
  Serial.println("3.1: Creating nested directories '/data/logs/app'"); // In thông báo đang tạo thư mục lồng nhau
  if (!sdCard.createDirectoryPath("/data/logs/app")) { // Tạo cấu trúc thư mục lồng nhau
    Serial.println("Failed to create nested directories!"); // In thông báo nếu tạo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục gốc
  Serial.println("3.2: Listing root directory"); // In thông báo đang liệt kê thư mục gốc
  if (!sdCard.listDirectory("/")) {   // Liệt kê nội dung thư mục gốc
    Serial.println("Failed to list root directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục cấp đầu tiên
  Serial.println("3.3: Listing /data directory"); // In thông báo đang liệt kê thư mục /data
  if (!sdCard.listDirectory("/data")) { // Liệt kê nội dung thư mục "/data"
    Serial.println("Failed to list /data directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục cấp thứ hai
  Serial.println("3.4: Listing /data/logs directory"); // In thông báo đang liệt kê thư mục /data/logs
  if (!sdCard.listDirectory("/data/logs")) { // Liệt kê nội dung thư mục "/data/logs"
    Serial.println("Failed to list /data/logs directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Tạo một tập tin trong thư mục lồng nhau
  Serial.println("3.5: Creating file in nested directory"); // In thông báo đang tạo tập tin trong thư mục lồng nhau
  if (!sdCard.createFileInPath("/data/logs/app/log.txt", "Log entry from deeply nested file.")) { // Tạo tập tin trong thư mục lồng sâu
    Serial.println("Failed to create file in nested directory!"); // In thông báo nếu tạo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê nội dung thư mục lồng nhau
  Serial.println("3.6: Listing nested directory content"); // In thông báo đang liệt kê nội dung thư mục lồng nhau
  if (!sdCard.listDirectory("/data/logs/app")) { // Liệt kê nội dung thư mục lồng nhau
    Serial.println("Failed to list nested directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Đọc tập tin từ thư mục lồng nhau
  Serial.println("3.7: Reading file from nested directory"); // In thông báo đang đọc tập tin từ thư mục lồng nhau
  memset(readBuffer, 0, sizeof(readBuffer)); // Xóa bộ đệm đọc
  uint32_t bytesRead = sdCard.readFile("/data/logs/app/log.txt", readBuffer, sizeof(readBuffer)); // Đọc tập tin từ thư mục lồng sâu

  if (bytesRead > 0) {                // Nếu đọc được dữ liệu
    Serial.print("Read ");            // In "Read"
    Serial.print(bytesRead);          // In số byte đã đọc
    Serial.println(" bytes:");        // In "bytes:"
    Serial.println(readBuffer);       // In nội dung đã đọc được

    // Xác minh nội dung
    if (strcmp(readBuffer, "Log entry from deeply nested file.") != 0) { // So sánh nội dung đọc được với nội dung mong đợi
      Serial.println("File content doesn't match!"); // In thông báo nếu nội dung không khớp
      success = false;                // Đánh dấu kiểm tra là thất bại
    }
  } else {                            // Nếu không đọc được dữ liệu
    Serial.println("Failed to read file from nested directory!"); // In thông báo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  endTest(success);                   // Kết thúc bài kiểm tra với kết quả
}

// Kiểm tra 4: Xóa tập tin
void testFileDeletion() {             // Hàm kiểm tra xóa tập tin
  beginTest("File Deletion");         // Bắt đầu bài kiểm tra xóa tập tin
  bool success = true;                // Khởi tạo biến theo dõi trạng thái thành công

  // Tạo một tập tin tạm thời để xóa
  Serial.println("4.1: Creating temporary file 'temp.txt'"); // In thông báo đang tạo tập tin tạm thời
  if (!sdCard.createFile("temp.txt", "This file will be deleted.")) { // Tạo tập tin tạm thời
    Serial.println("Failed to create temporary file!"); // In thông báo nếu tạo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục để xác minh việc tạo tập tin
  Serial.println("4.2: Listing directory to verify file creation"); // In thông báo xác minh tạo tập tin
  if (!sdCard.listDirectory("/")) {   // Liệt kê nội dung thư mục gốc
    Serial.println("Failed to list directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Xóa tập tin
  Serial.println("4.3: Deleting file 'temp.txt'"); // In thông báo đang xóa tập tin
  if (!sdCard.deleteFile("temp.txt")) { // Xóa tập tin tạm thời
    Serial.println("Failed to delete file!"); // In thông báo nếu xóa thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Liệt kê thư mục để xác minh việc xóa tập tin
  Serial.println("4.4: Listing directory to verify file deletion"); // In thông báo xác minh xóa tập tin
  if (!sdCard.listDirectory("/")) {   // Liệt kê nội dung thư mục gốc
    Serial.println("Failed to list directory!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  // Thử đọc tập tin đã xóa (nên thất bại)
  Serial.println("4.5: Attempting to read deleted file (should fail)"); // In thông báo đang thử đọc tập tin đã xóa
  memset(readBuffer, 0, sizeof(readBuffer)); // Xóa bộ đệm đọc
  uint32_t bytesRead = sdCard.readFile("temp.txt", readBuffer, sizeof(readBuffer)); // Thử đọc tập tin đã xóa

  if (bytesRead > 0) {                // Nếu đọc được dữ liệu (không nên xảy ra)
    Serial.println("File still exists after deletion!"); // In thông báo tập tin vẫn tồn tại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  } else {                            // Nếu không đọc được dữ liệu (điều này là đúng)
    Serial.println("File successfully deleted."); // In thông báo xóa thành công
  }

  endTest(success);                   // Kết thúc bài kiểm tra với kết quả
}

// Kiểm tra 5: Xử lý đường dẫn - Gốc và đường dẫn tuyệt đối
void testPathHandling() {             // Hàm kiểm tra xử lý đường dẫn
  beginTest("Path Handling");         // Bắt đầu bài kiểm tra xử lý đường dẫn
  bool success = true;                // Khởi tạo biến theo dõi trạng thái thành công

  // Kiểm tra các định dạng đường dẫn khác nhau
  Serial.println("5.1: Testing root path '/'"); // In thông báo kiểm tra đường dẫn gốc
  if (!sdCard.listDirectory("/")) {   // Liệt kê thư mục gốc với "/"
    Serial.println("Failed to list root directory with '/'!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  Serial.println("5.2: Testing empty path ''"); // In thông báo kiểm tra đường dẫn rỗng
  if (!sdCard.listDirectory("")) {    // Liệt kê thư mục gốc với đường dẫn rỗng
    Serial.println("Failed to list root directory with empty path!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  Serial.println("5.3: Testing absolute path with trailing slash '/data/'"); // In thông báo kiểm tra đường dẫn tuyệt đối
  if (!sdCard.listDirectory("/data/")) { // Liệt kê thư mục với dấu gạch chéo cuối
    Serial.println("Failed to list directory with trailing slash!"); // In thông báo nếu liệt kê thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  Serial.println("5.4: Creating file with absolute path"); // In thông báo tạo tập tin với đường dẫn tuyệt đối
  if (!sdCard.createFileInPath("/absolute_path.txt", "File with absolute path.")) { // Tạo tập tin với đường dẫn tuyệt đối
    Serial.println("Failed to create file with absolute path!"); // In thông báo nếu tạo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  Serial.println("5.5: Reading file with absolute path"); // In thông báo đọc tập tin với đường dẫn tuyệt đối
  memset(readBuffer, 0, sizeof(readBuffer)); // Xóa bộ đệm đọc
  uint32_t bytesRead = sdCard.readFile("/absolute_path.txt", readBuffer, sizeof(readBuffer)); // Đọc tập tin với đường dẫn tuyệt đối

  if (bytesRead > 0) {                // Nếu đọc được dữ liệu
    Serial.print("Read ");            // In "Read"
    Serial.print(bytesRead);          // In số byte đã đọc
    Serial.println(" bytes:");        // In "bytes:"
    Serial.println(readBuffer);       // In nội dung đã đọc được

    // Xác minh nội dung
    if (strcmp(readBuffer, "File with absolute path.") != 0) { // So sánh nội dung đọc được với nội dung mong đợi
      Serial.println("File content doesn't match!"); // In thông báo nếu nội dung không khớp
      success = false;                // Đánh dấu kiểm tra là thất bại
    }
  } else {                            // Nếu không đọc được dữ liệu
    Serial.println("Failed to read file with absolute path!"); // In thông báo thất bại
    success = false;                  // Đánh dấu kiểm tra là thất bại
  }

  endTest(success);                   // Kết thúc bài kiểm tra với kết quả
}

void setup() {
  // Khởi tạo Serial để debug
  Serial.begin(115200);              // Thiết lập giao tiếp Serial ở tốc độ 115200 baud
  delay(3000);                       // Đợi 3 giây để Serial khởi tạo

  Serial.println("ZBSdCard Complete API Test"); // In tiêu đề chương trình kiểm tra
  Serial.println("=============================="); // In đường phân cách

  // Khởi tạo thẻ SD
  Serial.println("Initializing SD card..."); // In thông báo khởi tạo thẻ SD
  if (!sdCard.begin(SD_CS_PIN)) {    // Khởi tạo thẻ SD với chân CS đã định nghĩa
    Serial.print("Initialization failed! Error: "); // In thông báo khởi tạo thất bại
    Serial.println(sdCard.getErrorMessage()); // In thông báo lỗi cụ thể
    while (1)
      ;  // Dừng thực thi
  }
  Serial.println("SD card initialized successfully!\n"); // In thông báo khởi tạo thành công

  // Chạy tất cả các bài kiểm tra
  testBasicFileOperations();         // Kiểm tra thao tác tập tin cơ bản
  testDirectoryOperations();         // Kiểm tra thao tác thư mục
  testNestedDirectories();           // Kiểm tra thư mục lồng nhau
  testFileDeletion();                // Kiểm tra xóa tập tin
  testPathHandling();                // Kiểm tra xử lý đường dẫn

  // Báo cáo kết quả kiểm tra tổng thể
  Serial.println("\n=============================="); // In đường phân cách
  Serial.print("OVERALL RESULTS: ");    // In tiêu đề kết quả tổng thể
  Serial.print(testsPassed);          // In số bài kiểm tra đã vượt qua
  Serial.print("/");                  // In dấu "/"
  Serial.print(testsRun);             // In tổng số bài kiểm tra
  Serial.print(" tests passed (");    // In "tests passed ("
  Serial.print((testsPassed * 100) / testsRun); // In phần trăm thành công
  Serial.println("%)");               // In ")%"

  if (testsPassed == testsRun) {      // Nếu tất cả các bài kiểm tra đều vượt qua
    Serial.println("All tests PASSED! ✓"); // In thông báo tất cả đều vượt qua
  } else {                            // Nếu có bài kiểm tra thất bại
    Serial.print(testsRun - testsPassed); // In số bài kiểm tra thất bại
    Serial.println(" tests FAILED! ✗"); // In thông báo có bài kiểm tra thất bại
  }
  Serial.println("=============================="); // In đường phân cách
}

void loop() {
  // Không có gì để làm trong vòng lặp
  delay(1000);                       // Đợi 1 giây
}
```

### Code đọc và hiển thị file từ SD Card lên OLED SSD1306

```cpp
/**
 * Trình xem tập tin SD Card với màn hình OLED SSD1306
 * 
 * Sketch này cho phép duyệt và xem các tập tin trên thẻ SD
 * sử dụng màn hình OLED SSD1306.
 * Tính năng:
 * - Duyệt tập tin với điều hướng thư mục
 * - Xem tập tin văn bản
 * - Cuộn cho nội dung tập tin dài
 */
#include <ZBPrint.h>           // Bao gồm thư viện ZBPrint
#include <SPI.h>               // Bao gồm thư viện SPI cho giao tiếp
#include <ZBSdCard.h>          // Bao gồm thư viện ZBSdCard để làm việc với thẻ SD
#include <Wire.h>              // Bao gồm thư viện Wire cho giao tiếp I2C
#include <Adafruit_GFX.h>      // Bao gồm thư viện đồ họa Adafruit GFX
#include <Adafruit_SSD1306.h>  // Bao gồm thư viện cho màn hình OLED SSD1306

// Cấu hình OLED
#define SCREEN_WIDTH 128                                                   // Định nghĩa chiều rộng màn hình là 128 pixel
#define SCREEN_HEIGHT 64                                                   // Định nghĩa chiều cao màn hình là 64 pixel
#define OLED_RESET -1                                                      // Định nghĩa chân reset màn hình (-1 nghĩa là dùng chân reset mặc định)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);  // Khởi tạo đối tượng màn hình

// Cấu hình thẻ SD
#define SD_CS_PIN 10  // Định nghĩa chân Chip Select cho thẻ SD là chân 10
ZBSdCard sdCard;      // Khởi tạo đối tượng thẻ SD

// Chân nút bấm - Cần khớp với kết nối vật lý của bạn
#define BTN_UP 2      // Nút lên kết nối với chân 2
#define BTN_DOWN 3    // Nút xuống kết nối với chân 3
#define BTN_SELECT 4  // Nút chọn kết nối với chân 4
#define BTN_BACK 5    // Nút quay lại kết nối với chân 5

// Biến cho trình xem tập tin
#define MAX_FILES 32            // Số lượng tập tin tối đa có thể hiển thị
#define MAX_FILENAME_LENGTH 20  // Độ dài tối đa cho tên tập tin
#define MAX_PATH_LENGTH 100     // Độ dài tối đa cho đường dẫn
#define LINES_PER_SCREEN 6      // Số dòng hiển thị trên mỗi màn hình
#define MAX_FILE_BUFFER 1024    // Kích thước bộ đệm tối đa cho đọc tập tin

// Bộ đệm cho thao tác tập tin
char fileBuffer[MAX_FILE_BUFFER];  // Bộ đệm dùng để lưu nội dung tập tin

// Đường dẫn thư mục hiện tại
char currentPath[MAX_PATH_LENGTH] = "/";  // Bắt đầu ở thư mục gốc

// Mảng để lưu tên tập tin
char fileList[MAX_FILES][MAX_FILENAME_LENGTH];  // Mảng 2 chiều để lưu tên các tập tin và thư mục
bool isDirectory[MAX_FILES];                    // Cờ để đánh dấu nếu mục là thư mục
int fileCount = 0;                              // Số lượng tập tin tìm thấy
int currentFile = 0;                            // Vị trí tập tin được chọn hiện tại
int scrollPosition = 0;                         // Vị trí cuộn hiện tại
int viewMode = 0;                               // Chế độ xem: 0 = danh sách tập tin, 1 = nội dung tập tin

// Khai báo các hàm
void scanFiles(const char* path);                              // Quét tập tin trong thư mục
void displayFileList();                                        // Hiển thị danh sách tập tin
void displayFileContent(const char* filename);                 // Hiển thị nội dung tập tin
void handleButtons();                                          // Xử lý các nút bấm
bool readButton(int pin);                                      // Đọc trạng thái nút bấm với chống dội
void navigateToFolder(const char* folderName);                 // Di chuyển vào thư mục con
void navigateUp();                                             // Di chuyển lên thư mục cha
void constructFullPath(char* fullPath, const char* filename);  // Tạo đường dẫn đầy đủ

void setup() {
  // Khởi tạo cổng nối tiếp cho debug
  Serial.begin(115200);  // Khởi tạo giao tiếp Serial với tốc độ 115200 baud
  delay(1000);           // Đợi 1 giây để Serial ổn định

  Serial.println("SD Card File Viewer");  // In thông báo khởi động

  // Khởi tạo các nút bấm với điện trở kéo lên
  pinMode(BTN_UP, INPUT_PULLUP);      // Cấu hình nút lên với điện trở kéo lên
  pinMode(BTN_DOWN, INPUT_PULLUP);    // Cấu hình nút xuống với điện trở kéo lên
  pinMode(BTN_SELECT, INPUT_PULLUP);  // Cấu hình nút chọn với điện trở kéo lên
  pinMode(BTN_BACK, INPUT_PULLUP);    // Cấu hình nút quay lại với điện trở kéo lên

  // Khởi tạo màn hình OLED
  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {  // Khởi tạo màn hình với địa chỉ I2C 0x3C
    Serial.println(F("SSD1306 allocation failed"));  // In thông báo lỗi nếu khởi tạo thất bại
    for (;;)
      ;  // Không tiếp tục, lặp vô hạn
  }

  // Khởi tạo thẻ SD
  display.clearDisplay();                      // Xóa màn hình
  display.setTextSize(1);                      // Đặt kích thước văn bản là 1
  display.setTextColor(SSD1306_WHITE);         // Đặt màu văn bản là trắng
  display.setCursor(0, 0);                     // Đặt con trỏ tại vị trí (0,0)
  display.println("Initializing SD Card...");  // Hiển thị thông báo đang khởi tạo thẻ SD
  display.display();                           // Cập nhật hiển thị

  if (!sdCard.begin(SD_CS_PIN)) {               // Khởi tạo thẻ SD với chân CS đã định nghĩa
    display.clearDisplay();                     // Xóa màn hình
    display.setCursor(0, 0);                    // Đặt con trỏ về vị trí (0,0)
    display.println("SD Card init failed!");    // Hiển thị thông báo lỗi khởi tạo
    display.println("Error: ");                 // Chuẩn bị hiển thị thông báo lỗi
    display.println(sdCard.getErrorMessage());  // Hiển thị thông báo lỗi cụ thể
    display.display();                          // Cập nhật hiển thị
    for (;;)
      ;  // Không tiếp tục, lặp vô hạn
  }

  sdCard.createFile("test2.txt", "This is test file #2 content.");                   // Tạo tập tin test2.txt với nội dung cho thử nghiệm
  sdCard.createFile("test3.txt", "This is test file #3 content.");                   // Tạo tập tin test3.txt với nội dung cho thử nghiệm
  sdCard.createDirectory("NEWDIR");                                                  // Tạo thư mục NEWDIR cho thử nghiệm
  sdCard.createFileInPath("/NEWDIR/test2.txt", "This is test file #2 in testdir.");  // Tạo tập tin trong thư mục NEWDIR

  // Hiển thị thông báo trong khi đang quét tập tin
  display.clearDisplay();                 // Xóa màn hình
  display.setCursor(0, 0);                // Đặt con trỏ tại vị trí (0,0)
  display.println("Reading SD Card...");  // Hiển thị thông báo đang đọc thẻ SD
  display.println("Please wait...");      // Hiển thị thông báo đợi
  display.display();                      // Cập nhật hiển thị

  // Quét tập tin trên thẻ SD (bắt đầu từ thư mục gốc)
  scanFiles("/");  // Quét các tập tin trong thư mục gốc

  // Hiển thị danh sách tập tin
  displayFileList();  // Hiển thị danh sách tập tin đã quét
}

void loop() {
  // In trạng thái hiện tại của các nút bấm để debug
  Serial.print("Buttons: ");              // In tiêu đề thông tin nút bấm
  Serial.print(digitalRead(BTN_UP));      // In trạng thái nút lên
  Serial.print(digitalRead(BTN_DOWN));    // In trạng thái nút xuống
  Serial.print(digitalRead(BTN_SELECT));  // In trạng thái nút chọn
  Serial.println(digitalRead(BTN_BACK));  // In trạng thái nút quay lại

  // Xử lý các nút bấm
  handleButtons();  // Xử lý phản hồi cho các nút bấm
  delay(100);       // Đợi nhỏ 100ms để chống dội nút
}

// Quét tập tin trong thư mục sử dụng phương thức mới
void scanFiles(const char* path) {
  fileCount = 0;       // Đặt lại số lượng tập tin về 0
  currentFile = 0;     // Đặt lại vị trí tập tin hiện tại về 0
  scrollPosition = 0;  // Đặt lại vị trí cuộn về 0

  // Lưu đường dẫn hiện tại
  strncpy(currentPath, path, MAX_PATH_LENGTH - 1);  // Sao chép đường dẫn đến biến currentPath
  currentPath[MAX_PATH_LENGTH - 1] = '\0';          // Đảm bảo kết thúc chuỗi

  // Hiển thị thông báo đang quét
  display.clearDisplay();                    // Xóa màn hình
  display.setCursor(0, 0);                   // Đặt con trỏ tại vị trí (0,0)
  display.println("Scanning directory...");  // Hiển thị thông báo đang quét thư mục
  display.display();                         // Cập nhật hiển thị

  // Không còn thêm mục "lên thư mục" nữa
  // Nút quay lại sẽ xử lý chức năng này thay thế

  // Sử dụng hàm mới để lấy các mục trong thư mục
  int foundEntries = 0;  // Biến đếm số mục tìm thấy
  if (!sdCard.listDirectoryEntries(path, &fileList[fileCount], &isDirectory[fileCount],
                                   MAX_FILES - fileCount, &foundEntries)) {  // Liệt kê mục trong thư mục
    display.setCursor(0, 24);                                                // Đặt con trỏ tại vị trí (0,24)
    display.println("Failed to list directory!");                            // Hiển thị thông báo lỗi
    display.display();                                                       // Cập nhật hiển thị
    delay(2000);                                                             // Đợi 2 giây để xem thông báo
    return;                                                                  // Thoát khỏi hàm
  }

  fileCount += foundEntries;  // Cập nhật tổng số tập tin tìm thấy

  Serial.print("Scanned directory: ");  // In thông tin về thư mục đã quét
  Serial.println(path);                 // In đường dẫn thư mục
  Serial.print("Found ");               // In thông tin về số lượng tìm thấy
  Serial.print(fileCount);              // In số lượng tập tin/thư mục
  Serial.println(" files/dirs.");       // In phần còn lại của thông báo
}

// Hiển thị danh sách tập tin trên màn hình OLED
void displayFileList() {
  display.clearDisplay();   // Xóa màn hình
  display.setCursor(0, 0);  // Đặt con trỏ tại vị trí (0,0)

  // Luôn hiển thị "File Browser" làm tiêu đề
  display.println("File Browser");                             // Hiển thị tiêu đề trình duyệt tập tin
  display.drawLine(0, 9, SCREEN_WIDTH - 1, 9, SSD1306_WHITE);  // Vẽ đường phân cách sau tiêu đề

  int startIdx = max(0, min(scrollPosition, fileCount - LINES_PER_SCREEN));  // Tính vị trí bắt đầu hiển thị
  int endIdx = min(startIdx + LINES_PER_SCREEN, fileCount);                  // Tính vị trí kết thúc hiển thị

  if (fileCount == 0) {                  // Nếu không có tập tin nào
    display.setCursor(0, 16);            // Đặt con trỏ tại vị trí (0,16)
    display.println("No files found!");  // Hiển thị thông báo không tìm thấy tập tin
  } else {
    for (int i = startIdx; i < endIdx; i++) {  // Lặp qua các tập tin trong phạm vi hiển thị
      // Làm nổi bật tập tin được chọn
      if (i == currentFile) {                                                          // Nếu đây là tập tin hiện tại
        display.fillRect(0, 11 + (i - startIdx) * 9, SCREEN_WIDTH, 9, SSD1306_WHITE);  // Vẽ hình chữ nhật nền trắng
        display.setTextColor(SSD1306_BLACK);                                           // Đặt màu chữ là đen (ngược với nền)
      } else {
        display.setTextColor(SSD1306_WHITE);  // Đặt màu chữ là trắng
      }

      display.setCursor(2, 12 + (i - startIdx) * 9);  // Đặt vị trí con trỏ

      // Hiển thị chỉ báo thư mục cho các thư mục
      if (isDirectory[i]) {          // Nếu đây là thư mục
        display.print("[");          // In dấu [ trước tên thư mục
        display.print(fileList[i]);  // In tên thư mục
        display.print("]");          // In dấu ] sau tên thư mục
      }
      // Tập tin thông thường
      else {
        display.println(fileList[i]);  // In tên tập tin
      }

      display.setTextColor(SSD1306_WHITE);  // Đặt lại màu chữ là trắng
    }

    // Vẽ thanh cuộn nếu cần
    if (fileCount > LINES_PER_SCREEN) {                                                             // Nếu có nhiều tập tin hơn số dòng hiển thị
      int barHeight = max(5, (LINES_PER_SCREEN * SCREEN_HEIGHT) / fileCount);                       // Tính chiều cao thanh cuộn
      int barPosition = (startIdx * (SCREEN_HEIGHT - barHeight)) / (fileCount - LINES_PER_SCREEN);  // Tính vị trí thanh cuộn
      display.drawRect(SCREEN_WIDTH - 3, 10, 3, SCREEN_HEIGHT - 10, SSD1306_WHITE);                 // Vẽ viền thanh cuộn
      display.fillRect(SCREEN_WIDTH - 3, 10 + barPosition, 3, barHeight, SSD1306_WHITE);            // Vẽ thanh cuộn
    }
  }

  display.display();  // Cập nhật hiển thị
}

// Hiển thị nội dung tập tin trên màn hình OLED
void displayFileContent(const char* filename) {
  display.clearDisplay();  // Xóa màn hình

  // Tạo đường dẫn đầy đủ đến tập tin
  char fullPath[MAX_PATH_LENGTH + MAX_FILENAME_LENGTH];  // Khai báo biến lưu đường dẫn đầy đủ
  constructFullPath(fullPath, filename);                 // Tạo đường dẫn đầy đủ

  // Hiển thị tên tập tin ở trên cùng
  display.setCursor(0, 0);  // Đặt con trỏ tại vị trí (0,0)
  // Hiển thị chỉ tên tập tin, không phải đường dẫn đầy đủ
  display.println(filename);                                   // In tên tập tin
  display.drawLine(0, 9, SCREEN_WIDTH - 1, 9, SSD1306_WHITE);  // Vẽ đường phân cách sau tiêu đề

  // Đọc nội dung tập tin
  memset(fileBuffer, 0, sizeof(fileBuffer));                                           // Xóa bộ đệm
  uint32_t bytesRead = sdCard.readFile(fullPath, fileBuffer, sizeof(fileBuffer) - 1);  // Đọc nội dung tập tin

  if (bytesRead == 0) {                     // Nếu không đọc được nội dung
    display.setCursor(0, 16);               // Đặt con trỏ tại vị trí (0,16)
    display.println("Error reading file");  // Hiển thị thông báo lỗi đọc tập tin
    display.println("or file is empty.");   // Hoặc tập tin rỗng
  } else {
    // Hiển thị nội dung với ngắt dòng
    int lineHeight = 8;                              // Chiều cao mỗi dòng (pixel)
    int x = 0, y = 11;                               // Vị trí bắt đầu hiển thị
    int contentLength = strlen(fileBuffer);          // Độ dài nội dung
    int charWidth = 6;                               // Chiều rộng xấp xỉ của một ký tự
    int maxCharsPerLine = SCREEN_WIDTH / charWidth;  // Số ký tự tối đa trên một dòng

    // Áp dụng cuộn cho chế độ xem nội dung
    int startPos = min(scrollPosition * maxCharsPerLine, contentLength);  // Tính vị trí bắt đầu cuộn

    // Hiển thị nội dung từ vị trí cuộn
    int pos = startPos;                                 // Vị trí hiện tại trong nội dung
    while (pos < contentLength && y < SCREEN_HEIGHT) {  // Lặp qua các ký tự trong nội dung
      if (fileBuffer[pos] == '\n') {                    // Nếu gặp ký tự xuống dòng
        // Xử lý ký tự xuống dòng
        x = 0;                               // Đặt lại vị trí x về đầu dòng
        y += lineHeight;                     // Tăng vị trí y lên một dòng
      } else if (fileBuffer[pos] == '\r') {  // Nếu gặp ký tự trả về đầu dòng
        // Bỏ qua ký tự trả về đầu dòng
      } else {
        // Hiển thị ký tự
        display.setCursor(x, y);         // Đặt con trỏ tại vị trí hiện tại
        display.write(fileBuffer[pos]);  // In ký tự
        x += charWidth;                  // Tăng vị trí x cho ký tự tiếp theo

        // Ngắt dòng nếu cần
        if (x >= SCREEN_WIDTH) {  // Nếu vượt quá chiều rộng màn hình
          x = 0;                  // Đặt lại vị trí x về đầu dòng
          y += lineHeight;        // Tăng vị trí y lên một dòng
        }
      }

      pos++;  // Tiến đến ký tự tiếp theo

      // Nếu đã lấp đầy màn hình, dừng lại
      if (y > SCREEN_HEIGHT - lineHeight)  // Nếu vượt quá chiều cao màn hình
        break;                             // Thoát khỏi vòng lặp
    }

    // Vẽ thanh cuộn nếu cần
    int totalLines = (contentLength + maxCharsPerLine - 1) / maxCharsPerLine;                     // Tính tổng số dòng
    if (totalLines > (SCREEN_HEIGHT - 11) / lineHeight) {                                         // Nếu có nhiều dòng hơn có thể hiển thị
      int visibleLines = (SCREEN_HEIGHT - 11) / lineHeight;                                       // Số dòng có thể hiển thị
      int barHeight = max(5, (visibleLines * (SCREEN_HEIGHT - 11)) / totalLines);                 // Chiều cao thanh cuộn
      int maxScrollPosition = totalLines - visibleLines;                                          // Vị trí cuộn tối đa
      int barPosition = (scrollPosition * (SCREEN_HEIGHT - 11 - barHeight)) / maxScrollPosition;  // Vị trí thanh cuộn
      display.drawRect(SCREEN_WIDTH - 3, 10, 3, SCREEN_HEIGHT - 10, SSD1306_WHITE);               // Vẽ viền thanh cuộn
      display.fillRect(SCREEN_WIDTH - 3, 10 + barPosition, 3, barHeight, SSD1306_WHITE);          // Vẽ thanh cuộn
    }
  }

  display.display();  // Cập nhật hiển thị
}

// Xử lý các nút bấm
void handleButtons() {
  // Nút UP (lên)
  if (digitalRead(BTN_UP) == LOW) {         // Nếu nút UP được nhấn (mức thấp)
    delay(50);                              // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_UP) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("UP button pressed");  // In thông báo nút UP được nhấn
      if (viewMode == 0) {                  // Nếu đang ở chế độ danh sách tập tin
        // Trong chế độ danh sách tập tin
        if (currentFile > 0) {               // Nếu không phải tập tin đầu tiên
          currentFile--;                     // Di chuyển lên một tập tin
          if (currentFile < scrollPosition)  // Nếu cần cuộn lên
            scrollPosition = currentFile;    // Cập nhật vị trí cuộn
          displayFileList();                 // Cập nhật hiển thị danh sách
        }
      } else {
        // Trong chế độ xem tập tin
        if (scrollPosition > 0) {                     // Nếu không phải đang ở đầu tập tin
          scrollPosition--;                           // Cuộn lên một dòng
          displayFileContent(fileList[currentFile]);  // Cập nhật hiển thị nội dung
        }
      }

      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_UP) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                          // Đợi 10ms
      }
    }
  }

  // Nút DOWN (xuống)
  if (digitalRead(BTN_DOWN) == LOW) {         // Nếu nút DOWN được nhấn (mức thấp)
    delay(50);                                // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_DOWN) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("DOWN button pressed");  // In thông báo nút DOWN được nhấn
      if (viewMode == 0) {                    // Nếu đang ở chế độ danh sách tập tin
        // Trong chế độ danh sách tập tin
        if (currentFile < fileCount - 1) {                        // Nếu không phải tập tin cuối cùng
          currentFile++;                                          // Di chuyển xuống một tập tin
          if (currentFile >= scrollPosition + LINES_PER_SCREEN)   // Nếu cần cuộn xuống
            scrollPosition = currentFile - LINES_PER_SCREEN + 1;  // Cập nhật vị trí cuộn
          displayFileList();                                      // Cập nhật hiển thị danh sách
        }
      } else {
        // Trong chế độ xem tập tin
        scrollPosition++;                           // Cuộn xuống một dòng
        displayFileContent(fileList[currentFile]);  // Cập nhật hiển thị nội dung
      }

      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_DOWN) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                            // Đợi 10ms
      }
    }
  }

  // Nút SELECT (chọn)
  if (digitalRead(BTN_SELECT) == LOW) {         // Nếu nút SELECT được nhấn (mức thấp)
    delay(50);                                  // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_SELECT) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("SELECT button pressed");  // In thông báo nút SELECT được nhấn

      if (viewMode == 0 && fileCount > 0) {  // Nếu đang ở chế độ danh sách và có tập tin
        // Nếu mục được chọn là thư mục
        if (isDirectory[currentFile]) {                    // Nếu đây là thư mục
          if (strcmp(fileList[currentFile], "..") == 0) {  // Nếu là mục ".." (lên một cấp)
            // Đi lên một thư mục
            navigateUp();  // Điều hướng lên thư mục cha
          } else {
            // Điều hướng vào thư mục được chọn
            navigateToFolder(fileList[currentFile]);  // Vào thư mục được chọn
          }
        } else {
          // Chuyển sang chế độ xem tập tin cho tập tin
          viewMode = 1;                               // Đặt chế độ xem là xem nội dung tập tin
          scrollPosition = 0;                         // Đặt lại vị trí cuộn về đầu
          displayFileContent(fileList[currentFile]);  // Hiển thị nội dung tập tin
        }
      }

      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_SELECT) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                              // Đợi 10ms
      }
    }
  }

  // Nút BACK (quay lại)
  if (digitalRead(BTN_BACK) == LOW) {         // Nếu nút BACK được nhấn (mức thấp)
    delay(50);                                // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_BACK) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("BACK button pressed");  // In thông báo nút BACK được nhấn
      if (viewMode == 1) {                    // Nếu đang ở chế độ xem tập tin
        // Quay lại chế độ danh sách tập tin từ chế độ xem tập tin
        viewMode = 0;                                                 // Đặt chế độ xem là danh sách tập tin
        scrollPosition = max(0, currentFile - LINES_PER_SCREEN + 1);  // Cập nhật vị trí cuộn
        displayFileList();                                            // Hiển thị danh sách tập tin
      } else if (viewMode == 0 && strcmp(currentPath, "/") != 0) {    // Nếu đang ở chế độ danh sách và không phải thư mục gốc
        // Đi lên một thư mục từ trình duyệt tập tin (nếu không ở thư mục gốc)
        navigateUp();  // Điều hướng lên thư mục cha
      }

      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_BACK) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                            // Đợi 10ms
      }
    }
  }
}

// Điều hướng đến thư mục con
void navigateToFolder(const char* folderName) {
  char newPath[MAX_PATH_LENGTH];  // Khai báo biến cho đường dẫn mới

  // Tạo đường dẫn mới
  if (strcmp(currentPath, "/") == 0) {  // Nếu đang ở thư mục gốc
    // Chúng ta đang ở thư mục gốc
    snprintf(newPath, MAX_PATH_LENGTH, "/%s", folderName);  // Tạo đường dẫn "/tên_thư_mục"
  } else {
    // Chúng ta đang ở thư mục con
    snprintf(newPath, MAX_PATH_LENGTH, "%s/%s", currentPath, folderName);  // Tạo đường dẫn "đường_dẫn_hiện_tại/tên_thư_mục"
  }

  // Quét thư mục mới
  scanFiles(newPath);  // Quét tập tin trong thư mục mới

  // Hiển thị danh sách tập tin mới
  displayFileList();  // Hiển thị danh sách tập tin
}

// Điều hướng lên thư mục cha
void navigateUp() {
  // Nếu đã ở thư mục gốc, không làm gì cả
  if (strcmp(currentPath, "/") == 0) {  // Nếu đang ở thư mục gốc
    return;                             // Thoát khỏi hàm
  }

  char newPath[MAX_PATH_LENGTH];  // Khai báo biến cho đường dẫn mới
  strcpy(newPath, currentPath);   // Sao chép đường dẫn hiện tại

  // Tìm dấu gạch chéo cuối cùng trong đường dẫn
  char* lastSlash = strrchr(newPath, '/');  // Tìm vị trí của dấu / cuối cùng

  if (lastSlash == newPath) {  // Nếu dấu / cuối cùng là ký tự đầu tiên
    // Chúng ta đang ở thư mục cấp cao nhất, quay lại thư mục gốc
    strcpy(newPath, "/");  // Đặt đường dẫn là "/"
  } else {
    // Cắt đường dẫn tại dấu gạch chéo cuối cùng
    *lastSlash = '\0';  // Kết thúc chuỗi tại vị trí dấu / cuối cùng
  }

  // Quét thư mục cha
  scanFiles(newPath);  // Quét tập tin trong thư mục cha

  // Hiển thị danh sách tập tin đã cập nhật
  displayFileList();  // Hiển thị danh sách tập tin
}

// Tạo đường dẫn đầy đủ từ thư mục hiện tại và tên tập tin
void constructFullPath(char* fullPath, const char* filename) {
  if (strcmp(currentPath, "/") == 0) {  // Nếu thư mục hiện tại là thư mục gốc
    // Thư mục gốc
    sprintf(fullPath, "/%s", filename);  // Tạo đường dẫn "/tên_tập_tin"
  } else {
    // Thư mục con
    sprintf(fullPath, "%s/%s", currentPath, filename);  // Tạo đường dẫn "đường_dẫn_hiện_tại/tên_tập_tin"
  }
}

// Đọc nút bấm với chống dội
bool readButton(int pin) {
  static unsigned long lastDebounceTime = 0;  // Thời điểm dội nút cuối cùng
  static int lastButtonState = HIGH;          // Trạng thái nút trước đó

  // Trạng thái nút hiện tại
  int buttonState = digitalRead(pin);  // Đọc trạng thái nút

  // Kiểm tra nếu trạng thái nút đã thay đổi
  if (buttonState != lastButtonState) {  // Nếu trạng thái khác với lần trước
    lastDebounceTime = millis();         // Cập nhật thời điểm thay đổi
  }

  lastButtonState = buttonState;  // Cập nhật trạng thái nút trước đó

  // Kiểm tra nếu đã đủ thời gian kể từ lần thay đổi cuối cùng
  if ((millis() - lastDebounceTime) > 50) {  // Nếu đã qua 50ms
    if (buttonState == LOW) {                // Nếu nút đang được nhấn
      // Nút được nhấn, đợi cho đến khi nhả ra
      while (digitalRead(pin) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                       // Đợi 10ms
      }
      return true;  // Trả về true để xác nhận nút được nhấn
    }
  }

  return false;  // Trả về false nếu nút không được nhấn
}
```

Copy 2 đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![sdcard-code](https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

### Sơ lược về thư viện ZBSdCard

ZBSdCard là thư viện tối ưu hóa cao cho các thao tác với thẻ SD, hỗ trợ cho Zerobase/Zerobase2.

#### Lưu ý khi sử dụng thư viện

1. Thư viện hoạt động trên giao diện SPI
2. Hỗ trợ đầy đủ các thao tác với hệ thống tập tin FAT32

#### 1. Constructor

```cpp
ZBSdCard();
```

- **Mục đích**: Khởi tạo đối tượng thẻ SD mới
- **Chi tiết**: Tạo một instance mới của thư viện SD card

#### 2. `begin()`

```cpp
bool begin(uint8_t csPin, SPIClass& spi = SPI);
```

- **Mục đích**: Khởi tạo thẻ SD và kết nối qua SPI hoặc SPI_1
- **Chi tiết**: Thiết lập kết nối với thẻ SD thông qua giao tiếp SPI
- **Tham số**:
  - `csPin`: Chân Chip Select cho thẻ SD
  - `spi`: Đối tượng SPI (mặc định là SPI, bạn có thể sử dụng SPI_1 nếu cần thiết)
- **Giá trị trả về**: `bool` - true nếu khởi tạo thành công, false nếu thất bại

#### 3. Các hàm thao tác tập tin cơ bản

##### 3.1 `createFile()`

```cpp
bool createFile(const char *fileName, const char *content = "");
```

- **Mục đích**: Tạo một tập tin mới trên thẻ SD
- **Chi tiết**: Tạo tập tin và ghi nội dung cho trước (nếu có)
- **Tham số**:
  - `fileName`: Tên tập tin cần tạo
  - `content`: Nội dung tập tin (mặc định là chuỗi rỗng)
- **Giá trị trả về**: `bool` - true nếu tạo thành công, false nếu thất bại

##### 3.2 `readFile()`

```cpp
uint32_t readFile(const char *fileName, char *buffer, uint32_t bufferSize);
```

- **Mục đích**: Đọc nội dung từ một tập tin
- **Chi tiết**: Đọc dữ liệu từ tập tin vào buffer được cung cấp
- **Tham số**:
  - `fileName`: Tên tập tin cần đọc
  - `buffer`: Buffer để lưu nội dung đọc được
  - `bufferSize`: Kích thước tối đa của buffer
- **Giá trị trả về**: `uint32_t` - Số byte đã đọc từ tập tin

##### 3.3 `appendFile()`

```cpp
bool appendFile(const char *fileName, const char *content);
```

- **Mục đích**: Thêm nội dung vào cuối tập tin
- **Chi tiết**: Mở tập tin hiện có và thêm dữ liệu mới vào cuối
- **Tham số**:
  - `fileName`: Tên tập tin cần thêm nội dung
  - `content`: Nội dung cần thêm vào
- **Giá trị trả về**: `bool` - true nếu thêm thành công, false nếu thất bại

##### 3.4 `deleteFile()`

```cpp
bool deleteFile(const char *fileName);
```

- **Mục đích**: Xóa một tập tin từ thẻ SD
- **Chi tiết**: Xóa tập tin với tên được chỉ định
- **Tham số**: `fileName` - Tên tập tin cần xóa
- **Giá trị trả về**: `bool` - true nếu xóa thành công, false nếu thất bại

#### 4. Các hàm thao tác thư mục

##### 4.1 `listDirectory()`

```cpp
bool listDirectory(const char *path = "/");
```

- **Mục đích**: Liệt kê nội dung của thư mục
- **Chi tiết**: In danh sách tập tin và thư mục trong đường dẫn được chỉ định
- **Tham số**: `path` - Đường dẫn thư mục cần liệt kê (mặc định là thư mục gốc "/")
- **Giá trị trả về**: `bool` - true nếu liệt kê thành công, false nếu thất bại

##### 4.2 `listDirectoryEntries()`

```cpp
bool listDirectoryEntries(const char* path, char (*fileNames)[20], bool* isDirectory, int maxEntries, int* entryCount);
```

- **Mục đích**: Lấy danh sách mục trong thư mục
- **Chi tiết**: Điền các mảng đã cấp phát với tên tập tin và loại mục
- **Tham số**:
  - `path`: Đường dẫn thư mục cần liệt kê
  - `fileNames`: Mảng lưu tên các mục
  - `isDirectory`: Mảng cờ chỉ ra mục nào là thư mục
  - `maxEntries`: Số lượng mục tối đa có thể lưu
  - `entryCount`: Con trỏ để lưu số lượng mục thực tế đã tìm thấy
- **Giá trị trả về**: `bool` - true nếu liệt kê thành công, false nếu thất bại

#### 5. Các hàm mở rộng (Chỉ có trên Zerobase2)

##### 5.1 `createDirectory()`

```cpp
bool createDirectory(const char *dirname);
```

- **Mục đích**: Tạo một thư mục mới
- **Chi tiết**: Tạo thư mục với tên được chỉ định
- **Tham số**: `dirname` - Tên thư mục cần tạo
- **Giá trị trả về**: `bool` - true nếu tạo thành công, false nếu thất bại
- **Lưu ý**: Không khả dụng trong chế độ Minimal (Zerobase)

##### 5.2 `createDirectoryPath()`

```cpp
bool createDirectoryPath(const char *path);
```

- **Mục đích**: Tạo chuỗi thư mục theo đường dẫn
- **Chi tiết**: Tạo tất cả các thư mục con trong đường dẫn nếu chúng chưa tồn tại
- **Tham số**: `path` - Đường dẫn thư mục cần tạo
- **Giá trị trả về**: `bool` - true nếu tạo thành công, false nếu thất bại
- **Lưu ý**: Không khả dụng trong chế độ Minimal (Zerobase)

##### 5.3 `createFileInPath()`

```cpp
bool createFileInPath(const char *path, const char *content);
```

- **Mục đích**: Tạo tập tin trong đường dẫn chỉ định
- **Chi tiết**: Tạo tập tin kèm theo nội dung tại vị trí đường dẫn cung cấp
- **Tham số**:
  - `path`: Đường dẫn đầy đủ (bao gồm tên tập tin)
  - `content`: Nội dung tập tin
- **Giá trị trả về**: `bool` - true nếu tạo thành công, false nếu thất bại
- **Lưu ý**: Không khả dụng trong chế độ Minimal (Zerobase)

#### 6. Các hàm xử lý lỗi

##### 6.1 `getErrorMessage()`

```cpp
const char* getErrorMessage();
```

- **Mục đích**: Lấy thông báo lỗi dưới dạng chuỗi
- **Chi tiết**: Trả về thông báo giải thích lỗi gần nhất xảy ra
- **Giá trị trả về**: `const char*` - Chuỗi mô tả lỗi

##### 6.2 `getLastError()`

```cpp
uint8_t getLastError();
```

- **Mục đích**: Lấy mã lỗi gần nhất
- **Chi tiết**: Trả về mã lỗi của thao tác gần nhất
- **Giá trị trả về**: `uint8_t` - Mã lỗi (0 = thành công)

### Giải thích code

#### 1. Code kiểm tra chức năng 

Đoạn code sau đây là một ví dụ hoàn chỉnh về cách sử dụng thư viện ZBSdCard để tương tác với thẻ SD card trên nền tảng vi điều khiển. Chương trình thực hiện kiểm tra đầy đủ các chức năng của thư viện, bao gồm các thao tác cơ bản với tập tin và thư mục, đồng thời báo cáo kết quả kiểm tra.

##### Phần khai báo thư viện và cấu hình

```cpp
#include <SPI.h>
#include <ZBSdCard.h>
#include <ZBPrint.h>
```

- `SPI.h`: Thư viện chuẩn của Arduino để giao tiếp qua giao thức SPI, cần thiết để làm việc với thẻ SD
- `ZBSdCard.h`: Thư viện chính để quản lý thẻ SD và thao tác với các tập tin/thư mục
- `ZBPrint.h`: Thư viện hỗ trợ in thông tin debug

```cpp
// Create an instance of the ZBSdCard class
ZBSdCard sdCard;

// Define the chip select pin for your setup
const int SD_CS_PIN = 10;  // Change as needed

// Buffer for file operations
char readBuffer[256];
```

- Tạo một instance `sdCard` của lớp ZBSdCard để làm việc với thẻ SD
- Định nghĩa chân Chip Select (CS) để kết nối với module SD, được thiết lập là chân 10
- Khởi tạo buffer `readBuffer` có kích thước 256 byte để đọc dữ liệu từ tập tin

```cpp
// Test counter and status tracking
int testsRun = 0;
int testsPassed = 0;
```

- `testsRun`: Biến đếm số lượng bài kiểm tra đã thực hiện
- `testsPassed`: Biến đếm số lượng bài kiểm tra đã vượt qua

##### Các hàm hỗ trợ kiểm tra

```cpp
// Function to print a test header
void beginTest(const char* testName) {
  testsRun++;
  Serial.println();
  Serial.print("TEST ");
  Serial.print(testsRun);
  Serial.print(": ");
  Serial.println(testName);
  Serial.println("----------------------------------------");
}
```

- Hàm `beginTest()` khởi đầu một bài kiểm tra với tên được cung cấp
- Tăng biến đếm số bài kiểm tra đã chạy
- In ra tiêu đề và số thứ tự của bài kiểm tra
- Vẽ đường phân cách để dễ đọc

```cpp
// Function to report test result
void endTest(bool success) {
  if (success) {
    testsPassed++;
    Serial.println("RESULT: PASS ✓");
  } else {
    Serial.println("RESULT: FAIL ✗");
  }
  Serial.println("----------------------------------------");
}
```

- Hàm `endTest()` báo cáo kết quả của bài kiểm tra
- Nếu kiểm tra thành công (`success` là `true`):
  - Tăng biến đếm số bài kiểm tra đã vượt qua
  - In thông báo "PASS" kèm biểu tượng tích
- Nếu kiểm tra thất bại, in thông báo "FAIL" kèm biểu tượng X
- Vẽ đường phân cách kết thúc bài kiểm tra

##### Kiểm tra 1: Thao tác tập tin cơ bản

```cpp
// Test 1: Basic file operations in root directory
void testBasicFileOperations() {
  beginTest("Basic File Operations");
  bool success = true;
```

- Định nghĩa hàm `testBasicFileOperations()` để kiểm tra các thao tác tập tin cơ bản
- Khởi tạo bài kiểm tra với tiêu đề "Basic File Operations"
- Khởi tạo biến `success` là `true` để theo dõi trạng thái kiểm tra

```cpp
  // Create a test file
  Serial.println("1.1: Creating file 'test1.txt'");
  if (!sdCard.createFile("test1.txt", "This is test file #1 content.")) {
    Serial.println("Failed to create file!");
    success = false;
  }
```

- Kiểm tra việc tạo tập tin mới với hàm `createFile()`
- Tạo tập tin "test1.txt" với nội dung "This is test file #1 content."
- Nếu tạo thất bại, in thông báo lỗi và đánh dấu bài kiểm tra thất bại

```cpp
  // Read the file
  Serial.println("1.2: Reading file 'test1.txt'");
  memset(readBuffer, 0, sizeof(readBuffer));
  uint32_t bytesRead = sdCard.readFile("test1.txt", readBuffer, sizeof(readBuffer));
```

- Kiểm tra việc đọc tập tin với hàm `readFile()`
- Xóa buffer bằng cách ghi giá trị 0 vào tất cả các vị trí
- Đọc nội dung tập tin "test1.txt" vào buffer và lưu số byte đọc được

```cpp
  if (bytesRead > 0) {
    Serial.print("Read ");
    Serial.print(bytesRead);
    Serial.println(" bytes:");
    Serial.println(readBuffer);

    // Verify content
    if (strcmp(readBuffer, "This is test file #1 content.") != 0) {
      Serial.println("File content doesn't match!");
      success = false;
    }
  } else {
    Serial.println("Failed to read file!");
    success = false;
  }
```

- Kiểm tra xem có dữ liệu đọc được hay không
- Nếu có, in số byte đọc được và nội dung tập tin
- Xác minh nội dung đọc được có trùng khớp với nội dung đã ghi không
- Nếu không trùng khớp hoặc không đọc được dữ liệu, đánh dấu kiểm tra thất bại

```cpp
  // Append to the file
  Serial.println("1.3: Appending to file 'test1.txt'");
  if (!sdCard.appendFile("test1.txt", "\nThis is appended content.")) {
    Serial.println("Failed to append to file!");
    success = false;
  }
```

- Kiểm tra việc thêm nội dung vào tập tin với hàm `appendFile()`
- Thêm dòng mới "\nThis is appended content." vào tập tin "test1.txt"
- Nếu thất bại, in thông báo lỗi và đánh dấu kiểm tra thất bại

```cpp
  // Read the file again to verify append
  Serial.println("1.4: Reading file after append");
  memset(readBuffer, 0, sizeof(readBuffer));
  bytesRead = sdCard.readFile("test1.txt", readBuffer, sizeof(readBuffer));
```

- Đọc lại tập tin để xác minh nội dung đã được thêm vào
- Xóa buffer và đọc lại tập tin "test1.txt"

```cpp
  if (bytesRead > 0) {
    Serial.print("Read ");
    Serial.print(bytesRead);
    Serial.println(" bytes:");
    Serial.println(readBuffer);

    // Verify content includes the appended data
    if (strstr(readBuffer, "This is appended content.") == NULL) {
      Serial.println("Appended content not found!");
      success = false;
    }
  } else {
    Serial.println("Failed to read file after append!");
    success = false;
  }
```

- Kiểm tra nội dung đọc được sau khi thêm dữ liệu
- Sử dụng hàm `strstr()` để tìm chuỗi đã thêm trong nội dung đọc được
- Nếu không tìm thấy hoặc không đọc được dữ liệu, đánh dấu kiểm tra thất bại

```cpp
  // List the root directory to verify file creation
  Serial.println("1.5: Listing root directory");
  if (!sdCard.listDirectory("/")) {
    Serial.println("Failed to list directory!");
    success = false;
  }

  endTest(success);
}
```

- Kiểm tra việc liệt kê thư mục gốc với hàm `listDirectory()`
- Nếu liệt kê thất bại, đánh dấu kiểm tra thất bại
- Kết thúc bài kiểm tra và báo cáo kết quả

##### Kiểm tra 2: Thao tác với thư mục

```cpp
// Test 2: Directory creation and listing
void testDirectoryOperations() {
  beginTest("Directory Operations");
  bool success = true;

  // Create a directory
  Serial.println("2.1: Creating directory 'testdir'");
  if (!sdCard.createDirectory("testdir")) {
    Serial.println("Failed to create directory!");
    success = false;
  }
```

- Định nghĩa hàm `testDirectoryOperations()` để kiểm tra các thao tác với thư mục
- Khởi tạo bài kiểm tra với tiêu đề "Directory Operations"
- Kiểm tra việc tạo thư mục với hàm `createDirectory()`
- Tạo thư mục "testdir" trong thư mục gốc

```cpp
  // List the root directory to verify directory creation
  Serial.println("2.2: Listing root directory to verify directory creation");
  if (!sdCard.listDirectory("/")) {
    Serial.println("Failed to list directory!");
    success = false;
  }
```

- Liệt kê thư mục gốc để xác minh thư mục đã được tạo
- Nếu liệt kê thất bại, đánh dấu kiểm tra thất bại

```cpp
  // Create a file in the directory
  Serial.println("2.3: Creating file in directory");
  if (!sdCard.createFileInPath("/testdir/test2.txt", "This is test file #2 in testdir.")) {
    Serial.println("Failed to create file in directory!");
    success = false;
  }
```

- Kiểm tra việc tạo tập tin trong thư mục với hàm `createFileInPath()`
- Tạo tập tin "test2.txt" trong thư mục "testdir" với nội dung định sẵn

```cpp
  // List the directory to verify file creation
  Serial.println("2.4: Listing directory content");
  if (!sdCard.listDirectory("/testdir")) {
    Serial.println("Failed to list directory content!");
    success = false;
  }
```

- Liệt kê nội dung thư mục "testdir" để xác minh tập tin đã được tạo
- Nếu liệt kê thất bại, đánh dấu kiểm tra thất bại

```cpp
  // Read the file in the directory
  Serial.println("2.5: Reading file from directory");
  memset(readBuffer, 0, sizeof(readBuffer));
  uint32_t bytesRead = sdCard.readFile("/testdir/test2.txt", readBuffer, sizeof(readBuffer));
```

- Kiểm tra việc đọc tập tin từ thư mục con
- Xóa buffer và đọc nội dung tập tin "/testdir/test2.txt"

```cpp
  if (bytesRead > 0) {
    Serial.print("Read ");
    Serial.print(bytesRead);
    Serial.println(" bytes:");
    Serial.println(readBuffer);

    // Verify content
    if (strcmp(readBuffer, "This is test file #2 in testdir.") != 0) {
      Serial.println("File content doesn't match!");
      success = false;
    }
  } else {
    Serial.println("Failed to read file from directory!");
    success = false;
  }

  endTest(success);
}
```

- Xác minh nội dung đọc được từ tập tin trong thư mục con
- So sánh với nội dung mong đợi và đánh dấu kết quả kiểm tra
- Kết thúc bài kiểm tra và báo cáo kết quả

##### Kiểm tra 3: Thư mục lồng nhau

```cpp
// Test 3: Nested directories and file operations
void testNestedDirectories() {
  beginTest("Nested Directories");
  bool success = true;

  // Create a nested directory structure
  Serial.println("3.1: Creating nested directories '/data/logs/app'");
  if (!sdCard.createDirectoryPath("/data/logs/app")) {
    Serial.println("Failed to create nested directories!");
    success = false;
  }
```

- Định nghĩa hàm `testNestedDirectories()` để kiểm tra thư mục lồng nhau
- Kiểm tra việc tạo cấu trúc thư mục lồng nhau với hàm `createDirectoryPath()`
- Tạo cấu trúc thư mục "/data/logs/app" (ba cấp thư mục)

```cpp
  // List the root directory
  Serial.println("3.2: Listing root directory");
  if (!sdCard.listDirectory("/")) {
    Serial.println("Failed to list root directory!");
    success = false;
  }

  // List the first level directory
  Serial.println("3.3: Listing /data directory");
  if (!sdCard.listDirectory("/data")) {
    Serial.println("Failed to list /data directory!");
    success = false;
  }

  // List the second level directory
  Serial.println("3.4: Listing /data/logs directory");
  if (!sdCard.listDirectory("/data/logs")) {
    Serial.println("Failed to list /data/logs directory!");
    success = false;
  }
```

- Liệt kê nội dung của các cấp thư mục khác nhau để xác minh cấu trúc thư mục
- Lần lượt kiểm tra thư mục gốc, thư mục "/data" và thư mục "/data/logs"

```cpp
  // Create a file in the nested directory
  Serial.println("3.5: Creating file in nested directory");
  if (!sdCard.createFileInPath("/data/logs/app/log.txt", "Log entry from deeply nested file.")) {
    Serial.println("Failed to create file in nested directory!");
    success = false;
  }
```

- Kiểm tra việc tạo tập tin trong thư mục lồng sâu
- Tạo tập tin "log.txt" trong thư mục "/data/logs/app" với nội dung định sẵn

```cpp
  // List the nested directory content
  Serial.println("3.6: Listing nested directory content");
  if (!sdCard.listDirectory("/data/logs/app")) {
    Serial.println("Failed to list nested directory!");
    success = false;
  }
```

- Liệt kê nội dung của thư mục lồng sâu nhất để xác minh tập tin đã được tạo

```cpp
  // Read the file from the nested directory
  Serial.println("3.7: Reading file from nested directory");
  memset(readBuffer, 0, sizeof(readBuffer));
  uint32_t bytesRead = sdCard.readFile("/data/logs/app/log.txt", readBuffer, sizeof(readBuffer));
```

- Kiểm tra việc đọc tập tin từ thư mục lồng sâu
- Xóa buffer và đọc nội dung tập tin "/data/logs/app/log.txt"

```cpp
  if (bytesRead > 0) {
    Serial.print("Read ");
    Serial.print(bytesRead);
    Serial.println(" bytes:");
    Serial.println(readBuffer);

    // Verify content
    if (strcmp(readBuffer, "Log entry from deeply nested file.") != 0) {
      Serial.println("File content doesn't match!");
      success = false;
    }
  } else {
    Serial.println("Failed to read file from nested directory!");
    success = false;
  }

  endTest(success);
}
```

- Xác minh nội dung đọc được từ tập tin trong thư mục lồng sâu
- So sánh với nội dung mong đợi và đánh dấu kết quả kiểm tra
- Kết thúc bài kiểm tra và báo cáo kết quả

##### Kiểm tra 4: Xóa tập tin

```cpp
// Test 4: File deletion
void testFileDeletion() {
  beginTest("File Deletion");
  bool success = true;

  // Create a temporary file to delete
  Serial.println("4.1: Creating temporary file 'temp.txt'");
  if (!sdCard.createFile("temp.txt", "This file will be deleted.")) {
    Serial.println("Failed to create temporary file!");
    success = false;
  }
```

- Định nghĩa hàm `testFileDeletion()` để kiểm tra việc xóa tập tin
- Tạo một tập tin tạm thời "temp.txt" để chuẩn bị xóa

```cpp
  // List directory to verify file creation
  Serial.println("4.2: Listing directory to verify file creation");
  if (!sdCard.listDirectory("/")) {
    Serial.println("Failed to list directory!");
    success = false;
  }
```

- Liệt kê thư mục gốc để xác minh tập tin tạm thời đã được tạo

```cpp
  // Delete the file
  Serial.println("4.3: Deleting file 'temp.txt'");
  if (!sdCard.deleteFile("temp.txt")) {
    Serial.println("Failed to delete file!");
    success = false;
  }
```

- Kiểm tra việc xóa tập tin với hàm `deleteFile()`
- Xóa tập tin "temp.txt" khỏi thư mục gốc

```cpp
  // List directory to verify file deletion
  Serial.println("4.4: Listing directory to verify file deletion");
  if (!sdCard.listDirectory("/")) {
    Serial.println("Failed to list directory!");
    success = false;
  }
```

- Liệt kê thư mục gốc lần nữa để xác minh tập tin đã bị xóa

```cpp
  // Try to read the deleted file (should fail)
  Serial.println("4.5: Attempting to read deleted file (should fail)");
  memset(readBuffer, 0, sizeof(readBuffer));
  uint32_t bytesRead = sdCard.readFile("temp.txt", readBuffer, sizeof(readBuffer));

  if (bytesRead > 0) {
    Serial.println("File still exists after deletion!");
    success = false;
  } else {
    Serial.println("File successfully deleted.");
  }

  endTest(success);
}
```

- Thử đọc tập tin đã xóa (kỳ vọng thất bại)
- Nếu đọc thành công (bytesRead > 0), đánh dấu kiểm tra thất bại vì tập tin vẫn còn tồn tại
- Nếu đọc thất bại, xác nhận tập tin đã được xóa thành công
- Kết thúc bài kiểm tra và báo cáo kết quả

##### Kiểm tra 5: Xử lý đường dẫn

```cpp
// Test 5: Path handling - Root and absolute paths
void testPathHandling() {
  beginTest("Path Handling");
  bool success = true;

  // Test different path formats
  Serial.println("5.1: Testing root path '/'");
  if (!sdCard.listDirectory("/")) {
    Serial.println("Failed to list root directory with '/'!");
    success = false;
  }

  Serial.println("5.2: Testing empty path ''");
  if (!sdCard.listDirectory("")) {
    Serial.println("Failed to list root directory with empty path!");
    success = false;
  }

  Serial.println("5.3: Testing absolute path with trailing slash '/data/'");
  if (!sdCard.listDirectory("/data/")) {
    Serial.println("Failed to list directory with trailing slash!");
    success = false;
  }
```

- Định nghĩa hàm `testPathHandling()` để kiểm tra xử lý các định dạng đường dẫn khác nhau
- Kiểm tra liệt kê thư mục với các định dạng đường dẫn:
  - Đường dẫn gốc "/"
  - Đường dẫn rỗng ""
  - Đường dẫn tuyệt đối với dấu gạch chéo cuối "/data/"

```cpp
  Serial.println("5.4: Creating file with absolute path");
  if (!sdCard.createFileInPath("/absolute_path.txt", "File with absolute path.")) {
    Serial.println("Failed to create file with absolute path!");
    success = false;
  }
```

- Kiểm tra việc tạo tập tin với đường dẫn tuyệt đối
- Tạo tập tin "/absolute_path.txt" trong thư mục gốc

```cpp
  Serial.println("5.5: Reading file with absolute path");
  memset(readBuffer, 0, sizeof(readBuffer));
  uint32_t bytesRead = sdCard.readFile("/absolute_path.txt", readBuffer, sizeof(readBuffer));

  if (bytesRead > 0) {
    Serial.print("Read ");
    Serial.print(bytesRead);
    Serial.println(" bytes:");
    Serial.println(readBuffer);

    // Verify content
    if (strcmp(readBuffer, "File with absolute path.") != 0) {
      Serial.println("File content doesn't match!");
      success = false;
    }
  } else {
    Serial.println("Failed to read file with absolute path!");
    success = false;
  }

  endTest(success);
}
```

- Kiểm tra việc đọc tập tin với đường dẫn tuyệt đối
- Xác minh nội dung đọc được từ tập tin có khớp với nội dung đã ghi không
- Kết thúc bài kiểm tra và báo cáo kết quả

##### Hàm setup() và loop()

```cpp
void setup() {
  // Initialize Serial for debugging
  Serial.begin(115200);
  delay(3000);  // Wait for Serial to initialize

  Serial.println("ZBSdCard Complete API Test");
  Serial.println("==============================");
```

- Hàm `setup()` chạy một lần khi khởi động chương trình
- Khởi tạo giao tiếp Serial với tốc độ 115200 baud
- Chờ 3 giây để kết nối Serial ổn định
- In tiêu đề chương trình kiểm tra

```cpp
  // Initialize the SD card
  Serial.println("Initializing SD card...");
  if (!sdCard.begin(SD_CS_PIN)) {
    Serial.print("Initialization failed! Error: ");
    Serial.println(sdCard.getErrorMessage());
    while (1)
      ;  // Stop execution
  }
  Serial.println("SD card initialized successfully!\n");
```

- Khởi tạo thẻ SD với hàm `begin()` và chân CS đã định nghĩa
- Nếu khởi tạo thất bại, in thông báo lỗi cụ thể và dừng thực thi
- Nếu thành công, in thông báo khởi tạo thành công

```cpp
  // Run all tests
  testBasicFileOperations();
  testDirectoryOperations();
  testNestedDirectories();
  testFileDeletion();
  testPathHandling();
```

- Lần lượt chạy tất cả các bài kiểm tra đã định nghĩa

```cpp
  // Report overall test results
  Serial.println("\n==============================");
  Serial.print("OVERALL RESULTS: ");
  Serial.print(testsPassed);
  Serial.print("/");
  Serial.print(testsRun);
  Serial.print(" tests passed (");
  Serial.print((testsPassed * 100) / testsRun);
  Serial.println("%)");

  if (testsPassed == testsRun) {
    Serial.println("All tests PASSED! ✓");
  } else {
    Serial.print(testsRun - testsPassed);
    Serial.println(" tests FAILED! ✗");
  }
  Serial.println("==============================");
}
```

- Báo cáo kết quả tổng thể của tất cả các bài kiểm tra
- In số bài kiểm tra đã vượt qua, tổng số bài kiểm tra và tỷ lệ phần trăm
- Hiển thị thông báo tổng kết: tất cả đã vượt qua hoặc một số bài kiểm tra thất bại

```cpp
void loop() {
  // Nothing to do in the loop
  delay(1000);
}
```

- Hàm `loop()` chạy lặp đi lặp lại sau khi `setup()` hoàn thành
- Trong chương trình này, không có thao tác nào cần thực hiện trong vòng lặp
- Chỉ tạm dừng 1 giây để giảm tải CPU

?> Kết quả sau khi chạy chương trình sẽ được in ra Serial Monitor, cho phép bạn theo dõi từng bước kiểm tra và kết quả cuối cùng.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-all-test.png" alt="sdcard-all-test">
     <p><em>Kết quả khi toàn bộ chức năng được kiểm tra thành công</em></p>
</div>

Để kiểm tra xem các file và folder đã được tạo thành công hay chưa, bạn tháo thẻ nhớ ra khỏi module và gắn vào đầu đọc thẻ nhớ sau đó kết nối với máy tính. Bạn sẽ thấy các file và folder đã được tạo ra như trong hình bên dưới.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-file-folder.png" alt="sdcard-file">
     <p><em>File và folder được tạo ra trên thẻ nhớ</em></p>
</div>

#### 2. Code đọc và hiển thị file từ SD Card lên OLED SSD1306

Đoạn code sau đây là một ứng dụng hoàn chỉnh để duyệt và xem các tập tin trên thẻ SD sử dụng màn hình OLED SSD1306. Chương trình cung cấp giao diện người dùng thông qua nút bấm để điều hướng qua các thư mục, xem nội dung tập tin và cuộn văn bản khi nội dung quá dài.

##### Phần khai báo thư viện và cấu hình cơ bản

```cpp
#include <ZBPrint.h>           // Bao gồm thư viện ZBPrint
#include <SPI.h>               // Bao gồm thư viện SPI cho giao tiếp
#include "ZBSdCard.h"          // Bao gồm thư viện ZBSdCard để làm việc với thẻ SD
#include <Wire.h>              // Bao gồm thư viện Wire cho giao tiếp I2C
#include <Adafruit_GFX.h>      // Bao gồm thư viện đồ họa Adafruit GFX
#include <Adafruit_SSD1306.h>  // Bao gồm thư viện cho màn hình OLED SSD1306
```

- `ZBPrint.h`: Thư viện hỗ trợ in dữ liệu debug
- `SPI.h`: Thư viện chuẩn để giao tiếp SPI với thẻ SD
- `ZBSdCard.h`: Thư viện tùy chỉnh để quản lý thẻ SD và thao tác với tập tin/thư mục
- `Wire.h`: Thư viện giao tiếp I2C, cần thiết cho màn hình OLED
- `Adafruit_GFX.h`: Thư viện đồ họa cơ bản của Adafruit
- `Adafruit_SSD1306.h`: Thư viện điều khiển màn hình OLED SSD1306

```cpp
// Cấu hình OLED
#define SCREEN_WIDTH 128                                                   // Định nghĩa chiều rộng màn hình là 128 pixel
#define SCREEN_HEIGHT 64                                                   // Định nghĩa chiều cao màn hình là 64 pixel
#define OLED_RESET -1                                                      // Định nghĩa chân reset màn hình (-1 nghĩa là dùng chân reset mặc định)
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);  // Khởi tạo đối tượng màn hình
```

- Định nghĩa kích thước màn hình OLED: 128x64 pixel
- Sử dụng `-1` cho chân reset, nghĩa là sử dụng chân reset mặc định 
- Khởi tạo đối tượng `display` để điều khiển màn hình OLED qua giao tiếp I2C

```cpp
// Cấu hình thẻ SD
#define SD_CS_PIN 10  // Định nghĩa chân Chip Select cho thẻ SD là chân 10
ZBSdCard sdCard;      // Khởi tạo đối tượng thẻ SD
```

- Chân CS (Chip Select) kết nối đến thẻ SD được đặt là chân 10
- Khởi tạo đối tượng `sdCard` để quản lý thẻ SD

```cpp
// Chân nút bấm - Cần khớp với kết nối vật lý của bạn
#define BTN_UP 2      // Nút lên kết nối với chân 2
#define BTN_DOWN 3    // Nút xuống kết nối với chân 3
#define BTN_SELECT 4  // Nút chọn kết nối với chân 4
#define BTN_BACK 5    // Nút quay lại kết nối với chân 5
```

- Định nghĩa các chân kết nối với nút bấm để tạo giao diện điều khiển
- 4 nút chính: Lên, Xuống, Chọn và Quay lại

##### Các biến toàn cục và hằng số

```cpp
// Biến cho trình xem tập tin
#define MAX_FILES 32            // Số lượng tập tin tối đa có thể hiển thị
#define MAX_FILENAME_LENGTH 20  // Độ dài tối đa cho tên tập tin
#define MAX_PATH_LENGTH 100     // Độ dài tối đa cho đường dẫn
#define LINES_PER_SCREEN 6      // Số dòng hiển thị trên mỗi màn hình
#define MAX_FILE_BUFFER 1024    // Kích thước bộ đệm tối đa cho đọc tập tin
```

- Định nghĩa các hằng số giới hạn cho ứng dụng
- `MAX_FILES`: Số lượng tập tin/thư mục tối đa có thể xử lý cùng lúc
- `MAX_FILENAME_LENGTH`: Độ dài tối đa của tên tập tin (20 ký tự)
- `MAX_PATH_LENGTH`: Độ dài tối đa của đường dẫn (100 ký tự)
- `LINES_PER_SCREEN`: Số dòng có thể hiển thị trên màn hình (6 dòng)
- `MAX_FILE_BUFFER`: Kích thước bộ đệm để đọc nội dung tập tin (1024 byte)

```cpp
// Bộ đệm cho thao tác tập tin
char fileBuffer[MAX_FILE_BUFFER];  // Bộ đệm dùng để lưu nội dung tập tin

// Đường dẫn thư mục hiện tại
char currentPath[MAX_PATH_LENGTH] = "/";  // Bắt đầu ở thư mục gốc

// Mảng để lưu tên tập tin
char fileList[MAX_FILES][MAX_FILENAME_LENGTH];  // Mảng 2 chiều để lưu tên các tập tin và thư mục
bool isDirectory[MAX_FILES];                    // Cờ để đánh dấu nếu mục là thư mục
int fileCount = 0;                              // Số lượng tập tin tìm thấy
int currentFile = 0;                            // Vị trí tập tin được chọn hiện tại
int scrollPosition = 0;                         // Vị trí cuộn hiện tại
int viewMode = 0;                               // Chế độ xem: 0 = danh sách tập tin, 1 = nội dung tập tin
```

- Các biến toàn cục để lưu trữ trạng thái của ứng dụng:
  - `fileBuffer`: Bộ đệm để lưu nội dung tập tin khi đọc
  - `currentPath`: Đường dẫn đến thư mục hiện tại, bắt đầu từ thư mục gốc "/"
  - `fileList`: Mảng 2 chiều lưu tên các tập tin và thư mục trong thư mục hiện tại
  - `isDirectory`: Mảng song song để đánh dấu liệu mục tương ứng có phải là thư mục hay không
  - `fileCount`: Số lượng tập tin/thư mục được tìm thấy trong thư mục hiện tại
  - `currentFile`: Chỉ số của tập tin/thư mục đang được chọn
  - `scrollPosition`: Vị trí cuộn hiện tại (cho cả danh sách tập tin và nội dung tập tin)
  - `viewMode`: Chế độ xem (0: danh sách tập tin, 1: nội dung tập tin)

##### Hàm setup()

```cpp
void setup() {
  // Khởi tạo cổng nối tiếp cho debug
  Serial.begin(115200);  // Khởi tạo giao tiếp Serial với tốc độ 115200 baud
  delay(1000);           // Đợi 1 giây để Serial ổn định

  Serial.println("SD Card File Viewer");  // In thông báo khởi động
```

- Khởi tạo cổng Serial với tốc độ 115200 baud để debug
- Đợi 1 giây để kết nối Serial ổn định
- In thông báo khởi động chương trình

```cpp
  // Khởi tạo các nút bấm với điện trở kéo lên
  pinMode(BTN_UP, INPUT_PULLUP);      // Cấu hình nút lên với điện trở kéo lên
  pinMode(BTN_DOWN, INPUT_PULLUP);    // Cấu hình nút xuống với điện trở kéo lên
  pinMode(BTN_SELECT, INPUT_PULLUP);  // Cấu hình nút chọn với điện trở kéo lên
  pinMode(BTN_BACK, INPUT_PULLUP);    // Cấu hình nút quay lại với điện trở kéo lên
```

- Cấu hình các chân nút bấm là INPUT_PULLUP
- Chế độ này sử dụng điện trở kéo lên nội bộ, nút sẽ đọc là LOW khi được nhấn

```cpp
  // Khởi tạo màn hình OLED
  if (!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)) {  // Khởi tạo màn hình với địa chỉ I2C 0x3C
    Serial.println(F("SSD1306 allocation failed"));  // In thông báo lỗi nếu khởi tạo thất bại
    for (;;)
      ;  // Không tiếp tục, lặp vô hạn
  }
```

- Khởi tạo màn hình OLED với địa chỉ I2C 0x3C
- Nếu khởi tạo thất bại, in thông báo lỗi và dừng chương trình

```cpp
  // Khởi tạo thẻ SD
  display.clearDisplay();                      // Xóa màn hình
  display.setTextSize(1);                      // Đặt kích thước văn bản là 1
  display.setTextColor(SSD1306_WHITE);         // Đặt màu văn bản là trắng
  display.setCursor(0, 0);                     // Đặt con trỏ tại vị trí (0,0)
  display.println("Initializing SD Card...");  // Hiển thị thông báo đang khởi tạo thẻ SD
  display.display();                           // Cập nhật hiển thị
```

- Thiết lập màn hình OLED để hiển thị thông báo khởi tạo thẻ SD
- Đặt kích thước chữ, màu chữ, vị trí con trỏ và hiển thị thông báo

```cpp
  if (!sdCard.begin(SD_CS_PIN)) {               // Khởi tạo thẻ SD với chân CS đã định nghĩa
    display.clearDisplay();                     // Xóa màn hình
    display.setCursor(0, 0);                    // Đặt con trỏ về vị trí (0,0)
    display.println("SD Card init failed!");    // Hiển thị thông báo lỗi khởi tạo
    display.println("Error: ");                 // Chuẩn bị hiển thị thông báo lỗi
    display.println(sdCard.getErrorMessage());  // Hiển thị thông báo lỗi cụ thể
    display.display();                          // Cập nhật hiển thị
    for (;;)
      ;  // Không tiếp tục, lặp vô hạn
  }
```

- Khởi tạo thẻ SD với chân CS đã xác định
- Nếu khởi tạo thất bại, hiển thị thông báo lỗi trên màn hình OLED và dừng chương trình

```cpp
  sdCard.createFile("test2.txt", "This is test file #2 content.");                   // Tạo tập tin test2.txt với nội dung cho thử nghiệm
  sdCard.createFile("test3.txt", "This is test file #3 content.");                   // Tạo tập tin test3.txt với nội dung cho thử nghiệm
  sdCard.createDirectory("NEWDIR");                                                  // Tạo thư mục NEWDIR cho thử nghiệm
  sdCard.createFileInPath("/NEWDIR/test2.txt", "This is test file #2 in testdir.");  // Tạo tập tin trong thư mục NEWDIR
```

- Tạo các tập tin và thư mục mẫu để thử nghiệm ứng dụng
- Tạo hai tập tin trong thư mục gốc, một thư mục con và một tập tin trong thư mục con

```cpp
  // Hiển thị thông báo trong khi đang quét tập tin
  display.clearDisplay();                 // Xóa màn hình
  display.setCursor(0, 0);                // Đặt con trỏ tại vị trí (0,0)
  display.println("Reading SD Card...");  // Hiển thị thông báo đang đọc thẻ SD
  display.println("Please wait...");      // Hiển thị thông báo đợi
  display.display();                      // Cập nhật hiển thị

  // Quét tập tin trên thẻ SD (bắt đầu từ thư mục gốc)
  scanFiles("/");  // Quét các tập tin trong thư mục gốc

  // Hiển thị danh sách tập tin
  displayFileList();  // Hiển thị danh sách tập tin đã quét
}
```

- Hiển thị thông báo đang quét tập tin
- Gọi hàm `scanFiles("/")` để quét các tập tin trong thư mục gốc
- Hiển thị danh sách tập tin bằng hàm `displayFileList()`

##### Hàm loop()

```cpp
void loop() {
  // In trạng thái hiện tại của các nút bấm để debug
  Serial.print("Buttons: ");              // In tiêu đề thông tin nút bấm
  Serial.print(digitalRead(BTN_UP));      // In trạng thái nút lên
  Serial.print(digitalRead(BTN_DOWN));    // In trạng thái nút xuống
  Serial.print(digitalRead(BTN_SELECT));  // In trạng thái nút chọn
  Serial.println(digitalRead(BTN_BACK));  // In trạng thái nút quay lại

  // Xử lý các nút bấm
  handleButtons();  // Xử lý phản hồi cho các nút bấm
  delay(100);       // Đợi nhỏ 100ms để chống dội nút
}
```

- Hàm loop() chạy liên tục sau khi setup() hoàn thành
- In trạng thái của các nút bấm ra Serial để debug
- Gọi hàm `handleButtons()` để xử lý tương tác từ người dùng
- Đợi 100ms để giảm tần suất cập nhật và giúp chống dội nút

##### Hàm quét tập tin

```cpp
// Quét tập tin trong thư mục sử dụng phương thức mới
void scanFiles(const char* path) {
  fileCount = 0;       // Đặt lại số lượng tập tin về 0
  currentFile = 0;     // Đặt lại vị trí tập tin hiện tại về 0
  scrollPosition = 0;  // Đặt lại vị trí cuộn về 0

  // Lưu đường dẫn hiện tại
  strncpy(currentPath, path, MAX_PATH_LENGTH - 1);  // Sao chép đường dẫn đến biến currentPath
  currentPath[MAX_PATH_LENGTH - 1] = '\0';          // Đảm bảo kết thúc chuỗi
```

- Hàm `scanFiles()` quét tất cả các tập tin và thư mục trong đường dẫn được chỉ định
- Đặt lại các biến trạng thái: `fileCount`, `currentFile`, `scrollPosition`
- Cập nhật biến `currentPath` với đường dẫn mới, đảm bảo kết thúc chuỗi đúng cách

```cpp
  // Hiển thị thông báo đang quét
  display.clearDisplay();                    // Xóa màn hình
  display.setCursor(0, 0);                   // Đặt con trỏ tại vị trí (0,0)
  display.println("Scanning directory...");  // Hiển thị thông báo đang quét thư mục
  display.display();                         // Cập nhật hiển thị

  // Không còn thêm mục "lên thư mục" nữa
  // Nút quay lại sẽ xử lý chức năng này thay thế
```

- Hiển thị thông báo "Scanning directory..." trên màn hình OLED
- Chú thích giải thích rằng không còn thêm mục ".." vào danh sách mà sẽ sử dụng nút quay lại

```cpp
  // Sử dụng hàm mới để lấy các mục trong thư mục
  int foundEntries = 0;  // Biến đếm số mục tìm thấy
  if (!sdCard.listDirectoryEntries(path, &fileList[fileCount], &isDirectory[fileCount],
                                   MAX_FILES - fileCount, &foundEntries)) {  // Liệt kê mục trong thư mục
    display.setCursor(0, 24);                                                // Đặt con trỏ tại vị trí (0,24)
    display.println("Failed to list directory!");                            // Hiển thị thông báo lỗi
    display.display();                                                       // Cập nhật hiển thị
    delay(2000);                                                             // Đợi 2 giây để xem thông báo
    return;                                                                  // Thoát khỏi hàm
  }
```

- Sử dụng hàm `listDirectoryEntries()` từ thư viện ZBSdCard để liệt kê tất cả các mục trong thư mục
- Hàm này điền vào mảng `fileList` và `isDirectory` với thông tin về các tập tin và thư mục
- Nếu không thể liệt kê thư mục, hiển thị thông báo lỗi và thoát hàm

```cpp
  fileCount += foundEntries;  // Cập nhật tổng số tập tin tìm thấy

  Serial.print("Scanned directory: ");  // In thông tin về thư mục đã quét
  Serial.println(path);                 // In đường dẫn thư mục
  Serial.print("Found ");               // In thông tin về số lượng tìm thấy
  Serial.print(fileCount);              // In số lượng tập tin/thư mục
  Serial.println(" files/dirs.");       // In phần còn lại của thông báo
}
```

- Cập nhật biến `fileCount` với số lượng mục đã tìm thấy
- In thông tin về quá trình quét ra cổng Serial để debug

##### Hàm hiển thị danh sách tập tin

```cpp
// Hiển thị danh sách tập tin trên màn hình OLED
void displayFileList() {
  display.clearDisplay();   // Xóa màn hình
  display.setCursor(0, 0);  // Đặt con trỏ tại vị trí (0,0)

  // Luôn hiển thị "File Browser" làm tiêu đề
  display.println("File Browser");                             // Hiển thị tiêu đề trình duyệt tập tin
  display.drawLine(0, 9, SCREEN_WIDTH - 1, 9, SSD1306_WHITE);  // Vẽ đường phân cách sau tiêu đề
```

- Hàm `displayFileList()` hiển thị danh sách tập tin/thư mục trên màn hình OLED
- Bắt đầu bằng việc xóa màn hình và hiển thị tiêu đề "File Browser"
- Vẽ đường phân cách ngang bên dưới tiêu đề

```cpp
  int startIdx = max(0, min(scrollPosition, fileCount - LINES_PER_SCREEN));  // Tính vị trí bắt đầu hiển thị
  int endIdx = min(startIdx + LINES_PER_SCREEN, fileCount);                  // Tính vị trí kết thúc hiển thị

  if (fileCount == 0) {                  // Nếu không có tập tin nào
    display.setCursor(0, 16);            // Đặt con trỏ tại vị trí (0,16)
    display.println("No files found!");  // Hiển thị thông báo không tìm thấy tập tin
  } else {
```

- Tính toán phạm vi tập tin cần hiển thị dựa trên vị trí cuộn và số lượng dòng trên màn hình
- Nếu không có tập tin nào, hiển thị thông báo "No files found!"

```cpp
    for (int i = startIdx; i < endIdx; i++) {  // Lặp qua các tập tin trong phạm vi hiển thị
      // Làm nổi bật tập tin được chọn
      if (i == currentFile) {                                                          // Nếu đây là tập tin hiện tại
        display.fillRect(0, 11 + (i - startIdx) * 9, SCREEN_WIDTH, 9, SSD1306_WHITE);  // Vẽ hình chữ nhật nền trắng
        display.setTextColor(SSD1306_BLACK);                                           // Đặt màu chữ là đen (ngược với nền)
      } else {
        display.setTextColor(SSD1306_WHITE);  // Đặt màu chữ là trắng
      }

      display.setCursor(2, 12 + (i - startIdx) * 9);  // Đặt vị trí con trỏ
```

- Vòng lặp qua các tập tin trong phạm vi hiển thị
- Làm nổi bật tập tin được chọn bằng cách vẽ hình chữ nhật nền trắng và sử dụng chữ màu đen
- Tập tin không được chọn sẽ hiển thị chữ màu trắng trên nền đen

```cpp
      // Hiển thị chỉ báo thư mục cho các thư mục
      if (isDirectory[i]) {          // Nếu đây là thư mục
        display.print("[");          // In dấu [ trước tên thư mục
        display.print(fileList[i]);  // In tên thư mục
        display.print("]");          // In dấu ] sau tên thư mục
      }
      // Tập tin thông thường
      else {
        display.println(fileList[i]);  // In tên tập tin
      }

      display.setTextColor(SSD1306_WHITE);  // Đặt lại màu chữ là trắng
    }
```

- Hiển thị tên tập tin/thư mục với định dạng khác nhau
- Thư mục được hiển thị với dấu ngoặc vuông: `[tên_thư_mục]`
- Tập tin hiển thị bình thường: `tên_tập_tin`

```cpp
    // Vẽ thanh cuộn nếu cần
    if (fileCount > LINES_PER_SCREEN) {                                                             // Nếu có nhiều tập tin hơn số dòng hiển thị
      int barHeight = max(5, (LINES_PER_SCREEN * SCREEN_HEIGHT) / fileCount);                       // Tính chiều cao thanh cuộn
      int barPosition = (startIdx * (SCREEN_HEIGHT - barHeight)) / (fileCount - LINES_PER_SCREEN);  // Tính vị trí thanh cuộn
      display.drawRect(SCREEN_WIDTH - 3, 10, 3, SCREEN_HEIGHT - 10, SSD1306_WHITE);                 // Vẽ viền thanh cuộn
      display.fillRect(SCREEN_WIDTH - 3, 10 + barPosition, 3, barHeight, SSD1306_WHITE);            // Vẽ thanh cuộn
    }
  }

  display.display();  // Cập nhật hiển thị
}
```

- Thêm thanh cuộn bên phải nếu số lượng tập tin vượt quá số dòng hiển thị
- Kích thước và vị trí thanh cuộn được tính toán dựa trên tỷ lệ các tập tin đang được hiển thị
- Cuối cùng, gọi `display.display()` để cập nhật màn hình OLED

##### Hàm hiển thị nội dung tập tin

```cpp
// Hiển thị nội dung tập tin trên màn hình OLED
void displayFileContent(const char* filename) {
  display.clearDisplay();  // Xóa màn hình

  // Tạo đường dẫn đầy đủ đến tập tin
  char fullPath[MAX_PATH_LENGTH + MAX_FILENAME_LENGTH];  // Khai báo biến lưu đường dẫn đầy đủ
  constructFullPath(fullPath, filename);                 // Tạo đường dẫn đầy đủ
```

- Hàm `displayFileContent()` hiển thị nội dung của một tập tin trên màn hình OLED
- Tạo đường dẫn đầy đủ đến tập tin bằng cách kết hợp thư mục hiện tại và tên tập tin

```cpp
  // Hiển thị tên tập tin ở trên cùng
  display.setCursor(0, 0);  // Đặt con trỏ tại vị trí (0,0)
  // Hiển thị chỉ tên tập tin, không phải đường dẫn đầy đủ
  display.println(filename);                                   // In tên tập tin
  display.drawLine(0, 9, SCREEN_WIDTH - 1, 9, SSD1306_WHITE);  // Vẽ đường phân cách sau tiêu đề
```

- Hiển thị tên tập tin ở phần đầu màn hình
- Vẽ đường phân cách ngang bên dưới tên tập tin

```cpp
  // Đọc nội dung tập tin
  memset(fileBuffer, 0, sizeof(fileBuffer));                                           // Xóa bộ đệm
  uint32_t bytesRead = sdCard.readFile(fullPath, fileBuffer, sizeof(fileBuffer) - 1);  // Đọc nội dung tập tin

  if (bytesRead == 0) {                     // Nếu không đọc được nội dung
    display.setCursor(0, 16);               // Đặt con trỏ tại vị trí (0,16)
    display.println("Error reading file");  // Hiển thị thông báo lỗi đọc tập tin
    display.println("or file is empty.");   // Hoặc tập tin rỗng
  } else {
```

- Đọc nội dung tập tin vào bộ đệm `fileBuffer`
- Nếu không đọc được nội dung (bytesRead = 0), hiển thị thông báo lỗi

```cpp
    // Hiển thị nội dung với ngắt dòng
    int lineHeight = 8;                              // Chiều cao mỗi dòng (pixel)
    int x = 0, y = 11;                               // Vị trí bắt đầu hiển thị
    int contentLength = strlen(fileBuffer);          // Độ dài nội dung
    int charWidth = 6;                               // Chiều rộng xấp xỉ của một ký tự
    int maxCharsPerLine = SCREEN_WIDTH / charWidth;  // Số ký tự tối đa trên một dòng

    // Áp dụng cuộn cho chế độ xem nội dung
    int startPos = min(scrollPosition * maxCharsPerLine, contentLength);  // Tính vị trí bắt đầu cuộn
```

- Thiết lập các tham số để hiển thị nội dung với ngắt dòng
- Tính toán vị trí bắt đầu dựa trên vị trí cuộn hiện tại

```cpp
    // Hiển thị nội dung từ vị trí cuộn
    int pos = startPos;                                 // Vị trí hiện tại trong nội dung
    while (pos < contentLength && y < SCREEN_HEIGHT) {  // Lặp qua các ký tự trong nội dung
      if (fileBuffer[pos] == '\n') {                    // Nếu gặp ký tự xuống dòng
        // Xử lý ký tự xuống dòng
        x = 0;                               // Đặt lại vị trí x về đầu dòng
        y += lineHeight;                     // Tăng vị trí y lên một dòng
      } else if (fileBuffer[pos] == '\r') {  // Nếu gặp ký tự trả về đầu dòng
        // Bỏ qua ký tự trả về đầu dòng
      } else {
        // Hiển thị ký tự
        display.setCursor(x, y);         // Đặt con trỏ tại vị trí hiện tại
        display.write(fileBuffer[pos]);  // In ký tự
        x += charWidth;                  // Tăng vị trí x cho ký tự tiếp theo

        // Ngắt dòng nếu cần
        if (x >= SCREEN_WIDTH) {  // Nếu vượt quá chiều rộng màn hình
          x = 0;                  // Đặt lại vị trí x về đầu dòng
          y += lineHeight;        // Tăng vị trí y lên một dòng
        }
      }

      pos++;  // Tiến đến ký tự tiếp theo

      // Nếu đã lấp đầy màn hình, dừng lại
      if (y > SCREEN_HEIGHT - lineHeight)  // Nếu vượt quá chiều cao màn hình
        break;                             // Thoát khỏi vòng lặp
    }
```

- Vòng lặp chính để hiển thị nội dung tập tin từ vị trí cuộn
- Xử lý đặc biệt cho ký tự xuống dòng ('\n') và ký tự trở về đầu dòng ('\r')
- Tự động ngắt dòng khi nội dung vượt quá chiều rộng màn hình
- Dừng hiển thị khi đã lấp đầy màn hình hoặc hết nội dung

```cpp
    // Vẽ thanh cuộn nếu cần
    int totalLines = (contentLength + maxCharsPerLine - 1) / maxCharsPerLine;                     // Tính tổng số dòng
    if (totalLines > (SCREEN_HEIGHT - 11) / lineHeight) {                                         // Nếu có nhiều dòng hơn có thể hiển thị
      int visibleLines = (SCREEN_HEIGHT - 11) / lineHeight;                                       // Số dòng có thể hiển thị
      int barHeight = max(5, (visibleLines * (SCREEN_HEIGHT - 11)) / totalLines);                 // Chiều cao thanh cuộn
      int maxScrollPosition = totalLines - visibleLines;                                          // Vị trí cuộn tối đa
      int barPosition = (scrollPosition * (SCREEN_HEIGHT - 11 - barHeight)) / maxScrollPosition;  // Vị trí thanh cuộn
      display.drawRect(SCREEN_WIDTH - 3, 10, 3, SCREEN_HEIGHT - 10, SSD1306_WHITE);               // Vẽ viền thanh cuộn
      display.fillRect(SCREEN_WIDTH - 3, 10 + barPosition, 3, barHeight, SSD1306_WHITE);          // Vẽ thanh cuộn
    }
  }

  display.display();  // Cập nhật hiển thị
}
```

- Tính toán và hiển thị thanh cuộn nếu nội dung dài hơn có thể hiển thị trên màn hình
- Kích thước và vị trí thanh cuộn được tính toán tương tự như trong danh sách tập tin
- Cuối cùng, cập nhật màn hình OLED

##### Hàm xử lý nút bấm

```cpp
// Xử lý các nút bấm
void handleButtons() {
  // Nút UP (lên)
  if (digitalRead(BTN_UP) == LOW) {         // Nếu nút UP được nhấn (mức thấp)
    delay(50);                              // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_UP) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("UP button pressed");  // In thông báo nút UP được nhấn
```

- Hàm `handleButtons()` xử lý tất cả các tương tác từ nút bấm
- Kiểm tra nút UP: Nếu được nhấn (LOW), đợi 50ms để chống dội và kiểm tra lại

```cpp
      if (viewMode == 0) {                  // Nếu đang ở chế độ danh sách tập tin
        // Trong chế độ danh sách tập tin
        if (currentFile > 0) {               // Nếu không phải tập tin đầu tiên
          currentFile--;                     // Di chuyển lên một tập tin
          if (currentFile < scrollPosition)  // Nếu cần cuộn lên
            scrollPosition = currentFile;    // Cập nhật vị trí cuộn
          displayFileList();                 // Cập nhật hiển thị danh sách
        }
      } else {
        // Trong chế độ xem tập tin
        if (scrollPosition > 0) {                     // Nếu không phải đang ở đầu tập tin
          scrollPosition--;                           // Cuộn lên một dòng
          displayFileContent(fileList[currentFile]);  // Cập nhật hiển thị nội dung
        }
      }
```

- Xử lý nút UP khác nhau tùy theo chế độ xem hiện tại:
  - Chế độ danh sách (viewMode = 0): Di chuyển lên một tập tin trong danh sách
  - Chế độ xem tập tin (viewMode = 1): Cuộn nội dung lên một dòng

```cpp
      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_UP) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                          // Đợi 10ms
      }
    }
  }
```

- Đợi cho đến khi nút được nhả ra trước khi tiếp tục

```cpp
  // Nút DOWN (xuống)
  if (digitalRead(BTN_DOWN) == LOW) {         // Nếu nút DOWN được nhấn (mức thấp)
    delay(50);                                // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_DOWN) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("DOWN button pressed");  // In thông báo nút DOWN được nhấn
      if (viewMode == 0) {                    // Nếu đang ở chế độ danh sách tập tin
        // Trong chế độ danh sách tập tin
        if (currentFile < fileCount - 1) {                        // Nếu không phải tập tin cuối cùng
          currentFile++;                                          // Di chuyển xuống một tập tin
          if (currentFile >= scrollPosition + LINES_PER_SCREEN)   // Nếu cần cuộn xuống
            scrollPosition = currentFile - LINES_PER_SCREEN + 1;  // Cập nhật vị trí cuộn
          displayFileList();                                      // Cập nhật hiển thị danh sách
        }
      } else {
        // Trong chế độ xem tập tin
        scrollPosition++;                           // Cuộn xuống một dòng
        displayFileContent(fileList[currentFile]);  // Cập nhật hiển thị nội dung
      }

      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_DOWN) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                            // Đợi 10ms
      }
    }
  }
```

- Xử lý nút DOWN tương tự như nút UP, nhưng di chuyển xuống thay vì lên
- Cập nhật vị trí cuộn khi cần thiết để đảm bảo tập tin được chọn luôn hiển thị

```cpp
  // Nút SELECT (chọn)
  if (digitalRead(BTN_SELECT) == LOW) {         // Nếu nút SELECT được nhấn (mức thấp)
    delay(50);                                  // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_SELECT) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("SELECT button pressed");  // In thông báo nút SELECT được nhấn

      if (viewMode == 0 && fileCount > 0) {  // Nếu đang ở chế độ danh sách và có tập tin
        // Nếu mục được chọn là thư mục
        if (isDirectory[currentFile]) {                    // Nếu đây là thư mục
          if (strcmp(fileList[currentFile], "..") == 0) {  // Nếu là mục ".." (lên một cấp)
            // Đi lên một thư mục
            navigateUp();  // Điều hướng lên thư mục cha
          } else {
            // Điều hướng vào thư mục được chọn
            navigateToFolder(fileList[currentFile]);  // Vào thư mục được chọn
          }
        } else {
          // Chuyển sang chế độ xem tập tin cho tập tin
          viewMode = 1;                               // Đặt chế độ xem là xem nội dung tập tin
          scrollPosition = 0;                         // Đặt lại vị trí cuộn về đầu
          displayFileContent(fileList[currentFile]);  // Hiển thị nội dung tập tin
        }
      }
```

- Xử lý nút SELECT khi được nhấn:
  - Nếu đang ở chế độ danh sách (viewMode = 0):
    - Nếu mục được chọn là thư mục, di chuyển vào thư mục đó
    - Nếu mục được chọn là tập tin, chuyển sang chế độ xem tập tin và hiển thị nội dung

```cpp
      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_SELECT) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                              // Đợi 10ms
      }
    }
  }
```

- Đợi cho đến khi nút SELECT được nhả ra

```cpp
  // Nút BACK (quay lại)
  if (digitalRead(BTN_BACK) == LOW) {         // Nếu nút BACK được nhấn (mức thấp)
    delay(50);                                // Đợi 50ms để chống dội nút
    if (digitalRead(BTN_BACK) == LOW) {       // Kiểm tra lại nếu nút vẫn được nhấn
      Serial.println("BACK button pressed");  // In thông báo nút BACK được nhấn
      if (viewMode == 1) {                    // Nếu đang ở chế độ xem tập tin
        // Quay lại chế độ danh sách tập tin từ chế độ xem tập tin
        viewMode = 0;                                                 // Đặt chế độ xem là danh sách tập tin
        scrollPosition = max(0, currentFile - LINES_PER_SCREEN + 1);  // Cập nhật vị trí cuộn
        displayFileList();                                            // Hiển thị danh sách tập tin
      } else if (viewMode == 0 && strcmp(currentPath, "/") != 0) {    // Nếu đang ở chế độ danh sách và không phải thư mục gốc
        // Đi lên một thư mục từ trình duyệt tập tin (nếu không ở thư mục gốc)
        navigateUp();  // Điều hướng lên thư mục cha
      }

      // Đợi cho đến khi nút được nhả ra
      while (digitalRead(BTN_BACK) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                            // Đợi 10ms
      }
    }
  }
}
```

- Xử lý nút BACK khi được nhấn:
  - Nếu đang ở chế độ xem tập tin (viewMode = 1), quay lại chế độ danh sách tập tin
  - Nếu đang ở chế độ danh sách và không phải thư mục gốc, di chuyển lên thư mục cha

##### Các hàm hỗ trợ điều hướng

```cpp
// Điều hướng đến thư mục con
void navigateToFolder(const char* folderName) {
  char newPath[MAX_PATH_LENGTH];  // Khai báo biến cho đường dẫn mới

  // Tạo đường dẫn mới
  if (strcmp(currentPath, "/") == 0) {  // Nếu đang ở thư mục gốc
    // Chúng ta đang ở thư mục gốc
    snprintf(newPath, MAX_PATH_LENGTH, "/%s", folderName);  // Tạo đường dẫn "/tên_thư_mục"
  } else {
    // Chúng ta đang ở thư mục con
    snprintf(newPath, MAX_PATH_LENGTH, "%s/%s", currentPath, folderName);  // Tạo đường dẫn "đường_dẫn_hiện_tại/tên_thư_mục"
  }

  // Quét thư mục mới
  scanFiles(newPath);  // Quét tập tin trong thư mục mới

  // Hiển thị danh sách tập tin mới
  displayFileList();  // Hiển thị danh sách tập tin
}
```

- Hàm `navigateToFolder()` di chuyển vào một thư mục con
- Tạo đường dẫn mới từ đường dẫn hiện tại và tên thư mục
- Quét tập tin trong thư mục mới và hiển thị danh sách

```cpp
// Điều hướng lên thư mục cha
void navigateUp() {
  // Nếu đã ở thư mục gốc, không làm gì cả
  if (strcmp(currentPath, "/") == 0) {  // Nếu đang ở thư mục gốc
    return;                             // Thoát khỏi hàm
  }

  char newPath[MAX_PATH_LENGTH];  // Khai báo biến cho đường dẫn mới
  strcpy(newPath, currentPath);   // Sao chép đường dẫn hiện tại

  // Tìm dấu gạch chéo cuối cùng trong đường dẫn
  char* lastSlash = strrchr(newPath, '/');  // Tìm vị trí của dấu / cuối cùng

  if (lastSlash == newPath) {  // Nếu dấu / cuối cùng là ký tự đầu tiên
    // Chúng ta đang ở thư mục cấp cao nhất, quay lại thư mục gốc
    strcpy(newPath, "/");  // Đặt đường dẫn là "/"
  } else {
    // Cắt đường dẫn tại dấu gạch chéo cuối cùng
    *lastSlash = '\0';  // Kết thúc chuỗi tại vị trí dấu / cuối cùng
  }

  // Quét thư mục cha
  scanFiles(newPath);  // Quét tập tin trong thư mục cha

  // Hiển thị danh sách tập tin đã cập nhật
  displayFileList();  // Hiển thị danh sách tập tin
}
```

- Hàm `navigateUp()` di chuyển lên thư mục cha
- Nếu đã ở thư mục gốc, không làm gì cả
- Tìm dấu "/" cuối cùng trong đường dẫn hiện tại và cắt chuỗi tại đó
- Trường hợp đặc biệt: nếu đang ở thư mục cấp cao nhất (ngay dưới thư mục gốc), quay lại thư mục gốc

```cpp
// Tạo đường dẫn đầy đủ từ thư mục hiện tại và tên tập tin
void constructFullPath(char* fullPath, const char* filename) {
  if (strcmp(currentPath, "/") == 0) {  // Nếu thư mục hiện tại là thư mục gốc
    // Thư mục gốc
    sprintf(fullPath, "/%s", filename);  // Tạo đường dẫn "/tên_tập_tin"
  } else {
    // Thư mục con
    sprintf(fullPath, "%s/%s", currentPath, filename);  // Tạo đường dẫn "đường_dẫn_hiện_tại/tên_tập_tin"
  }
}
```

- Hàm `constructFullPath()` tạo đường dẫn đầy đủ từ đường dẫn hiện tại và tên tập tin
- Xử lý trường hợp đặc biệt cho thư mục gốc để tránh dấu "/" trùng lặp

```cpp
// Đọc nút bấm với chống dội
bool readButton(int pin) {
  static unsigned long lastDebounceTime = 0;  // Thời điểm dội nút cuối cùng
  static int lastButtonState = HIGH;          // Trạng thái nút trước đó

  // Trạng thái nút hiện tại
  int buttonState = digitalRead(pin);  // Đọc trạng thái nút

  // Kiểm tra nếu trạng thái nút đã thay đổi
  if (buttonState != lastButtonState) {  // Nếu trạng thái khác với lần trước
    lastDebounceTime = millis();         // Cập nhật thời điểm thay đổi
  }

  lastButtonState = buttonState;  // Cập nhật trạng thái nút trước đó

  // Kiểm tra nếu đã đủ thời gian kể từ lần thay đổi cuối cùng
  if ((millis() - lastDebounceTime) > 50) {  // Nếu đã qua 50ms
    if (buttonState == LOW) {                // Nếu nút đang được nhấn
      // Nút được nhấn, đợi cho đến khi nhả ra
      while (digitalRead(pin) == LOW) {  // Trong khi nút vẫn được nhấn
        delay(10);                       // Đợi 10ms
      }
      return true;  // Trả về true để xác nhận nút được nhấn
    }
  }

  return false;  // Trả về false nếu nút không được nhấn
}
```

- Hàm `readButton()` đọc trạng thái nút bấm với chống dội
- Sử dụng kỹ thuật debounce để loại bỏ nhiễu khi nút bấm được nhấn/nhả
- Đợi cho đến khi nút được nhả ra trước khi trả về true
- Hàm này được định nghĩa nhưng không được sử dụng trực tiếp trong code hiện tại

## Kết quả

?> Sau khi chạy chương trình, bạn sẽ thấy màn hình OLED hiển thị các tập tin, bạn có thể cuộn lên/xuống để xem các tập tin khác nhau hoặc chọn tập tin để xem nội dung bên trong. Sau khi chọn tập tin, bạn có thể nhấn nút để quay lại danh sách tập tin.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/sdcard/sdcard-result.gif" alt="sdcard-result">
    <p><em>Kết quả được hiển thị trên OLED SSD1306</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn bạn cách sử dụng modules SD Card và OLED SSD1306 để tạo một trình duyệt tập tin đơn giản trên Board Zerobase 2.

Để phát triển thêm từ bài học này, bạn có thể thực hiện các ý tưởng sau:

- Thêm chức năng tìm kiếm tập tin trong thư mục.
- Thêm chức năng xóa tập tin hoặc thư mục.
- Thêm chức năng sao chép hoặc di chuyển tập tin giữa các thư mục.
- Tạo giao diện người dùng đẹp hơn với các biểu tượng hoặc hình ảnh.
- Thêm chức năng tạo tập tin mới hoặc thư mục mới.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)

