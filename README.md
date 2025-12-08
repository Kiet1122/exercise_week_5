# 📱 Ứng Dụng Ghi Chú - Flutter SQLite

**Dự án: Tuần 5 - Nguyễn Tất Kiệt**  
Một ứng dụng quản lý ghi chú đơn giản nhưng mạnh mẽ, được phát triển bằng Flutter với lưu trữ SQLite cục bộ.

---

## 🎯 Tính Năng Nổi Bật

### 📝 **Quản lý Ghi Chú Đầy Đủ**
- ✅ **Tạo mới**: Thêm ghi chú với tiêu đề và nội dung
- ✅ **Xem danh sách**: Hiển thị tất cả ghi chú theo thời gian cập nhật
- ✅ **Chỉnh sửa**: Cập nhật nội dung ghi chú hiện có
- ✅ **Xóa**: Xóa ghi chú với hộp thoại xác nhận
- ✅ **Lưu trữ**: Dữ liệu được lưu vĩnh viễn trong SQLite
- ✅ **Đồng bộ**: Giao diện tự động cập nhật khi có thay đổi

### 🎨 **Giao Diện Thân Thiện**
- Material Design 3 với giao diện sạch sẽ
- Hiển thị thời gian tạo và cập nhật
- Pull-to-refresh để làm mới danh sách
- Responsive design cho nhiều kích thước màn hình

---

## 🏗️ Kiến Trúc Ứng Dụng

### 📁 **Cấu Trúc Dự Án**
```
lib/
├── main.dart                    # Điểm khởi đầu ứng dụng
├── models/
│   └── note.dart              # Model dữ liệu ghi chú
├── database/
│   └── db_helper.dart         # Quản lý SQLite database
├── providers/
│   └── note_provider.dart     # State management với Provider
├── screens/
│   ├── home_page.dart         # Màn hình chính
│   └── note_editor_screen.dart # Màn hình chỉnh sửa
└── widgets/
    └── note_card.dart         # Widget hiển thị ghi chú
```

### 🔧 **Công Nghệ Sử Dụng**
- **Flutter 3.0+** - Framework đa nền tảng
- **Dart** - Ngôn ngữ lập trình
- **SQLite (sqflite)** - Cơ sở dữ liệu cục bộ
- **Provider** - Quản lý trạng thái
- **Material Design 3** - Thiết kế giao diện

---

## 🚀 **Hướng Dẫn Cài Đặt**

### **Yêu Cầu Hệ Thống**
- Flutter SDK ≥ 3.0.0
- Dart SDK ≥ 2.19.0
- Android Studio hoặc VS Code
- Git

### **Bước 1: Clone Dự Án**
```bash
git clone https://github.com/Kiet1122/exercise_week_5.git
cd ex5
```

### **Bước 2: Cài Đặt Dependencies**
```bash
flutter pub get
```

### **Bước 3: Chạy Ứng Dụng**
```bash
# Android
flutter run
```

---

## 📱 **Hướng Dẫn Sử Dụng**

### **1. Tạo Ghi Chú Mới**
1. Nhấn nút **+** (màu xanh) ở góc dưới phải
2. Nhập tiêu đề vào ô "Tiêu đề"
3. Nhập nội dung vào ô "Nhập nội dung"
4. Nhấn **"Lưu"** để lưu ghi chú

### **2. Xem Danh Sách Ghi Chú**
- Tất cả ghi chú được hiển thị theo thứ tự **mới nhất lên đầu**
- Mỗi ghi chú hiển thị:
  - Tiêu đề 
  - Nội dung 
  - Thời gian cập nhật gần nhất

### **3. Chỉnh Sửa Ghi Chú**
1. Nhấn vào bất kỳ ghi chú nào trong danh sách
2. Sửa tiêu đề hoặc nội dung
3. Nhấn **"Lưu"** để cập nhật thay đổi

### **4. Xóa Ghi Chú**
1. Nhấn biểu tượng **🗑️** (màu đỏ) trên ghi chú
2. Xác nhận **"Xóa"** trong hộp thoại
3. Ghi chú sẽ bị xóa vĩnh viễn

---

## 💾 **Cấu Trúc Dữ Liệu**

### **Model Note**
```dart
class Note {
  final int? id;            // ID tự động tăng
  final String title;       // Tiêu đề ghi chú
  final String content;     // Nội dung ghi chú
  final DateTime createdAt; // Thời gian tạo
  final DateTime updatedAt; // Thời gian cập nhật
}
```

### **Database Schema**
```sql
CREATE TABLE notes (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  content TEXT NOT NULL,
  createdAt TEXT NOT NULL,
  updatedAt TEXT NOT NULL
)
```

---

## 🔄 **Luồng Dữ Liệu**

