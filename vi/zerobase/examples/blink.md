<br>
<br>
<br>

# Nạp Code và nháy LED

## 1. Giới Thiệu

> Bài viết này hướng dẫn cách nạp code cho Zerobase của bạn trên Arduino IDE và thực hiện nháy LED đơn giản.

## 2. Chuẩn Bị

- Zerobase
- Dây USB kết nối với máy tính
- Arduino IDE
- Driver và core phù hợp với vi điều khiển trên board
- Điện trở 330Ω
- LED

## 3. Cài Đặt Board Trên Arduino IDE

1. Mở **Arduino IDE**.
2. Vào **File > Preferences**.
3. Trong mục **Additional Board Manager URLs**, thêm đường dẫn sau:

   ```link
   https://raw.githubusercontent.com/ChipstackLTD/zerobase-board-manager/refs/heads/master/zerobase.json
   ```

4. Nhấn **OK**, sau đó mở **Boards Manager** (*Tools > Board > Boards Manager*).
5. Tìm kiếm tên board: `ZB` và nhấn **Install**.

## 4. Quy Trình Nạp Code

1. Kết nối board với máy tính bằng cáp USB.
2. Vào chế độ nạp code bằng cách:

   - Nhấn giữ nút **BOOT**.
   - Nhấn nút **RESET** rồi thả ra.
   - Sau đó, thả nút **BOOT**. Board sẽ vào chế độ nạp code.

3. Nạp code từ Arduino IDE:

   - Mở **Arduino IDE**.
   - Vào **Tools > Board**, chọn đúng tên board của bạn.
   - Vào **Tools > Port**, chọn đúng cổng COM.
   - Viết hoặc mở code cần nạp.
   - Nhấn **Upload** (**Ctrl+U**) để nạp code.
   - Nếu lỗi chưa có driver, cài đặt lại driver phù hợp.

4. Nhấn nút **RESET** để chạy code mới.

## 5. Sơ Đồ Kết nối
![blink-zerobase](../../_media/blinkZerobase.png "blink-zerobase]")

## 6. Code Nháy LED Mẫu

Dưới đây là đoạn code đơn giản để nháy LED trên board:

```cpp
void setup() {
    pinMode(LED_BUILTIN, OUTPUT);
    pinMode(3, OUTPUT);
}

void loop() {
    digitalWrite(LED_BUILTIN, HIGH);
    digitalWrite(3, HIGH);
    delay(500);
    digitalWrite(LED_BUILTIN, LOW);
    digitalWrite(3, LOW);
    delay(500);
}
```

## 7. Lưu Ý

!> Nếu không nhận board trên Arduino IDE, kiểm tra lại driver.

!> Đảm bảo chọn đúng board và cổng COM.

!> Nếu nạp code thất bại, thử lại quy trình vào chế độ nạp code.

**Chúc bạn thành công!**

