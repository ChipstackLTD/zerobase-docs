<br>
<br>
<br>

# Các lỗi thường gặp khi sử dụng Zerobase

## Nạp code và chạy code

Trước khi nạp code, bạn cần đưa vi điều khiển vào chế độ nạp code - [Hướng dẫn nạp code](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu không IDE sẽ báo lỗi khi nạp code:

![error-upload](https://cdn.chipstack.vn/zerobase/troubleshooting/error-upload.png)

Khi nạp code thành công, bạn cần nhấn nút Reset để đưa vi điều khiển về chế độ chạy code.

## Lỗi cấp nguồn

!> Nếu bạn đã cấp nguồn cho board bằng cổng USB, không được cấp nguồn thêm cho board qua chân 5V.

## Lệnh Serial.print() không hoạt động.

!> Vì Zerobase không hỗ trợ Serial over USB nên phải dùng thêm mạch [USB-to-UART](https://chipstack.vn/san-pham/cap-usb-uart-pl2303hx/) gắn thêm vào Zerobase để hỗ trợ in log qua `Serial1`. Zerobase 2 và Zerobase 2W thì không nhất thiết phải dùng mạch này. Xem thêm tại [Chipstack Academy](https://academy.chipstack.vn/course/view.php?id=2)



