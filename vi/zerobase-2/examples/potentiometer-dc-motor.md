<br>
<br>
<br>

# Điều khiển động cơ DC bằng biến trở

![potentiometer-dc-motor-circuit](https://cdn.chipstack.vn/zerobase2/dc-motor/potentiometer-dc-motor-circuit.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ DC bằng biến trở (potentiometer) trên board Zerobase 2. Bạn có thể điều chỉnh tốc độ quay và đảo chiều của động cơ DC bằng cách xoay biến trở.

## Chuẩn bị

| Linh kiện | Link mua |
|--- | --- |
| Board Zerobase 2|[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Động cơ DC 2 trục tỷ lệ 1:120 | [Mua ngay](https://chipstack.vn/san-pham/dong-co-dc-2-truc-ty-le-1120/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |
| Module cầu H điều khiển động cơ DC | [Mua ngay](https://chipstack.vn/san-pham/module-cau-h-dieu-khien-dong-co-dc/) |
| Biến trở 10kΩ | [Mua ngay](https://chipstack.vn/san-pham/bien-tro-wh148-3-chan-truc-15mm/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/dong-co-dc.jpg" alt="dong-co-dc">
    <p><em>Động cơ DC 2 trục tỷ lệ 1:120</em></p>
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
    <p><em>Module nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/dc-motor/module-cau-h-dong-co-dc.jpg">
    <p><em>Module cầu H điều khiển động cơ DC</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/potentiometer/potentiometer.jpg" alt="potentiometer">
    <p><em>Biến trở 10kΩ</em></p>
</div>


## Nguyên lý hoạt động

| In1 (IN3) | In2 (IN4) | Chế độ |
|--- |--- |--- |
| LOW (0) | LOW (0) | Standby (Dừng từ từ) |
| PWM hoặc HIGH (1) | LOW (0) | Quay xuôi |
| LOW (0) | PWM hoặc HIGH (1) | Quay ngược |
| HIGH (1) | HIGH (1) | Brake (Dừng cưỡng bức) |

?> Động cơ được điều khiển qua hai chân IN1 và IN2 kết hợp với xung PWM để điều chỉnh tốc độ và chiều quay. Khi cả hai chân ở mức LOW, động cơ ở trạng thái standby (dừng tự do). Nếu IN1 là PWM/HIGH và IN2 là LOW, động cơ quay xuôi; ngược lại, nếu IN1 là LOW và IN2 là PWM/HIGH, động cơ quay ngược. Khi cả hai đều HIGH, động cơ phanh gấp (brake).

?> Khi xoay biến trở, giá trị điện áp thay đổi sẽ được vi điều khiển đọc thông qua chân ADC. Nếu giá trị ADC nhỏ hơn 515, động cơ sẽ quay theo một chiều (quay xuôi), và càng nhỏ thì tốc độ quay càng nhanh. Nếu giá trị ADC lớn hơn 524, động cơ quay theo chiều ngược lại (quay ngược), và càng lớn thì tốc độ cũng càng cao. Trong khoảng giữa 515–524, động cơ sẽ dừng. 

?> Tín hiệu điều khiển tốc độ được tạo bằng xung PWM 12-bit, đảm bảo điều chỉnh mượt mà và chính xác. 

> Xem thêm về biến trở [tại đây](https://chipstack.vn/kien-thuc/dien-tu-co-ban/cau-tao-va-cach-mac-bien-tro-3-chan-chi-tiet-de-hieu/).

## Sơ đồ kết nối

![zerobase2-potentiometer-dc-motor-pins](https://cdn.chipstack.vn/zerobase2/dc-motor/zerobase2-potentiometer-dc-motor-pins.png)

Sử dụng chân A3 để kết nối với chân giữa của biến trở, một chân của biến trở nối với nguồn 3.3V và chân còn lại nối với GND của board Zerobase 2.

Chân D3 được kết nối với chân IN1 của module cầu H, chân D2 được kết nối với chân IN2 của module cầu H.

Chân 3.3V của board Zerobase 2 được nối với 3.3V của module nguồn.

Chân GND của module cầu H được nối với GND của board Zerobase 2 và nguồn. Chân 5V của module cầu H được nối với chân 5V của nguồn.

Một chân MOTOR A của module cầu H được nối với cực dương của động cơ DC, chân còn lại nối với cực âm của động cơ DC.

![potentiometer-dc-motor-schematic](https://cdn.chipstack.vn/zerobase2/dc-motor/potentiometer-dc-motor-schematic.png)

![potentiometer-dc-motor-circuit](https://cdn.chipstack.vn/zerobase2/dc-motor/potentiometer-dc-motor-circuit.jpg)

!> **Ngắt nguồn trước khi nạp code**: Trước khi cắm dây USB vào để nạp code vào board Zerobase 2, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase 2 và chạy code bình thường.

!> **Không dùng nguồn 5V từ Zerobase 2 cho động cơ**: Tuyệt đối không nối 5V trực tiếp của board Zerobase 2 vào động cơ DC, vì động cơ DC có thể tiêu tốn dòng điện lớn hơn mức cho phép của board Zerobase 2, dẫn đến hỏng board.

!> **Cấp nguồn cho Zerobase 2 với 3.3V**: Bạn cần đảm bảo một bên của module nguồn MB102 830 đang ở chế độ 3.3V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 3.3V.

!> **Cấp nguồn cho module cầu H với 5V**: Bạn cần đảm bảo bên còn lại của module nguồn MB102 830 đang ở chế độ 5V bằng cách điều chỉnh công tắc trên module nguồn sang vị trí 5V.

## Code

```cpp
// Khai báo các chân điều khiển motor và chân đọc biến trở

const int motorIn1 = 3;  // Chân điều khiển hướng 1 của motor (PWM 12-bit)
const int motorIn2 = 2;  // Chân điều khiển hướng 2 của motor (PWM 12-bit hoặc digital)
const int potPin = A3;   // Chân đọc giá trị biến trở (ADC 10-bit)

void setup() {
  // Cấu hình các chân I/O

  pinMode(motorIn1, OUTPUT);      // Thiết lập chân motorIn1 là OUTPUT để xuất tín hiệu PWM/digital
  pinMode(motorIn2, OUTPUT);      // Thiết lập chân motorIn2 là OUTPUT để điều khiển hướng quay khác
  pinMode(potPin, INPUT_ANALOG);  // Thiết lập chân potPin là INPUT_ANALOG để đọc giá trị ADC từ biến trở
}

void loop() {
  // Vòng lặp chính – thực hiện liên tục

  int sensorValue = analogRead(potPin);  // Đọc giá trị điện áp từ biến trở (0 - 1023 vì là ADC 10-bit)
  int pwmValue;                          // Biến dùng để lưu giá trị PWM sẽ xuất ra motor

  if (sensorValue < 515) {
    // Nếu giá trị biến trở nhỏ hơn 515 => điều khiển motor quay ngược

    pwmValue = map(sensorValue, 0, 515, 4095, 0);
    // Ánh xạ giá trị ADC 0–515 thành PWM từ 4095 (tốc độ tối đa) về 0 (tốc độ dừng)
    // Càng vặn nhỏ biến trở thì tốc độ càng cao (quay ngược)

    analogWrite(motorIn1, 0);         // Đặt motorIn1 = 0
    analogWrite(motorIn2, pwmValue);  // Xuất PWM tới motorIn2 để quay ngược

  } else if (sensorValue > 524) {
    // Nếu giá trị biến trở lớn hơn 524 => điều khiển motor quay xuôi

    pwmValue = map(sensorValue, 524, 1023, 0, 4095);
    // Ánh xạ giá trị ADC từ 524–1023 thành PWM 0–4095
    // Càng vặn lớn biến trở thì tốc độ càng cao (quay xuôi)

    analogWrite(motorIn1, pwmValue);  // Xuất xung PWM (12-bit) tới motorIn1 để quay xuôi
    analogWrite(motorIn2, 0);         // Đặt motorIn2 = 0 để tạo phân cực đúng chiều quay
  } else {
    // Nếu giá trị nằm trong khoảng 515–524 => vùng chết (deadzone) => dừng motor

    analogWrite(motorIn1, 0);  // Dừng xuất PWM
    analogWrite(motorIn2, 0);  // Dừng xuất PWM
  }

  delay(5);  // Delay nhỏ để tránh nhiễu, cho phép cập nhật tốc độ thường xuyên
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![potentiometer-dc-motor-code](https://cdn.chipstack.vn/zerobase2/dc-motor/potentiometer-dc-motor-code.png "potentiometer-dc-motor-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị của biến `motorIn1`, `motorIn2` hoặc `potPin` sau đó kết nối LED và biến trở với chân tương ứng.

```cpp
const int motorIn1 = 3;  // Chân điều khiển hướng 1 của motor (PWM 12-bit)
const int motorIn2 = 2;  // Chân điều khiển hướng 2 của motor (PWM 12-bit hoặc digital)
const int potPin = A3;   // Chân đọc giá trị biến trở (ADC 10-bit)
```

### Giải thích code

Khai báo chân kết nối điều khiển motor và biến trở.

```cpp
const int motorIn1 = 3;  // Chân điều khiển hướng 1 của motor (PWM 12-bit)
const int motorIn2 = 2;  // Chân điều khiển hướng 2 của motor (PWM 12-bit hoặc digital)
const int potPin = A3;   // Chân đọc giá trị biến trở (ADC 10-bit)
```

Trong hàm `setup()`, cấu hình các chân I/O. Chân motorIn1 và motorIn2 được thiết lập là OUTPUT để xuất tín hiệu PWM/digital, trong khi chân potPin được thiết lập là INPUT_ANALOG để đọc giá trị ADC từ biến trở.

```cpp
void setup() {
  pinMode(motorIn1, OUTPUT);      // Thiết lập chân motorIn1 là OUTPUT để xuất tín hiệu PWM/digital
  pinMode(motorIn2, OUTPUT);      // Thiết lập chân motorIn2 là OUTPUT để điều khiển hướng quay khác
  pinMode(potPin, INPUT_ANALOG);  // Thiết lập chân potPin là INPUT_ANALOG để đọc giá trị ADC từ biến trở
}
```

Trong hàm `loop()`, đọc giá trị điện áp từ biến trở (0 - 1023 vì là ADC 10-bit).

```cpp
int sensorValue = analogRead(potPin);  // Đọc giá trị điện áp từ biến trở (0 - 1023 vì là ADC 10-bit)
int pwmValue;                          // Biến dùng để lưu giá trị PWM sẽ xuất ra motor
```

Nếu giá trị biến trở nhỏ hơn 515, điều khiển motor quay ngược. Ánh xạ giá trị ADC 0–515 thành PWM từ 4095 (tốc độ tối đa) về 0 (tốc độ dừng). Càng vặn nhỏ biến trở thì tốc độ càng cao (quay ngược).

```cpp
if (sensorValue < 515) {
    pwmValue = map(sensorValue, 0, 515, 4095, 0);
    // Ánh xạ giá trị ADC 0–515 thành PWM từ 4095 (tốc độ tối đa) về 0 (tốc độ dừng)
    // Càng vặn nhỏ biến trở thì tốc độ càng cao (quay ngược)

    analogWrite(motorIn1, 0);         // Đặt motorIn1 = 0
    analogWrite(motorIn2, pwmValue);  // Xuất PWM tới motorIn2 để quay ngược
```
Nếu giá trị biến trở lớn hơn 524, điều khiển motor quay xuôi. Ánh xạ giá trị ADC từ 524–1023 thành PWM 0–4095. Càng vặn lớn biến trở thì tốc độ càng cao (quay xuôi).

```cpp
} else if (sensorValue > 524) {
    pwmValue = map(sensorValue, 524, 1023, 0, 4095);
    // Ánh xạ giá trị ADC từ 524–1023 thành PWM 0–4095
    // Càng vặn lớn biến trở thì tốc độ càng cao (quay xuôi)

    analogWrite(motorIn1, pwmValue);  // Xuất xung PWM (12-bit) tới motorIn1 để quay xuôi
    analogWrite(motorIn2, 0);         // Đặt motorIn2 = 0 để tạo phân cực đúng chiều quay
```

Nếu giá trị nằm trong khoảng 515–524, dừng motor.

```cpp
} else {
    analogWrite(motorIn1, 0);  // Dừng xuất PWM
    analogWrite(motorIn2, 0);  // Dừng xuất PWM
}
```

## Kết quả

?> Sau khi nạp code thành công, bạn có thể xoay biến trở để điều chỉnh tốc độ quay của động cơ DC. Nếu bạn xoay theo chiều kim đồng hồ, động cơ sẽ quay xuôi; nếu bạn xoay ngược chiều kim đồng hồ, động cơ sẽ quay ngược. Khi bạn dừng lại ở giữa, động cơ sẽ dừng lại.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/dc-motor/potentiometer-dc-motor-result.gif" alt="potentiometer-dc-motor-result">
</div>

## Kết luận và hướng phát triển

Bạn đã hoàn thành việc điều khiển động cơ DC bằng biến trở trên board Zerobase 2. Đây là một ứng dụng thú vị và hữu ích trong việc điều khiển tốc độ và chiều quay của động cơ DC.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Thêm màn hình LCD để hiển thị giá trị tốc độ hoặc chiều quay.
- Dùng encoder để phản hồi tốc độ thực tế của motor và điều khiển PID.
- Kết hợp với cảm biến siêu âm để điều khiển động cơ theo khoảng cách.
- Thêm các nút nhấn để điều khiển động cơ theo các chế độ khác nhau (quay xuôi, quay ngược, dừng, phanh gấp).
- Nâng cấp điều khiển sang sử dụng giao tiếp UART, I2C hoặc Bluetooth để điều khiển từ xa.
- Kết hợp với các cảm biến khác như cảm biến ánh sáng, cảm biến nhiệt độ để điều khiển động cơ theo môi trường xung quanh.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)




