# Milestone 3 — Advanced Features & Monetization (Frontend)

Status: Planned  
Scope: Frontend (Flutter). Tập trung vào các tính năng nâng cao còn lại, tích hợp APIs Jarvis/KB.

Labels to use: `milestone:3`, `frontend`, `flutter`, `bot`, `knowledge`, `agent`, `monetization`, `ads`, `email`, `images`

Docs: Xem `milestone3/PLAN_MILESTONE_3.md` và `milestone3/IMPLEMENTATION_GUIDE.md`.
Branch: `advance-feature` (toàn bộ issues M3 code trên nhánh này)
Deadline: 04/01/2026

---

## Master Issue — Milestone 3 Delivery

Theo dõi tiến độ tất cả issues con. Chỉ tick khi issue con đã đóng (closed).

### AI BOT Management

- [ ] [BOT-001] Build AI Bot CRUD (Frontend)
- [ ] [BOT-002] Attach/Remove Knowledge to Bot (Frontend)
- [ ] [BOT-003] Chat with Bot (Frontend)

### Knowledge Base

- [ ] [KB-001] Create/List/Delete Knowledge (Frontend)
- [ ] [KB-002] Upload Knowledge from File/Website (Frontend)

### Custom AI Agent

- [ ] [AGENT-001] Define Agent Workflows (3+) (Docs + Config)
- [ ] [AGENT-002] Integrate Agent into Chat (Frontend)

### Monetization

- [ ] [MON-001] Subscription Upgrade Flow (Frontend)
- [ ] [ADS-001] Integrate Ads (Google Mobile Ads) (Frontend)

### Image Q&A

- [ ] [IMG-001] Image Q&A (Upload/Capture) (Frontend)

### AI Email

- [ ] [EMAIL-001] AI Email Drafting (Frontend)

### Enhancements

- [ ] [ADV-001] Enhancements (Analytics/Crashlytics/CI-CD/Store)

---

## Cách sử dụng file này

- Tạo từng GitHub issue tương ứng bên dưới (copy đầy đủ template).
- Thêm labels: `milestone:3`, `frontend`, `flutter`, và nhãn module (`bot`, `knowledge`, ...).
- Link các issue đã tạo vào Master Issue bằng "Linked issues".

---

## ISSUE TEMPLATES (Frontend)

Lưu ý: Title bằng tiếng Anh theo yêu cầu. Nội dung mô tả/bước làm bằng tiếng Việt.

---

### [BOT-001] Build AI Bot CRUD (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `bot`, `api`

Mô tả:
Xây dựng hạ tầng FE cho CRUD AI Assistant (Bot): tạo, liệt kê, cập nhật, xóa; kèm filter/search.

APIs tham khảo:

- POST /kb-core/v1/ai-assistant
- GET /kb-core/v1/ai-assistant (q, order, order_field, offset, limit, is_favorite, is_published)
- PATCH /kb-core/v1/ai-assistant/{assistantId}
- DELETE /kb-core/v1/ai-assistant/{assistantId}

Nhiệm vụ:

- [ ] Tạo `bot_remote_data_source.dart` và `bot_repository_impl.dart`
- [ ] Map DTO -> domain entities, handle lỗi chuẩn
- [ ] UI danh sách bots: phân trang cơ bản, filter, search
- [ ] UI tạo/sửa bot (assistantName, instructions, description)
- [ ] Tests (data source, repository, viewmodel cơ bản)

Tiêu chí nghiệm thu:

- [ ] Tạo/sửa/xóa hoạt động; danh sách hiển thị đúng, filter hoạt động
- [ ] `flutter analyze` PASS, `dart format` áp dụng

Files gợi ý:

- `lib/data/datasources/remote/bot_remote_data_source.dart`
- `lib/data/repositories/bot_repository_impl.dart`
- `lib/domain/repositories/bot_repository.dart`
- `lib/presentation/viewmodels/bot_view_model.dart`
- `lib/presentation/views/bot/`

---

### [BOT-002] Attach/Remove Knowledge to Bot (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `bot`, `knowledge`, `api`

Mô tả:
Cho phép gắn/xóa Knowledge vào AI Assistant; hiển thị danh sách knowledge đã gắn.

APIs tham khảo:

- POST /kb-core/v1/ai-assistant/{assistantId}/knowledge
- DELETE /kb-core/v1/ai-assistant/{assistantId}/knowledge/{knowledgeId}
- GET /kb-core/v1/knowledge (chọn nguồn để attach)

