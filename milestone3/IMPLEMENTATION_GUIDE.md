# Milestone 3: Hướng dẫn hiện thực & kiến trúc (Advance Features)

## Phạm vi

- Frontend Flutter (theo kiến trúc `data` / `domain` / `presentation`)
- Tính năng: AI BOT, Knowledge Base, Custom AI Agent, Subscription + Ads, Image Q&A, AI Email, Enhancements
- Nhánh: `advance-feature` (toàn bộ thay đổi trong M3)
- Deadline: 04/01/2026

---

## Kiến trúc & Tổ chức mã nguồn

Giữ nguyên pattern từ M2, mở rộng thêm các module mới:

```
lib/
├── data/
│   ├── datasources/
│   │   ├── remote/
│   │   │   ├── bot_remote_data_source.dart
│   │   │   ├── knowledge_remote_data_source.dart
│   │   │   ├── agent_remote_data_source.dart   (gọi n8n/Vertex gateway)
│   │   │   ├── monetization_remote_data_source.dart (usage/token)
│   │   │   └── email_remote_data_source.dart
│   │   └── local/
│   │       ├── knowledge_local_data_source.dart (cache nhẹ, optional)
│   │       └── monetization_local_data_source.dart (trạng thái PRO)
│   │
│   ├── models/
│   │   ├── assistant_model.dart
│   │   ├── knowledge_model.dart
│   │   ├── agent_message_model.dart
│   │   ├── subscription_usage_model.dart
│   │   └── email_draft_model.dart
│   │
│   └── repositories/
│       ├── bot_repository_impl.dart
│       ├── knowledge_repository_impl.dart
│       ├── agent_repository_impl.dart
│       ├── monetization_repository_impl.dart
│       └── email_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── assistant_entity.dart
│   │   ├── knowledge_entity.dart
│   │   ├── agent_entity.dart
│   │   ├── subscription_entity.dart
│   │   └── email_entity.dart
│   │
│   ├── repositories/
│   │   ├── bot_repository.dart
│   │   ├── knowledge_repository.dart
│   │   ├── agent_repository.dart
│   │   ├── monetization_repository.dart
│   │   └── email_repository.dart
│   │
│   └── usecases/
│       ├── bot/
│       ├── knowledge/
│       ├── agent/
│       ├── monetization/
│       └── email/
│
└── presentation/
    ├── viewmodels/
    │   ├── bot_view_model.dart
    │   ├── knowledge_view_model.dart
    │   ├── agent_view_model.dart
    │   ├── monetization_view_model.dart
    │   └── email_view_model.dart
    │
    └── views/
        ├── bot/
        ├── knowledge/
        ├── agent/
        ├── monetization/
        ├── images/   (Image Q&A)
        └── email/
```

- Tất cả call HTTP vẫn đi qua `presentation/services/api_service.dart` (Dio + interceptors) từ M2.
- Token/refresh giữ nguyên logic M2; thêm endpoints mới theo module.

---

## API endpoints trọng tâm (đã tham chiếu Apidog)

Lưu ý base: `https://knowledge-api.jarvis.cx/kb-core/v1`

- Assistant (Bot)

  - POST `/ai-assistant` — Tạo bot (body: assistantName, instructions, description)
  - GET `/ai-assistant` — Danh sách + filter (q, order, order_field, offset, limit, is_favorite, is_published)
  - PATCH `/ai-assistant/{assistantId}` — Cập nhật
  - DELETE `/ai-assistant/{assistantId}` — Xóa
  - POST `/ai-assistant/{assistantId}/knowledge` — Import Knowledge vào bot
  - DELETE `/ai-assistant/{assistantId}/knowledge/{knowledgeId}` — Remove Knowledge khỏi bot
  - POST `/ai-assistant/{assistantId}/threads` — (nếu dùng thread APIs) tạo thread/ask
  - POST `/ai-assistant/{assistantId}/ask` — Hỏi nhanh bot (tuỳ API cụ thể)

- Knowledge

  - POST `/knowledge` — Tạo knowledge (metadata)
  - GET `/knowledge` — Danh sách, filter
  - DELETE `/knowledge/{id}` — Xóa
  - POST `/knowledge/upload/file` — Upload file cục bộ
  - POST `/knowledge/upload/website` — Upload từ URL website

- Monetization / Usage / Token

  - Web Pricing: `https://dev.jarvis.cx/pricing` (test: 4242 4242 4242 4242)
  - Sau thanh toán: gọi `GET /usage` + `GET /token` (endpoint trong Apidog Jarvis) để cập nhật trạng thái PRO và token limit

- AI Email

  - POST `.../suggest-reply-ideas` — Gợi ý trả lời nhanh
  - POST `.../response-email` — Sinh nội dung email trả lời

