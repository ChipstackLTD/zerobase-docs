<br>
<br>
<br>

# Phát nhạc Happy Birthday bằng còi buzzer sử dụng board Zerobase 2

![buzzer-music-circuit](https://cdn.chipstack.vn/zerobas2/buzzer/buzzer-music-circuit.jpg "buzzer-music-circuit")

## Tổng quan

?> Bài viết này hướng dẫn cách phát nhạc bằng buzzer với board Zerobase 2.

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

?> Sử dụng 2 nút nhấn để phát nhạc và dừng nhạc. Khi nhấn nút 1, buzzer sẽ phát ra âm thanh. Khi nhấn nút 2, âm thanh sẽ dừng lại.

> Tìm hiểu thêm về cách sử dụng thư viện [Tone](vi/zerobase-2/examples/buzzer-tone.md).

> Tìm hiểu thêm về ngắt ngoài (external interrupt) [tại đây](vi/zerobase-2/examples/interrupt.md).

> Tìm hiểu thêm về buzzer [tại đây](vi/zerobase-2/examples/buzzer.md).

## Sơ đồ kết nối

![buzzer-music-zerobase2-pins](https://cdn.chipstack.vn/zerobase2/buzzer/buzzer-music-zerobase2-pins.png "buzzer-music-zerobase2-pins")

Sử dụng chân D1 của board Zerobase 2 để điều khiển buzzer. Chân D1 được kết nối với cực (+) của buzzer, còn cực (-) của buzzer được nối với chân GND của board Zerobase 2.

Sử dụng chân D2 làm nút phát nhạc và chân D3 làm nút dừng nhạc. Chân D2 nối với 1 chân của nút nhấn, chân còn lại nối với GND. Chân D3 cũng được nối tương tự như vậy.

![buzzer-music-schematic](https://cdn.chipstack.vn/zerobase2/buzzer/buzzer-music-schematic.png "buzzer-music-schematic")

![buzzer-music-circuit](https://cdn.chipstack.vn/zerobase2/buzzer/buzzer-music-circuit.jpg "buzzer-music-circuit")

## Code

```cpp
// Định nghĩa chân kết nối với buzzer và nút bấm
const int BUZZER_PIN = 1;   // Chân kết nối với buzzer
const int BUTTON_PLAY = 2;  // Chân kết nối với nút PLAY
const int BUTTON_STOP = 3;  // Chân kết nối với nút STOP

volatile bool isPlaying = false;  // Biến cờ báo hiệu trạng thái phát nhạc

// Mảng chứa các tần số (Hz) của giai điệu
const int melody[] = {
  262, 262, 294, 262, 349, 330,
  262, 262, 294, 262, 392, 349,
  262, 262, 523, 440, 349, 330, 294,
  440, 440, 349, 392, 349
};

// Mảng chứa thời gian phát của từng nốt (ms)
const int durations[] = {
  400, 200, 600, 600, 600, 1200,
  400, 200, 600, 600, 600, 1200,
  400, 200, 600, 600, 600, 600, 1200,
  400, 200, 600, 600, 1200
};

// Xử lý ngắt cho nút PLAY (D2)
void checkSwitch_PLAY(void) {
  EXTI_ClearITPendingBit(EXTI_Line2);  // Xóa cờ ngắt của chân D2
  isPlaying = true;                    // Bật trạng thái phát nhạc
}

// Xử lý ngắt cho nút STOP (D3)
void checkSwitch_STOP(void) {
  EXTI_ClearITPendingBit(EXTI_Line3);  // Xóa cờ ngắt của chân D3
  isPlaying = false;                   // Tắt trạng thái phát nhạc
}

void setup() {
  pinMode(BUZZER_PIN, OUTPUT);         // Cấu hình chân buzzer là OUTPUT
  pinMode(BUTTON_PLAY, INPUT_PULLUP);  // Cấu hình nút PLAY là INPUT với pull-up nội
  pinMode(BUTTON_STOP, INPUT_PULLUP);  // Cấu hình nút STOP là INPUT với pull-up nội

  // Gán hàm xử lý ngắt cho nút PLAY và STOP, kích hoạt khi có xung xuống (nhấn nút)
  attachInterrupt(BUTTON_PLAY, GPIO_Mode_IPU, checkSwitch_PLAY, EXTI_Mode_Interrupt, EXTI_Trigger_Falling);
  attachInterrupt(BUTTON_STOP, GPIO_Mode_IPU, checkSwitch_STOP, EXTI_Mode_Interrupt, EXTI_Trigger_Falling);
}

void loop() {
  if (isPlaying) {  // Nếu đang trong trạng thái phát nhạc
    for (int i = 0; i < sizeof(melody) / sizeof(melody[0]); i++) {
      if (!isPlaying) {      // Kiểm tra nếu nhấn STOP, dừng ngay lập tức
        noTone(BUZZER_PIN);  // Tắt buzzer
        digitalWrite(BUZZER_PIN, LOW); // Đảm bảo buzzer tắt
        return;  // Thoát khỏi vòng lặp
      }
      tone(BUZZER_PIN, melody[i], durations[i]);  // Phát nốt nhạc
      delay(durations[i] + 50);                   // Giữ khoảng cách giữa các nốt
    }
    noTone(BUZZER_PIN);  // Dừng phát nhạc sau khi hoàn thành giai điệu
    digitalWrite(BUZZER_PIN, LOW); // Đảm bảo buzzer tắt
    isPlaying = false;  // Đặt lại trạng thái
  } else {
    noTone(BUZZER_PIN);  // Nếu không phát nhạc, đảm bảo buzzer tắt
    digitalWrite(BUZZER_PIN, LOW); // Đảm bảo buzzer tắt
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.
![buzzer-music-code](https://cdn.chipstack.vn/zerobase2/buzzer/buzzer-music-code.png "buzzer-music-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)


### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase 2. Nếu chưa biết cách nạp code cho Zerobase 2, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `BUZZER_PIN`, `BUTTON_PLAY` và `BUTTON_STOP` trong code sau đó kết nối nút nhấn và buzzer với chân tương ứng.

```cpp
const int BUZZER_PIN = 1;   // Chân kết nối với buzzer
const int BUTTON_PLAY = 2;  // Chân kết nối với nút PLAY
const int BUTTON_STOP = 3;  // Chân kết nối với nút STOP
```

### Giải thích code

Khai báo chân kết nối với buzzer và nút nhấn. Chân D1 được sử dụng để điều khiển buzzer, chân D2 được sử dụng để phát nhạc và chân D3 được sử dụng để dừng nhạc.

```cpp
const int BUZZER_PIN = 1;   // Chân kết nối với buzzer
const int BUTTON_PLAY = 2;  // Chân kết nối với nút PLAY
const int BUTTON_STOP = 3;  // Chân kết nối với nút STOP
```

Khai báo biến cờ `isPlaying` để theo dõi trạng thái phát nhạc. Biến này sẽ được đặt thành `true` khi nhấn nút PLAY và `false` khi nhấn nút STOP.

```cpp
volatile bool isPlaying = false;  // Biến cờ báo hiệu trạng thái phát nhạc
```

Khai báo mảng `melody` chứa các tần số (Hz) của giai điệu của bài Happy Birthday và mảng `durations` chứa thời gian phát của từng nốt (ms).

```cpp
const int melody[] = {
  262, 262, 294, 262, 349, 330,
  262, 262, 294, 262, 392, 349,
  262, 262, 523, 440, 349, 330, 294,
  440, 440, 349, 392, 349
};

const int durations[] = {
  400, 200, 600, 600, 600, 1200,
  400, 200, 600, 600, 600, 1200,
  400, 200, 600, 600, 600, 600, 1200,
  400, 200, 600, 600, 1200
};
```
Trong chương trình này, chúng ta sử dụng ngắt ngoài để phát hiện sự kiện nhấn nút PLAY và STOP. Khi một nút được nhấn, bộ vi điều khiển sẽ ngay lập tức chuyển đến hàm xử lý ngắt tương ứng, đảm bảo phản hồi nhanh mà không cần phải kiểm tra liên tục trong vòng lặp loop().

Ngắt ngoài được kích hoạt bởi một tín hiệu cạnh xuống (xung xuống) khi nút nhấn chuyển từ mức cao xuống mức thấp. Khi xảy ra ngắt, chương trình hiện tại sẽ tạm dừng để xử lý sự kiện ngắt, sau đó quay trở lại tiếp tục thực thi từ điểm bị gián đoạn.

Việc sử dụng ngắt giúp tránh tình trạng chương trình bị chậm do phải kiểm tra trạng thái của nút nhấn liên tục trong loop(). Khi một nút được nhấn, chương trình sẽ ngay lập tức thực hiện thao tác cần thiết mà không gây trễ cho các tác vụ khác.

Khai báo hàm `checkSwitch_PLAY` để xử lý ngắt khi nhấn nút PLAY. Khi nút được nhấn, biến `isPlaying` sẽ được đặt thành `true`.

```cpp
void checkSwitch_PLAY(void) {
  EXTI_ClearITPendingBit(EXTI_Line2);  // Xóa cờ ngắt của chân D2
  isPlaying = true;                    // Bật trạng thái phát nhạc
}
```

Khai báo hàm `checkSwitch_STOP` để xử lý ngắt khi nhấn nút STOP. Khi nút được nhấn, biến `isPlaying` sẽ được đặt thành `false`.

```cpp
void checkSwitch_STOP(void) {
  EXTI_ClearITPendingBit(EXTI_Line3);  // Xóa cờ ngắt của chân D3
  isPlaying = false;                   // Tắt trạng thái phát nhạc
}
```

Khai báo hàm `setup()` để cấu hình chân buzzer là OUTPUT và các nút nhấn là INPUT với pull-up nội. Gán hàm xử lý ngắt cho nút PLAY và STOP, kích hoạt khi có xung xuống (nhấn nút).

```cpp
void setup() {
  pinMode(BUZZER_PIN, OUTPUT);         // Cấu hình chân buzzer là OUTPUT
  pinMode(BUTTON_PLAY, INPUT_PULLUP);  // Cấu hình nút PLAY là INPUT với pull-up nội
  pinMode(BUTTON_STOP, INPUT_PULLUP);  // Cấu hình nút STOP là INPUT với pull-up nội

  // Gán hàm xử lý ngắt cho nút PLAY và STOP, kích hoạt khi có xung xuống (nhấn nút)
  attachInterrupt(BUTTON_PLAY, GPIO_Mode_IPU, checkSwitch_PLAY, EXTI_Mode_Interrupt, EXTI_Trigger_Falling);
  attachInterrupt(BUTTON_STOP, GPIO_Mode_IPU, checkSwitch_STOP, EXTI_Mode_Interrupt, EXTI_Trigger_Falling);
}
```

Hàm `loop()` sẽ kiểm tra trạng thái của biến `isPlaying`. 

```cpp
if(isPlaying) {  // Nếu đang trong trạng thái phát nhạc
```
Nếu biến `isPlaying` là `true`, nó sẽ phát nhạc bằng cách lặp qua mảng `melody` và `durations`.

sizeof(melody) / sizeof(melody[0]) sẽ trả về số lượng phần tử trong mảng melody. Cách tính này giúp bạn không cần phải biết trước số lượng phần tử trong mảng.

```cpp
for (int i = 0; i < sizeof(melody) / sizeof(melody[0]); i++)
```

Nếu đang phát nhạc trong vòng lặp for loop, nó sẽ kiểm tra xem biến `isPlaying` có còn là `true` hay không. Nếu không, nó sẽ dừng phát nhạc ngay lập tức bằng cách gọi hàm `noTone()` và thoát khỏi vòng lặp.

```cpp
if (!isPlaying) {      // Kiểm tra nếu nhấn STOP, dừng ngay lập tức
  noTone(BUZZER_PIN);  // Tắt buzzer
  digitalWrite(BUZZER_PIN, LOW); // Đảm bảo buzzer tắt
  return;              // Thoát khỏi vòng lặp
}
```

Hàm `tone()` sẽ phát âm thanh với tần số và thời gian tương ứng từ mảng `melody` và `durations`. Sau khi phát xong, nó sẽ giữ khoảng cách giữa các nốt bằng cách sử dụng hàm `delay()`.

```cpp
tone(BUZZER_PIN, melody[i], durations[i]);  // Phát nốt nhạc với tần số và thời gian tương ứng
delay(durations[i] + 50);                   // Giữ khoảng cách giữa các nốt
```

Khi hoàn thành giai điệu, nó sẽ dừng phát nhạc bằng cách gọi hàm `noTone()` và đặt lại trạng thái `isPlaying` thành `false`.

```cpp
noTone(BUZZER_PIN);  // Dừng phát nhạc sau khi hoàn thành giai điệu
digitalWrite(BUZZER_PIN, LOW); // Đảm bảo buzzer tắt
isPlaying = false;   // Đặt lại trạng thái
```

Nếu không phát nhạc, nó sẽ đảm bảo rằng buzzer tắt bằng cách gọi hàm `noTone()`.

```cpp
else {
  noTone(BUZZER_PIN);  // Nếu không phát nhạc, đảm bảo buzzer tắt
  digitalWrite(BUZZER_PIN, LOW); // Đảm bảo buzzer tắt
}
```

## Kết quả

?> Nếu bạn đã thực hiện đúng các bước, bạn sẽ nghe thấy âm thanh của bài Happy Birthday phát ra từ buzzer khi nhấn nút PLAY và dừng lại khi nhấn nút STOP.

<div align="center">
    <video controls style="width: 700px; height: auto;">
        <source src="https://cdn.chipstack.vn/zerobase2/buzzer/buzzer-music-res.mp4" type="video/mp4">
        Trình duyệt của bạn không hỗ trợ video.
    </video>
    <p><em>Phát nhạc bằng còi buzzer</em></p>
</div>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn cách phát nhạc bằng buzzer với board Zerobase 2. Đây là bước khởi đầu giúp bạn làm quen với lập trình vi điều khiển và cách điều khiển thiết bị ngoại vi.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Thay đổi giai điệu và thời gian phát của các nốt nhạc trong mảng `melody` và `durations` để tạo ra các bài hát khác nhau.
- Thay đổi giai điệu và thời gian phát của các nốt nhạc trong mảng melody và durations để tạo ra các bài hát khác nhau.
- Sử dụng nút bấm để chọn và phát các bài nhạc khác nhau theo yêu cầu.
- Điều chỉnh âm lượng bằng cách thay đổi độ rộng xung (PWM) của tín hiệu điều khiển buzzer.
- Kết hợp với màn hình LCD hoặc LED để hiển thị thông tin về bài hát đang phát.
- Đồng bộ hóa âm thanh với các hiệu ứng ánh sáng LED để tạo hiệu ứng sinh động hơn.
- Tích hợp cảm biến để phát nhạc dựa trên dữ liệu môi trường, ví dụ như phát âm thanh cảnh báo khi phát hiện chuyển động.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase-2/examples.md)