Nhiệm vụ:

- [ ] UI chọn knowledge từ danh sách để attach vào bot
- [ ] Gọi API attach/remove, đồng bộ lại danh sách knowledge của bot
- [ ] Xử lý lỗi và hiển thị thông báo rõ ràng

Tiêu chí nghiệm thu:

- [ ] Attach/Remove thành công; UI cập nhật tức thời

Files gợi ý:

- `lib/presentation/views/bot/bot_detail_page.dart`
- `lib/presentation/viewmodels/bot_view_model.dart`

---

### [BOT-003] Chat with Bot (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `bot`, `chat`

Mô tả:
Tích hợp chat với Bot đã tạo (Ask Assistant/Chat With Bot), hỗ trợ tạo thread mới, mở lịch sử thread.

APIs tham khảo:

- Ask Assistant / Chat with Bot (tham chiếu Apidog: ask-assistant, chat-with-bot)
- Threads & messages (nếu sử dụng luồng thread)

Nhiệm vụ:

- [ ] Cho phép chọn Bot hiện tại trong UI Chat
- [ ] Gọi endpoint gửi/nhận message; tạo thread mới khi cần
- [ ] Hiển thị lịch sử (nếu có) và trạng thái loading/error

Tiêu chí nghiệm thu:

- [ ] Người dùng có thể chat với bot, tạo thread mới, mở lại lịch sử thread

Files gợi ý:

- `lib/presentation/views/chat/`
- `lib/presentation/viewmodels/chat_view_model.dart`

---

### [KB-001] Create/List/Delete Knowledge (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `knowledge`, `api`

Mô tả:
Xây dựng CRUD cơ bản cho Knowledge: tạo metadata, liệt kê, xóa; filter/tìm kiếm.

APIs tham khảo:

- POST /kb-core/v1/knowledge
- GET /kb-core/v1/knowledge
- DELETE /kb-core/v1/knowledge/{id}

Nhiệm vụ:

- [ ] `knowledge_remote_data_source.dart`, `knowledge_repository_impl.dart`
- [ ] UI danh sách knowledge + filter/search
- [ ] Xóa knowledge với dialog xác nhận

Tiêu chí nghiệm thu:

- [ ] Tạo và xóa hoạt động; danh sách hiển thị đúng

---

### [KB-002] Upload Knowledge from File/Website (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `knowledge`, `upload`

Mô tả:
Hỗ trợ nạp dữ liệu vào Knowledge từ file cục bộ hoặc URL website.

APIs tham khảo:

- POST /kb-core/v1/knowledge/upload/file
- POST /kb-core/v1/knowledge/upload/website

Nhiệm vụ:

- [ ] UI upload file (hiển thị progress); UI nhập URL website
- [ ] Gọi API upload tương ứng; hiển thị thành công/thất bại
- [ ] Đồng bộ danh sách knowledge sau khi upload

Tiêu chí nghiệm thu:

- [ ] Upload hoạt động, dữ liệu xuất hiện trong knowledge; lỗi được hiển thị rõ

---

### [AGENT-001] Define Agent Workflows (3+) (Docs + Config)

Labels: `milestone:3`, `agent`, `docs`

Mô tả:
Thiết kế tối thiểu 3 workflow (Vertex AI/n8n). Viết tài liệu workflow (sơ đồ, input/output, steps) và cung cấp endpoint gateway để FE tích hợp.

Nhiệm vụ:

- [ ] Viết tài liệu chi tiết 3 workflow (kèm hình/sơ đồ nếu có)
- [ ] Cấu hình webhook/service gateway để gọi từ FE (dev/staging)
- [ ] Demo test URLs

Tiêu chí nghiệm thu:

- [ ] Tài liệu hoàn chỉnh, có endpoint chạy được cho mỗi workflow

---

### [AGENT-002] Integrate Agent into Chat (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `agent`, `chat`

Mô tả:
Cho phép chọn 1 Agent trong UI Chat; gửi message đến Agent endpoint và hiển thị câu trả lời như bot.

Nhiệm vụ:

- [ ] UI chọn Agent trong Chat
- [ ] Gọi Agent endpoint khi gửi message (nếu agent được chọn)
- [ ] Render kết quả, xử lý loading/error

Tiêu chí nghiệm thu:

- [ ] Tương tác với Agent thành công, phản hồi hiển thị đúng

---

### [MON-001] Subscription Upgrade Flow (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `monetization`

