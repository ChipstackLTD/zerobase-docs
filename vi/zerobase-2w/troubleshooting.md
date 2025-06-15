<br>
<br>
<br>

# Các lỗi thường gặp khi sử dụng Zerobase 2W

## Cài đặt driver

Nếu upload code xuất hiện lỗi như hình dưới đây:

![upload-unsuccess-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-unsuccess-zerobase2.png "upload-unsuccess-zerobase2]")

Bạn cần cài đặt driver cho board Zerobase 2W. Bạn có thể tải driver tại [đây](https://cdn.chipstack.vn/reference/zadig-2.9.exe).

Chạy file `zadig-2.9.exe` vừa tải về. Đưa board vào chế độ nạp code bằng 1 trong 2 cách như trên. Sau đó chọn **Options > List All Devices**.

![list-all-devices](https://cdn.chipstack.vn/zerobase2/quickstart/list-all-devices.png "list-all-devices]")

Chọn **USB Module**.

![usb-module](https://cdn.chipstack.vn/zerobase2/quickstart/usb-module.png "usb-module]")

Nhấn mũi tên lên hoặc xuống để chọn driver **WinUSB**. và nhấn **Replace Driver**.

![win-usb](https://cdn.chipstack.vn/zerobase2/quickstart/win-usb.png "win-usb]")

Đợi đến khi driver được cài đặt thành công, bạn sẽ thấy dòng thông báo như hình dưới đây.

![driver-installed-success](https://cdn.chipstack.vn/zerobase2/quickstart/driver-installed-success.png "driver-installed-success]")

Bạn nhấn **Upload** hoặc nhấn **Ctrl+U** để nạp code.

![upload-code-z2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-code-z2.png "upload-code-z2]")

Nếu nạp code thành công, bạn sẽ thấy dòng thông báo như hình dưới đây.

![upload-success-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/upload-success-zerobase2.png "upload-success-zerobase2]")

## Nạp code và chạy code

Trước khi nạp code, bạn cần đưa vi điều khiển vào chế độ nạp code - [Hướng dẫn nạp code](https://zerobase.chipstack.vn/#/vi/zerobase-2/quickstart).

Nếu không IDE sẽ báo lỗi khi nạp code:

![error-upload](https://cdn.chipstack.vn/zerobase2/troubleshooting/error-upload.png)

Khi nạp code thành công, board sẽ tự động chạy đoạn code vừa nạp mà không cần nhấn nút Reset.

## Lỗi cấp nguồn

!> Nếu bạn đã cấp nguồn cho board bằng cổng USB, không được cấp nguồn thêm cho board qua chân 3V3 hoặc 5V.

## Sử dụng thư viện

## Thư viện OLED `Adafruit_SSD1306`

Nếu bạn sử dụng thư viện `Adafruit_SSD1306` và khi biên dịch IDE báo lỗi như hình dưới đây.

![oled-ssd1306-error](https://cdn.chipstack.vn/zerobase2/oled-ssd1306/oled-ssd1306-error.png)

Bạn tìm đến file `Adafruit_SSD1306.cpp` theo đường dẫn xuất hiện trong thông báo lỗi, ví dụ ở trên là `c:\Users\ADMIN\OneDrive\Documents\Arduino\libraries\Adafruit_SSD1306\Adafruit_SSD1306.cpp`.

Sau đó bạn mở file `Adafruit_SSD1306.cpp`.

![oled-ssd1306-file](https://cdn.chipstack.vn/zerobase2/oled-ssd1306/oled-ssd1306-file.png)

Bạn tìm đến dòng 51 và comment lại toàn bộ như hình dưới đây.

![need-comment](https://cdn.chipstack.vn/zerobase2/oled-ssd1306/need-comment.png)

![comment](https://cdn.chipstack.vn/zerobase2/oled-ssd1306/comment.png)

Sau đó bạn thực hiện biên dịch lại code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")