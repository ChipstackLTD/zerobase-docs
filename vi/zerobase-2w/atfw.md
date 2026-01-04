<br>
<br>
<br>

# AT Firmware cho ESP8285 trên Zerobase 2W

## Cách cập nhật firmware cho chip Wi-Fi ESP8285

?> Mặc định AT firmware đã được nạp lúc sản xuất Zerobase 2W nên phần này sẽ được dùng khi có bản AT firmware mới hơn

### Danh sách các phiên bản AT firmware

| Phiên bản | Ngày phát hành | Trạng thái |
|:----------|:---------------|:-----------|
| 2.2.3.0-dev | 09-05-2025 | Phiên bản đang được sử dụng |

### Cập nhật firmware cho chip Wi-Fi ESP8285

Để cập nhật firmware cho chip Wi-Fi ESP8285 trên Zerobase 2W, bạn cần tải về file bin chứa firmware từ nhà sản xuất [tại đây](https://cdn.chipstack.vn/zerobase2w/download-firmware/ESP8285.bin)

Sau đó bạn tải về file ZIP chứa các công cụ cần thiết [tại đây](https://cdn.chipstack.vn/zerobase2w/download-firmware/esptool_zb2w.zip).

!> Bạn chỉ cần sử dụng `esptool_zb2w` và `usb-uart-bridge` trong file ZIP vừa tải về để nạp firmware cho chip ESP8285, nếu muốn tải bản firmware mới nhất của nhà sản xuất và tự build file bin, bạn có thể tham khảo phần [Hướng dẫn build AT firmware cho ESP8285](#tuỳ-chọn-hướng-dẫn-build-at-firmware-cho-esp8285).

1. Đầu tiên, bạn cần có Git Bash để thực hiện các lệnh nạp firmware hoặc có thể sử dụng Command Prompt. Nếu bạn chưa cài Git Bash, bạn có thể tải về tại [đây](https://git-scm.com/downloads).

2. Bạn copy 2 file `esptool_zb2w` và `usb-uart-bridge` vào thư mục chứa file bin firmware đã tải về từ bước đầu tiên. Kết quả sẽ như hình dưới đây:

![esp-at-8285-only](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-8285-only.png)

3. Sử dụng esptool để nạp firmware cho chip ESP8285. Bạn có thể sử dụng Command Prompt hoặc Git Bash.

- Đối với Command Prompt:

  - Mở Command Prompt bằng cách nhấn `Windows + R`, gõ `cmd` và nhấn Enter.

  ![cmd](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd.png "cmd]")

  - Bạn chuyển sang thư mục chứa các file đã tải về bằng lệnh `cd`. Ví dụ nếu bạn lưu các file trong thư mục `D:\Down\esp8285-1MB-at`, bạn sẽ gõ:

  ```bash
  cd /d "D:\Down\esp8285-1MB-at"
  ```

  ![cd-cmd](https://cdn.chipstack.vn/zerobase2w/download-firmware/cd-cmd.png "cd-cmd]")

- Đối với Git Bash:

  - Nhấn giữ shift và nhấn chuột phải vào khoảng trống, sau đó chọn Open Git Bash here.

  ![open-git-bash](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-8285-only-open-git-bash.png)

4. Sau đó bạn nạp code Arduino `usb-uart-bridge` vào board Zerobase 2W như đã hướng dẫn ở phần trước. Bạn kiểm tra cổng COM của board Zerobase 2W trong **Tools > Port**. Ví dụ ở đây là `COM17`.

![COM-port](https://cdn.chipstack.vn/zerobase2w/download-firmware/COM-port.png "COM-port]")

!> Lưu ý: Sau khi nạp code `usb-uart-bridge`, bạn cần tắt Arduino IDE và không sử dụng cổng COM của board Zerobase 2W nữa vì cổng COM này sẽ được sử dụng ở bước tiếp theo.

5. Tiếp theo, bạn cần nạp firmware cho chip ESP8285 bằng cách sử dụng lệnh sau trong Git Bash hoặc Command Prompt:

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

5. Nếu lỗi xuất hiện như hình dưới đây, bạn cần tắt Arduino IDE, không sử dụng cổng COM của board Zerobase 2W nữa và nhấn nút reset trên board.

Đối với Command Prompt:

![COM-port-access-denied](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd-access-denied.png)

Đối với Git Bash:

![COM-port-access-denied](https://cdn.chipstack.vn/zerobase2w/download-firmware/COM-port-access-denied.png "COM-port-access-denied]")

6. Thực hiện nạp lại firmware bằng lệnh trên và chờ quá trình nạp firmware hoàn tất. Bạn sẽ thấy thông báo như hình dưới đây:

Đối với Command Prompt:

![flashing-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd-flashing-success.png)

Đối với Git Bash:

![flashing-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/flashing-success.png "flashing-success]")

7. Sau khi nạp firmware thành công, bạn copy đoạn code mẫu sau vào Arduino IDE để kiểm tra firmware đã nạp thành công hay chưa:

Lưu ý: Ở đoạn code `const char* ssid = "YOUR_WIFI_NAME";const char* password = "YOUR_WIFI_PASSWORD";`, Bạn cần thay thế `YOUR_WIFI_NAME` và `YOUR_WIFI_PASSWORD` bằng tên và mật khẩu Wi-Fi của bạn.

```cpp
/*
  ConnectWifi.ino - Example code to connect to WiFi using WiFiEspAT library
*/
#include <ZBPrint.h>

#define WIFIESPAT2
#include <WiFiEspAT.h>

const char* ssid = "YOUR_WIFI_NAME";
const char* password = "YOUR_WIFI_PASSWORD";

void setup() {
    Serial.begin(9600);
    delay(2000);

    Serial4.begin(115200);
    WiFi.init(Serial4);

    if (WiFi.status() == WL_NO_MODULE) {
    Serial.println("Cannot connect to WiFi module");
    }

    String fv = WiFi.firmwareVersion();
    Serial.print("Firmware version: ");
    Serial.println(fv);

    WiFi.setPersistent(true);
    delay(1000);

    Serial.println("Disconnect to all WiFi...");
    WiFi.disconnect();
    delay(3000);

    Serial.print("Connect to WiFi: ");
    Serial.println(ssid);

    int status = WiFi.begin(ssid, password);
    delay(2000);
    if (status == WL_CONNECTED) {
    Serial.println("Connect to WiFi successfully");
    } else {
    Serial.println("Connect to WiFi failed");
    }

    printWifiStatus();
}

void loop() {
    delay(1000);
}

void printWifiStatus() {
    Serial.print("SSID: ");
    Serial.println(WiFi.SSID());

    IPAddress ip = WiFi.localIP();
    Serial.print("IP Address: ");
    Serial.println(ip);

    long rssi = WiFi.RSSI();
    Serial.print("RSSI: ");
    Serial.print(rssi);
    Serial.println(" dBm");

    Serial.print("Gateway: ");
    Serial.println(WiFi.gatewayIP());

    Serial.print("Subnet Mask: ");
    Serial.println(WiFi.subnetMask());

    Serial.print("DNS Server: ");
    Serial.println(WiFi.dnsIP());
}
```

Sau khi nạp code thành công, bạn mở Serial Monitor bằng cách vào **Tools > Serial Monitor** hoặc nhấn tổ hợp phím `Ctrl + Shift + M`.

?> Khi kết nối Wi-Fi thành công, bạn sẽ thấy hiển thị các thông tin có định dạng sau:

```sh
Firmware version: 2.2.3.0-dev
Disconnect to all WiFi..
Connect to WiFi: 
Connect to WiFi successfully

SSID: Ten Wifi
IP Address: 192.168.1.xxx
RSSI: -xx dBm
Gateway: 192.168.1.1
Subnet Mask: 255.255.255.0
DNS Server: xxx.xxx.xxx.xxx
```

## Hướng dẫn build AT firmware cho ESP8285

Để cập nhật firmware mới nhất từ nhà sản xuất cho chip Wi-Fi ESP8285 trên Zerobase 2W, bạn cần tải về file ZIP chứa các công cụ cần thiết [tại đây](https://cdn.chipstack.vn/zerobase2w/download-firmware/esptool_zb2w.zip).

Trong file ZIP bao gồm:

- **esptool_zb2w**: Đây là tool dùng để nạp firmware cho chip ESP8285.

- **esp8285_merger**: Đây là tool dùng để hợp nhất các file firmware thành một file duy nhất.

- **AT2_esp8266_factory_param_tx1rx3**: Đây là file bin chứa chân ESP8285 sử dụng trên Zerobase 2W.

- **usb-uart-bridge**: Đây là file code Arduino dùng để giao tiếp với chip ESP8285.

Tiếp theo, bạn cần tải về file firmware mới nhất cho chip ESP8285 theo các bước sau:

1. Truy cập vào trang [esp-at](https://github.com/espressif/esp-at).

![esp-at](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-github.png "esp-at]")

2. Bạn chọn vào phần Actions, sau đó nhấn vào Branch và tìm `ESP8266` rồi chọn bản release mới nhất, ví dụ ở đây là `release/v2.3.0.0_esp8266`.

![esp-at-release](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-actions.png "esp-at-release]")

3. Tiếp theo, bạn chọn phần mới nhất trong phần workflow.

![esp-at-merge](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-merge.png "esp-at-merge]")

4. Bạn kéo xuống dưới cùng và tìm phần `Artifacts`, tìm `esp8285-1MB-at`, nhấn vào biểu tượng tải xuống để tải về file ZIP chứa firmware mới nhất.

![esp-at-download](https://cdn.chipstack.vn/zerobase2w/download-firmware/esp-at-download.png "esp-at-download]")

5. Bạn giải nén file ZIP vừa tải về và đồng thời giải nén file ZIP chứa các công cụ nạp firmware mà bạn đã tải về ở bước đầu tiên.

6. Copy 4 file `esptool_zb2w`, `esp8285_merger`, `AT2_esp8266_factory_param_tx1rx3` và `usb-uart-bridge` vào thư mục chứa firmware đã tải về từ bước 4. Kết quả sẽ như hình dưới đây:

![esptool-copy](https://cdn.chipstack.vn/zerobase2w/download-firmware/esptool-copy.png "esptool-copy]")

7. Ở bước này, bạn cần có Git Bash để thực hiện các lệnh nạp firmware. Nếu bạn chưa cài Git Bash, bạn có thể tải về tại [đây](https://git-scm.com/downloads).

8. Sử dụng esptool để nạp firmware cho chip ESP8285. Bạn có thể sử dụng Command Prompt hoặc Git Bash.

- Đối với Command Prompt:

  - Mở Command Prompt bằng cách nhấn `Windows + R`, gõ `cmd` và nhấn Enter.

  ![cmd](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd.png "cmd]")

  - Bạn chuyển sang thư mục chứa các file đã tải về bằng lệnh `cd`. Ví dụ nếu bạn lưu các file trong thư mục `D:\Down\esp8285-1MB-at`, bạn sẽ gõ:

  ```bash
  cd /d "D:\Down\esp8285-1MB-at"
  ```

  ![cd-cmd](https://cdn.chipstack.vn/zerobase2w/download-firmware/cd-cmd.png "cd-cmd]")

- Đối với Git Bash:

  - Nhấn giữ shift và nhấn chuột phải vào khoảng trống, sau đó chọn Open Git Bash here.

  ![open-git-bash](https://cdn.chipstack.vn/zerobase2w/download-firmware/open-git-bash.png "open-git-bash]")

9. Đầu tiên bạn chạy lệnh sau để hợp nhất các file firmware thành một file duy nhất:

```bash
python esp8285_merger.py -o ESP8285.bin
```

10. Sau khi hợp nhất thành công, bạn sẽ thấy file mới có tên là `ESP8285.bin` và thông báo như hình dưới đây:

Đối với Command Prompt:

![cmd-merger-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd-merger-success.png "cmd-merger-success]")

Đối với Git Bash:

![esp-merger-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/python-merge-esp.png "esp-merger-success]")

11. Bạn nạp code Arduino `usb-uart-bridge` vào board Zerobase 2W như đã hướng dẫn ở phần trước. Bạn kiểm tra cổng COM của board Zerobase 2W trong **Tools > Port**. Ví dụ ở đây là `COM17`.

![COM-port](https://cdn.chipstack.vn/zerobase2w/download-firmware/COM-port.png "COM-port]")

!> Lưu ý: Sau khi nạp code `usb-uart-bridge`, bạn cần tắt Arduino IDE và không sử dụng cổng COM của board Zerobase 2W nữa vì cổng COM này sẽ được sử dụng ở bước tiếp theo.

12. Tiếp theo, bạn cần nạp firmware cho chip ESP8285 bằng cách sử dụng lệnh sau trong Git Bash hoặc Command Prompt:

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

13. Nếu lỗi xuất hiện như hình dưới đây, bạn cần tắt Arduino IDE, không sử dụng cổng COM của board Zerobase 2W nữa và nhấn nút reset trên board.

Đối với Command Prompt:

![COM-port-access-denied](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd-access-denied.png)

Đối với Git Bash:

![COM-port-access-denied](https://cdn.chipstack.vn/zerobase2w/download-firmware/COM-port-access-denied.png "COM-port-access-denied]")

14. Thực hiện nạp lại firmware bằng lệnh trên và chờ quá trình nạp firmware hoàn tất. Bạn sẽ thấy thông báo như hình dưới đây:

Đối với Command Prompt:

![flashing-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/cmd-flashing-success.png)

Đối với Git Bash:

![flashing-success](https://cdn.chipstack.vn/zerobase2w/download-firmware/flashing-success.png "flashing-success]")

15. Sau khi nạp firmware thành công, bạn copy đoạn code mẫu đã cung cấp ở phần trước vào Arduino IDE để kiểm tra firmware đã nạp thành công hay chưa.