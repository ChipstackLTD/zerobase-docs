<br>
<br>
<br>

# Các lưu ý khi sử dụng board Zerobase 2

## Nguồn cấp

![chan-cap-nguon-zerobase2](https://cdn.chipstack.vn/zerobase2/quickstart/chan-cap-nguon-zerobase2.png "chan-cap-nguon-zerobase2.png]")

Nguồn cấp cho board Zerobase 2 là 3V3.

Bạn có thể cấp nguồn qua chân 3V3 hoặc qua cổng USB.

?> Bạn cũng có thể cấp nguồn cho board qua chân 5V.

## Lưu ý khi sử dụng các thư viện bên ngoài

Vì board Zerobase 2 sử dụng vi điều khiển CH32V203, nên một số thư viện bên ngoài có thể không tương thích với vi điều khiển này.

## UART

### Serial (USB)

Đây là cổng Serial mặc định được sử dụng để in dữ liệu ra Serial Monitor thông qua kết nối USB trực tiếp trên board.

Để có thể sử dụng Serial, bạn cần thêm thư viện sau vào code:

 ```cpp
#include <ZBPrint.h>
```

### Các chân Serial

Board Zerobase 2 có ba cổng UART: Serial1, Serial2, Serial3.

| Tên cổng sử dụng trong thư viện | UART |Chân TX | Chân RX | Chân CTS | Chân RTS |
|:--|:--|:--| :--| :--| :--|
| Serial1 | USART1 | D1 | D0 |||
| Serial2 | USART2| D16 | D17 | A0/D14| A1/D15 |
| Serial3 | USART3 | D19 | D18 |||


## I2C
### Điện trở kéo lên (Pull-up resistor)

Hiện tại MCU chưa có điện trở kéo (pull-up) cho hai chân I2C (SCL, SDA). Vì ở chế độ output open-drain không có sẵn trở kéo nội, nên cần thêm 2 điện trở 4.7kΩ nối SCL và SDA lên 3V3 để giao tiếp I2C hoạt động ổn định.

Thông thường, các cảm biến I2C đã có sẵn trở kéo bên trong, nên không cần thêm ngoài.

!> Tuy nhiên, nếu dùng hai board Zerobase 2 giao tiếp I2C với nhau, bạn cần gắn thêm trở kéo ngoài cho ít nhất một board, nếu không sẽ không hoạt động.

### Các chân I2C

Zerobase 2 có hai cổng I2C: Wire và Wire1.

| Tên cổng sử dụng trong thư viện | I2C | Chân SDA | Chân SCL |
| :--|:--|:--| :--|
| Wire | I2C2 | D18 | D19 |
| Wire1 | I2C1 | D3 (D+) | D2 (D-) |

## SPI

### Các chân SPI

Zerobase 2 có hai cổng SPI: SPI và SPI1.

| Tên cổng sử dụng trong thư viện | SPI | Chân MOSI | Chân MISO | Chân SCK | Chân CS |
| :--|:--|:--| :--| :--| :--|
| SPI | SPI1 | D11 | D12 | D13 | D10 |
| SPI_1 | SPI2 | D9 | D8 | D7 | D6 |

## Timer (analogWrite)

Trừ các chân D6, A6, A7 thì toàn bộ chân GPIO đều hỗ trợ PWM.

Tuy nhiên, một số chân sử dụng cùng bộ Timer và cùng kênh với nhau, hoặc sử dụng cùng bộ Timer khác kênh nhau nhưng mapping khác nhau, nên không thể sử dụng đồng thời.

Dưới đây là bảng chân PWM và các chân không thể sử dụng đồng thời với nhau:

| Chân GPIO | Timer | Channel | Không thể dùng đồng thời với |
|:--|:--|:--|:--|
| D25 | Timer 1 | Channel 1 | D7 |
| D1 | Timer 1 | Channel 2 | D8 |
| D0 | Timer 1 | Channel 3 | D9 |
| D26 | Timer 1 | Channel 4 | |
| D7 | Timer 1 | Channel 1N | D25 |
| D8 | Timer 1 | Channel 2N | D1 |
| D9 | Timer 1 | Channel 3N | D0 |
| D14/A0 | Timer 2 | Channel 1 | D10, D13, D19, D18 |
| D10 | Timer 2 | Channel 1 | D14/A0, D15/A1, D16/A2, D17/A3, D19, D18 |
| D15/A1 | Timer 2 | Channel 2 | D10, D13, D19, D18 |
| D13 | Timer 2 | Channel 2 | D14/A0, D15/A1, D16/A2, D17/A3, D10, D19, D18 |
| D16/A2 | Timer 2 | Channel 3 | D10, D13, D19, D18 |
| D19 | Timer 2 | Channel 3 | D14/A0, D15/A1, D16/A2, D17/A3, D10, D13, D18 |
| D17/A3 | Timer 2 | Channel 4 | D10, D13, D19, D18 |
| D18 | Timer 2 | Channel 4 | D14/A0, D15/A1, D16/A2, D17/A3, D10, D13, D19 |
| D23 | Timer 3 | Channel 1 | D12, D11, D30, D31 |
| D12 | Timer 3 | Channel 1 | D23, D24, D30, D31 |
| D24 | Timer 3 | Channel 2 | D12, D11, D30, D31 |
| D11 | Timer 3 | Channel 2 | D23, D24, D30, D31 |
| D30 | Timer 3 | Channel 3 | D23, D24, D12, D11 |
| D31 | Timer 3 | Channel 4 | D23, D24, D12, D11 |
| D2 | Timer 4 | Channel 1 | |
| D3 | Timer 4 | Channel 2 | |
| D4 | Timer 4 | Channel 3 | |
| D5 | Timer 4 | Channel 4 | |