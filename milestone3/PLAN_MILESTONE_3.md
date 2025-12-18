# Milestone 3: Hoàn thiện tính năng nâng cao (Advance Features)

Trạng thái: Planned
Thời hạn (Deadline): 04/01/2026
Nhánh làm việc: advance-feature (toàn bộ code Milestone 3 đẩy lên nhánh này)
Phạm vi: Frontend (Flutter) — tích hợp với APIs đã có (Jarvis/KB)

---

## Tổng quan

Milestone 3 tập trung hoàn thiện các nhóm tính năng nâng cao còn lại sau Milestone 2:

1. Tạo và quản lý AI BOT (CRUD, import knowledge, chat với bot)
2. Tạo và quản lý bộ dữ liệu tri thức (Knowledge Base)
3. Custom AI Agent (ít nhất 3 workflow với Vertex AI/n8n) và tích hợp vào AI Chat
4. Monetization: Subscription (nâng cấp PRO) + Ads
5. Hỏi đáp trên ảnh (Upload/Chụp ảnh và chat)
6. Soạn email với AI (thao tác nhanh, reply ideas)
7. Các chức năng nâng cao (tối ưu, phân tích, CI/CD…)

Lưu ý: Các API tham chiếu từ Apidog/Jarvis. Một số endpoint quan trọng đã được trích xuất:

- AI Assistant (Bot):
  - POST/GET/PATCH/DELETE https://knowledge-api.jarvis.cx/kb-core/v1/ai-assistant
  - Import Knowledge To Assistant: POST /kb-core/v1/ai-assistant/{assistantId}/knowledge
- Knowledge:
  - POST /kb-core/v1/knowledge (tạo)
  - GET /kb-core/v1/knowledge (liệt kê/tìm kiếm)
  - DELETE /kb-core/v1/knowledge/{id}
  - Upload file: POST /kb-core/v1/knowledge/upload/file
  - Upload website: POST /kb-core/v1/knowledge/upload/website
- Chat with Bot: tham chiếu "Chat With Bot" (Jarvis Chat Widget / Ask Assistant)
- AI Email: "Suggest Reply Ideas", "Response Email"
- Subscription/Token/Usage: Pricing page + endpoint usage/token để cập nhật trạng thái PRO

Tham chiếu nguồn API (đã đối chiếu):

- Create Assistant: share.apidog.com/.../create-assistant-11271664e0
- Get Assistants: share.apidog.com/.../get-assistants-11271665e0
- Update Assistant: share.apidog.com/.../update-assistant-11271666e0
- Delete Assistant: share.apidog.com/.../delete-assistant-11271667e0
- Import Knowledge To Assistant: share.apidog.com/.../import-knowledge-to-assistant-11271669e0
- Create Knowledge: share.apidog.com/.../create-knowledge-11271685e0
- Get Knowledges: share.apidog.com/.../get-knowledges-11271686e0
- Delete Knowledge: share.apidog.com/.../delete-knowledge-11271690e0
- Upload a Local File: share.apidog.com/.../upload-a-local-file-11271694e0
- Upload Website: share.apidog.com/.../upload-website-to-knowledge-11271704e0
- Chat with Bot: share.apidog.com/.../chat-with-bot-15052587e0
- Reply Ideas: share.apidog.com/.../suggest-reply-ideas-11490529e0
- Response Email: share.apidog.com/.../response-email-11490528e0
- Pricing: https://dev.jarvis.cx/pricing (thẻ test 4242)

---

## Nhóm tính năng & Issues đề xuất

### Nhóm 1: AI BOT Management

Mô tả: CRUD bot, cập nhật prompt/instructions, gắn/xóa knowledge, tìm kiếm/lọc bot, chat với bot đã tạo.

- [ ] [BOT-001] Build AI Bot CRUD (Frontend)

  - Nhiệm vụ:
    - DataSource/Repository gọi các API Create/Get/Update/Delete Assistant
    - UI danh sách BOT + tạo/sửa/xóa + tìm kiếm/lọc (is_favorite, is_published, order, limit)
    - Form chỉnh sửa instructions/description
  - Tiêu chí nghiệm thu:
    - Tạo/sửa/xóa xem được kết quả, danh sách hiển thị đúng, filter hoạt động

- [ ] [BOT-002] Attach/Remove Knowledge to Bot (Frontend)

  - Nhiệm vụ:
    - Tích hợp API Import/Remove Knowledge vào Assistant
    - UI chọn knowledge gắn vào BOT, hiển thị danh sách knowledge của BOT
  - Tiêu chí nghiệm thu:
    - Gắn/xóa knowledge thành công, danh sách cập nhật tức thời

- [ ] [BOT-003] Chat with Bot (Frontend)
  - Nhiệm vụ:
    - Tích hợp endpoint Ask Assistant/Chat with Bot
    - Cho phép tạo thread mới, mở lịch sử thread, replay
  - Tiêu chí nghiệm thu:
    - Gửi/nhận tin nhắn ổn định, tạo thread mới, mở lịch sử thread OK

### Nhóm 2: Knowledge Base

Mô tả: Tạo/lấy/xóa Knowledge, nạp dữ liệu từ file/URL; quản lý trạng thái/nguồn.

- [ ] [KB-001] Create/List/Delete Knowledge (Frontend)

  - Nhiệm vụ:
    - DataSource/Repository cho create/list/delete Knowledge
    - UI danh sách knowledge, filter, trạng thái enable/disable nếu có
  - Tiêu chí nghiệm thu:
    - Tạo và xóa knowledge hoạt động, danh sách và tìm kiếm hiển thị đúng

