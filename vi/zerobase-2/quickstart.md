<br>
<br>
<br>

# Hướng dẫn sử dụng Zerobase 2

## Tổng quan

![zerobase2](https://cdn.chipstack.vn/default/zerobase2-overview.png "zerobase2]")

Zerobase 2 là một board phát triển dựa trên vi điều khiển CH32. Board hỗ trợ nhiều giao tiếp như I2C, SPI, UART, GPIO, ADC, PWM, và nhiều chức năng khác. 
<br>
<br>
Hướng dẫn này trình bày chi tiết cách cài đặt bo mạch, nạp code và nháy LED với Zerobase 2 trên Arduino IDE.

## Sơ đồ chân

Một số lưu ý khi sử dụng Zerobase 2:

!> Mức logic: 3.3V.

!> Trừ các chân D6, A6, A7 thì Toàn bộ chân GPIO đều hỗ trợ PWM.

!> Toàn bộ chân GPIO đều hỗ trợ ngắt ngoại vi.

!> Toàn bộ chân GPIO đều hỗ trợ INPUT/OUTPUT.

Bạn có tham khảo thêm sơ đồ chân trong [bài viết này](https://zerobase.chipstack.vn/#/vi/zerobase-2/pinout).

## Nguồn cấp
![chan-cap-nguon-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/chan-cap-nguon-zerobase2.png "chan-cap-nguon-zerobase2.png]")
- **3.3V**: Chân này có thể nhận nguồn 3.3VDC (input) hoặc cấp nguồn cho thiết bị khác (output).
- **USB**: Zerobase 2 hỗ trợ cấp nguồn qua cổng USB.

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


## Cài đặt Arduino IDE và board Zerobase 2
Để có thể lập trình cho Zerobase 2, đầu tiên bạn cần tải và cài đặt Arduino IDE phiên bản mới nhất theo đường link sau: [Arduino IDE](https://www.arduino.cc/en/software).

Sau khi cài đặt xong, bạn cần cài đặt board Zerobase 2 trên Arduino IDE theo các bước sau:

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

Để chọn board Zerobase 2, bạn vào **Tools > Board**, chọn Zerobase 2.

![select-board](https://cdn.chipstack.vn/zerobase2/quickstart/select-board-zerobase-2.png "select-board]")

Bạn có thể sử dụng code mẫu để nháy LED trên Zerobase 2 bằng cách vào **File > Examples > DigitalIO > Blink**.

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

**Nếu ban đầu nạp code cho Zerobase 2**, bạn nhấn giữ nút **BOOT** sau đó cắm USB vào máy tính. Khi đã cắm USB vào máy tính, bạn thả nút **BOOT** ra. Board Zerobase 2 sẽ tự động vào chế độ nạp code.

<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/quickstart/zb2-boot.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Nếu ban đầu nạp code</em></p>
</div>

Những lần nạp code tiếp theo, bạn chỉ cần thực hiện như cách trên hoặc bạn cắm USB vào máy tính, nhấn giữ nút **BOOT**. Sau đó nhấn nút **RESET** rồi thả nút **RESET** này ra. Cuối cùng, thả nút **BOOT**. Board Zerobase 2 sẽ vào chế độ nạp code.

<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/quickstart/zb2-boot-2.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Những lần nạp code tiếp theo</em></p>
</div>

!> Lưu ý: Không cần chọn cổng COM cho board Zerobase 2 khi nạp code. Board Zerobase 2 sẽ tự động nhận cổng COM khi được chuyển sang chế độ nạp code.

Bạn nhấn **Upload** hoặc nhấn **Ctrl+U** để nạp code.

![upload-code-z2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-code-z2.png "upload-code-z2]")

Nếu upload code xuất hiện lỗi như hình dưới đây:

![upload-unsuccess-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-unsuccess-zerobase2.png "upload-unsuccess-zerobase2]")

Bạn cần cài đặt driver cho board Zerobase 2. Bạn có thể tải driver tại [đây](https://cdn.chipstack.vn/reference/zadig-2.9.exe).

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

Kết quả cuối cùng, bạn sẽ thấy LED trên board Zerobase 2 nháy theo chu kỳ 1 giây.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/quickstart/led-blink-zerobase2.gif" alt="led-blink-zerobase2">
    <p><em>LED nháy theo chu kỳ 1 giây</em></p>
</div>

## Cách in ra Serial Monitor bằng Zerobase 2

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

Như vậy, bạn đã hoàn thành việc cài đặt board Zerobase 2, nạp code, nháy LED và in ra Serial Monitor trên Zerobase 2. Bạn có thể thử nghiệm các chức năng khác của Zerobase 2 bằng cách thay đổi code mẫu hoặc viết code mới.