```
Người dùng tương tác → Provider → DatabaseHelper → SQLite
       ↑                        ↓
Giao diện cập nhật ← notifyListeners() ← Dữ liệu trả về
```

### **Quy Trình CRUD**
1. **Create**: `NoteProvider.addNote()` → `DatabaseHelper.create()`
2. **Read**: `NoteProvider.loadNotes()` → `DatabaseHelper.readALL()`
3. **Update**: `NoteProvider.updateNote()` → `DatabaseHelper.update()`
4. **Delete**: `NoteProvider.deleteNote()` → `DatabaseHelper.delete()`

---

## 🎨 **Giao Diện Người Dùng**

### **Màn Hình Chính (HomePage)**
- AppBar: "Ghi chú" với màu chủ đạo
- Body: Danh sách ghi chú dạng ListView
- FloatingActionButton: Nút thêm ghi chú mới
- Empty State: Hiển thị khi chưa có ghi chú

### **Màn Hình Chỉnh Sửa (NoteEditorScreen)**
- 2 chế độ: Thêm mới / Sửa ghi chú
- Tiêu đề thay đổi theo chế độ
- 2 TextField: Tiêu đề và nội dung
- Nút "Lưu" trên AppBar

### **Widget NoteCard**
- Card hiển thị thông tin ghi chú
- Tiêu đề lớn, nội dung thu gọn
- Hiển thị thời gian cập nhật
- Nút xóa màu đỏ

---

## ⚙️ **Cấu Hình & Tùy Chỉnh**

### **Thay Đổi Màu Sắc Chủ Đạo**
Trong `main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
```
Thay `Colors.blue` bằng màu bạn thích:
- `Colors.green` - Màu xanh lá
- `Colors.purple` - Màu tím
- `Colors.orange` - Màu cam

### **Thay Đổi Sắp Xếp**
Trong `db_helper.dart`:
```dart
orderBy: 'updatedAt DESC'  // Mới nhất lên đầu
```
Có thể thay đổi thành:
- `'createdAt DESC'` - Theo thời gian tạo
- `'title ASC'` - Theo bảng chữ cái

---

## 🐛 **Xử Lý Lỗi Thường Gặp**

### **1. Lỗi Database Không Khởi Tạo**
```
"Bad state: databaseFactory not initialized"
```
**Giải pháp:**
```bash
flutter clean
flutter pub get
flutter run
```

### **2. Lỗi "Nhập tiêu đề trước nha"**
- Đảm bảo nhập tiêu đề trước khi lưu
- Tiêu đề không được để trống

### **3. Ứng Dụng Chạy Chậm**
- Kiểm tra số lượng ghi chú quá lớn
- Xóa các ghi chú không cần thiết
- Sử dụng pagination nếu cần

---

## 📊 **Hiệu Suất & Tối Ưu**

### **Tối Ưu Database**
- Chỉ query khi cần thiết
- Sử dụng chỉ mục cho cột thường dùng
- Đóng database khi không sử dụng

### **Tối Ưu Giao Diện**
- Sử dụng `ListView.builder` cho danh sách lớn
- Giới hạn số dòng hiển thị nội dung
- Sử dụng `const` cho widget tĩnh

---

## 🔮 **Tính Năng Tương Lai**

### **Trong Kế Hoạch**
- [ ] Tìm kiếm ghi chú
- [ ] Phân loại theo danh mục
- [ ] Đánh dấu sao (favorite)
- [ ] Backup/Restore dữ liệu
- [ ] Dark mode
- [ ] Đồng bộ đám mây

### **Đề Xuất Cải Thiện**
- Thêm tính năng chia sẻ ghi chú
- Hỗ trợ định dạng văn bản (in đậm, nghiêng)
- Thêm ảnh vào ghi chú
- Nhắc nhở thông báo

---

## 📸 **Hình Ảnh Demo**

| Màn Hình Chính | Thêm Ghi Chú Mới |
|----------------|------------------|
| ![Home Screen](https://res.cloudinary.com/dmnkakpnb/image/upload/v1764779914/ex5-1_yvcoyj.png) | ![Add Note](https://res.cloudinary.com/dmnkakpnb/image/upload/v1764779913/ex5-2_lbomq5.png) |

| Danh sách ghi chú | Xác Nhận Xóa |
|-------------------|---------------|
| ![Edit Note](https://res.cloudinary.com/dmnkakpnb/image/upload/v1764779914/ex5-3_ozoba6.png) | ![Delete Confirm](https://res.cloudinary.com/dmnkakpnb/image/upload/v1764779914/ex5-4_jl9unw.png) |

# **🎬 Video Demo**

[**👉 Xem Video Demo tại đây 👈**](https://res.cloudinary.com/dmnkakpnb/video/upload/v1765205917/123_h7soex.mp4)

