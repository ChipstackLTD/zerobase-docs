<br>
<br>
<br>

# Nháy LED sử dụng hàm millis() trên Zerobase 2

![blink-zerobase2-image](https://cdn.chipstack.vn/zerobase2/blink/blink-led-external-zerobase2.jpg "blink-zerobase2-image]")

## Tổng quan

?>  Bài viết này hướng dẫn thực hiện nháy LED sử dụng hàm millis() trên Zerobase 2 trên Arduino IDE.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 |[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Điện trở 330Ω |[Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED |[Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

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

## Nguyên lý hoạt động

?> Zerobase 2 sẽ bật LED bằng cách cho chân GPIO nối với cực (+) của LED lên mức cao và tắt LED bằng cách cho chân đấy xuống mức thấp.

> Xem thêm về LED [tại đây](https://chipstack.vn/uncategorized/diot-phat-quang-la-gi-nguyen-ly-hoat-dong-va-ung-dung-tiet-kiem-nang-luong/).

## Sơ đồ kết nối
![zerobase2-pins-blink](https://cdn.chipstack.vn/zerobase2/blink/zerobase2-pins-blink.png "zerobase2-pins-blink]")

Sử dụng chân D2 để kết nối với điện trở 330ohm nối tiếp với chân anode **(chân dài hơn là +)** của LED và GND để kết nối với chân cathode **( chân ngắn hơn là -)** của LED.

![blink-zerobase2-schematic](https://cdn.chipstack.vn/zerobase2/blink/blink-zerobase2-schematic.png "blink-zerobase2-schematic]")

![blink-zerobase2-image](https://cdn.chipstack.vn/zerobase2/blink/blink-led-external-zerobase2.jpg "blink-zerobase2-image]")

## Code

Dưới đây là đoạn code đơn giản để nháy LED:

```cpp
// Khai báo chân kết nối LED (chân số 2)
const int ledPin = 2;

// Biến lưu thời điểm lần cuối LED được thay đổi trạng thái
unsigned long previousMillis = 0;

// Trạng thái hiện tại của LED (LOW là tắt, HIGH là bật)
bool ledState = LOW;

void setup() {
  // Thiết lập chân ledPin là OUTPUT (ngõ ra) để điều khiển LED
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // Đọc thời gian hiện tại tính từ khi Arduino bắt đầu chạy (đơn vị: milli-giây)
  unsigned long currentMillis = millis();

  // Thời gian giữa mỗi lần đổi trạng thái LED (ở đây là 500ms)
  unsigned long interval = 500;  // 0.5 giây

  // Nếu đã đủ thời gian (500ms) kể từ lần đổi trạng thái trước
  if (currentMillis - previousMillis >= interval) {
    // Cập nhật thời điểm đổi trạng thái gần nhất
    previousMillis = currentMillis;

    // Đảo trạng thái LED: nếu đang bật thì tắt, nếu đang tắt thì bật
    ledState = !ledState;

    // Gửi tín hiệu ra chân điều khiển LED để bật hoặc tắt LED
    digitalWrite(ledPin, ledState);
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![blink-led-millis](https://cdn.chipstack.vn/zerobase2/blink/blink-led-millis.png "blink-led-millis]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn nháy LED ở chân khác, bạn có thể thay đổi giá trị của biến `ledPin` thành chân bạn muốn nháy sau đó kết nối LED với chân đó.

### Giải thích code

Khai báo chân kết nối và biến điều khiển:

```cpp
const int ledPin = 2;                       // Chân D2 cho LED
unsigned long previousMillis = 0;          // Thời điểm lần cuối LED được đổi trạng thái
bool ledState = LOW;                       // Trạng thái hiện tại của LED
```

Chân D2 được dùng để điều khiển LED. Biến `previousMillis` lưu thời điểm lần cuối đèn LED thay đổi trạng thái. `ledState` giữ trạng thái hiện tại của LED.

Cấu hình chân trong hàm setup:

```cpp
void setup() {
  pinMode(ledPin, OUTPUT);  // Cấu hình LED là OUTPUT
}
```

Thiết lập chân D2 làm ngõ ra để điều khiển bật/tắt LED.

Vòng lặp chính điều khiển nhấp nháy LED:

```cpp
void loop() {
  unsigned long currentMillis = millis();
  unsigned long interval = 500;  // Khoảng thời gian giữa hai lần đổi trạng thái
```

Dùng hàm `millis()` để lấy thời gian hiện tại tính bằng mili giây. `interval` đặt khoảng thời gian mong muốn giữa hai lần thay đổi LED, ở đây là 500ms (0.5 giây).

```cpp
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    ledState = !ledState;
    digitalWrite(ledPin, ledState);
  }
```

Nếu thời gian đã trôi qua từ lần đổi trạng thái trước đó lớn hơn hoặc bằng `interval`, thì đảo trạng thái của LED và cập nhật `previousMillis`.

Cách này sử dụng `millis()` thay vì `delay()`, cho phép thực hiện thêm các tác vụ khác trong vòng lặp mà không bị chặn lại bởi hàm `delay()`.

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ thấy LED nháy theo chu kỳ 500ms (0.5 giây).

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase2/blink/millis-blink-result.gif" alt="millis-blink-result">
</p>

## Kết luận và Hướng phát triển
Bài viết đã hướng dẫn cách nháy LED đơn giản trên board Zerobase 2 bằng Arduino IDE. Đây là bước khởi đầu giúp bạn làm quen với lập trình vi điều khiển và cách điều khiển thiết bị ngoại vi.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- [Điều khiển LED bằng nút nhấn](vi/zerobase2/examples/button.md): Sử dụng nút nhấn để bật/tắt LED hoặc thay đổi tốc độ nháy.
- [Nháy LED theo tín hiệu cảm biến](vi/zerobase2/examples/pir.md): Kết hợp với cảm biến ánh sáng, nhiệt độ hoặc cảm biến chuyển động để điều khiển LED một cách thông minh.
- [Sử dụng PWM để điều chỉnh độ sáng LED](vi/zerobase2/examples/potentiometer.md): Thay vì chỉ bật/tắt LED, bạn có thể sử dụng PWM để thay đổi độ sáng của LED một cách mượt mà.
- **Điều khiển LED từ xa:** Kết hợp với Bluetooth, Wi-Fi hoặc RF để điều khiển LED từ xa bằng điện thoại hoặc máy tính.

Những ý tưởng này sẽ giúp bạn mở rộng hiểu biết về lập trình vi điều khiển và ứng dụng thực tế trong các dự án IoT. Hãy thử nghiệm và sáng tạo với Zerobase 2!

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)