<br>
<br>
<br>

# Hướng dẫn sử dụng ZeroBase 2W

## Tổng quan

![zerobase2](https://cdn.chipstack.vn/default/zerobase2-overview.png "zerobase2]")

Zerobase 2W là một board phát triển dựa trên vi điều khiển CH32. Board hỗ trợ nhiều giao tiếp như I2C, SPI, UART, GPIO, ADC, PWM, và nhiều chức năng khác.

Ngoài ra board có tích hợp chip Wi-Fi ESP8285, cho phép kết nối không dây và giao tiếp với các thiết bị IoT khác.

## Sơ đồ chân

Một số lưu ý khi sử dụng Zerobase 2W:

!> Mức logic: 3.3V.

!> Trừ các chân D6, A6, A7 thì Toàn bộ chân GPIO đều hỗ trợ PWM.

!> Toàn bộ chân GPIO đều hỗ trợ ngắt ngoại vi.

!> Toàn bộ chân GPIO đều hỗ trợ INPUT/OUTPUT.

Bạn có tham khảo thêm sơ đồ chân trong [bài viết này](https://zerobase.chipstack.vn/#/vi/zerobase-2w/pinout).

![chan-cap-nguon-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/chan-cap-nguon-zerobase2.png "chan-cap-nguon-zerobase2.png]")
- **3.3V**: Chân này có thể nhận nguồn 3.3VDC (input) hoặc cấp nguồn cho thiết bị khác (output).
- **USB**: Zerobase 2W hỗ trợ cấp nguồn qua cổng USB.

## Nút nhấn
<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/quickstart/boot-zerobase2.png" alt="chan-boot-zerobase2">
    <p><strong>BOOT</strong>: Chân này dùng để đưa vi điều khiển vào chế độ nạp code.
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/quickstart/reset-zerobase2.png" alt="chan-reset-zerobase2">
    <p><strong>RESET</strong>: Chân này dùng để khởi động lại vi điều khiển.</p>
</div>


## Chế độ hoạt động

| Chế độ hoạt động |  Cách chuyển chế độ |
|------------------|------------------|
| Chế độ nạp code      | Nhấn giữ nút Boot và nhấn nút Reset, sau đó thả nút Reset ra, cuối cùng thả nút Boot ra. |
| Chế độ chạy code      | Khi đang ở chế độ nạp code, nhấn nút Reset để chuyển sang chế độ chạy code. |

## Hàn chân

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="han-chan-zerobase2">
    <p>Trước khi hàn chân</p>
</div>
<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/quickstart/sau-khi-han-zerobase2.jpg" alt="han-chan-zerobase2">
    <p>Sau khi hàn chân</p>
</div>


## Cài đặt Arduino IDE và board Zerobase 2W
Để có thể lập trình cho Zerobase 2W, đầu tiên bạn cần tải và cài đặt Arduino IDE phiên bản mới nhất theo đường link sau: [Arduino IDE](https://www.arduino.cc/en/software).

Sau khi cài đặt xong, bạn cần cài đặt board Zerobase 2W trên Arduino IDE theo các bước sau:

Mở **Arduino IDE**. Sau đó vào **File > Preferences**.

![preferences](https://cdn.chipstack.vn/zerobase/quickstart/preferences.png "preferences]")

Một hộp thoại sẽ xuất hiện giống như hình dưới đây.

![preferences](https://cdn.chipstack.vn/zerobase/quickstart/preferences2.png "preferences]")

Trong mục **Additional Board Manager URLs**, thêm đường dẫn sau:

 ```link
https://raw.githubusercontent.com/ChipstackLTD/zerobase-board-manager/refs/heads/master/zerobase.json
 ```

Sau khi dán đường dẫn, nhấn **OK** để lưu lại.

![preferences](https://cdn.chipstack.vn/zerobase/quickstart/preferences3.png "preferences]")

Sau khi nhấn **OK**, ở góc dưới cùng bên trái sẽ hiển thị quá trình tải board Zerobase, chờ cho quá trình tải hoàn tất.

![download-index](https://cdn.chipstack.vn/zerobase/quickstart/download-index-zerobase.png "download-index]")

Khi quá trình tải hoàn tất, bạn vào **Tools > Board > Boards Manager**.

![boards-manager](https://cdn.chipstack.vn/zerobase/quickstart/boards-manager.png "boards-manager]")

Tìm kiếm tên board: `ZB`, chọn version mới nhất và nhấn **Install**.

![install-board](https://cdn.chipstack.vn/zerobase/quickstart/install-board-zb-boards-manager.png "install-board]")

Sau khi nhấn **Install**, quá trình cài đặt board Zerobase sẽ bắt đầu. Chờ cho quá trình cài đặt hoàn tất. Sau khi cài đặt hoàn tất, kết quả sẽ hiển thị như hình dưới đây.

![install-success](https://cdn.chipstack.vn/zerobase/quickstart/install-success.png "install-success]")

Thoát khỏi Arduino IDE và mở lại để sử dụng board Zerobase.

## Nạp Code và nháy LED

Để chọn board Zerobase 2W, bạn vào **Tools > Board**, chọn Zerobase 2W.

![select-board](https://cdn.chipstack.vn/zerobase2w/download-firmware/select-board-zerobase-2w.png "select-board]")

Bạn có thể sử dụng code mẫu để nháy LED trên Zerobase 2W bằng cách vào **File > Examples > DigitalIO > Blink**.

![blink-zerobase](https://cdn.chipstack.vn/zerobase/quickstart/blink-zerobase.png "blink-zerobase]")

Arduino IDE sẽ mở ra một cửa sổ mới chứa code mẫu nháy LED.

![blink-example](https://cdn.chipstack.vn/zerobase2/quickstart/blink-example.png "blink-example]")

Nếu không thể mở code mẫu, bạn có thể sử dụng đoạn code sau:

```cpp
void setup() {
  // Khởi tạo chân LED_BUILTIN làm đầu ra (OUTPUT)
  pinMode(LED_BUILTIN, OUTPUT);
}

// Hàm loop chạy lặp lại liên tục
void loop() {
  digitalWrite(LED_BUILTIN, HIGH);  // Bật LED (HIGH tương ứng với mức điện áp cao)
  delay(1000);                      // Dừng 1 giây (1000ms)
  
  digitalWrite(LED_BUILTIN, LOW);   // Tắt LED (LOW tương ứng với mức điện áp thấp)
  delay(1000);                      // Dừng 1 giây (1000ms)
}
```

**Nếu ban đầu nạp code cho Zerobase 2W**, bạn nhấn giữ nút **BOOT** sau đó cắm USB vào máy tính. Khi đã cắm USB vào máy tính, bạn thả nút **BOOT** ra. Board Zerobase 2W sẽ tự động vào chế độ nạp code.

<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/quickstart/zb2-boot.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Nếu ban đầu nạp code</em></p>
</div>

Những lần nạp code tiếp theo, bạn chỉ cần thực hiện như cách trên hoặc bạn cắm USB vào máy tính, nhấn giữ nút **BOOT**. Sau đó nhấn nút **RESET** rồi thả nút **RESET** này ra. Cuối cùng, thả nút **BOOT**. Board Zerobase 2W sẽ vào chế độ nạp code.

<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/quickstart/zb2-boot-2.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Những lần nạp code tiếp theo</em></p>
</div>

!> Lưu ý: Không cần chọn cổng COM cho board Zerobase 2W khi nạp code. Board Zerobase 2W sẽ tự động nhận cổng COM khi được chuyển sang chế độ nạp code.

Bạn nhấn **Upload** hoặc nhấn **Ctrl+U** để nạp code.

![upload-code-z2](https://cdn.chipstack.vn/zerobase2w/download-firmware/upload-code-z2.png "upload-code-z2]")

Nếu upload code xuất hiện lỗi như hình dưới đây:

![upload-unsuccess-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-unsuccess-zerobase2.png "upload-unsuccess-zerobase2]")

Bạn cần cài đặt driver cho board Zerobase 2W. Bạn có thể tải driver tại [đây](https://cdn.chipstack.vn/reference/zadig-2.9.exe).

Chạy file `zadig-2.9.exe` vừa tải về. Đưa board vào chế độ nạp code bằng 1 trong 2 cách như trên. Sau đó chọn **Options > List All Devices**.

![list-all-devices](https://cdn.chipstack.vn/zerobase2/quickstart/list-all-devices.png "list-all-devices]")

Chọn **USB Module**.

![usb-module](https://cdn.chipstack.vn/zerobase2/quickstart/usb-module.png "usb-module]")

Nhấn mũi tên lên hoặc xuống để chọn driver **WinUSB**. và nhấn **Replace Driver**.

![win-usb](https://cdn.chipstack.vn/zerobase2/quickstart/win-usb.png "win-usb]")

Đợi đến khi driver được cài đặt thành công, bạn sẽ thấy dòng thông báo như hình dưới đây.

![driver-installed-success](https://cdn.chipstack.vn/zerobase2/quickstart/driver-installed-success.png "driver-installed-success]")

Bạn nhấn **Upload** hoặc nhấn **Ctrl+U** để nạp code.

![upload-code-z2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-code-z2.png "upload-code-z2]")

Nếu nạp code thành công, bạn sẽ thấy dòng thông báo như hình dưới đây.

![upload-success-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-success-zerobase2.png "upload-success-zerobase2]")

Kết quả cuối cùng, bạn sẽ thấy LED trên board Zerobase 2W nháy theo chu kỳ 1 giây.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/quickstart/led-blink-zerobase2.gif" alt="led-blink-zerobase2">
    <p><em>LED nháy theo chu kỳ 1 giây</em></p>
</div>

## Cách cập nhật firmware cho chip Wi-Fi ESP8285

Để cập nhật firmware cho chip Wi-Fi ESP8285 trên Zerobase 2W, bạn cần tải về file ZIP chứa các công cụ cần thiết [tại đây](https://cdn.chipstack.vn/zerobase2w/download-firmware/esptool_zb2w.zip).

Trong file ZIP bao gồm:

- **esptool_zb2w**: Đây là tool dùng để nạp firmware cho chip ESP8285.

- **esp8285_merger**: Đây là tool dùng để hợp nhất các file firmware thành một file duy nhất.

- **AT2_esp8266_factory_param_tx1rx3**: Đây là file bin chứa chân ESP8285 sử dụng trên Zerobase 2W.

- **usb-uart-bridge**: Đây là file code Arduino dùng để giao tiếp với chip ESP8285.

Tiếp theo, bạn cần tải về file firmware mới nhất cho chip ESP8285 theo các bước sau:

1. Truy cập vào trang [esp-at](https://github.com/espressif/esp-at).

![esp-at](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-github.png "esp-at]")

2. Bạn chọn vào phần Actions, sau đó nhấn vào Branch và tìm `ESP8266` rồi chọn bản relase mới nhất, ví dụ ở đây là `release/v2.3.0.0_esp8266`.

![esp-at-release](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-actions.png "esp-at-release]")

3. Tiếp theo, bạn chọn phần mới nhất trong phần workflow.

![esp-at-merge](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-merge.png "esp-at-merge]")

4. Bạn kéo xuống dưới cùng và tìm phần `Artifacts`, tìm `esp8285-1MB-at`, nhấn vào biểu tượng tải xuống để tải về file ZIP chứa firmware mới nhất.

![esp-at-download](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-download.png "esp-at-download]")

!> Nếu không thấy biểu tượng tải xuống, bạn có thể tải xuống trực tiếp [tại đây](https://cdn.chipstack.vn/zerobase2w/download-firmware/ESP8285.bin)

5. Bạn giải nén file ZIP vừa tải về và đồng thời giải nén file ZIP chứa các công cụ nạp firmware mà bạn đã tải về ở bước đầu tiên.

6. Copy 4 file `esptool_zb2w`, `esp8285_merger`, `AT2_esp8266_factory_param_tx1rx3` và `usb-uart-bridge` vào thư mục vừa giải nén ở bước 5. Kết quả sẽ như hình dưới đây:

![esptool-copy](https://cdn.chipstack.vn/zerobase2w/download-firmware/esptool-copy.png "esptool-copy]")

7. Ở bước này, bạn cần có Git Bash để thực hiện các lệnh nạp firmware. Nếu bạn chưa cài Git Bash, bạn có thể tải về tại [đây](https://git-scm.com/downloads).

8. Nhấn giữ shift và nhấn chuột phải vào khoảng trống, sau đó chọn Open Git Bash here.

![open-git-bash](https://cdn.chipstack.vn/zerobase2w/download-firmware/open-git-bash.png "open-git-bash]")

9. Đầu tiên bạn chạy lệnh sau để hợp nhất các file firmware thành một file duy nhất:

```bash
python esp8285_merger.py -o ESP8285.bin
```

10. Sau khi hợp nhất thành công, bạn sẽ thấy file mới có tên là `ESP8285.bin` và thông báo như hình dưới đây:

![esp-merger-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/python-merge-esp.png "esp-merger-success]")

11. Bạn nạp code Arduino `usb-uart-bridge` vào board Zerobase 2W như đã hướng dẫn ở phần trước. Bạn kiểm tra cổng COM của board Zerobase 2W trong **Tools > Port**. Ví dụ ở đây là `COM17`.

![COM-port](https://cdn.chipstack.vn/zerobase2w/download-firmware/COM-port.png "COM-port]")

!> Lưu ý: Sau khi nạp code `usb-uart-bridge`, bạn cần tắt Arduino IDE và không sử dụng cổng COM của board Zerobase 2W nữa vì cổng COM này sẽ được sử dụng ở bước tiếp theo.

12. Tiếp theo, bạn cần nạp firmware cho chip ESP8285 bằng cách sử dụng lệnh sau trong Git Bash:

```bash
python esptool_zb2w.py --port COM17 --file ESP8285.BIN
```

Một số lựa chọn bạn có thể sử dụng:

| Option | Short | Type | Default | Description |
|--------|-------|------|---------|-------------|
| `--port` | `-p` | string | COM10 | Serial port name |
| `--baud` | `-b` | integer | 460800 | Baud rate for communication |
| `--file` | `-f` | string | ESP8285.BIN | Firmware file to flash |
| `--addr` | `-a` | hex/int | 0x0000 | Flash memory address |
| `--block-size` | | integer | 2048 | Block size for flashing (bytes) |
| `--verbose` | `-v` | flag | False | Enable verbose output |
| `--list-ports` | | flag | False | List available serial ports |
| `--help` | `-h` | flag | False | Show help message |

13. Nếu lỗi xuất hiện như hình dưới đây, bạn cần tắt Arduino IDE và không sử dụng cổng COM của board Zerobase 2W nữa.

![COM-port-access-denied](https://cdn.chipstack.vn/zerobase2w/download-firmware/COM-port-access-denied.png "COM-port-access-denied]")

14. Thực hiện nạp lại firmware bằng lệnh trên và chờ quá trình nạp firmware hoàn tất. Bạn sẽ thấy thông báo như hình dưới đây:

![flashing-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/flashing-success.png "flashing-success]")

15. Sau khi nạp firmware thành công, bạn copy đoạn code mẫu sau vào Arduino IDE để kiểm tra firmware đã nạp thành công hay chưa:

!> Lưu ý: ở đoạn code `String connectCmd = "AT+CWJAP=\"Ten Wifi\",\"Mat Khau Wifi\"";`, đổi `Ten Wifi` và `Mat Khau Wifi` thành tên và mật khẩu Wi-Fi của bạn.


```cpp
#include <ZBPrint.h>

String receiveResponse(unsigned long timeout = 2000) {
  String response = "";
  unsigned long startTime = millis();

  while ((millis() - startTime) < timeout) {
    if (Serial4.available()) {
      char c = Serial4.read();
      response += c;

      // Kiểm tra nếu phản hồi kết thúc với OK hoặc ERROR
      if (response.endsWith("OK\r\n") || response.endsWith("ERROR\r\n") || response.endsWith("FAIL\r\n")) {
        break;
      }
    }
  }

  return response;
}

bool sendCommand(const char* command, String& response, unsigned long timeout = 2000) {
  Serial.print("Gửi: ");
  Serial.println(command);

  Serial4.println(command);
  response = receiveResponse(timeout);

  Serial.print("Nhận: ");
  Serial.println(response);

  return (response.indexOf("OK") != -1);
}
#define ESP_RST_PIN PA6    // RST pin connection
#define ESP_GPIO0_PIN PA7  // GPIO0 pin connection

void setup() {
  Serial.begin(9600);     // Debug monitor
  Serial4.begin(115200);  // ESP8285 giao tiếp UART
  delay(3000);            // Đợi ESP8285 khởi động hoàn tất
                          // Reset sequence for normal operation
  pinMode(ESP_RST_PIN, OUTPUT);
  pinMode(ESP_GPIO0_PIN, OUTPUT);

  digitalWrite(ESP_GPIO0_PIN, HIGH);  // Set GPIO0 high for normal boot
  delay(10);

  digitalWrite(ESP_RST_PIN, LOW);  // Assert reset
  delay(50);                       // Hold in reset

  digitalWrite(ESP_RST_PIN, HIGH);  // Release reset
  delay(50);                        // Give ESP time to boot


  Serial.println("Bắt đầu kết nối WiFi...");

  String response;

  // Reset ESP8285
  sendCommand("AT+RST", response, 5000);
  delay(2000);

  // Kiểm tra kết nối AT
  if (!sendCommand("AT", response)) {
    Serial.println("Lỗi: Không thể kết nối với ESP8285");
    return;
  }

// Kiểm tra AT
  sendCommand("AT", response);

  // Kiểm tra phiên bản AT
  sendCommand("AT+GMR", response);

  // Đặt chế độ Station
  sendCommand("AT+CWMODE=1", response);

  // Ngắt kết nối WiFi hiện tại nếu có
  sendCommand("AT+CWQAP", response);

  // Kết nối WiFi - Lưu ý cách escape dấu ngoặc kép
  Serial.println("Đang kết nối WiFi...");
  String connectCmd = "AT+CWJAP=\"Ten Wifi\",\"Mat Khau Wifi\"";
  if (sendCommand(connectCmd.c_str(), response, 15000)) {
    Serial.println("Kết nối WiFi thành công!");
  } else {
    Serial.println("Kết nối WiFi thất bại!");
    return;
  }

  // Lấy địa chỉ IP sau khi kết nối thành công
  delay(1000);
  sendCommand("AT+CIFSR", response);

  // Hiển thị thông tin IP
  int ipIndex = response.indexOf("+CIFSR:STAIP,\"");
  if (ipIndex != -1) {
    int endIndex = response.indexOf("\"", ipIndex + 14);
    String ipAddress = response.substring(ipIndex + 14, endIndex);
    Serial.print("Địa chỉ IP: ");
    Serial.println(ipAddress);
  }
}

void loop() {
  // Đọc và hiển thị dữ liệu đến từ ESP8285
  while (Serial4.available()) {
    String data = Serial4.readStringUntil('\n');
    data.trim();
    if (data.length() > 0) {
      Serial.println("ESP: " + data);
    }
  }

  // Kiểm tra dữ liệu từ Serial monitor để gửi lệnh AT
  if (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    command.trim();
    if (command.length() > 0) {
      String response;
      sendCommand(command.c_str(), response);
    }
  }
}
```

Sau khi nạp code thành công, bạn mở Serial Monitor bằng cách vào **Tools > Serial Monitor** hoặc nhấn tổ hợp phím `Ctrl + Shift + M`.
Khi kết nối Wi-Fi thành công, bạn sẽ thấy hiển thị `Kết nối WiFi thành công!` cùng các thông tin khác.


## Cách in ra Serial Monitor bằng Zerobase 2W

Để in ra Serial Monitor, bạn cần thêm thư viện sau vào code

 ```cpp
#include <Adafruit_TinyUSB.h>
```

Sau đó, ở hàm `setup()`, bạn cần khởi tạo Serial Monitor bằng cách thêm dòng sau vào code:

 ```cpp
Serial.begin(9600);
```

Cuối cùng, bạn có thể in ra Serial Monitor bằng cách sử dụng hàm `Serial.println()`.

```cpp
Serial.println("Hello World!");
```

Dưới đây là code mẫu in ra Serial Monitor:

```cpp
#include <Adafruit_TinyUSB.h>

void setup() {
  // Khởi tạo Serial Monitor với tốc độ 9600 bps
  Serial.begin(9600);
}

void loop() {
  // In ra Serial Monitor
  Serial.println("Hello World!");
  delay(1000); // Dừng 1 giây (1000ms)
}
```

Bạn thực hiện nạp code theo 1 trong 2 cách đã nếu trên. Sau khi nạp code thành công, chọn **Tools > Port > COMX (ở ví dụ này sẽ là COM14)** để chọn cổng COM tương ứng.

![select-com-port](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/select-com-port.png "select-com-port")

Sau đó, để mở Serial Monitor, chọn **Tools > Serial Monitor** hoặc nhấn tổ hợp phím `Ctrl + Shift + M`.

![open-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/open-serial-monitor.png "open-serial-monitor")

Quan sát dữ liệu từ Serial Monitor, nếu bạn thấy hiển thị ký tự lạ như hình bên dưới:

![weird-characters-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/weird-characters-serial-monitor.png "weird-characters-serial-monitor")

Bạn cần kiểm tra lại cài đặt baudrate của Serial Monitor, và chọn lại 9600 theo như trong code.

![uartttl-serial-monitor](https://cdn.chipstack.vn/zerobase/uart/uart-ttl/uartttl-serial-monitor.png "uartttl-serial-monitor")

Kết quả cuối cùng, bạn sẽ thấy Serial Monitor in ra dòng chữ "Hello World!" mỗi giây một lần.

![serial-monitor-hello-world](https://cdn.chipstack.vn/zerobase2/quickstart/serial-monitor-hello-world.png "serial-monitor-hello-world]")

## Kết luận

Như vậy, bạn đã hoàn thành việc cài đặt board Zerobase 2W, nạp code, nháy LED và in ra Serial Monitor trên Zerobase 2W. Bạn có thể thử nghiệm các chức năng khác của Zerobase 2W bằng cách thay đổi code mẫu hoặc viết code mới.

