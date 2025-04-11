<br>
<br>
<br>

# Điều khiển động cơ bước 28BYJ-48

![stepper-circuit](https://cdn.chipstack.vn/zerobase/stepper/stepper-circuit.png)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách điều khiển động cơ bước 28BYJ-48 với Zerobase. Động cơ bước 28BYJ-48 là một loại động cơ bước phổ biến, thường được sử dụng trong các ứng dụng như máy in 3D, robot và các thiết bị tự động hóa khác.

## Chuẩn bị

| Linh kiện | Link mua |
| --- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Động cơ bước 28BYJ-48 |[Mua ngay](https://chipstack.vn/san-pham/dong-co-buoc-28byj48/) |
| Module điều khiển động cơ bước ULN2003 | [Mua ngay](https://chipstack.vn/san-pham/module-dieu-khien-dong-co-buoc-uln2003/) |

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
    <img src="https://cdn.chipstack.vn/zerobase/stepper/28byj-48.png" alt="28byj-48">
    <p><em>Động cơ bước 28BYJ-48</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/stepper/uln2003.png" alt="uln2003">
    <p><em>Module điều khiển động cơ bước ULN2003</em></p>
</div>

## Nguyên lý hoạt động

?> Động cơ bước 28BYJ-48 là một loại động cơ bước có 4 dây điều khiển. Để điều khiển động cơ này, chúng ta cần sử dụng một module điều khiển động cơ bước, thường là ULN2003. Module này sẽ nhận tín hiệu từ Zerobase và điều khiển động cơ bước quay theo chiều kim đồng hồ hoặc ngược chiều kim đồng hồ.

?> Động cơ bước 28BYJ-48 có thể quay 360 độ với 2048 bước. Mỗi bước tương ứng với một góc quay là 0.175 độ. Để điều khiển động cơ quay một góc nhất định, chúng ta cần gửi tín hiệu điều khiển đến module ULN2003 theo thứ tự nhất định.

?> Chúng ta sẽ sử dụng thư viện `Stepper` trong Arduino để điều khiển động cơ bước 28BYJ-48. Thư viện này cung cấp các hàm để điều khiển động cơ bước một cách dễ dàng và hiệu quả.

?> Chúng ta sẽ sử dụng 4 chân GPIO trên Zerobase để điều khiển động cơ bước.

## Sơ đồ kết nối

![stepper-pins](https://cdn.chipstack.vn/zerobase/stepper/stepper-pins.png)

Sử dụng chân A0 nối với IN1, A1 nối với IN2, A2 nối với IN3, A3 nối với IN4 của module ULN2003. Chân GND của module ULN2003 nối với chân GND của Zerobase. Chân VCC của module ULN2003 nối với chân 5V của Zerobase.

![stepper-schematic](https://cdn.chipstack.vn/zerobase/stepper/stepper-schematic.png)

![stepper-circuit](https://cdn.chipstack.vn/zerobase/stepper/stepper-circuit.png)

## Code

```cpp
// Khai báo thư viện điều khiển motor bước với driver ULN2003
#include <Stepper.h>

// Số bước của một vòng quay (của 28BYJ-48 là khoảng 2048 bước/vòng)
const int stepsPerRevolution = 2048;

// Khởi tạo đối tượng Stepper
Stepper myStepper(stepsPerRevolution, A0, A2, A1, A3); 
// Chú ý thứ tự chân: IN1->IN3->IN2->IN4 theo ULN2003 datasheet

void setup() {
  // Đặt tốc độ quay (rpm)
  myStepper.setSpeed(15); // 15 vòng/phút
}

void loop() {
  // Quay một vòng theo chiều kim đồng hồ
  myStepper.step(stepsPerRevolution);
  delay(1000);

  // Quay một vòng ngược chiều kim đồng hồ
  myStepper.step(-stepsPerRevolution);
  delay(1000);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![stepper-code](https://cdn.chipstack.vn/zerobase/stepper/stepper-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu bạn muốn đổi các chân điều khiển động cơ, bạn có thể thay đổi các tham số trong hàm khởi tạo `Stepper` như sau:

```cpp
Stepper myStepper(stepsPerRevolution, A0, A2, A1, A3); 
```
Thay đổi các chân A0, A1, A2, A3 thành các chân mà bạn muốn sử dụng để điều khiển động cơ bước.

### Giải thích code

Khai báo thư viện `Stepper` để sử dụng các hàm điều khiển động cơ bước.

```cpp
#include <Stepper.h>
```

Khai báo số bước của một vòng quay. Đối với động cơ 28BYJ-48, số bước là 2048.

```cpp
const int stepsPerRevolution = 2048;
```

Khởi tạo đối tượng `Stepper` với số bước và các chân điều khiển động cơ. **Chú ý thứ tự chân: IN1->IN3->IN2->IN4 theo ULN2003 datasheet.**

```cpp
Stepper myStepper(stepsPerRevolution, A0, A2, A1, A3); 
```

Trong hàm `setup()`, đặt tốc độ quay của động cơ. Tốc độ này được tính bằng vòng/phút (rpm).

```cpp
void setup() {
  myStepper.setSpeed(15); // 15 vòng/phút
}
```

Trong hàm `loop()`, quay một vòng (360 độ) theo chiều kim đồng hồ và sau đó quay một vòng (360 độ) ngược chiều kim đồng hồ. Giữa hai lần quay có một khoảng thời gian delay 1 giây.

```cpp
void loop() {
  myStepper.step(stepsPerRevolution); // Quay một vòng theo chiều kim đồng hồ
  delay(1000); // Delay 1 giây

  myStepper.step(-stepsPerRevolution); // Quay một vòng ngược chiều kim đồng hồ
  delay(1000); // Delay 1 giây
}
```

## Kết quả

?> Khi bạn nạp code thành công, động cơ bước 28BYJ-48 sẽ quay một vòng theo chiều kim đồng hồ và sau đó quay một vòng ngược chiều kim đồng hồ. Bạn có thể thay đổi tốc độ quay bằng cách thay đổi giá trị trong hàm `setSpeed()`.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/stepper/stepper-result.gif" alt="stepper-result">
    <p><em>Động cơ bước 28BYJ-48 quay theo chiều kim đồng hồ và ngược chiều kim đồng hồ</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết này đã hướng dẫn bạn cách điều khiển động cơ bước 28BYJ-48 với Zerobase. Bạn có thể áp dụng kiến thức này để điều khiển các loại động cơ bước khác hoặc kết hợp với các cảm biến và thiết bị khác để tạo ra các ứng dụng tự động hóa thú vị.

Để phát triển thêm từ bài học này, bạn có thể thực hiện các ý tưởng sau:

- Sử dụng nút nhấn để điều khiển động cơ bước quay theo chiều kim đồng hồ hoặc ngược chiều kim đồng hồ.
- Thêm cảm biến để điều khiển động cơ bước quay đến một vị trí nhất định.
- Hiển thị góc quay lên màn hình LCD.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)