Mô tả:
Xây dựng luồng nâng cấp PRO thông qua trang Pricing (WebView/Custom Tabs). Sau thanh toán, xác thực trạng thái PRO qua APIs Usage/Token để cập nhật UI.

Refs:

- Pricing: https://dev.jarvis.cx/pricing (test card 4242 4242 4242 4242)
- Get Usage / Get Token (Jarvis APIs trong Apidog)

Nhiệm vụ:

- [ ] Mở Pricing trong WebView/Custom Tabs
- [ ] Sau khi hoàn tất, gọi `GET /usage` + `GET /token` để xác thực PRO
- [ ] Lưu cờ `isPro`; cập nhật UI (ẩn ads, token unlimited)

Tiêu chí nghiệm thu:

- [ ] Luồng nâng cấp hoàn chỉnh, hiển thị trạng thái PRO chính xác

---

### [ADS-001] Integrate Ads (Google Mobile Ads) (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `ads`

Mô tả:
Tích hợp quảng cáo (ưu tiên banner). Ẩn quảng cáo khi tài khoản PRO.

Nhiệm vụ:

- [ ] Cấu hình `google_mobile_ads` với test ids
- [ ] Render banner ads ở màn hợp lý; xử lý lifecycle
- [ ] Ẩn ads nếu `isPro == true`

Tiêu chí nghiệm thu:

- [ ] Ads hiển thị ổn định, không che nội dung; PRO không thấy ads

---

### [IMG-001] Image Q&A (Upload/Capture) (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `images`, `chat`

Mô tả:
Cho phép upload/chụp ảnh và đặt câu hỏi dựa trên ảnh. Gửi ảnh (multipart) + prompt đến API; hiển thị câu trả lời.

Nhiệm vụ:

- [ ] Tích hợp `image_picker` và upload multipart qua Dio
- [ ] UI xem trước ảnh, nhập prompt tùy chọn
- [ ] Xử lý progress, lỗi; hiển thị kết quả trả lời

Tiêu chí nghiệm thu:

- [ ] Ảnh được gửi và trả lời hiển thị rõ ràng; UX mượt

---

### [EMAIL-001] AI Email Drafting (Frontend)

Labels: `milestone:3`, `frontend`, `flutter`, `email`

Mô tả:
Tạo tab Email với hành động nhanh: gợi ý trả lời (Reply Ideas) và sinh email trả lời (Response Email). Có các quick actions (Thanks, Sorry, Yes, No, Follow Up…).

APIs tham khảo:

- POST suggest-reply-ideas
- POST response-email

Nhiệm vụ:

- [ ] UI tab Email với 2 chức năng chính
- [ ] Gọi APIs và hiển thị kết quả; nút copy/share/composer
- [ ] Xử lý lỗi/empty/loading

Tiêu chí nghiệm thu:

- [ ] Gợi ý và soạn email hoạt động, có thể copy/send

---

### [ADV-001] Enhancements (Analytics/Crashlytics/CI-CD/Store)

Labels: `milestone:3`, `enhancement`, `analytics`, `ci-cd`

Mô tả:
Bổ sung các tính năng nâng cao để tăng chất lượng sản phẩm: analytics, crash reporting, CI/CD, hoặc publish thử (web/app).

Nhiệm vụ:

- [ ] Tích hợp tối thiểu 1-2 công cụ (Firebase Analytics, Sentry, Crashlytics…)
- [ ] Thiết lập CI/CD đơn giản (GitHub Actions)
- [ ] Ghi chú tài liệu cấu hình

Tiêu chí nghiệm thu:

- [ ] Có số liệu hoặc pipeline chạy thành công; tài liệu rõ ràng

---

## Definition of Done (áp dụng cho mỗi issue)

- [ ] Theo kiến trúc `data`/`domain`/`presentation`
- [ ] Có unit tests (tối thiểu cho business logic mới) + widget tests cho màn chính
- [ ] Không phá vỡ UI/luồng sẵn có nếu không yêu cầu
- [ ] Tài liệu/README cập nhật nếu có cấu hình mới
- [ ] `dart format` áp dụng; `flutter analyze` PASS
- [ ] Verified trên iOS và Android simulator/emulator

---

## Ghi chú

- Tái sử dụng `api_service.dart`, interceptors, token storage từ M2.
- Không lưu token vào SharedPreferences (dùng secure storage).
- Điều hướng qua `presentation/routes/` và `presentation/services/navigation_service.dart`.
