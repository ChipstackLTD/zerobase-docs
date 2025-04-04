<br>
<br>
<br>

# Điều khiển động cơ Servo bằng biến trở

![potentiometer-servo-circuit](https://cdn.chipstack.vn/zerobase/servo/potentiometer-servo-circuit.jpg)

## Tổng quan

?> Bài viết này hướng dẫn sử dụng biến trở để điều khiển động cơ Servo với Zerobase.

## Chuẩn bị

| Linh kiện | Link mua |
|--- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |
| Động cơ Servo SG90 180 độ | [Mua ngay](https://chipstack.vn/san-pham/dong-co-servo-sg90-180-do/) |
| Biến trở 10kΩ | [Mua ngay](https://chipstack.vn/san-pham/bien-tro-wh148-3-chan-truc-15mm/) |

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

<div align="center">
    <img src="https://cdn.chipstack.vn/default/module-nguon-cho-breadboard-mb102-830.jpg" alt="module-nguon-cho-breadboard-mb102-830">
    <p><em>Module nguồn cho Breadboard MB102 830</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w.jpg" alt="nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w">
    <p><em>Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/servo/dong-co-servo-sg90-180-do.jpg" alt="dong-co-servo-sg90-180-do">
    <p><em>Động cơ Servo SG90 180 độ</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/potentiometer/potentiometer.jpg" alt="potentiometer">
    <p><em>Biến trở 10kΩ</em></p>
</div>

## Nguyên lý hoạt động

?> Để điều khiển động cơ Servo, bạn cần cung cấp cho nó một tín hiệu PWM (Pulse Width Modulation) với tần số 50Hz. Tín hiệu này sẽ xác định vị trí của động cơ Servo.

?> Biến trở sẽ được sử dụng để điều chỉnh độ rộng của xung PWM, từ đó điều khiển vị trí của động cơ Servo.

## Sơ đồ kết nối

![zerobase-potentiometer-servo-pins](https://cdn.chipstack.vn/zerobase/servo/zerobase-potentiometer-servo-pins.png)

Sử dụng chân A0 để kết nối với chân giữa của biến trở, một chân của biến trở nối với nguồn 5V và chân còn lại nối với GND của board Zerobase.

Chân D19 (SCL) kết nối đến chân màu cam của servo. Chân GND (màu đen) của servo nối với GND của board Zerobase và nguồn. chân VCC (màu đỏ) của servo nối với nguồn 5V và nguồn.

![potentiometer-servo-schematic](https://cdn.chipstack.vn/zerobase/servo/potentiometer-servo-schematic.png)

![potentiometer-servo-circuit](https://cdn.chipstack.vn/zerobase/servo/potentiometer-servo-circuit.jpg)

!> **Ngắt nguồn trước khi nạp code**: Trước khi cắm dây USB vào để nạp code vào board Zerobase, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase và chạy code bình thường.

!> **Không dùng nguồn 5V từ Zerobase cho động cơ**: Tuyệt đối không nối 5V trực tiếp của board Zerobase vào động cơ DC, vì động cơ DC có thể tiêu tốn dòng điện lớn hơn mức cho phép của board Zerobase, dẫn đến hỏng board.

!> **Module nguồn MB102 830 ở chế độ 5V**: Bạn cần đảm bảo module nguồn MB102 830 đang ở chế độ 5V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 5V.


## Code
```cpp
#include "SimpleServo.h"  // Thư viện SimpleServo giúp điều khiển servo dễ dàng

const int servoPin = 19;  // Pin 19 được kết nối với servo
const int potPin = A0;    // Pin A0 được kết nối với điện trở điều chỉnh (potentiometer)
int potValue = 0;         // Biến lưu giá trị từ điện trở điều chỉnh
int angle = 0;            // Biến lưu góc quay của servo
SimpleServo servo(servoPin);  // Khởi tạo đối tượng servo với pin 19

void setup() {
  servo.attach();  // Kết nối servo với pin đã chỉ định (pin 19)
}

void loop() {
  potValue = analogRead(potPin);           // Đọc giá trị từ điện trở điều chỉnh
  angle = map(potValue, 0, 1023, 0, 180);  // Chuyển đổi giá trị đọc được từ 0-1023 thành góc từ 0-180 độ
  servo.write(angle);                      // Điều khiển servo quay đến góc đã chuyển đổi
  delay(15);                               // Chờ 15ms để servo có thời gian di chuyển đến vị trí
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![potentiometer-servo-code](https://cdn.chipstack.vn/zerobase/servo/potentiometer-servo-code.png "potentiometer-servo-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu muốn điều khiển động cơ ở chân khác, hoặc đọc giá trị biến trở từ chân khác, bạn có thể thay đổi giá trị của biến `servoPin` hoặc `potPin` thành chân bạn muốn điều khiển sau đó kết nối servo và biến trở với chân đó.

```cpp
const int servoPin = 19;  // Pin 19 được kết nối với servo
const int potPin = A0;    // Pin A0 được kết nối với điện trở điều chỉnh (potentiometer)
```

### Giải thích code

Khai báo chân kết nối servo và biến trở.
```cpp
const int servoPin = 19;  // Pin 19 được kết nối với servo
const int potPin = A0;    // Pin A0 được kết nối với điện trở điều chỉnh (potentiometer)
```
Khởi tạo biến lưu giá trị từ biến trở và góc quay của servo.
```cpp
int potValue = 0;         // Biến lưu giá trị từ điện trở điều chỉnh
int angle = 0;            // Biến lưu góc quay của servo
```

Khởi tạo đối tượng servo với pin 19.
```cpp
SimpleServo servo(servoPin);  // Khởi tạo đối tượng servo với pin 19
```

Kết nối servo với pin đã chỉ định (pin 19).
```cpp
servo.attach();  // Kết nối servo với pin đã chỉ định (pin 19)
```

Đọc giá trị từ biến trở và chuyển đổi giá trị đọc được từ 0-1023 thành góc từ 0-180 độ.
```cpp
potValue = analogRead(potPin);           // Đọc giá trị từ điện trở điều chỉnh
angle = map(potValue, 0, 1023, 0, 180);  // Chuyển đổi giá trị đọc được từ 0-1023 thành góc từ 0-180 độ
```

Điều khiển servo quay đến góc đã chuyển đổi.
```cpp
servo.write(angle);                      // Điều khiển servo quay đến góc đã chuyển đổi
```

Chờ 15ms để servo có thời gian di chuyển đến vị trí.
```cpp
delay(15);                               // Chờ 15ms để servo có thời gian di chuyển đến vị trí
```

## Kết quả

?> Khi bạn xoay biến trở, động cơ Servo sẽ quay theo góc mà bạn điều chỉnh. Nếu bạn xoay biến trở từ 0 đến 180 độ, động cơ Servo sẽ quay từ vị trí 0 độ đến 180 độ tương ứng.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/servo/potentiometer-servo-result.gif" alt="potentiometer-servo-result">
    <p><em>Kết quả</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn cách sử dụng biến trở để điều chỉnh góc quay của động cơ Servo với vi điều khiển Zerobase, thông qua việc đọc tín hiệu từ biến trở và điều khiển góc quay của động cơ Servo. Đây là một ứng dụng cơ bản nhưng rất hữu ích trong điều khiển điện tử.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Bạn có thể thử thêm các cảm biến khác như cảm biến khoảng cách (ultrasonic sensor) để điều khiển góc quay của Servo theo khoảng cách từ vật thể.
- Phát triển hệ thống điều khiển Servo từ xa qua Bluetooth hoặc Wi-Fi, mở rộng ứng dụng trong các thiết bị IoT.
- Điều khiển nhiều động cơ Servo cùng lúc bằng biến trở.

**Chúc bạn thành công!**



