<br>
<br>
<br>

# Điều khiển còi buzzer trên board Zerobase

![buzzer-zerobase](https://cdn.chipstack.vn/vi/zerobase/buzzer/buzzer-zerobase.png)

## Tổng quan

?> Bài viết này hướng dẫn thực hiện điều khiển buzzer sử dụng board Zerobase trên Arduino IDE.

## Chuẩn bị
| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Buzzer |[Mua ngay](https://chipstack.vn/san-pham/coi-buzzer-chu-dong-12x9-5/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
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

## Nguyên lý hoạt động

?> Còi buzzer là một thiết bị điện tử phát ra âm thanh khi có dòng điện chạy qua.

?> Trong bài này, chúng ta sẽ sử dụng buzzer để phát ra âm thanh khi có tín hiệu từ chân GPIO của board Zerobase. Khi chân GPIO được thiết lập ở mức cao, buzzer sẽ phát ra âm thanh. Ngược lại, khi chân GPIO được thiết lập ở mức thấp, buzzer sẽ ngừng phát âm thanh.

## Sơ đồ kết nối

![buzzer-zerobase-pins](https://cdn.chipstack.vn/vi/zerobase/buzzer/buzzer-zerobase-pins.png)

Sử dụng chân D2 của board Zerobase để điều khiển buzzer. Chân D2 được kết nối với cực (+) của buzzer, còn cực (-) của buzzer được nối với chân GND của board Zerobase.

![buzzer-schematic](https://cdn.chipstack.vn/vi/zerobase/buzzer/buzzer-schematic.png)

![buzzer-zerobase-circuit](https://cdn.chipstack.vn/vi/zerobase/buzzer/buzzer-zerobase-circuit.png)

## Code

```cpp
// Khai báo chân kết nối với buzzer
const int buzzer = 1;

void setup() {
  // Thiết lập chân buzzer làm đầu ra
  pinMode(buzzer, OUTPUT);
}

void loop() {
  // Bật buzzer
  digitalWrite(buzzer, HIGH);
  // Giữ trạng thái bật trong 1 giây
  delay(1000);

  // Tắt buzzer
  digitalWrite(buzzer, LOW);
  // Giữ trạng thái tắt trong 1 giây
  delay(1000);
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![buzzer-code](https://cdn.chipstack.vn/zerobase/buzzer/buzzer-code.png)

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png)

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `buzzer` trong code và kết nối lại chân tương ứng trên board Zerobase.

```cpp
const int buzzer = 1; // Chân kết nối với buzzer
```

### Giải thích code

Khai báo biến hằng số `buzzer` với giá trị là 1, chính là chân D1 trên board Zerobase.

```cpp
const int buzzer = 1; // Khai báo biến hằng số cho chân 1
```

Trong hàm `setup()`, chúng ta sẽ thiết lập chân `buzzer` làm chân đầu ra.

```cpp
void setup() {
  // Thiết lập chân buzzer làm đầu ra
  pinMode(buzzer, OUTPUT);
}
```

Trong hàm loop, sử dụng hàm `digitalWrite()` và truyền vào tham số là HIGH để bật buzzer trên board Zerobase.

```cpp
digitalWrite(buzzer, HIGH); // Bật buzzer
```

Sử dụng hàm `delay()` để bật buzzer trong 1 giây.

```cpp
delay(1000); // Giữ trạng thái HIGH trong 1 giây
```

Sau đó sử dụng hàm `digitalWrite()` và truyền vào tham số là LOW để tắt buzzer trên board Zerobase.

```cpp
digitalWrite(buzzer, LOW); // Tắt buzzer
```

Sử dụng hàm `delay()` để tắt buzzer trong 1 giây.

```cpp
delay(1000); // Giữ trạng thái LOW trong 1 giây
```

Kết quả

Buzzer sẽ phát ra âm thanh trong 1 giây và tắt trong 1 giây. Quá trình này sẽ lặp lại liên tục.

<div align="center">
    <img src="https://cdn.chipstack.vn/vi/zerobase/buzzer/buzzer.gif" alt="buzzer-zerobase-gif">
    <p><em>Âm thanh phát ra từ buzzer</em></p>
</div>

## Kết luận và hướng phát triển

Bạn đã hoàn thành việc điều khiển buzzer trên board Zerobase.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Điều khiển Buzzer bằng các nút nhấn.
- Sử dụng thư viện Tone để phát ra âm thanh khác nhau (phát nhạc, âm thanh cảnh báo, ...).
- Kết hợp với cảm biến để phát ra âm thanh khi có sự kiện xảy ra (ví dụ: cảm biến chuyển động, cảm biến ánh sáng, ...).
- Kết hợp với LED để tạo hiệu ứng âm thanh và ánh sáng đồng bộ.
- Tạo một ứng dụng điều khiển từ xa để bật/tắt buzzer qua Bluetooth hoặc Wi-Fi.

**Chúc bạn thành công!**

[🏠 TRỞ VỀ TRANG TỔNG HỢP CÁC VÍ DỤ](vi/zerobase/examples.md)






