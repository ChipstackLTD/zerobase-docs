<br>
<br>
<br>

# Thêm âm thanh cho nút nhấn

![button-buzzer-circuit](https://cdn.chipstack.vn/zerobase2/buzzer/button-buzzer-circuit.jpg)
## Tổng quan

?> Bài viết này hướng dẫn thực hiện thêm âm thanh cho nút nhấn sử dụng board Zerobase 2 trên Arduino IDE.

## Chuẩn bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase 2 |[Mua ngay](https://chipstack.vn/san-pham/zerobase-2/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Buzzer |[Mua ngay](https://chipstack.vn/san-pham/coi-buzzer-chu-dong-12x9-5/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase2-overview.png" alt="zerobase2">
    <p><em>Board Zerobase 2</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/buzzer.png" alt="buzzer">
    <p><em>Buzzer</em></p>
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
    <img src="https://cdn.chipstack.vn/zerobase/button/push-button.png" alt="push-button">
    <p><em>Nút nhấn</em></p>
</div>

## Nguyên lý hoạt động

?> Khi nhấn một trong các nút bấm, vi điều khiển đọc trạng thái mức thấp (LOW) do sử dụng điện trở pull-up nội bộ. Dựa vào nút được nhấn, chương trình sẽ phát ra tần số âm thanh tương ứng trên buzzer bằng hàm `tone(buzzer_pins, frequency)`, với mỗi nút đại diện cho một nốt nhạc trong gam nhạc phổ biến: Đô (C - 262Hz), Rê (D - 294Hz), Mi (E - 330Hz), Pha (F - 349Hz), Son (G - 392Hz) và La (A - 440Hz).

?> Nếu không có nút nào được nhấn, hàm `noTone(buzzer_pins)` sẽ dừng phát âm, đồng thời `digitalWrite(BUZZER_PIN, LOW)` đảm bảo buzzer không bị kích hoạt ngoài ý muốn.

> Tìm hiểu thêm về còi buzzer [tại đây](vi/zerobase-2/examples/buzzer.md).

> Phát nhạc Happy Birthday bằng còi buzzer [tại đây](vi/zerobase-2/examples/buzzer-music.md).

> Tìm hiểu thêm về nguyên lý của nút nhấn [tại đây](vi/zerobase-2/examples/button.md).


## Sơ đồ kết nối

![button-buzzer-pins](https://cdn.chipstack.vn/zerobase2/buzzer/button-buzzer-pins.png)

Sử dụng chân D1 của board Zerobase 2 để điều khiển buzzer. Chân D1 được kết nối với cực (+) của buzzer, còn cực (-) của buzzer được nối với chân GND của board Zerobase 2.

Sử dụng chân D14 đến D19 của board Zerobase 2 để kết nối với các nút nhấn. Chân D14 được kết nối với một chân của nút nhấn, chân còn lại của nút nhấn được nối với chân GND của board Zerobase 2. Các chân D15, D16, D17, D18 và D19 cũng được kết nối tương tự.

![button-buzzer-schematic](https://cdn.chipstack.vn/zerobase2/buzzer/button-buzzer-schematic.png)

![button-buzzer-circuit](https://cdn.chipstack.vn/zerobase2/buzzer/button-buzzer-circuit.jpg)



## Code
```cpp
// Định nghĩa các chân kết nối với nút nhấn
const int BUTTON_PIN_14 = 14;  // Nút nhấn phát âm Đô (C)
const int BUTTON_PIN_15 = 15;  // Nút nhấn phát âm Rê (D)
const int BUTTON_PIN_16 = 16;  // Nút nhấn phát âm Mi (E)
const int BUTTON_PIN_17 = 17;  // Nút nhấn phát âm Pha (F)
const int BUTTON_PIN_18 = 18;  // Nút nhấn phát âm Son (G)
const int BUTTON_PIN_19 = 19;  // Nút nhấn phát âm La (A)

// Định nghĩa chân kết nối với buzzer
const int BUZZER_PIN = 1;  // Buzzer sẽ phát ra âm thanh khi nhấn nút

// Định nghĩa các tần số tương ứng với các nốt nhạc
const int TONE_C = 262;  // Tần số của nốt Đô (C)
const int TONE_D = 294;  // Tần số của nốt Rê (D)
const int TONE_E = 330;  // Tần số của nốt Mi (E)
const int TONE_F = 349;  // Tần số của nốt Pha (F)
const int TONE_G = 392;  // Tần số của nốt Son (G)
const int TONE_A = 440;  // Tần số của nốt La (A)

void setup() {
  // Cấu hình các chân nút nhấn là INPUT_PULLUP để tránh trạng thái lơ lửng
  pinMode(BUTTON_PIN_14, INPUT_PULLUP);
  pinMode(BUTTON_PIN_15, INPUT_PULLUP);
  pinMode(BUTTON_PIN_16, INPUT_PULLUP);
  pinMode(BUTTON_PIN_17, INPUT_PULLUP);
  pinMode(BUTTON_PIN_18, INPUT_PULLUP);
  pinMode(BUTTON_PIN_19, INPUT_PULLUP);

  // Cấu hình chân buzzer là OUTPUT
  pinMode(BUZZER_PIN, OUTPUT);
}

void loop() {
  // Kiểm tra lần lượt các nút nhấn, nếu nút nào được nhấn, phát ra âm thanh tương ứng
  if (digitalRead(BUTTON_PIN_14) == LOW) {
    tone(BUZZER_PIN, TONE_C);  // Phát nốt Đô (C)
  } else if (digitalRead(BUTTON_PIN_15) == LOW) {
    tone(BUZZER_PIN, TONE_D);  // Phát nốt Rê (D)
  } else if (digitalRead(BUTTON_PIN_16) == LOW) {
    tone(BUZZER_PIN, TONE_E);  // Phát nốt Mi (E)
  } else if (digitalRead(BUTTON_PIN_17) == LOW) {
    tone(BUZZER_PIN, TONE_F);  // Phát nốt Pha (F)
  } else if (digitalRead(BUTTON_PIN_18) == LOW) {
    tone(BUZZER_PIN, TONE_G);  // Phát nốt Son (G)
  } else if (digitalRead(BUTTON_PIN_19) == LOW) {
    tone(BUZZER_PIN, TONE_A);  // Phát nốt La (A)
  } else {
    // Nếu không có nút nào được nhấn, dừng phát âm thanh
    noTone(BUZZER_PIN);
    digitalWrite(BUZZER_PIN, LOW);  // Đảm bảo buzzer không bị kích hoạt ngoài ý muốn
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![button-buzzer-code](https://cdn.chipstack.vn/zerobase2/buzzer/button-buzzer-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `BUZZER_PIN` hoặc các biến `BUTTON_PIN_14`, `BUTTON_PIN_15`, `BUTTON_PIN_16`, `BUTTON_PIN_17`, `BUTTON_PIN_18` và `BUTTON_PIN_19` trong code và kết nối lại chân tương ứng trên board Zerobase 2.

```cpp
const int BUZZER_PIN = 1;  // Chân kết nối với buzzer
const int BUTTON_PIN_14 = 14;  // Nút nhấn phát âm Đô (C)
const int BUTTON_PIN_15 = 15;  // Nút nhấn phát âm Rê (D)
const int BUTTON_PIN_16 = 16;  // Nút nhấn phát âm Mi (E)
const int BUTTON_PIN_17 = 17;  // Nút nhấn phát âm Pha (F)
const int BUTTON_PIN_18 = 18;  // Nút nhấn phát âm Son (G)
const int BUTTON_PIN_19 = 19;  // Nút nhấn phát âm La (A)
```

Nếu bạn muốn thay đổi tần số âm thanh phát ra cho các nốt nhạc, bạn có thể thay đổi giá trị của các biến `TONE_C`, `TONE_D`, `TONE_E`, `TONE_F`, `TONE_G` và `TONE_A` trong code.

```cpp
const int TONE_C = 262;  // Tần số của nốt Đô (C)
const int TONE_D = 294;  // Tần số của nốt Rê (D)
const int TONE_E = 330;  // Tần số của nốt Mi (E)
const int TONE_F = 349;  // Tần số của nốt Pha (F)
const int TONE_G = 392;  // Tần số của nốt Son (G)
const int TONE_A = 440;  // Tần số của nốt La (A)
```

### Giải thích code

Khai báo các chân kết nối với nút nhấn và buzzer, cùng với các tần số tương ứng với các nốt nhạc.

```cpp
// Định nghĩa các chân kết nối với nút nhấn
const int BUTTON_PIN_14 = 14;  // Nút nhấn phát âm Đô (C)
const int BUTTON_PIN_15 = 15;  // Nút nhấn phát âm Rê (D)
const int BUTTON_PIN_16 = 16;  // Nút nhấn phát âm Mi (E)
const int BUTTON_PIN_17 = 17;  // Nút nhấn phát âm Pha (F)
const int BUTTON_PIN_18 = 18;  // Nút nhấn phát âm Son (G)
const int BUTTON_PIN_19 = 19;  // Nút nhấn phát âm La (A)

// Định nghĩa chân kết nối với buzzer
const int BUZZER_PIN = 1;  // Buzzer sẽ phát ra âm thanh khi nhấn nút

// Định nghĩa các tần số tương ứng với các nốt nhạc
const int TONE_C = 262;  // Tần số của nốt Đô (C)
const int TONE_D = 294;  // Tần số của nốt Rê (D)
const int TONE_E = 330;  // Tần số của nốt Mi (E)
const int TONE_F = 349;  // Tần số của nốt Pha (F)
const int TONE_G = 392;  // Tần số của nốt Son (G)
const int TONE_A = 440;  // Tần số của nốt La (A)
```

Trong hàm `setup()`, chúng ta sẽ thiết lập các chân nút nhấn là INPUT_PULLUP để tránh trạng thái lơ lửng và thiết lập chân buzzer là OUTPUT.

```cpp
void setup() {
  // Cấu hình các chân nút nhấn là INPUT_PULLUP để tránh trạng thái lơ lửng
  pinMode(BUTTON_PIN_14, INPUT_PULLUP);
  pinMode(BUTTON_PIN_15, INPUT_PULLUP);
  pinMode(BUTTON_PIN_16, INPUT_PULLUP);
  pinMode(BUTTON_PIN_17, INPUT_PULLUP);
  pinMode(BUTTON_PIN_18, INPUT_PULLUP);
  pinMode(BUTTON_PIN_19, INPUT_PULLUP);

  // Cấu hình chân buzzer là OUTPUT
  pinMode(BUZZER_PIN, OUTPUT);
}
```

Trong hàm `loop()`, chúng ta sẽ kiểm tra lần lượt các nút nhấn, nếu nút nào được nhấn, phát ra âm thanh sử dụng hàm `tone(buzzer_pins, frequency)` với tần số tương ứng với nốt nhạc.

```cpp
  // Kiểm tra lần lượt các nút nhấn, nếu nút nào được nhấn, phát ra âm thanh tương ứng
  if (digitalRead(BUTTON_PIN_14) == LOW) {
    tone(BUZZER_PIN, TONE_C);  // Phát nốt Đô (C)
  } else if (digitalRead(BUTTON_PIN_15) == LOW) {
    tone(BUZZER_PIN, TONE_D);  // Phát nốt Rê (D)
  } else if (digitalRead(BUTTON_PIN_16) == LOW) {
    tone(BUZZER_PIN, TONE_E);  // Phát nốt Mi (E)
  } else if (digitalRead(BUTTON_PIN_17) == LOW) {
    tone(BUZZER_PIN, TONE_F);  // Phát nốt Pha (F)
  } else if (digitalRead(BUTTON_PIN_18) == LOW) {
    tone(BUZZER_PIN, TONE_G);  // Phát nốt Son (G)
  } else if (digitalRead(BUTTON_PIN_19) == LOW) {
    tone(BUZZER_PIN, TONE_A);  // Phát nốt La (A)
  }
```

Nếu không có nút nào được nhấn, dừng phát âm thanh sử dụng hàm `noTone(buzzer_pins)` và đảm bảo buzzer không bị kích hoạt ngoài ý muốn bằng cách sử dụng `digitalWrite(BUZZER_PIN, LOW)`.

```cpp
  else {
    // Nếu không có nút nào được nhấn, dừng phát âm thanh
    noTone(BUZZER_PIN);
    digitalWrite(BUZZER_PIN, LOW);  // Đảm bảo buzzer không bị kích hoạt ngoài ý muốn
  }
}
```

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ nghe thấy âm thanh phát ra từ buzzer tương ứng với nốt nhạc mà bạn đã nhấn.

<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/buzzer/zerobase2-button-buzzer-res.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Kết quả khi thêm âm thanh cho các nút nhấn</em></p>
</div>



## Kết luận và Hướng phát triển

Bạn đã hoàn thành việc thêm âm thanh cho nút nhấn sử dụng board Zerobase 2 trên Arduino IDE.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Mở rộng thang âm**: Thêm nhiều nốt nhạc hơn hoặc cho phép thay đổi quãng tám để tạo ra nhiều giai điệu hơn.
- **Chơi giai điệu tự động**: Lưu trữ một bài hát trong bộ nhớ và phát tự động khi nhấn nút.
- **Thêm đèn LED**: Kết hợp với đèn LED để tạo hiệu ứng ánh sáng khi phát âm thanh.
- **Tạo nhạc cụ**: Kết hợp nhiều nút nhấn và buzzer để tạo ra một nhạc cụ đơn giản.
- **Kết nối với các cảm biến khác**: Thay vì dùng nút nhấn, bạn có thể sử dụng cảm biến ánh sáng, cảm biến tiệm cận hoặc cử chỉ để phát nhạc khi có tương tác.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)




