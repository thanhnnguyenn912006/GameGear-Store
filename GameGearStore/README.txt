GAMEGEAR STORE - HƯỚNG DẪN CÀI ĐẶT

YÊU CẦU
- XAMPP (Apache + MySQL/MariaDB)
- Trình duyệt web

CÀI ĐẶT
1. Giải nén thư mục GameGearStore vào C:\xampp\htdocs\GameGearStore
2. Mở XAMPP Control Panel, Start Apache và MySQL.
3. Mở http://localhost/phpmyadmin
4. Chọn tab Import, chọn file sql/gamegear_store.sql rồi bấm Import/Go.
5. Kiểm tra thông tin kết nối trong config.php (mặc định XAMPP: user root, password rỗng).
6. Mở http://localhost/GameGearStore/

TẠO TÀI KHOẢN QUẢN TRỊ
1. Trên website, đăng ký tài khoản tại /register.php bằng email của bạn.
2. Trong phpMyAdmin, chọn CSDL gamegear_store, mở bảng users, tìm tài khoản vừa tạo.
3. Sửa cột role từ customer thành admin.
4. Đăng xuất và đăng nhập lại để mở mục Quản trị.

CHỨC NĂNG ĐÃ CÓ
- Trang chủ, danh sách sản phẩm, tìm kiếm và lọc danh mục
- Chi tiết sản phẩm, giỏ hàng lưu trong session
- Đặt hàng, lưu orders/order_details và cập nhật tồn kho trong transaction
- Đăng ký, đăng nhập, đăng xuất; mật khẩu được password_hash/password_verify
- Trang liên hệ và lưu nội dung vào MySQL
- Trang quản trị: CRUD sản phẩm và danh mục; cập nhật trạng thái đơn hàng; xóa liên hệ
- Dữ liệu sản phẩm minh họa có sẵn trong file SQL

