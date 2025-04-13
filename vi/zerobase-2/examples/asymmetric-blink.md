<br>
<br>
<br>

# Nháy LED

![blink-zerobase2-image](https://cdn.chipstack.vn/zerobase2/blink/blink-led-external-zerobase2.jpg "blink-zerobase2-image]")

## Tổng quan

?>  Bài viết này hướng dẫn thực hiện nháy LED sử dụng board Zerobase trên Arduino IDE.

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

Sử dụng chân D3 để kết nối với điện trở 330ohm nối tiếp với chân anode **(chân dài hơn là +)** của LED và GND để kết nối với chân cathode **( chân ngắn hơn là -)** của LED.

Sử dụng D22 (LED_BUILTIN) để thực hiện nháy LED có sẵn trên board.

![blink-zerobase2-schematic](https://cdn.chipstack.vn/zerobase2/blink/blink-zerobase2-schematic.png "blink-zerobase2-schematic]")

![blink-zerobase2-image](https://cdn.chipstack.vn/zerobase2/blink/blink-led-external-zerobase2.jpg "blink-zerobase2-image]")

## Code

Dưới đây là đoạn code đơn giản để nháy LED:

```cpp
// Khai báo chân kết nối LED (chân số 2)
const int ledPin = 2;

void setup() {
  // Thiết lập chân ledPin là OUTPUT (ngõ ra) để điều khiển LED
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // Bật LED (xuất mức HIGH ra chân ledPin)
  digitalWrite(ledPin, HIGH);
  // Giữ trạng thái bật trong 200 mili-giây
  delay(200);  // Bật 200ms

  // Tắt LED (xuất mức LOW ra chân ledPin)
  digitalWrite(ledPin, LOW);
  // Giữ trạng thái tắt trong 800 mili-giây
  delay(800);  // Tắt 800ms
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![asymmetric-blink](https://cdn.chipstack.vn/zerobase2/blink/asymmetric-blink.png "asymmetric-blink]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn nháy LED ở chân khác, bạn có thể thay đổi giá trị của biến `ledPin` thành chân bạn muốn nháy sau đó kết nối LED với chân đó.

### Giải thích code

Khai báo biến hằng số `ledPin` với giá trị là 2, chính là chân D2 trên board Zerobase 2.

```cpp
const int ledPin = 2; // Khai báo biến hằng số cho chân 2
```
Trong hàm `setup()`, chúng ta sẽ thiết lập chân `ledPin` làm chân đầu ra.


```cpp
void setup() {
    pinMode(ledPin, OUTPUT);      // Thiết lập chân 2 làm đầu ra
}
```
Trong hàm loop, sử dụng hàm `digitalWrite()` và HIGH để bật LED được kết nối với chân 2.

```cpp
    digitalWrite(ledPin, HIGH);      // Bật LED được kết nối với chân 2
```
Sử dụng hàm `delay()` để bật LED trong 200ms.

```cpp
    delay(200);                      // Giữ trạng thái HIGH trong 200ms
```

Sử dụng hàm `digitalWrite()` và LOW để tắt LED được kết nối với chân 2.

```cpp
    digitalWrite(ledPin, LOW);       // Tắt LED được kết nối với chân 2
```

Sử dụng hàm `delay()` để tắt LED trong 800ms.

```cpp
    delay(800);                      // Giữ trạng thái LOW trong 800ms
```

Bạn có thể thay đổi chân kết nối LED bằng cách thay đổi giá trị của biến `ledPin`.

```cpp
const int ledPin = 2; // thay đổi giá trị 2 thành chân khác
```

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ thấy LED bật sáng trong 200ms và tắt trong 800ms.

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase2/blink/asymmetric-blink-result.gif" alt="asymmetric-blink-result">
</p>

## Kết luận và Hướng phát triển
Bài viết đã hướng dẫn cách nháy LED đơn giản trên board Zerobase 2 bằng Arduino IDE. Đây là bước khởi đầu giúp bạn làm quen với lập trình vi điều khiển và cách điều khiển thiết bị ngoại vi.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- [Điều khiển LED bằng nút nhấn](vi/zerobase-2/examples/button.md): Sử dụng nút nhấn để bật/tắt LED hoặc thay đổi tốc độ nháy.
- [Nháy LED theo tín hiệu cảm biến](vi/zerobase-2/examples/pir.md): Kết hợp với cảm biến ánh sáng, nhiệt độ hoặc cảm biến chuyển động để điều khiển LED một cách thông minh.
- [Sử dụng PWM để điều chỉnh độ sáng LED](vi/zerobase-2/examples/potentiometer.md): Thay vì chỉ bật/tắt LED, bạn có thể sử dụng PWM để thay đổi độ sáng của LED một cách mượt mà.
- **Điều khiển LED từ xa:** Kết hợp với Bluetooth, Wi-Fi hoặc RF để điều khiển LED từ xa bằng điện thoại hoặc máy tính.

Những ý tưởng này sẽ giúp bạn mở rộng hiểu biết về lập trình vi điều khiển và ứng dụng thực tế trong các dự án IoT. Hãy thử nghiệm và sáng tạo với Zerobase 2!

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)