<br>
<br>
<br>

# Điều khiển Relay từ xa bằng remote hồng ngoại

![ir-remote-circuit](https://cdn.chipstack.vn/zerobase/ir-remote/ir-remote-circuit.jpg)

## Tổng quan

Bài hướng dẫn này sẽ giúp bạn điều khiển Relay từ xa bằng remote hồng ngoại.

## Chuẩn bị

| Linh kiện | Link mua |
|--- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Module relay 5V 2 kênh mức thấp |[Mua ngay](https://chipstack.vn/san-pham/module-relay-5v-2-kenh-muc-thap/) |
| Điện trở 330Ω |[Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED |[Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| LED thu hồng ngoại 3 chân VS1838B | [Mua ngay](https://chipstack.vn/san-pham/led-thu-hong-ngoai-3-chan-vs1838b/) |
| Remote hồng ngoại 17 phím | [Mua ngay](https://chipstack.vn/san-pham/remote-hong-ngoai-17-phim/) |

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

<div align="center">
    <img src="https://cdn.chipstack.vn/default/module-relay-5v-2-kenh-muc-thap.jpg" alt="module-relay-5v-2-kenh-muc-thap">
    <p><em>Module relay 5V 2 kênh mức thấp</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/ir-remote/ir-receiver.png" alt="ir-receiver">
    <p><em>LED thu hồng ngoại 3 chân VS1838B</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/ir-remote/ir-remote.jpg" alt="remote">
    <p><em>Remote hồng ngoại 17 phím</em></p>
</div>


## Nguyên lý hoạt động

?> Sử dụng module VS1838B để nhận tín hiệu hồng ngoại từ remote điều khiển. Tín hiệu này được mã hóa theo chuẩn NEC với chuỗi xung gồm phần mở đầu và 32 bit dữ liệu. Zerobase sẽ đọc các xung này thông qua chân tín hiệu IR và đo thời gian để xác định giá trị từng bit.

?> Chương trình sử dụng các hàm đo xung để phân biệt giữa bit 0 và bit 1 dựa vào độ rộng xung HIGH. Sau khi hoàn tất quá trình giải mã, một giá trị 32 bit (mã lệnh) sẽ được thu được. Mã này sau đó được đối chiếu với các giá trị đã lập trình sẵn để xác định hành động tương ứng.

?> Tùy theo mã lệnh nhận được, Zerobase sẽ điều khiển bật hoặc tắt relay qua các chân số 10 và 11. Vì relay sử dụng mức điều khiển thấp, ghi LOW sẽ bật và HIGH sẽ tắt. Qua đó, người dùng có thể điều khiển thiết bị điện từ xa như bật/tắt đèn, quạt hoặc ổ cắm thông minh một cách dễ dàng và linh hoạt.

## Sơ đồ kết nối

![irir-receiver-vs1838b-pinout](https://cdn.chipstack.vn/zerobase/ir-remote/ir-receiver-vs1838b-pinout.png)

![zerobase-ir-remote-pins](https://cdn.chipstack.vn/zerobase/ir-remote/zerobase-ir-remote-pins.png)

Sử dụng chân D2 của board Zerobase để nối với chân tín hiệu của LED thu hồng ngoại. Chân 5V nối với chân VCC của LED thu hồng ngoại, chân GND nối với chân GND của LED thu hồng ngoại.

Chân D10 và D11 được kết nối với chân IN1 và IN2 của relay.
Chân VCC của relay nối với chân 5V của board Zerobase, chân GND nối với chân GND của board Zerobase.

Chân anode (+) của LED đỏ nối nối với NO (Normally Open) của relay 1, từ COM (Common) của relay 1 nối với nguồn 5V. Chân cathode (-) của LED nối với một chân của điện trở 330Ω, chân còn lại của điện trở nối với GND của board Zerobase.

LED xanh lá nối tương tự như LED đỏ, nhưng nối với relay 2.

![ir-remote-schematic](https://cdn.chipstack.vn/zerobase/ir-remote/ir-remote-schematic.png)

![ir-remote-circuit](https://cdn.chipstack.vn/zerobase/ir-remote/ir-remote-circuit.jpg)

## Code

```cpp
// Khai báo chân nhận tín hiệu IR
const int IR_PIN 2  // Chân D2 kết nối với chân OUT của VS1838B

// Thời gian chờ timeout (10ms) cho từng bước khi chờ trạng thái HIGH hoặc LOW
const int TIMEOUT_US 10000

// Khai báo chân điều khiển relay
const int RELAY1_PIN 10  // Relay 1 kết nối chân D10
const int RELAY2_PIN 11  // Relay 2 kết nối chân D11

void setup() {
  pinMode(IR_PIN, INPUT);  // Đặt chân IR là đầu vào để nhận tín hiệu từ remote

  pinMode(RELAY1_PIN, OUTPUT);  // Đặt chân relay 1 là đầu ra
  pinMode(RELAY2_PIN, OUTPUT);  // Đặt chân relay 2 là đầu ra

  // Relay mức thấp: LOW là bật, HIGH là tắt
  digitalWrite(RELAY1_PIN, HIGH);  // Tắt relay 1 lúc khởi động
  digitalWrite(RELAY2_PIN, HIGH);  // Tắt relay 2 lúc khởi động
}

// Hàm chờ cho đến khi IR_PIN có trạng thái 'state', hoặc hết thời gian timeout_us
bool waitForState(int state, unsigned long timeout_us) {
  unsigned long start = micros();  // Lưu thời điểm bắt đầu
  while (digitalRead(IR_PIN) != state) {
    if ((micros() - start) > timeout_us) {
      return false;  // Nếu quá thời gian chờ, thoát và trả về false
    }
  }
  return true;  // Nếu đến trạng thái đúng, trả về true
}

// Hàm đọc tín hiệu IR theo giao thức NEC
unsigned long readIR() {
  // Bước 1: Chờ tín hiệu bắt đầu (Start signal) = 9ms LOW + 4.5ms HIGH
  if (!waitForState(LOW, TIMEOUT_US)) return 0;  // Chờ bắt đầu xuống LOW
  unsigned long t1 = micros();
  if (!waitForState(HIGH, TIMEOUT_US)) return 0;  // Kết thúc phần LOW
  unsigned long t2 = micros();
  if ((t2 - t1) < 8000 || (t2 - t1) > 10000) return 0;  // Kiểm tra có phải 9ms không

  // Bước 2: Chờ phần HIGH 4.5ms
  t1 = micros();
  if (!waitForState(LOW, TIMEOUT_US)) return 0;
  t2 = micros();
  if ((t2 - t1) < 4000 || (t2 - t1) > 5000) return 0;  // Kiểm tra có phải 4.5ms không

  // Bước 3: Đọc 32 bit dữ liệu từ remote
  unsigned long data = 0;
  for (int i = 0; i < 32; i++) {
    if (!waitForState(HIGH, TIMEOUT_US)) return 0;  // Bắt đầu HIGH của bit
    t1 = micros();
    if (!waitForState(LOW, TIMEOUT_US)) return 0;  // Kết thúc HIGH
    t2 = micros();

    unsigned long pulse = t2 - t1;  // Đo thời gian HIGH

    if (pulse > 1000) {
      data = (data << 1) | 1;  // Nếu HIGH dài (~1.69ms) => bit 1
    } else {
      data = (data << 1);  // Nếu HIGH ngắn (~0.56ms) => bit 0
    }
  }

  return data;  // Trả về mã IR đọc được
}

void loop() {
  unsigned long irCode = readIR();  // Gọi hàm đọc tín hiệu IR

  if (irCode != 0) {  // Nếu có mã IR nhận được

    // Xử lý mã lệnh từ remote
    switch (irCode) {
      case 0xFFA25D:  // Nút: bật relay 1
        digitalWrite(RELAY1_PIN, LOW);
        break;

      case 0xFF629D:  // Nút: bật relay 2
        digitalWrite(RELAY2_PIN, LOW);
        break;

      case 0xFFE21D:  // Nút: tắt relay 1
        digitalWrite(RELAY1_PIN, HIGH);
        break;

      case 0xFF22DD:  // Nút: tắt relay 2
        digitalWrite(RELAY2_PIN, HIGH);
        break;

      case 0xFF02FD:  // Nút: bật cả 2 relay
        digitalWrite(RELAY1_PIN, LOW);
        digitalWrite(RELAY2_PIN, LOW);
        break;

      case 0xFFC23D:  // Nút: tắt cả 2 relay
        digitalWrite(RELAY1_PIN, HIGH);
        digitalWrite(RELAY2_PIN, HIGH);
        break;
    }
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![ir-remote-code](https://cdn.chipstack.vn/zerobase/ir-remote/ir-remote-code.png "ir-remote-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code
Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

### Giải thích code

Dòng này khai báo hằng số `IR_PIN` có giá trị là 2, tương ứng với chân D2 trên Arduino. Chân này được dùng để nhận tín hiệu hồng ngoại từ remote thông qua cảm biến VS1838B.
```cpp
// Khai báo chân nhận tín hiệu IR
const int IR_PIN = 2;  // Chân D2 kết nối với chân OUT của VS1838B
```

Khai báo hằng số `TIMEOUT_US` có giá trị là 10000 micro giây (tương đương 10ms). Giá trị này được sử dụng làm thời gian chờ tối đa khi kiểm tra tín hiệu IR ở các trạng thái HIGH hoặc LOW.
```cpp
// Thời gian chờ timeout (10ms) cho từng bước khi chờ trạng thái HIGH hoặc LOW
const int TIMEOUT_US = 10000;
```

Hai dòng này khai báo chân điều khiển relay: `RELAY1_PIN` là chân D10 dùng để điều khiển relay 1, và `RELAY2_PIN` là chân D11 dùng để điều khiển relay 2.
```cpp
// Khai báo chân điều khiển relay
const int RELAY1_PIN = 10;  // Relay 1 kết nối chân D10
const int RELAY2_PIN = 11;  // Relay 2 kết nối chân D11
```

Hàm `setup()` được Arduino gọi một lần duy nhất khi bắt đầu chạy chương trình.
```cpp
void setup() {
```

Cấu hình chân `IR_PIN` (D2) là đầu vào để có thể đọc tín hiệu từ cảm biến hồng ngoại.
```cpp
  pinMode(IR_PIN, INPUT);  // Đặt chân IR là đầu vào để nhận tín hiệu từ remote
```

Cấu hình chân `RELAY1_PIN` (D10) là đầu ra để điều khiển relay 1.
```cpp
  pinMode(RELAY1_PIN, OUTPUT);  // Đặt chân relay 1 là đầu ra
```

Cấu hình chân `RELAY2_PIN` (D11) là đầu ra để điều khiển relay 2.
```cpp
  pinMode(RELAY2_PIN, OUTPUT);  // Đặt chân relay 2 là đầu ra
```

Đặt chân D10 ở mức HIGH, tức tắt relay 1 theo logic relay mức thấp.
```cpp
  digitalWrite(RELAY1_PIN, HIGH);  // Tắt relay 1 lúc khởi động
```

Đặt chân D11 ở mức HIGH, tức tắt relay 2 theo logic relay mức thấp.
```cpp
  digitalWrite(RELAY2_PIN, HIGH);  // Tắt relay 2 lúc khởi động
```

Kết thúc hàm `setup()`.
```cpp
}
```

Khai báo hàm `waitForState`, nhận vào 2 tham số: `state` (trạng thái cần chờ: HIGH hoặc LOW) và `timeout_us` (thời gian chờ tối đa).
```cpp
bool waitForState(int state, unsigned long timeout_us) {
```

Lưu lại thời điểm hiện tại tính bằng micro giây để tính toán thời gian chờ.
```cpp
  unsigned long start = micros();  // Lưu thời điểm bắt đầu
```

Lặp liên tục đến khi tín hiệu đọc từ chân IR bằng với trạng thái mong muốn (`state`).
```cpp
  while (digitalRead(IR_PIN) != state) {
```

Kiểm tra nếu thời gian chờ vượt quá `timeout_us` thì kết thúc vòng lặp.
```cpp
    if ((micros() - start) > timeout_us) {
```

Trả về `false` nếu không đạt được trạng thái mong muốn trong thời gian cho phép.
```cpp
      return false;  // Nếu quá thời gian chờ, thoát và trả về false
```

Kết thúc điều kiện `if`.
```cpp
    }
```

Kết thúc vòng lặp `while`.
```cpp
  }
```

Trả về `true` nếu tín hiệu đã đạt trạng thái mong muốn.
```cpp
  return true;  // Nếu đến trạng thái đúng, trả về true
```

Kết thúc hàm `waitForState`.
```cpp
}
```

Khai báo hàm `readIR`, trả về mã tín hiệu IR dạng số nguyên không dấu 32-bit.
```cpp
unsigned long readIR() {
```

Chờ tín hiệu bắt đầu: tín hiệu phải xuống mức LOW, nếu không đúng thời gian thì trả về 0.
```cpp
  if (!waitForState(LOW, TIMEOUT_US)) return 0;
```

Lưu lại thời điểm bắt đầu của mức LOW.
```cpp
  unsigned long t1 = micros();
```

Chờ kết thúc mức LOW để chuyển sang HIGH. Nếu vượt thời gian thì trả về 0.
```cpp
  if (!waitForState(HIGH, TIMEOUT_US)) return 0;
```

Lưu thời điểm bắt đầu của mức HIGH.
```cpp
  unsigned long t2 = micros();
```

Kiểm tra xem khoảng thời gian mức LOW có nằm trong khoảng 9ms (8000-10000us) không. Nếu không đúng thì trả về 0.
```cpp
  if ((t2 - t1) < 8000 || (t2 - t1) > 10000) return 0;
```

Lưu lại thời điểm bắt đầu mức HIGH của phần 4.5ms tiếp theo.
```cpp
  t1 = micros();
```

Chờ kết thúc mức HIGH (chuyển sang LOW). Nếu không xảy ra đúng thời điểm thì trả về 0.
```cpp
  if (!waitForState(LOW, TIMEOUT_US)) return 0;
```

Lưu lại thời điểm bắt đầu mức LOW.
```cpp
  t2 = micros();
```

Kiểm tra độ dài mức HIGH có nằm trong khoảng 4.5ms không (4000-5000us). Nếu sai thì trả về 0.
```cpp
  if ((t2 - t1) < 4000 || (t2 - t1) > 5000) return 0;
```

Tạo biến `data` để lưu dữ liệu nhận được từ remote.
```cpp
  unsigned long data = 0;
```

Bắt đầu vòng lặp đọc 32 bit dữ liệu từ remote.
```cpp
  for (int i = 0; i < 32; i++) {
```

Chờ bắt đầu tín hiệu HIGH của từng bit.
```cpp
    if (!waitForState(HIGH, TIMEOUT_US)) return 0;
```

Lưu thời điểm bắt đầu mức HIGH.
```cpp
    t1 = micros();
```

Chờ kết thúc mức HIGH (bắt đầu mức LOW).
```cpp
    if (!waitForState(LOW, TIMEOUT_US)) return 0;
```

Lưu thời điểm bắt đầu mức LOW.
```cpp
    t2 = micros();
```

Tính thời gian mà tín hiệu giữ mức HIGH.
```cpp
    unsigned long pulse = t2 - t1;
```

Nếu khoảng thời gian HIGH > 1000us (tương đương 1.69ms), đó là bit 1.
```cpp
    if (pulse > 1000) {
```

Dịch trái `data` 1 bit và gán thêm 1 vào bit cuối cùng.
```cpp
      data = (data << 1) | 1;
```

Ngược lại, nếu thời gian ngắn hơn thì đó là bit 0.
```cpp
    } else {
```

Dịch trái `data` 1 bit và gán thêm 0.
```cpp
      data = (data << 1);
```

Kết thúc điều kiện `if-else`.
```cpp
    }
```

Kết thúc vòng lặp đọc 32 bit.
```cpp
  }
```

Trả về mã điều khiển đọc được từ remote.
```cpp
  return data;  // Trả về mã IR đọc được
```

Kết thúc hàm `readIR()`.
```cpp
}
```

Trong hàm `loop()`, gọi hàm `readIR()` để đọc mã IR từ remote.
```cpp
void loop() {
  unsigned long irCode = readIR();  // Gọi hàm đọc tín hiệu IR
```

Nếu mã IR khác 0, tức là có tín hiệu từ remote.
```cpp
  if (irCode != 0) {  // Nếu có mã IR nhận được
```

Xử lý mã lệnh từ remote bằng cách sử dụng cấu trúc `switch-case`.
```cpp
    // Xử lý mã lệnh từ remote
    switch (irCode)
```

Nếu mã lệnh hợp lệ 1 trong các mã lệnh đã định nghĩa, thực hiện bật, tắt, bật tất cả hoặc tắt tất cả relay.
```cpp
      case 0xFFA25D:  // Nút: bật relay 1
        digitalWrite(RELAY1_PIN, LOW);
        break;

      case 0xFF629D:  // Nút: bật relay 2
        digitalWrite(RELAY2_PIN, LOW);
        break;

      case 0xFFE21D:  // Nút: tắt relay 1
        digitalWrite(RELAY1_PIN, HIGH);
        break;

      case 0xFF22DD:  // Nút: tắt relay 2
        digitalWrite(RELAY2_PIN, HIGH);
        break;

      case 0xFF02FD:  // Nút: bật cả 2 relay
        digitalWrite(RELAY1_PIN, LOW);
        digitalWrite(RELAY2_PIN, LOW);
        break;

      case 0xFFC23D:  // Nút: tắt cả 2 relay
        digitalWrite(RELAY1_PIN, HIGH);
        digitalWrite(RELAY2_PIN, HIGH);
        break;
```

## Kết quả

?> Khi nhấn nút trên remote, relay sẽ bật hoặc tắt tương ứng với mã lệnh đã lập trình. Bạn có thể điều khiển thiết bị điện từ xa một cách dễ dàng và tiện lợi.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/ir-remote/ir-remote-result.gif" alt="ir-remote-result">
    <p><em>Điều khiển Relay từ xa bằng remote hồng ngoại</em></p>
</div>

## Kết luận và hướng phát triển

Bạn đã hoàn thành việc điều khiển Relay từ xa bằng remote hồng ngoại. Bạn có thể mở rộng dự án này để điều khiển nhiều thiết bị khác nhau hoặc kết hợp với các cảm biến khác để tạo ra các ứng dụng thông minh hơn.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Thêm nhiều nút trên remote để điều khiển nhiều thiết bị khác nhau.
- Kết hợp với cảm biến nhiệt độ hoặc độ ẩm để tự động bật/tắt thiết bị dựa trên điều kiện môi trường.
- Thay vì điều khiển LED, bạn có thể điều khiển các thiết bị điện khác như quạt, đèn, hoặc ổ cắm thông minh.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)

