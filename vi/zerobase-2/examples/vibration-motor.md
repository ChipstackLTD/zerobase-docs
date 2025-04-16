<br>
<br>
<br>

# Điều khiển động cơ rung

![vibration-motor-circuit](https://cdn.chipstack.vn/zerobase2/vibration-motor/vibration-motor-circuit.jpg)

## Tổng quan

Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ rung với board Zerobase 2. Động cơ rung sẽ hoạt động khi có tín hiệu HIGH từ chân GPIO mà nó được kết nối.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 |[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breakout động cơ rung 1030 | [Mua ngay](https://chipstack.vn/san-pham/breakout-dong-co-rung/) |

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
    <img src="https://cdn.chipstack.vn/zerobase2/vibration-motor/breakout-dong-co-rung.jpg" alt="breakout-dong-co-rung">
    <p><em>Breakout động cơ rung 1030</em></p>
</div>

## Nguyên lý hoạt động

?> Zerobase 2 sẽ bật động cơ rung bằng cách cho chân GPIO nối với chân IN của động cơ rung lên mức cao và tắt động cơ rung bằng cách cho chân đấy xuống mức thấp.

## Sơ đồ kết nối

![Zerobase2-vibration-motor-pins](https://cdn.chipstack.vn/zerobase2/vibration-motor/vibration-motor-pins.png)

Sử dụng chân D2 nối với chân IN của động cơ rung. Chân GND nối với chân GND của board Zerobase 2. Chân VCC nối với chân 5V của board Zerobase 2.

![Zerobase2-vibration-motor-circuit](https://cdn.chipstack.vn/zerobase2/vibration-motor/vibration-motor-circuit.jpg)

![Zerobase2-vibration-motor-schematic](https://cdn.chipstack.vn/zerobase2/vibration-motor/vibration-motor-schematic.png)

## Code

```cpp
const int vibOutPin = 2;  // Khai báo chân số 2 là chân xuất tín hiệu (cho motor rung)

void setup() {
  pinMode(vibOutPin, OUTPUT);  // Thiết lập chân vibOutPin là ngõ ra (output)
}

void loop() {
  digitalWrite(vibOutPin, HIGH);  // Bật tín hiệu (HIGH) - thiết bị rung hoạt động
  delay(2000);                    // Giữ trạng thái HIGH trong 2000ms (2 giây)

  digitalWrite(vibOutPin, LOW);   // Tắt tín hiệu (LOW) - thiết bị ngừng rung
  delay(600);                     // Dừng 600ms

  digitalWrite(vibOutPin, HIGH);  // Bật lại tín hiệu
  delay(2000);                    // Giữ trong 2 giây

  digitalWrite(vibOutPin, LOW);   // Tắt tín hiệu
  delay(600);                     // Dừng 600ms

  digitalWrite(vibOutPin, HIGH);  // Bật lại tín hiệu
  delay(2000);                    // Giữ trong 2 giây

  digitalWrite(vibOutPin, LOW);   // Tắt tín hiệu
  delay(600);                     // Dừng 600ms

  delay(5000);  // Dừng thêm 5 giây trước khi lặp lại chu kỳ
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![Zerobase2-vibration-motor-code](https://cdn.chipstack.vn/zerobase2/vibration-motor/vibration-motor-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

## Giải thích code

Khai báo biến hằng số `vibOutPin` với giá trị là 2, chính là chân D2 trên board Zerobase 2.

```cpp
const int vibOutPin = 2; // Khai báo chân số 2 là chân xuất tín hiệu (cho motor rung)
```

Trong hàm `setup()`, chúng ta sẽ thiết lập chân `vibOutPin` là ngõ ra.

```cpp
pinMode(vibOutPin, OUTPUT); // Thiết lập chân vibOutPin là ngõ ra (output)
```

Trong hàm `loop()`, sử dụng hàm `digitalWrite()` và HIGH để bật động cơ rung trên board Zerobase 2 trong 2 giây
```cpp
digitalWrite(vibOutPin, HIGH);  // Bật tín hiệu (HIGH) - thiết bị rung hoạt động
delay(2000);                    // Giữ trạng thái HIGH trong 2000ms (2 giây)
```

Sau đó sử dụng hàm `digitalWrite()` và LOW để tắt động cơ rung trên board Zerobase 2 trong 600ms
```cpp
  digitalWrite(vibOutPin, LOW);  // Tắt tín hiệu (LOW) - thiết bị ngừng rung
  delay(600);                    // Dừng 600ms
```

Lặp lại các bước trên cho đến khi dừng thêm 5 giây trước khi lặp lại chu kỳ

```cpp
  digitalWrite(vibOutPin, HIGH);  // Bật lại tín hiệu
  delay(2000);                    // Giữ trong 2 giây

  digitalWrite(vibOutPin, LOW);   // Tắt tín hiệu
  delay(600);                     // Dừng 600ms

  digitalWrite(vibOutPin, HIGH);  // Bật lại tín hiệu
  delay(2000);                    // Giữ trong 2 giây

  digitalWrite(vibOutPin, LOW);   // Tắt tín hiệu
  delay(600);                     // Dừng 600ms

  delay(5000);  // Dừng thêm 5 giây trước khi lặp lại chu kỳ
```

## Kết quả

?> Khi nạp code thành công, động cơ rung sẽ hoạt động theo chu kỳ 2 giây rung và 600ms dừng. Sau đó sẽ dừng thêm 5 giây trước khi lặp lại chu kỳ.


<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/vibration-motor/vibration-motor-result.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Motor sẽ rung khi có tín hiệu từ Zerobase 2</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn bạn cách điều khiển động cơ rung với board Zerobase 2.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Thay đổi thời gian rung và dừng của động cơ rung.
- Thay đổi chân kết nối động cơ rung để thử nghiệm với các chân khác trên board Zerobase 2.
- Thay đổi cách điều khiển động cơ rung bằng cách sử dụng cảm biến hoặc nút nhấn.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)



