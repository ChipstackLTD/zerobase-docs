<br>
<br>
<br>

# Các hiệu ứng nút nhấn

![button-effect-circuit](https://cdn.chipstack.vn/zerobase2/button/button-effect-circuit.jpg)

## Tổng quan

?> Bài viết này sẽ hướng dẫn bạn cách tạo ra các hiệu ứng nút nhấn khác nhau (Single Press, Double Press, Long Press) trên bo mạch ZeroBase 2.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2| [Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Breadboard | [Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Dây USB Type C | [Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
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
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard-830-lo">
    <p><em>Breadboard</em></p>
</div>

<br>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/usb-type-c.jpg" alt="usb-type-c">
    <p><em>Dây USB Type C</em></p>
</div>

## Nguyên Lý Hoạt Động

?> Chương trình sẽ nhận diện các trạng thái của nút nhấn và in ra Serial Monitor các trạng thái đó bằng giao tiếp UART. Các trạng thái bao gồm:
- Single Press: Nhấn nút 1 lần
- Double Press: Nhấn nút 2 lần liên tiếp
- Long Press: Nhấn nút giữ lâu hơn 1 giây

> Xem thêm về ví dụ nút nhấn [tại đây](vi/zerobase-2/examples/button.md).

> Nếu bạn chưa biết cách in ra Serial Monitor bằng USB UART TTL, hãy tham khảo [tại đây](vi/zerobase-2/examples/uartttl.md).

> Để tìm hiểu thêm kỹ thuật chống dội, bạn có thể xem [tại đây](vi/zerobase-2/examples/debounce-button).

## Sơ đồ kết nối

![button-effect-pins](https://cdn.chipstack.vn/zerobase2/button/button-effect-pins.png)

Chân D2 kết nối với một chân của nút nhấn và chân còn lại của nút nhấn kết nối với GND.

![button-effect-schematic](https://cdn.chipstack.vn/zerobase2/button/button-effect-schematic.png)

![button-effect-circuit](https://cdn.chipstack.vn/zerobase2/button/button-effect-circuit.jpg)

## Code

```cpp
#include <Adafruit_TinyUSB.h>

// Chân kết nối nút nhấn
const int buttonPin = 2;

// Biến lưu thời điểm thay đổi trạng thái gần nhất (cho debounce)
unsigned long lastDebounceTime = 0;
// Khoảng thời gian debounce (loại bỏ nhiễu khi nhấn nút)
unsigned long debounceDelay = 50;

// Biến lưu thời điểm nhấn và nhả nút
unsigned long buttonDownTime = 0;
unsigned long buttonUpTime = 0;

// Thời điểm lần nhấn gần nhất để kiểm tra double press
unsigned long lastButtonPress = 0;

// Trạng thái hiện tại của nút
bool buttonState = HIGH;
// Trạng thái trước đó của nút
bool lastButtonState = HIGH;

// Cờ để kiểm tra đã xử lý nhấn giữ chưa
bool longPressDetected = false;
// Cờ để chờ xem có nhấn lần thứ 2 không (double click)
bool waitingForDouble = false;

// Thời gian cần giữ để tính là long press (ms)
const unsigned long longPressTime = 1000;
// Khoảng thời gian tối đa giữa 2 lần nhấn để tính là double press (ms)
const unsigned long doubleClickGap = 400;

void setup() {
  // Cấu hình chân nút nhấn là INPUT_PULLUP (nút nối GND)
  pinMode(buttonPin, INPUT_PULLUP);

  // Khởi tạo Serial với tốc độ 9600 baud
  Serial.begin(9600);
}

void loop() {
  // Đọc trạng thái nút hiện tại (LOW khi nhấn, HIGH khi nhả)
  bool reading = digitalRead(buttonPin);

  // Nếu trạng thái hiện tại khác trạng thái trước đó → khả năng bị nhiễu hoặc nhấn thật
  if (reading != lastButtonState) {
    // Lưu lại thời điểm thay đổi để debounce
    lastDebounceTime = millis();
  }

  // Nếu đã qua thời gian debounce thì xác nhận đây là thay đổi hợp lệ
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // Nếu trạng thái thay đổi thật sự
    if (reading != buttonState) {
      // Cập nhật trạng thái mới
      buttonState = reading;

      // Nếu nút vừa được nhấn xuống
      if (buttonState == LOW) {
        buttonDownTime = millis();  // Lưu thời điểm nhấn
        longPressDetected = false;  // Reset cờ long press

      } else {                                                        // Nếu nút vừa được nhả ra
        buttonUpTime = millis();                                      // Lưu thời điểm nhả
        unsigned long pressDuration = buttonUpTime - buttonDownTime;  // Tính thời gian giữ

        // Nếu giữ đủ lâu → long press
        if (pressDuration >= longPressTime) {
          Serial.println("Long Press");
          longPressDetected = true;
        } else {
          // Nếu đang chờ nhấn lần 2 → kiểm tra khoảng cách giữa 2 lần nhấn
          if (waitingForDouble) {
            if (millis() - lastButtonPress <= doubleClickGap) {
              Serial.println("Double Press");
              waitingForDouble = false;
            }
          } else {
            // Nếu là lần nhấn đầu → chờ xem có lần 2 không
            waitingForDouble = true;
            lastButtonPress = millis();
          }
        }
      }
    }
  }

  // Nếu sau một thời gian mà không có lần nhấn thứ 2 → xác nhận là single press
  if (waitingForDouble && (millis() - lastButtonPress > doubleClickGap)) {
    Serial.println("Single Press");
    waitingForDouble = false;
  }

  // Cập nhật trạng thái trước đó cho vòng lặp sau
  lastButtonState = reading;
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![button effect-code](https://cdn.chipstack.vn/zerobase2/button/button-effect-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu bạn muốn thay đổi chân kết nối của nút nhấn, bạn chỉ cần sửa lại giá trị biến `buttonPin` trong code sau đó kết nối nút nhấn với chân tương ứng.

```cpp
const int buttonPin = 2; // Thay đổi chân nút nhấn
```

Bạn cũng có thể thay đổi thời gian của các hiệu ứng bằng cách thay đổi các biến sau:

```cpp
// Thời gian cần giữ để tính là long press (ms)
const unsigned long longPressTime = 1000; // Thay đổi thời gian giữ nút để tính là long press (ms)
// Khoảng thời gian tối đa giữa 2 lần nhấn để tính là double press (ms)
const unsigned long doubleClickGap = 400; // Thay đổi khoảng thời gian giữa 2 lần nhấn để tính là double press (ms)
```

### Giải Thích Code

Khai báo thư viện Adafruit TinyUSB để in ra Serial Monitor.

```cpp
#include <Adafruit_TinyUSB.h>
```

Khai báo biến `buttonPin` là chân số 2 kết nối với nút nhấn.

```cpp
const int buttonPin = 2;
```

Khai báo biến `lastDebounceTime` để lưu thời điểm thay đổi trạng thái cuối cùng nhằm tránh nhiễu (debounce).

```cpp
unsigned long lastDebounceTime = 0;
```

Khai báo độ trễ debounce là 50 mili giây.

```cpp
unsigned long debounceDelay = 50;
```

Biến `buttonDownTime` lưu thời điểm nút được nhấn xuống.

```cpp
unsigned long buttonDownTime = 0;
```

Biến `buttonUpTime` lưu thời điểm nút được nhả ra.

```cpp
unsigned long buttonUpTime = 0;
```

Biến `lastButtonPress` lưu thời điểm lần nhấn gần nhất để phục vụ kiểm tra double press.

```cpp
unsigned long lastButtonPress = 0;
```

Biến `buttonState` lưu trạng thái hiện tại của nút.

```cpp
bool buttonState = HIGH;
```

Biến `lastButtonState` lưu trạng thái trước đó của nút để phát hiện thay đổi.

```cpp
bool lastButtonState = HIGH;
```

Biến `longPressDetected` là cờ để đánh dấu khi nào đã xảy ra nhấn giữ.

```cpp
bool longPressDetected = false;
```

Biến `waitingForDouble` là một "cờ trạng thái" giúp chương trình biết rằng đã có một lần nhấn và đang chờ xem có nhấn lần thứ hai hay không để xác định đó là double press.

```cpp
bool waitingForDouble = false;
```

Hằng `longPressTime` xác định thời gian tối thiểu để xem là nhấn giữ (long press).

```cpp
const unsigned long longPressTime = 1000;  // ms
```

Hằng `doubleClickGap` xác định khoảng thời gian tối đa giữa 2 lần nhấn để tính là double press.

```cpp
const unsigned long doubleClickGap = 400;  // ms
```

Hàm `setup()` cấu hình chân nút nhấn là INPUT_PULLUP và khởi tạo giao tiếp Serial.

```cpp
void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(9600);
}
```

Trong hàm `loop()`, chúng ta đọc trạng thái của nút nhấn và kiểm tra xem có thay đổi hay không. Nếu có thay đổi, chúng ta sẽ lưu lại thời điểm thay đổi để xử lý debounce.

```cpp
bool reading = digitalRead(buttonPin);
if (reading != lastButtonState) {
  lastDebounceTime = millis();
}
```

Nếu trạng thái giữ ổn định trong khoảng thời gian debounce, ta xử lý thay đổi trạng thái thực sự.

```cpp
if ((millis() - lastDebounceTime) > debounceDelay) {
  if (reading != buttonState) {
    buttonState = reading;
```

Nếu nút được nhấn xuống, ta lưu lại thời điểm nhấn và đặt cờ longPress về false để chuẩn bị kiểm tra.

```cpp
    if (buttonState == LOW) {
      buttonDownTime = millis();
      longPressDetected = false;
```

Nếu nút được nhả ra, ta tính thời gian giữ nút và kiểm tra xem có phải nhấn giữ không.

```cpp
    } else {
      buttonUpTime = millis();
      unsigned long pressDuration = buttonUpTime - buttonDownTime;

      if (pressDuration >= longPressTime) {
        Serial.println("Long Press");
        longPressDetected = true;
```

Nếu không phải nhấn giữ, ta kiểm tra xem có phải là double press không. Nếu đúng, in ra "Double Press".

```cpp
      } else {
        if (waitingForDouble) {
          if (millis() - lastButtonPress <= doubleClickGap) {
            Serial.println("Double Press");
            waitingForDouble = false;
```

Nếu không đang chờ double, thì lưu thời điểm nhấn để bắt đầu chờ nhấn lần hai.

```cpp
          }
        } else {
          waitingForDouble = true;
          lastButtonPress = millis();
        }
      }
    }
  }
}
```

Nếu đang chờ double click nhưng quá thời gian cho phép, thì đây là single press.

```cpp
if (waitingForDouble && (millis() - lastButtonPress > doubleClickGap)) {
  Serial.println("Single Press");
  waitingForDouble = false;
}
```

Cập nhật lại trạng thái cũ để vòng lặp kế tiếp có thể phát hiện thay đổi.

```cpp
lastButtonState = reading;
```

## Kết Quả

?> Khi nút được nhấn theo các hiệu ứng khác nhau, Serial Monitor sẽ in ra các trạng thái tương ứng.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase2/button/button-effect-result.gif" alt="button-effect-result">
    <p><em>Kết quả khi nhấn nút với các hiệu ứng khác nhau</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn chi tiết cách tạo ra các hiệu ứng nút nhấn khác nhau (Single Press, Double Press, Long Press) trên bo mạch Zerobase 2. Thông qua việc kết nối phần cứng, lập trình và kiểm tra kết quả, bạn đã hiểu được cách hoạt động của nút nhấn, điện trở kéo cũng như cách điều khiển LED bằng vi điều khiển.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:
- Thay đổi thời gian giữ nút để xem ảnh hưởng đến các hiệu ứng.
- Thêm âm thanh cho các hiệu ứng bằng cách sử dụng còi buzzer.
- Thêm hiệu ứng tripple press (nhấn 3 lần) để mở rộng khả năng điều khiển.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)