- Image Q&A
  - Tùy API backend cung cấp (multipart/form-data cho ảnh + prompt). FE chuẩn bị form upload (ảnh + text)

Tham chiếu Apidog (đã đối chiếu một phần trong Plan): Create/Get/Update/Delete Assistant, Import Knowledge, Create/Get/Delete Knowledge, Upload File/Website, Chat with Bot, Reply Ideas, Response Email.

---

## Gợi ý hiện thực theo từng module

### 1) AI BOT Management

- DataSource: `bot_remote_data_source.dart` map 1-1 với endpoints Assistant
- Repository: `bot_repository_impl.dart` trả Domain Entities (Assistant)
- ViewModel/UI:
  - Danh sách bots + filter + search
  - Form tạo/sửa: assistantName, instructions, description
  - Gắn/Xóa Knowledge: picker danh sách knowledge -> call import/remove
  - Chat với Bot: dùng luồng Chat hiện có, thêm "select Bot" và chuyển route phù hợp
- Test: mock DataSource -> Repository -> ViewModel; widget test cho form + list

### 2) Knowledge Base

- DataSource: `knowledge_remote_data_source.dart`
- Repository/UI:
  - List Knowledge (phân trang nhẹ); tạo/xóa
  - Upload: file/website -> theo dõi progress, lỗi, kết quả
- Test: happy/error paths cho upload, create/delete

### 3) Custom AI Agent (Vertex AI/n8n)

- Triển khai 3 workflow tối thiểu (ví dụ: chuẩn hóa yêu cầu khách hàng, tạo tóm tắt, trích xuất key points)
- Lớp gateway FE: `agent_remote_data_source.dart` gọi endpoint n8n webhook/Vertex API (qua backend gateway nếu cần CORS/token)
- UI Chat: menu chọn Agent; khi gửi message nếu Agent được chọn -> gọi Agent endpoint -> render trả lời như bot
- Tài liệu: kèm sơ đồ, input/output, và URL test cho mỗi workflow

### 4) Monetization (Subscription + Ads)

- Subscription Flow (đơn giản, không IAP):
  - Mở `https://dev.jarvis.cx/pricing` trong WebView/CustomTab
  - Sau khi user thanh toán: FE gọi `GET /usage` + `GET /token` để xác định trạng thái PRO và cập nhật UI (token unlimited)
  - Lưu cờ `isPro` trong `monetization_local_data_source` (SharedPreferences)
- Ads:
  - Khuyến nghị: `google_mobile_ads`
  - Triển khai banner (tối thiểu) ở màn phù hợp; tắt ads khi `isPro == true`
  - Chú ý App Store/Play Policy, test id trong debug

### 5) Image Q&A

- UI: màn chọn/chụp ảnh, nhập prompt phụ (optional), gửi
- Networking: multipart upload ảnh + text
- Hiển thị: thumbnail ảnh + message AI
- Lỗi: dung lượng lớn, mất kết nối -> hiển thị rõ ràng, cho retry

### 6) AI Email

- Tab Email riêng với 2 hành động chính:
  - "Gợi ý trả lời" (Suggest Reply Ideas): trả về danh sách ý tưởng
  - "Sinh email trả lời" (Response Email): trả về nội dung mail hoàn chỉnh
- UX: các nút nhanh (Thanks, Sorry, Yes, No, Follow Up, Request Info), copy to clipboard, hoặc mở composer ngoài

### 7) Enhancements

- Gợi ý: Firebase Analytics/Sentry/Crashlytics, CI/CD (GitHub Actions), publish web
- Tối ưu: caching nhẹ cho danh sách, debounce search, skeleton loading

---

## State management & Error handling

- Tiếp tục dùng ViewModel (ChangeNotifier/Provider)
- Quy ước trạng thái: idle/loading/success/error
- Chuẩn hóa lỗi: map HTTP -> thông điệp người dùng + log ở debug
- Retry/backoff cho request an toàn (GET)

---

## Testing

- Unit test cho Repository + ViewModel
- Widget test cho màn hình trọng yếu (Bot list/form, Knowledge list/upload, Email tab)
- Kiểm thử thủ công Subscription/Ads trên iOS/Android simulator (ads dùng test ids)

---

## Gợi ý package

- HTTP: Dio (đã dùng ở M2)
- Secure: flutter_secure_storage (giữ token)
- Ads: google_mobile_ads
- Image: image_picker, dio (multipart)
- WebView/Browser: url_launcher / webview_flutter (tùy UX)

---

## Checklist chất lượng (DoD)

- Theo kiến trúc clean, không gọi API trực tiếp từ UI
- Loading/Error/Empty states rõ ràng; có retry nếu hợp lý
- Không lộ token/log nhạy cảm ở release
- `dart format`, `flutter analyze` PASS; chạy iOS/Android OK
- Tài liệu cập nhật (README/usage)
