<br>
<br>
<br>

# Điều khiển động cơ DC bằng relay và nút nhấn

![relay-dc-motor](https://cdn.chipstack.vn/zerobase/relay/relay-dc-motor.png)

## Tổng quan

?> Bài viết này hướng dẫn bạn cách điều khiển động cơ DC bằng relay và nút nhấn.

## Chuẩn bị

| Linh kiện | Link mua |
|--- | --- |
| Board Zerobase |[Mua ngay](https://chipstack.vn/san-pham/zerobase/) |
| Breadboard |[Mua ngay](https://chipstack.vn/san-pham/breadboard-830-lo/) |
| Nút nhấn | [Mua ngay](https://chipstack.vn/san-pham/nut-nhan-12x12x7-3-co-the-gan-chup/) |
| Động cơ DC | [Mua ngay](https://chipstack.vn/san-pham/dong-co-dc-2-truc-ty-le-1120/) |
| Dây jumper Đực – Đực | [Mua ngay](https://chipstack.vn/san-pham/day-jumper-duc-duc/) |
| Dây USB Type C |[Mua ngay](https://chipstack.vn/san-pham/day-usb-type-c-1m/) |
| Module relay 5V 2 kênh mức thấp |[Mua ngay](https://chipstack.vn/san-pham/module-relay-5v-2-kenh-muc-thap/) |
| Module nguồn cho Breadboard MB102 830 | [Mua ngay](https://chipstack.vn/san-pham/module-nguon-cho-breadboard-mb102-830/) |
| Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W | [Mua ngay](https://chipstack.vn/san-pham/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w/) |

<div align="center">
    <img src="https://cdn.chipstack.vn/default/zerobase-overview.png" alt="zerobase">
    <p><em>Board Zerobase</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/breadboard.png" alt="breadboard">
    <p><em>Breadboard</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/button/push-button.png" alt="push-button">
    <p><em>Nút nhấn</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/dong-co-dc.png" alt="dong-co-dc">
    <p><em>Động cơ DC</em></p>
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
    <img src="https://cdn.chipstack.vn/relay/module-relay-5v-2-kenh-muc-thap.png" alt="module-relay-5v-2-kenh-muc-thap">
    <p><em>Module relay 5V 2 kênh mức thấp</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/module-nguon-cho-breadboard-mb102-830.png" alt="module-nguon-cho-breadboard-mb102-830">
    <p><em>Module nguồn cho Breadboard MB102 830</em></p>
</div>

<div align="center">
    <img src="https://cdn.chipstack.vn/default/nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w.png" alt="nguon-ac-dc-dieu-chinh-dien-ap-3-12v-3a-36w">
    <p><em>Nguồn AC-DC điều chỉnh điện áp 3-12V 3A 36W</em></p>
</div>

## Nguyên lý hoạt động


?> Khi bạn nhấn nút, vi điều khiển sẽ kích hoạt relay. Relay hoạt động như một công tắc điện có ba chân quan trọng: COM (chân chung), NO (Normally Open - Thường hở), và NC (Normally Closed - Thường đóng).

![relay-schematic](https://cdn.chipstack.vn/zerobase/relay/relay-schematic.png)

?> Khi relay chưa kích hoạt, COM nối với NC, nghĩa là mạch không cấp điện cho động cơ.

![relay-schematic](https://cdn.chipstack.vn/zerobase/relay/relay-schematic-2.png)

?> Khi relay được kích hoạt, COM sẽ nối với NO, giúp cấp nguồn cho động cơ, làm động cơ quay. 

?> Nếu sử dụng một relay, bạn chỉ có thể bật hoặc tắt động cơ. 

Xem thêm cách đảo chiều động cơ bằng relay [tại đây]().

## Sơ đồ kết nối

![zerobase-pins-relay](https://cdn.chipstack.vn/zerobase/relay/zerobase-pins-relay.png "zerobase-pins-relay")

Sử dụng chân D3 để kết nối với một chân của nút nhấn, chân còn lại của nút nhấn nối với GND của board Zerobase, GND của module nguồn và chân GND của relay.

Chân D12 được kết nối với chân IN1 của relay.

5V của module nguồn dùng để cấp nguồn cho động cơ DC, chân VCC của relay và cấp nguồn cho board Zerobase.

Chân GND của board Zerobase được kết nối với chân GND của relay và của module nguồn.

![dc-1-direction-schematic](https://cdn.chipstack.vn/zerobase/relay/dc-1-direction-schematic.png "dc-1-direction-schematic")

![dc-1-direction-image](https://cdn.chipstack.vn/zerobase/relay/dc-1-direction-image.png "dc-1-direction-image")

!> Lưu ý quan trọng: Trước khi cắm dây USB vào để nạp code vào board Zerobase, bạn cần ngắt nguồn cấp 5V ra khỏi board để tránh làm hỏng board. Bạn có thể ngắt nguồn bằng cách rút dây nguồn hoặc tháo module nguồn ra khỏi breadboard. Sau khi nạp code xong, bạn có thể cấp nguồn lại cho board Zerobase và chạy code bình thường.

## Code

Dưới đây là đoạn code để điều khiển động cơ DC bằng relay và nút nhấn:

```cpp
// Khai báo chân điều khiển relay, nối với chân số 12 trên vi điều khiển
const int relayPin = 12;

// Khai báo chân nút nhấn, nối với chân số 3 trên vi điều khiển
const int buttonPin = 3;

void setup() {
  // Thiết lập chân relayPin là OUTPUT để có thể điều khiển relay
  pinMode(relayPin, OUTPUT);

  // Thiết lập chân buttonPin là INPUT_PULLUP để sử dụng điện trở pull-up nội  
  // Điều này có nghĩa là khi nút chưa nhấn, chân buttonPin sẽ ở mức HIGH (5V)  
  // Khi nhấn nút, chân buttonPin sẽ bị kéo xuống mức LOW (0V)
  pinMode(buttonPin, INPUT_PULLUP);
}

void loop() {
  // Đọc trạng thái của nút nhấn
  if (digitalRead(buttonPin) == LOW) {  
    // Nếu nút nhấn được nhấn (buttonPin = LOW)
    
    // Đưa relayPin xuống mức LOW, điều này bật relay  
    // Vì module relay 5V thường hoạt động với mức điều khiển LOW (mức kích LOW)
    digitalWrite(relayPin, LOW);  
  } else {
    // Nếu nút nhấn không được nhấn (buttonPin = HIGH)
    
    // Đưa relayPin lên mức HIGH, điều này tắt relay
    digitalWrite(relayPin, HIGH);  
  }
}
```

Copy đoạn code trên và dán vào Arduino IDE, kết quả sẽ được như hình bên dưới.

![relay-zerobase-code](https://cdn.chipstack.vn/zerobase/relay/relay-zerobase-code.png "relay-zerobase-code")

### Biên dịch

Nhấn vào biểu tượng Verify để biên dịch code.

![verify-code](https://cdn.chipstack.vn/default/verify-code.png "verify-code]")

### Thực hiện nạp code

Cuối cùng bạn thực hiện nạp code vào board Zerobase. Nếu chưa biết cách nạp code cho Zerobase, bạn có thể tham khảo [tại đây](https://zerobase.chipstack.vn/#/vi/zerobase/quickstart).

Nếu muốn điều khiển động cơ ở chân khác, bạn có thể thay đổi giá trị của biến `relayPin` thành chân bạn muốn điều khiển sau đó kết nối relay với chân đó.

```cpp
const int relayPin = 12; // Khai báo chân điều khiển relay, nối với chân số 12 trên vi điều khiển
```

Nếu muốn sử dụng nút nhấn ở chân khác, bạn có thể thay đổi giá trị của biến `buttonPin` thành chân bạn muốn điều khiển sau đó kết nối nút nhấn với chân đó.

```cpp
const int buttonPin = 3; // Khai báo chân nút nhấn, nối với chân số 3 trên vi điều khiển
```

### Giải thích code

Khai báo biến hằng số `relayPin` với giá trị là 12, chính là chân D12 trên board Zerobase.

```cpp
const int relayPin = 12;
```

Khai báo biến hằng số `buttonPin` với giá trị là 3, chính là chân D3 trên board Zerobase.

```cpp
const int buttonPin = 3;
```

Trong hàm `setup()`, chúng ta sẽ thiết lập chân `relayPin` là đầu ra và chân `buttonPin` là đầu vào với điện trở kéo lên nội bộ.

```cpp
void setup() {
  pinMode(relayPin, OUTPUT); // Thiết lập chân relayPin là OUTPUT để có thể điều khiển relay
  pinMode(buttonPin, INPUT_PULLUP); // Thiết lập chân buttonPin là INPUT_PULLUP để sử dụng điện trở pull-up nội  
}
```

Trong hàm `loop()`, sử dụng hàm `digitalRead()` để đọc trạng thái của nút nhấn. Nếu nút nhấn được nhấn (chân buttonPin = LOW), thì relayPin sẽ được đưa xuống mức LOW, làm bật relay.

```cpp
if (digitalRead(buttonPin) == LOW) {  
    digitalWrite(relayPin, LOW);  
}  
```

Còn nếu nút không được nhấn (chân buttonPin = HIGH), thì relayPin sẽ được đưa lên mức HIGH, làm tắt relay.

```cpp
else {
    digitalWrite(relayPin, HIGH);  
}
```

## Kết quả

?> Khi nút được nhấn, động cơ sẽ quay. Khi nút được nhả ra, động cơ sẽ dừng lại.

<div align="center">
    <img src="https://cdn.chipstack.vn/zerobase/relay/relay-dc-motor-result.gif" alt="relay-dc-motor-result">
</div>

## Kết luận và hướng phát triển

Bạn đã hoàn thành việc điều khiển động cơ DC bằng relay và nút nhấn.

Để phát triển thêm từ bài học này, bạn có thể thử các ý tưởng sau:

- Đảo chiều quay của động cơ DC bằng cách sử dụng hai relay.
- Sử dụng cảm biến để tự động điều khiển động cơ DC, chẳng hạn như cảm biến ánh sáng hoặc cảm biến khoảng cách.
- Kết hợp với các cảm biến khác để tạo ra một robot tự hành đơn giản (robot dò line, robot tránh vật cản, ...).
- Sử dụng module Bluetooth hoặc Wi-Fi để điều khiển động cơ từ xa qua điện thoại hoặc máy tính.

**Chúc bạn thành công!**