- [ ] [KB-002] Upload Knowledge (File/Website) (Frontend)
  - Nhiệm vụ:
    - Tích hợp upload file cục bộ và upload website vào Knowledge
    - Hiển thị progress, lỗi, và kết quả parse
  - Tiêu chí nghiệm thu:
    - Upload hoạt động, backend nhận và index, dữ liệu xuất hiện trong knowledge

### Nhóm 3: Custom AI Agent (Vertex AI/n8n)

Mô tả: Thiết kế tối thiểu 3 workflow cho 1 business domain bất kỳ. Tích hợp agent vào Chat.

- [ ] [AGENT-001] Define Agent Workflows (3+) (Docs + Config)

  - Nhiệm vụ:
    - Mô tả 3 workflow trong tài liệu (sơ đồ, input/output, step)
    - Cấu hình endpoint gateway (n8n webhook hoặc service middle-layer) để FE gọi
  - Tiêu chí nghiệm thu:
    - Tài liệu workflow hoàn chỉnh, có demo endpoint để FE tích hợp

- [ ] [AGENT-002] Integrate Agent into Chat (Frontend)
  - Nhiệm vụ:
    - UI chọn Agent trong Chat và gửi message tới Agent endpoint
    - Hiển thị kết quả trả về như tin nhắn bot
  - Tiêu chí nghiệm thu:
    - Chọn Agent và tương tác thành công, kết quả phản hồi hiển thị đúng

### Nhóm 4: Monetization (Subscription + Ads)

Mô tả: Nâng cấp PRO qua trang Pricing (WebView/Deep link/Callback), hiển thị trạng thái Pro và gắn quảng cáo.

- [ ] [MON-001] Subscription Upgrade Flow (Frontend)

  - Nhiệm vụ:
    - Mở trang Pricing trong WebView/CustomTab
    - Sau thanh toán, gọi APIs Usage/Token để xác nhận PRO và cập nhật token limit (unlimited)
  - Tiêu chí nghiệm thu:
    - Luồng nâng cấp hoàn chỉnh, trạng thái PRO phản ánh trong UI

- [ ] [ADS-001] Integrate Ads (Google Mobile Ads) (Frontend)
  - Nhiệm vụ:
    - Tích hợp banner/interstitial/rewarded (tối thiểu 1 loại)
    - Cấu hình test ads; ẩn ads cho tài khoản PRO
  - Tiêu chí nghiệm thu:
    - Ads hiển thị đúng nơi, không gây gián đoạn; PRO không thấy quảng cáo

### Nhóm 5: Hỏi đáp trên ảnh

- [ ] [IMG-001] Image Q&A (Upload/Capture) (Frontend)
  - Nhiệm vụ:
    - Cho phép upload/chụp ảnh và gửi kèm prompt tới API xử lý (theo tài liệu backend)
    - UI hiển thị ảnh và câu trả lời của AI
  - Tiêu chí nghiệm thu:
    - Ảnh được gửi/nhận kết quả; UX mượt, xử lý lỗi tốt

### Nhóm 6: Soạn email với AI

- [ ] [EMAIL-001] AI Email Drafting (Reply Ideas + Generate Response) (Frontend)
  - Nhiệm vụ:
    - Tích hợp APIs Suggest Reply Ideas và Response Email
    - Tab riêng cho Email, action nhanh (Thanks, Sorry, Yes, No, Follow-up…)
  - Tiêu chí nghiệm thu:
    - Gợi ý và sinh email hoạt động, copy/send được ngay trong UI

### Nhóm 7: Các chức năng nâng cao (tùy chọn, cộng điểm)

- [ ] [ADV-001] Enhancements (Analytics/Crashlytics/CI-CD/Store)
  - Nhiệm vụ:
    - Tích hợp ít nhất 1-2 công cụ (ví dụ: Firebase Analytics, Sentry, Crashlytics)
    - Thiết lập quy trình CI/CD cơ bản hoặc publish web/app thử nghiệm
  - Tiêu chí nghiệm thu:
    - Có số liệu thu thập hoặc pipeline chạy thành công

---

## Phân công & Quy trình

- Nhánh riêng: advance-feature
- Quy ước nhãn: `milestone:3`, `frontend`, `flutter`, cộng nhãn theo module: `bot`, `knowledge`, `agent`, `monetization`, `ads`, `email`, `images`
- Quy ước PR: Mỗi issue một PR; review trong 24h; chạy `flutter analyze` + `dart format` trước khi merge

---

## Timeline gợi ý (trước 04/01/2026)

- Tuần 1: BOT Management (BOT-001..003) + KB (KB-001..002)
- Tuần 2: Custom Agent (AGENT-001..002) + Monetization Subscription (MON-001)
- Tuần 3: Ads (ADS-001) + Image Q&A (IMG-001) + Email (EMAIL-001)
- Tuần 4: Buffer & Enhancements (ADV-001), QA, tối ưu hiệu năng, test cuối

---

## Tiêu chuẩn hoàn thành (DoD)

- Tuân thủ kiến trúc data/domain/presentation; không gọi API trực tiếp từ Widget
- UI có trạng thái loading/error/empty rõ ràng; retry nếu cần
- Viết unit tests cho business logic chính và một số widget tests cho màn hình quan trọng
- `dart format` áp dụng; `flutter analyze` PASS; chạy thử trên iOS/Android
- Tài liệu cập nhật (README, usage trong module, hướng dẫn cấu hình)
