<br>
<br>
<br>

# Nháy LED

![blink-zerobase-image](https://cdn.chipstack.vn/zerobase/blink/blink-led-external-zerobase.png "blink-zerobase-image]")

## Tổng quan

?>  Bài viết này hướng dẫn thực hiện nháy LED sử dụng board Zerobase trên Arduino IDE.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Điện trở 330Ω |[Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED |[Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
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

?> Zerobase sẽ bật LED bằng cách cho chân GPIO nối với cực (+) của LED lên mức cao và tắt LED bằng cách cho chân đấy xuống mức thấp.

> Xem thêm về LED [tại đây](https://chipstack.vn/uncategorized/diot-phat-quang-la-gi-nguyen-ly-hoat-dong-va-ung-dung-tiet-kiem-nang-luong/).

## Sơ đồ kết nối
![zerobase-pins-blink](https://cdn.chipstack.vn/zerobase/blink/zerobase-pins-blink.png "zerobase-pins-blink]")

Sử dụng chân D3 để kết nối với điện trở 330ohm nối tiếp với chân anode **(chân dài hơn là +)** của LED và GND để kết nối với chân cathode **( chân ngắn hơn là -)** của LED.

Sử dụng chân D2 để thực hiện nháy LED có sẵn trên board.

![blink-zerobase-schematic](https://cdn.chipstack.vn/zerobase/blink/blink-zerobase-schematic.png "blink-zerobase-schematic]")

![blink-zerobase-image](https://cdn.chipstack.vn/zerobase/blink/blink-led-external-zerobase.png "blink-zerobase-image]")

## Code

Dưới đây là đoạn code đơn giản để nháy LED:

```cpp
const int ledPin = 3; // Khai báo biến hằng số cho chân 3

// Hàm setup() chạy một lần khi vi điều khiển khởi động
void setup() {
    pinMode(LED_BUILTIN, OUTPUT); // Thiết lập LED của board làm đầu ra
    pinMode(ledPin, OUTPUT);      // Thiết lập chân 3 làm đầu ra
}

// Hàm loop() chạy lặp lại liên tục
void loop() {
    digitalWrite(LED_BUILTIN, HIGH); // Bật LED trên board ZeroBase
    digitalWrite(ledPin, HIGH);      // Bật LED được kết nối với chân 3
    delay(500);                      // Giữ trạng thái HIGH trong 500ms

    digitalWrite(LED_BUILTIN, LOW);  // Tắt LED trên board ZeroBase
    digitalWrite(ledPin, LOW);       // Tắt LED được kết nối với chân 3
    delay(500);                      // Giữ trạng thái LOW trong 500ms
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![blink-zerobase-code](https://cdn.chipstack.vn/zerobase/blink/blink-zerobase-code.png "blink-zerobase-code]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu muốn nháy LED ở chân khác, bạn có thể thay đổi giá trị của biến `ledPin` thành chân bạn muốn nháy sau đó kết nối LED với chân đó.

### Giải thích code

Khai báo biến hằng số `ledPin` với giá trị là 3, chính là chân D3 trên board Zerobase.

```cpp
const int ledPin = 3; // Khai báo biến hằng số cho chân 3
```
Trong hàm `setup()`, chúng ta sẽ thiết lập chân `LED_BUILTIN` và chân `ledPin` làm chân đầu ra.


```cpp
void setup() {
    pinMode(LED_BUILTIN, OUTPUT); // Thiết lập LED của board làm đầu ra
    pinMode(ledPin, OUTPUT);      // Thiết lập chân 3 làm đầu ra
}
```
Trong hàm loop, sử dụng hàm `digitalWrite()` và HIGH để bật LED trên board Zerobase và LED được kết nối với chân 3.

```cpp
    digitalWrite(LED_BUILTIN, HIGH); // Bật LED trên board ZeroBase
    digitalWrite(ledPin, HIGH);      // Bật LED được kết nối với chân 3
```
Sử dụng hàm `delay()` để bật LED trong 500ms.

```cpp
    delay(500);                      // Giữ trạng thái HIGH trong 500ms
```

Sử dụng hàm `digitalWrite()` và LOW để tắt LED trên board Zerobase và LED được kết nối với chân 3.

```cpp
    digitalWrite(LED_BUILTIN, LOW);  // Tắt LED trên board ZeroBase
    digitalWrite(ledPin, LOW);       // Tắt LED được kết nối với chân 3
```

Sử dụng hàm `delay()` để tắt LED trong 500ms.

```cpp
    delay(500);                      // Giữ trạng thái LOW trong 500ms
```

Bạn có thể thay đổi chân kết nối LED bằng cách thay đổi giá trị của biến `ledPin`.

```cpp
const int ledPin = 3; // thay đổi giá trị 3 thành chân khác
```

Bạn có thể thay đổi giá trị của hàm `delay()` để thay đổi tốc độ nháy LED.

```cpp
delay(500); // thay đổi giá trị 500 thành giá trị khác
```

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ thấy LED nháy theo chu kỳ 500ms.

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase/blink/result-led-blink-external-zerobase.gif" alt="result-led-blink-external-zerobase">
</p>

## Kết luận và Hướng phát triển
Bài viết đã hướng dẫn cách nháy LED đơn giản trên board Zerobase bằng Arduino IDE. Đây là bước khởi đầu giúp bạn làm quen với lập trình vi điều khiển và cách điều khiển thiết bị ngoại vi.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- [Điều khiển LED bằng nút nhấn](vi/zerobase/examples/button.md): Sử dụng nút nhấn để bật/tắt LED hoặc thay đổi tốc độ nháy.
- [Nháy LED theo tín hiệu cảm biến](vi/zerobase/examples/pir.md): Kết hợp với cảm biến ánh sáng, nhiệt độ hoặc cảm biến chuyển động để điều khiển LED một cách thông minh.
- [Sử dụng PWM để điều chỉnh độ sáng LED](vi/zerobase/examples/potentiometer.md): Thay vì chỉ bật/tắt LED, bạn có thể sử dụng PWM để thay đổi độ sáng của LED một cách mượt mà.
- **Điều khiển LED từ xa:** Kết hợp với Bluetooth, Wi-Fi hoặc RF để điều khiển LED từ xa bằng điện thoại hoặc máy tính.

Những ý tưởng này sẽ giúp bạn mở rộng hiểu biết về lập trình vi điều khiển và ứng dụng thực tế trong các dự án IoT. Hãy thử nghiệm và sáng tạo với Zerobase!

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)