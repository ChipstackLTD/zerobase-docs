<br>
<br>
<br>

# Xử lý chống dội nút nhấn (Debounce Button)

![debounce-button-circuit](https://cdn.chipstack.vn/zerobase/button/debounce-button-circuit.jpg)

## Tổng quan

?> Khi ta nhấn hoặc nhả một nút bấm cơ học (button), tín hiệu điện không thay đổi ngay lập tức một cách mượt mà. Thay vào đó, nó thường bị rung (bật tắt liên tục) trong vài milli-giây đầu tiên. Hiện tượng này được gọi là dội nút (bouncing).

?> Điều này khiến vi điều khiển (ví dụ: Arduino) hiểu sai là bạn đã nhấn nút nhiều lần liên tục, dù thực tế bạn chỉ nhấn một lần.

?> Bài viết này sẽ hướng dẫn xử lý chống dội nút nhấn.

## Chuẩn bị

## Chuẩn Bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Điện trở 330Ω | [Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED | [Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/button/push-button.png" alt="push-button">
    <p><em>Nút nhấn</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
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

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard-830-lo">
    <p><em>Breadboard</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

## Nguyên lý hoạt động

?> Bài viết này hướng dẫn 3 cách xử lý dội nút nhấn (debounce button) với Zerobase. Bạn có thể chọn cách nào phù hợp với mình nhé!

?> Cách 1: Ta sẽ dùng hàm millis() của Arduino để đo khoảng thời gian giữa các lần nhấn nút. Nếu nút chỉ được nhấn sau một khoảng thời gian ổn định (ví dụ 50ms), thì mới tính là nhấn thật.
Nhờ vậy, chương trình vẫn tiếp tục chạy mượt mà, không bị dừng lại bởi delay().

?> Cách 2: Sau khi phát hiện nút được nhấn, ta chờ một khoảng thời gian ngắn (ví dụ delay(50)), rồi mới kiểm tra lại. Nếu sau thời gian đó nút vẫn đang được nhấn, thì mới tính là nhấn hợp lệ.

?> Cách 3: Sử dụng thư viện Bounce2. Bounce2 là thư viện được thiết kế chuyên xử lý dội nút. Nó giúp bạn quản lý nút nhấn một cách gọn gàng, hiệu quả và chuyên nghiệp hơn. Chỉ cần gọi .update() và kiểm tra .fell() hoặc .rose(), bạn sẽ biết khi nào nút được nhấn hoặc nhả – đã được xử lý dội sẵn.

## Sơ đồ kết nối

![debounce-button-pins](https://cdn.chipstack.vn/zerobase/button/debounce-button-pins.png "debounce-button-pins")

Sử dụng chân D2 để kết nối với điện trở 330ohm nối tiếp với cực Anode (+) của LED và GND để kết nối với cực Cathode (-) của LED.

Sử dụng chânD3) để kết nối với nút nhấn và GND để kết nối với chân còn lại của nút nhấn.

![debounce-button-schematic](https://cdn.chipstack.vn/zerobase/button/debounce-button-schematic.png "debounce-button-schematic")

![debounce-button-circuit](https://cdn.chipstack.vn/zerobase/button/debounce-button-circuit.jpg "debounce-button-circuit")

## Code

### Cách 1: Sử dụng hàm delay()

Ưu điểm:

- Code đơn giản, dễ hiểu cho người mới bắt đầu

Nhược điểm:

- Làm chương trình bị đứng lại trong thời gian delay()

- Không thích hợp khi bạn cần thực hiện nhiều việc cùng lúc

```cpp
// Khai báo chân kết nối nút nhấn (button) là chân số 3
const int buttonPin = 3;

// Khai báo chân kết nối LED là chân số 2
const int ledPin = 2;

// Thời gian chống dội phím (debounce) tính bằng mili giây
const int debounceTime = 50;

void setup() {
  // Cấu hình chân nút nhấn là INPUT với điện trở kéo lên nội (INPUT_PULLUP)
  pinMode(buttonPin, INPUT_PULLUP);

  // Cấu hình chân LED là OUTPUT
  pinMode(ledPin, OUTPUT);
}

void loop() {
  // Kiểm tra nếu nút được nhấn (LOW vì dùng INPUT_PULLUP)
  if (digitalRead(buttonPin) == LOW) {
    // Đợi một khoảng thời gian để chống dội phím
    delay(debounceTime);

    // Kiểm tra lại trạng thái nút sau thời gian debounce
    if (digitalRead(buttonPin) == LOW) {
      // Đảo trạng thái hiện tại của LED (BẬT thành TẮT, TẮT thành BẬT)
      digitalWrite(ledPin, !digitalRead(ledPin));

      // Chờ cho đến khi nút được nhả ra
      while (digitalRead(buttonPin) == LOW)
        ;  // Chờ đến khi nút được nhả ra
    }
  }
}
```

### Cách 2: Sử dụng hàm millis()

Ưu điểm:

- Không gây treo chương trình

- Phù hợp với các dự án có nhiều tác vụ chạy song song (ví dụ: LED, cảm biến, relay...)

Nhược điểm:

- Code phức tạp hơn một chút so với cách 1

```cpp
// Code điều khiển LED bằng nút nhấn có debounce
// Button ở chân D3, LED ở chân D2

// Định nghĩa các chân
const int buttonPin = 3;  // Chân D3 cho nút nhấn
const int ledPin = 2;     // Chân D2 cho đèn LED

// Biến trạng thái
int ledState = LOW;         // Trạng thái hiện tại của LED
int buttonState;            // Trạng thái hiện tại của nút nhấn
int lastButtonState = LOW;  // Trạng thái trước đó của nút nhấn

// Biến thời gian cho debounce
unsigned long lastDebounceTime = 0;  // Thời điểm cuối cùng mà nút nhấn thay đổi trạng thái
unsigned long debounceDelay = 50;    // Thời gian debounce, đơn vị mili giây

void setup() {
  // Cấu hình chân INPUT với điện trở kéo lên cho nút nhấn
  pinMode(buttonPin, INPUT_PULLUP);
  // Cấu hình chân OUTPUT cho LED
  pinMode(ledPin, OUTPUT);

  // Thiết lập trạng thái ban đầu cho LED
  digitalWrite(ledPin, ledState);
}

void loop() {
  // Đọc trạng thái của nút nhấn
  int reading = digitalRead(buttonPin);

  // Kiểm tra nếu có sự thay đổi trạng thái, do nhiễu hoặc nhấn nút
  if (reading != lastButtonState) {
    // Đặt lại bộ đếm thời gian debounce
    lastDebounceTime = millis();
  }

  // Nếu đã qua đủ thời gian debounce, kiểm tra nếu trạng thái nút nhấn thật sự thay đổi
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // Nếu trạng thái nút đã thay đổi:
    if (reading != buttonState) {
      buttonState = reading;

      // Chỉ chuyển đổi trạng thái LED nếu nút nhấn được nhấn (LOW vì sử dụng INPUT_PULLUP)
      if (buttonState == LOW) {
        ledState = !ledState;  // Đảo trạng thái LED
      }
    }
  }

  // Cập nhật trạng thái LED
  digitalWrite(ledPin, ledState);

  // Lưu trạng thái nút nhấn cho lần lặp tiếp theo
  lastButtonState = reading;
}
```

### Cách 3: Sử dụng thư viện Bounce2

Ưu điểm:
- Code ngắn gọn, dễ hiểu

#### Cài đặt thư viện Bounce2

Truy cập [Bounce2](https://github.com/thomasfredericks/Bounce2).

Tải thư viện về máy tính dưới dạng file .zip bằng cách nhấn vào nút **Code** và chọn **Download ZIP**.

![bounce2-down.png](https://cdn.chipstack.vn/zerobase/button/bounce2-down.png)

Mở Arduino IDE, vào Sketch > Include Library > Add .ZIP Library....

![add-zip-lib](https://cdn.chipstack.vn/zerobase/rtc/add-zip-lib.png)

Chọn file .zip vừa tải về để cài đặt thư viện.

![bounce2-open](https://cdn.chipstack.vn/zerobase/button/bounce2-open.png)

Bạn chờ một chút để Arduino IDE cài đặt thư viện. Sau khi cài xong, bạn sẽ thấy thư viện thông báo **library installed**.

![bounce2-lib-installed](https://cdn.chipstack.vn/zerobase/button/bounce2-lib-installed.png)

#### Code

```cpp
// Thêm thư viện Bounce2 để hỗ trợ xử lý chống dội nút nhấn
#include <Bounce2.h>

// Khai báo chân nút nhấn là chân số 3
const int buttonPin = 3;

// Khai báo chân điều khiển LED là chân số 2
const int ledPin = 2;

// Thời gian chống dội phím (debounce) tính bằng mili giây
const int debouceDelay = 50;

// Tạo đối tượng debouncer từ thư viện Bounce
Bounce debouncer = Bounce();

void setup() {
  // Cấu hình chân LED là OUTPUT
  pinMode(ledPin, OUTPUT);

  // Gán chân nút nhấn vào đối tượng debouncer và sử dụng điện trở kéo lên nội (INPUT_PULLUP)
  debouncer.attach(buttonPin, INPUT_PULLUP);

  // Thiết lập khoảng thời gian debounce cho nút nhấn
  debouncer.interval(debouceDelay);
}

void loop() {
  // Cập nhật trạng thái nút nhấn (kiểm tra thay đổi)
  debouncer.update();

  // Nếu nút vừa được nhấn (từ HIGH → LOW)
  if (debouncer.fell()) {
    // Đảo trạng thái của LED (nếu đang bật thì tắt, đang tắt thì bật)
    digitalWrite(ledPin, !digitalRead(ledPin));
  }
}
```

### Giải thích code

#### Cách 1: Sử dụng hàm delay()

Khai báo chân kết nối:

```cpp
const int buttonPin = 3;  // Chân D3 cho nút nhấn
const int ledPin = 2;     // Chân D2 cho LED
```

Hai chân này tương tự như ví dụ trước, D3 dành cho nút nhấn, D2 để điều khiển LED.

Khai báo thời gian chống dội:

```cpp
const int debounceTime = 50;  // Thời gian debounce tính bằng mili giây
```

Giá trị này dùng trong hàm `delay()` để loại bỏ nhiễu khi nhấn nút.

Hàm setup:

```cpp
void setup() {
  pinMode(buttonPin, INPUT_PULLUP);  // Nút nhấn với điện trở kéo lên
  pinMode(ledPin, OUTPUT);           // LED làm đầu ra
}
```

Cấu hình chân nút là INPUT_PULLUP để tránh dùng điện trở ngoài, và LED là OUTPUT để có thể điều khiển.

Vòng lặp chính:

```cpp
void loop() {
  if (digitalRead(buttonPin) == LOW) {
```

Nếu nút được nhấn (LOW), bắt đầu quy trình debounce.

```cpp
    delay(debounceTime);
```

Tạm dừng một khoảng thời gian để chờ nhiễu cơ học kết thúc.

```cpp
    if (digitalRead(buttonPin) == LOW) {
```

Sau thời gian chờ, kiểm tra lại trạng thái nút. Nếu vẫn đang nhấn, tức là nhấn thật.

```cpp
      digitalWrite(ledPin, !digitalRead(ledPin));
```

Đảo trạng thái LED hiện tại bằng cách đọc trạng thái và lấy phủ định.

```cpp
      while (digitalRead(buttonPin) == LOW);
```

Chờ cho đến khi nút được thả ra, tránh việc lặp lại thao tác trong một lần nhấn.

Đây là cách debounce đơn giản bằng hàm `delay()` và không cần biến phụ, phù hợp với ứng dụng đơn giản nhưng không hiệu quả nếu có nhiều tác vụ khác đang chạy song song.

#### Cách 2: Sử dụng hàm millis()

Khai báo các chân kết nối nút nhấn và led:

```cpp
const int buttonPin = 3;  // Chân D3 cho nút nhấn
const int ledPin = 2;     // Chân D2 cho đèn LED
```

Hai chân được sử dụng là chân digital của arduino: chân D3 để đọc tín hiệu từ nút nhấn và chân D2 để điều khiển led. nút nhấn sẽ hoạt động với logic nghịch (nhấn là LOW) do sử dụng chế độ input_pullup.

Khai báo biến trạng thái cho led và nút nhấn:

```cpp
int ledState = LOW;         // Trạng thái hiện tại của LED
int buttonState;            // Trạng thái hiện tại của nút nhấn
int lastButtonState = LOW;  // Trạng thái trước đó của nút nhấn
```

ledState lưu trạng thái hiện tại của led (bật hay tắt). buttonState là trạng thái được xác nhận sau khi debounce. lastButtonState là giá trị nút nhấn mới đọc được ở vòng lặp trước, dùng để phát hiện thay đổi trạng thái.

Khai báo biến thời gian để xử lý chống dội (debounce):

```cpp
unsigned long lastDebounceTime = 0;  // Thời điểm cuối cùng mà nút nhấn thay đổi trạng thái
unsigned long debounceDelay = 50;    // Thời gian debounce, đơn vị mili giây
```

Debounce là kỹ thuật lọc nhiễu do dao động cơ học khi nhấn nút. biến lastDebounceTime ghi lại thời điểm gần nhất xảy ra thay đổi trạng thái, còn debounceDelay là khoảng thời gian tối thiểu để xác nhận thay đổi là hợp lệ.

Hàm setup cấu hình các chân và thiết lập trạng thái ban đầu của led:

```cpp
void setup() {
  pinMode(buttonPin, INPUT_PULLUP);  // Cấu hình chân nút nhấn với điện trở kéo lên
  pinMode(ledPin, OUTPUT);           // Cấu hình chân led là output
  digitalWrite(ledPin, ledState);    // Thiết lập trạng thái ban đầu cho led
}
```

Chân nút nhấn được thiết lập với chế độ input_pullup, nghĩa là mặc định sẽ ở mức cao (HIGH), và khi nhấn nút sẽ nối xuống đất (LOW). led được cấu hình là output và được thiết lập ban đầu là tắt (LOW).

Vòng lặp chính kiểm tra và xử lý trạng thái của nút nhấn:

```cpp
void loop() {
  int reading = digitalRead(buttonPin);  // Đọc trạng thái hiện tại của nút nhấn
```

Đọc trạng thái hiện tại của chân nút nhấn. giá trị đọc được có thể là HIGH (không nhấn) hoặc LOW (đang nhấn).

```cpp
  if (reading != lastButtonState) {
    lastDebounceTime = millis();
  }
```

Nếu trạng thái vừa đọc khác với trạng thái trước đó, coi như có khả năng nút được nhấn hoặc thả, nên reset lại bộ đếm debounce bằng cách cập nhật thời gian hiện tại.

```cpp
  if ((millis() - lastDebounceTime) > debounceDelay) {
    if (reading != buttonState) {
      buttonState = reading;
```

nNếu đã vượt qua khoảng thời gian debounce (ví dụ 50ms), kiểm tra xem trạng thái hiện tại có thật sự khác với trạng thái đã xác nhận không. nếu có, cập nhật giá trị buttonState.

```cpp
      if (buttonState == LOW) {
        ledState = !ledState;
      }
    }
  }
```

Nếu nút thực sự đang được nhấn (LOW), đảo trạng thái led: nếu đang bật thì tắt, đang tắt thì bật. điều này tạo ra hiệu ứng "toggle" mỗi lần nhấn.

```cpp
  digitalWrite(ledPin, ledState);  // Cập nhật trạng thái LED
  lastButtonState = reading;       // Cập nhật trạng thái cũ của nút nhấn
}
```

Cập nhật chân led với trạng thái mới và lưu giá trị nút nhấn hiện tại cho vòng lặp kế tiếp.

### Cách 3: Sử dụng thư viện Bounce2

Khai báo thư viện và các chân kết nối:

```cpp
#include <Bounce2.h>              // Thêm thư viện Bounce2 để xử lý chống dội
const int buttonPin = 3;          // Chân D3 cho nút nhấn
const int ledPin = 2;             // Chân D2 cho LED
const int debouceDelay = 50;      // Thời gian debounce tính bằng mili giây
```

Thư viện Bounce2 giúp xử lý debounce hiệu quả và gọn gàng hơn nhờ các hàm hỗ trợ sẵn. Biến debounceDelay quy định khoảng thời gian để xác định nút đã ổn định.

Khai báo đối tượng xử lý nút nhấn:

```cpp
Bounce debouncer = Bounce();  // Tạo đối tượng xử lý chống dội
```

Đối tượng `debouncer` sẽ quản lý trạng thái và lọc nhiễu cho nút nhấn.

Hàm setup cấu hình chân và thiết lập debounce:

```cpp
void setup() {
  pinMode(ledPin, OUTPUT);                         // Cấu hình LED là OUTPUT
  debouncer.attach(buttonPin, INPUT_PULLUP);       // Gán chân nút vào debouncer với điện trở kéo lên
  debouncer.interval(debouceDelay);                // Thiết lập thời gian debounce
}
```

LED được cấu hình đầu ra để điều khiển. Đối tượng debouncer được gán với chân D3 và hoạt động với chế độ INPUT_PULLUP. Hàm `interval()` giúp đặt thời gian chống dội.

Vòng lặp chính xử lý trạng thái nút nhấn:

```cpp
void loop() {
  debouncer.update();  // Cập nhật trạng thái nút nhấn từ thư viện
```

Lệnh `update()` giúp debouncer kiểm tra và xử lý thay đổi trạng thái của nút nhấn.

```cpp
  if (debouncer.fell()) {
    digitalWrite(ledPin, !digitalRead(ledPin));
  }
```

Nếu phát hiện cạnh xuống (tức là nút vừa được nhấn), đảo trạng thái của LED. Hàm `fell()` trả về true nếu nút chuyển từ HIGH sang LOW.

Sử dụng thư viện Bounce2 giúp code ngắn gọn, dễ đọc và quản lý debounce tốt hơn trong các ứng dụng phức tạp.

## Kết quả

?> Khi không sử dụng xử lý chống dội nút nhấn, bạn sẽ thấy đèn LED nhấp nháy liên tục khi nhấn nút.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/button/without-debounce-button-result.gif" alt="debounce-button">
    <p><em>Đèn LED bật/tắt không theo ý muốn</em></p>
</div>

?> Khi sử dụng xử lý chống dội nút nhấn, bạn sẽ thấy đèn LED chỉ sáng một lần khi nhấn nút.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/button/debounce-button-result.gif" alt="debounce-button">
    <p><em>Đèn LED bật/tắt theo ý muốn khi xử lý chống dội</em></p>

## Kết luận và hướng phát triển

Bài viết đã hướng đẫn cách xử lý chống dội nút nhấn (debounce button) với 3 cách khác nhau. Bạn có thể chọn cách nào phù hợp với mình nhé!

Để phát triển thêm từ bài học này, bạn có thể thực hiện các ý tưởng sau:

- Thêm nhiều nút nhấn và LED để điều khiển nhiều thiết bị cùng lúc.
- Thay đổi thời gian debounce để xem ảnh hưởng đến độ nhạy của nút nhấn.
- Thay vì đèn LED thì bạn có thể sử dụng relay, buzzer hoặc các thiết bị khác để điều khiển.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)





