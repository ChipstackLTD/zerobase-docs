<br>
<br>
<br>

# Sử Dụng Biến Trở Điều Chỉnh Độ Sáng LED Với Zerobase 2

![potentiometer-zerobase2-mat-tren](https://cdn.chipstack.vn/zerobase2/potentiometer/potentiometer-zerobase2-mat-tren.jpg "potentiometer-zerobase2-mat-tren")
## Tổng quan

?> Bài viết này hướng dẫn sử dụng biến trở để điều chỉnh độ sáng của LED với Zerobase 2.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 | [Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Biến trở 10kΩ | [Mua ngay](https://chipstack.vn/san-pham/bien-tro-wh148-3-chan-truc-15mm/) |
| Điện trở 330Ω | [Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED | [Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/potentiometer/potentiometer.jpg" alt="potentiometer">
    <p><em>Biến trở 10kΩ</em></p>
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

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

## Nguyên lý hoạt động

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/potentiometer/potentiometer-pinout.png" alt="pir-pinout">
    <p><em>Sơ đồ chân biến trở</em></p>
</div>
<br>

?> Biến trở có ba chân: hai chân ngoài nối với nguồn và GND, chân giữa xuất ra điện áp thay đổi khi xoay biến trở. Board Zerobase 2 đọc điện áp từ chân giữa của biến trở bằng cổng analog A1, sau đó chuyển đổi thành giá trị số (ADC) để vi điều khiển xử lý. Dựa trên giá trị ADC, vi điều khiển điều chỉnh độ sáng của LED bằng kỹ thuật PWM. Khi xoay biến trở theo một hướng, điện áp tăng làm LED sáng hơn; xoay theo hướng ngược lại, điện áp giảm khiến LED mờ dần. Nhờ đó, ta có thể dễ dàng thay đổi độ sáng LED bằng cách xoay biến trở.

> Xem thêm về biến trở [tại đây](https://chipstack.vn/kien-thuc/dien-tu-co-ban/cau-tao-va-cach-mac-bien-tro-3-chan-chi-tiet-de-hieu/).

> Xem thêm về LED [tại đây](https://chipstack.vn/uncategorized/diot-phat-quang-la-gi-nguyen-ly-hoat-dong-va-ung-dung-tiet-kiem-nang-luong/).

## Sơ đồ kết nối

![potentiometer-zerobase2-pins](https://cdn.chipstack.vn/zerobase2/potentiometer/potentiometer-zerobase2-pins.png "potentiometer-zerobase2-pins")

Sử dụng chân A1 của Zerobase 2 để kết nối với chân 2 của biến trở. Chân 1 được nối với GND, chân 3 được nối với VCC.

Sử dụng chân D3 của Zerobase 2 để kết nối với cực anode (+) của LED. Cực cathode (-) của LED được nối với GND của Zerobase 2.

![potentiometer-zerobase2-schematic](https://cdn.chipstack.vn/zerobase2/potentiometer/potentiometer-zerobase2-schematic.png "potentiometer-zerobase2-schematic")

![potentiometer-zerobase2-mat-tren](https://cdn.chipstack.vn/zerobase2/potentiometer/potentiometer-zerobase2-mat-tren.jpg "potentiometer-zerobase2-mat-tren")

## Code

```cpp
#include <Adafruit_TinyUSB.h>

// Khai báo chân kết nối LED (hằng số, không thay đổi)
const int led = 3;

// Khai báo chân kết nối biến trở (hằng số, không thay đổi)
const int potPin = A1;

void setup() {
  Serial.begin(9600);

  // Cấu hình chân LED là OUTPUT (ngõ ra)
  pinMode(led, OUTPUT);

  // Cấu hình chân biến trở là INPUT_ANALOG (ngõ vào analog)
  pinMode(potPin, INPUT_ANALOG);
}

void loop() {
  // Đọc giá trị từ biến trở (giá trị ADC 12 bit từ 0 đến 4095)
  int sensorValue = analogRead(potPin);
  Serial.print("Value: ");
  Serial.println(sensorValue);

  // Xuất tín hiệu PWM đến LED với độ sáng tương ứng với giá trị biến trở
  analogWrite(led, sensorValue);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![potentiometer-zerobase2-code](https://cdn.chipstack.vn/zerobase2/potentiometer/potentiometer-zerobase2-code.png "potentiometer-zerobase2-code]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị của biến `led` hoặc `potPin` sau đó kết nối LED và biến trở với chân tương ứng.

```cpp
const int led = 3; // Thay đổi chân kết nối LED
const int potPin = A1; // Thay đổi chân kết nối biến trở
```

### Giải thích code

Khái báo thư viện Adafruit_TinyUSB để in ra Serial monitor.

```cpp
#include <Adafruit_TinyUSB.h>
``` 

Khởi tạo Serial với tốc độ 9600 baud.

```cpp
Serial.begin(9600);
```

Khai báo chân kết nối LED và biến trở.

```cpp
const int led = 3;
const int potPin = A1;
```

Cấu hình chân LED là OUTPUT và chân biến trở là INPUT_ANALOG.

```cpp
pinMode(led, OUTPUT);
pinMode(potPin, INPUT_ANALOG);
```

Đọc giá trị từ biến trở (ADC 102 bit từ 0 đến 4095).

```cpp
int sensorValue = analogRead(potPin);
```

In ra giá trị đọc được từ biến trở lên Serial monitor.

```cpp
Serial.print("Value: ");
Serial.println(sensorValue);
```

Xuất tín hiệu PWM đến LED với độ sáng tương ứng với giá trị biến trở.

```cpp
analogWrite(led, sensorValue);
```

## Kết quả

?> Sau khi nạp code thành công, bạn sẽ thấy LED sáng lên và độ sáng của LED sẽ thay đổi tùy theo vị trí của trục xoay của biến trở.

<p align="center">
  <img src="https://cdn.chipstack.vn/zerobase2/potentiometer/potentiometer-zerobase2-result.gif" alt="potentiometer-zerobase2-result">
</p>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn cách sử dụng biến trở để điều chỉnh độ sáng của LED với vi điều khiển Zerobase 2, thông qua việc đọc tín hiệu từ biến trở và điều khiển cường độ PWM. Đây là một ứng dụng cơ bản nhưng rất hữu ích trong điều khiển điện tử.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Sử dụng biến trở để điều chỉnh tốc độ quay của động cơ: Thay vì điều khiển LED, bạn có thể dùng biến trở để thay đổi tốc độ quay của động cơ DC hoặc động cơ servo bằng cách điều chỉnh giá trị PWM.
- Sử dụng biến trở để điều chỉnh độ nhạy của một cảm biến: Trong một số ứng dụng, bạn có thể dùng biến trở để tinh chỉnh độ nhạy của cảm biến ánh sáng (LDR), cảm biến nhiệt độ hoặc cảm biến siêu âm bằng cách thay đổi điện áp tham chiếu.
- Kết nối biến trở với màn hình LCD để hiển thị giá trị điện áp hoặc thông số điều chỉnh.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)