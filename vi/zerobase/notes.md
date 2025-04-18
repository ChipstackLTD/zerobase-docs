<br>
<br>
<br>

# Các lưu ý khi sử dụng board Zerobase

## Nguồn cấp

![chan-cap-nguon-zerobase](https://cdn.chipstack.vn/zerobase/quickstart/chan-cap-nguon-zerobase.png "chan-cap-nguon-zerobase.png]")

Nguồn cấp cho board Zerobase là 5V.

Bạn có thể cấp nguồn qua chân 5V hoặc qua cổng USB.

Chân 3V3 trên board Zerobase chỉ được kết nối nội bộ qua connector QWIIC, nên không có khả năng cấp nguồn cho các thiết bị khác hay làm nguồn cấp cho board Zerobase.

## Lưu ý khi sử dụng các thư viện bên ngoài

Vì board Zerobase sử dụng vi điều khiển CH32V003, nên một số thư viện bên ngoài có thể không tương thích với vi điều khiển này.

Board Zerobase chỉ có dung lượng bộ nhớ Flash là 16kB, nên một số thư viện có dung lượng lớn sẽ không thể sử dụng được và sẽ gây ra lỗi sau khi biên dịch.

![overflowed-flash](https://cdn.chipstack.vn/zerobase/notes/overflowed-flash.png)

## UART

### Serial (USB)

Đây là cổng Serial mặc định được sử dụng để in dữ liệu ra Serial Monitor thông qua kết nối USB trực tiếp trên board.

Tuy nhiên, Serial hiện tại đang không hoạt động trên firmware của Zerobase — do đó bạn không thể sử dụng Serial Monitor qua cổng USB bằng Serial trong thời điểm này.

### Các chân UART

| Tên cổng sử dụng trong thư viện | Chân TX | Chân RX |
|:--|:--| :--|
| Serial1 |D1 | D0 |

Bạn có thể sử dụng Serial1 để:
- Giao tiếp UART với các module hoặc thiết bị ngoại vi như GPS, cảm biến, ESP, v.v.
- In thông tin ra Serial Monitor bằng cách kết nối TX và RX với một bộ chuyển đổi USB-UART (TTL) rồi cắm vào máy tính. Bạn có thể tham khảo thêm cách sử dụng Serial Monitor với board Zerobase trong [bài viết này](vi/zerobase/examples/uartttl.md).

## I2C

### Điện trở kéo lên (Pull-up resistor)

Hiện tại MCU chưa có điện trở kéo (pull-up) cho hai chân I2C (SCL, SDA). Vì ở chế độ output open-drain không có sẵn trở kéo nội, nên cần thêm 2 điện trở 4.7kΩ nối SCL và SDA lên 3V3 để giao tiếp I2C hoạt động ổn định.

Thông thường, các cảm biến I2C đã có sẵn trở kéo bên trong, nên không cần thêm ngoài.

!> Tuy nhiên, nếu dùng hai board Zerobase giao tiếp I2C với nhau, bạn cần gắn thêm trở kéo ngoài cho ít nhất một board, nếu không sẽ không hoạt động.

### Các chân I2C

| Tên cổng sử dụng trong thư viện | Chân SDA | Chân SCL |
|:--|:--| :--|
| Wire |D18 | D19 |

## SPI

### Các chân SPI

| Tên cổng sử dụng trong thư viện | Chân MOSI | Chân MISO | Chân SCK | Chân SS |
|:--|:--| :--|:--| :--|
| SPI |D11 | D12 | D13 | D10 |

### Chế độ slave cho Zerobase

Mặc định, chế độ hoạt động của Zerobase là chế độ master. Nếu bạn muốn sử dụng Zerobase như một thiết bị slave, vào tool > I2C Slave support > I2C Slave Enabled.

![i2c-slave-enabled](https://cdn.chipstack.vn/zerobase/notes/i2c-slave-enabled.png)

## Timer (analogWrite)

Toàn bộ chân trên board Zerobase đều hỗ trợ PWM.

Tuy nhiên, một số chân sử dụng cùng bộ Timer và cùng kênh với nhau, hoặc sử dụng cùng bộ Timer khác kênh nhau nhưng mapping khác nhau, nên không thể sử dụng đồng thời.

Dưới đây là bảng chân PWM và các chân không thể sử dụng đồng thời với nhau:

| Chân GPIO |	Timer |	Channel	| Không thể dùng đồng thời với |
|:--|:--|:--|:--|
| D13 | Timer 2 | Channel 1 | D3, D10 |
| D19 | Timer 2 | Channel 2 | |
| A3/D17 | Timer 2 | Channel 3 | D3, D10 |
| D10 | Timer 2 | Channel 3 | D3, D13 , A3/D17, D18, D19|
| D3 | Timer 2 | Channel 3 | D10, D13 , A3/D17, D18, D19| 
| D18 | Timer 2 | Channel 4 | D3, D10 |
| D11 | Timer 1 | Channel 1 | A3/D17, A1/D15, D2, A2/D16, D1, A0/D14, D0 |
| D12 | Timer 1 | Channel 2 | A3/D17, A1/D15, D2, A2/D16, D1, A0/D14, D0 |
| A3/D17 | Timer 1 | Channel 1 | D11, D1 |
| A1/D15 | Timer 1 | Channel 2 | D12, A0/D14 |
| D2 | Timer 1 | Channel 3 | D0 |
| A2/D16 | Timer 1 | Channel 4 | |
| D1 | Timer 1 | Channel 1N | A3/D17, D11 |
| A0/D14 | Timer 1 | Channel 2N | A1/D15, D12 |
| D0 | Timer 1 | Channel 3N | D2 |


