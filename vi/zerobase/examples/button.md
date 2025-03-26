<br>
<br>
<br>

# Điều khiển đèn LED bằng nút nhấn

![btn-zerboase](../../../_media/btn-zerobase.png "btn-zerboase")

## Tổng quan

?> Bài viết này hướng dẫn cách sử dụng nút nhấn với Zerobase để điều khiển LED.

## Chuẩn Bị

| Linh kiện |  Link mua |
| --- | --- |
| Board Zerobase | [Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |
| Dây nối | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Điện trở 330Ω | [Mua ngay](https://chipstack.vn/san-pham/dien-tro-1-4w-1/) |
| LED | [Mua ngay](https://chipstack.vn/san-pham/led-5mm-vo-mau/) |

<br>

<div align="center">
    <img src="../../../_media/zerobase-image.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<br>

<div align="center">
    <img src="../../../_media/push-button.png" alt="push-button">
    <p><em>Nút nhấn</em></p>
</div>

<br>

<div align="center">
    <img src="../../../_media/jumper-wire.png" alt="jumper-wire">
    <p><em>Dây nối</em></p>
</div>

<br>

<div align="center">
    <img src="../../../_media/dien-tro-330-ohm.png" alt="dien-tro-330-ohm">
    <p><em>Điện trở 330Ω</em></p>
</div>

<br>

<div align="center">
    <img src="../../../_media/led-do.png" alt="led-do">
    <p><em>LED</em></p>
</div>

## Nguyên Lý Hoạt Động

?> Khi nút nhấn được nhấn, đèn LED sẽ bật. Khi nút được thả ra, đèn LED sẽ tắt.

> Xem thêm về LED [tại đây](https://chipstack.vn/uncategorized/diot-phat-quang-la-gi-nguyen-ly-hoat-dong-va-ung-dung-tiet-kiem-nang-luong/).

## Sơ đồ kết nối

![btn-zerboase-pins](../../../_media/btn-zerobase-pins.png "btn-zerboase-pins")

Sử dụng chân D3 để kết nối với điện trở 330ohm nối tiếp với cực Anode (+) của LED và GND để kết nối với cực Cathode (-) của LED.

Sử dụng chân A0 (D14) để kết nối với nút nhấn và GND để kết nối với chân còn lại của nút nhấn.

![btn-zerboase-schmatic](../../../_media/btn-zerboase-schmatic.png "btn-zerboase-schmatic")

![btn-zerboase](../../../_media/btn-zerobase.png "btn-zerboase")

## Code

Dưới đây là đoạn code mẫu để điều khiển LED bằng nút nhấn:

```cpp
// Khai báo chân nút nhấn (button) được kết nối tại chân số 14
const int btn = 14;

// Khai báo chân đèn LED được kết nối tại chân số 3
const int led = 3;

// Hàm setup() chạy một lần khi khởi động hoặc reset board
void setup() {
  // Cấu hình chân nút nhấn là INPUT với chế độ PULLUP (mặc định là mức HIGH khi không nhấn)
  pinMode(btn, INPUT_PULLUP);

  // Cấu hình chân LED là OUTPUT để điều khiển đèn LED
  pinMode(led, OUTPUT);
}

// Hàm loop() chạy liên tục sau khi setup() hoàn thành
void loop() {
  // Kiểm tra trạng thái của nút nhấn
  if (digitalRead(btn)) {     // Nếu nút chưa được nhấn (mức HIGH do PULLUP)
    digitalWrite(led, LOW);   // Tắt đèn LED
  } else {                    // Nếu nút được nhấn (mức LOW)
    digitalWrite(led, HIGH);  // Bật đèn LED
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![btn-zerobase-code](../../../_media/btn-zerobase-code.png "btn-zerobase-code]")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/verify-code.png "verify-code]")

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu muốn thay đổi chân kết nối, bạn chỉ cần sửa lại giá trị biến `btn` hoặc `led` trong code sau đó kết nối nút nhấn và đèn LED với chân tương ứng.

```cpp
const int btn = 14; // Thay đổi chân nút nhấn
const int led = 3; // Thay đổi chân đèn LED
```

Nếu muốn thay đổi `INPUT_PULLUP` thành `INPUT_PULLDOWN`, bạn chỉ cần sửa lại dòng cấu hình chân `btn` trong hàm `setup()`.

```cpp
pinMode(btn, INPUT_PULLDOWN); // Thay đổi thành chế độ PULLDOWN
```

### Giải Thích Code

```cpp
const int btn = 14;
const int led = 3;
```

Khai báo biến `btn` là chân số 14 kết nối với nút nhấn và biến `led` là chân số 3 kết nối với đèn LED.

```cpp
pinMode(btn, INPUT_PULLUP);
pinMode(led, OUTPUT);
```

Trong hàm `setup()`, chúng ta cấu hình chân `btn` là INPUT_PULLUP để sử dụng điện trở kéo lên nội bộ của vi điều khiển. Chân `led` được cấu hình là OUTPUT để điều khiển đèn LED.

```cpp
if (digitalRead(btn)) {
  digitalWrite(led, LOW);
}
```

Trong hàm `loop()`, chúng ta kiểm tra trạng thái của nút nhấn. Nếu nút chưa được nhấn (mức HIGH do điện trở PULLUP), đèn LED sẽ tắt.

```cpp
else {
  digitalWrite(led, HIGH);
}
```

Nếu nút được nhấn (mức LOW), đèn LED sẽ bật.

## Kết Quả

?> Khi nút nhấn được nhấn, đèn LED sẽ bật. Khi nút nhấn được thả ra, đèn LED sẽ tắt.

<p align="center">
  <img src="../../../_media/btn-zerobase-result.gif" alt="btn-zerobase-result.gif">
</p>

## Kết luận và hướng phát triển

Bài viết đã hướng dẫn chi tiết cách sử dụng nút nhấn để điều khiển đèn LED với Zerobase. Thông qua việc kết nối phần cứng, lập trình và kiểm tra kết quả, bạn đã hiểu được cách hoạt động của nút nhấn, điện trở kéo cũng như cách điều khiển LED bằng vi điều khiển.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- **Mở rộng chức năng:** Thay vì chỉ bật/tắt LED, bạn có thể lập trình để LED nhấp nháy theo số lần nhấn hoặc chuyển đổi trạng thái mỗi lần nhấn.
- **Sử dụng ngắt ngoài (Interrupt):** Thay vì kiểm tra nút nhấn liên tục trong loop(), bạn có thể sử dụng ngắt ngoài để phản hồi nhanh hơn khi nút được nhấn.
- **Điều khiển nhiều thiết bị:** Áp dụng cơ chế điều khiển này để bật/tắt nhiều thiết bị khác nhau như còi báo động, động cơ hoặc màn hình LCD.
- **Cải thiện chống dội phím (Debounce):** Thêm cơ chế debounce bằng phần mềm hoặc sử dụng mạch RC để tránh trạng thái không ổn định khi nhấn nút.
- **Kết nối với IoT:** Kết hợp với WiFi hoặc Bluetooth để điều khiển LED từ xa qua ứng dụng di động hoặc giao diện web.

Với những gợi ý trên, bạn có thể tiếp tục mở rộng dự án để tạo ra nhiều ứng dụng thực tế hơn.

**Chúc bạn thành công!**

