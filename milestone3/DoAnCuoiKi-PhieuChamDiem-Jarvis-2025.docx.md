# Đồ án cuối kì

## *Phiếu chấm điểm*

	Sinh viên thực hiện:  \<MSSV\> \- \<Họ tên\>

	Địa chỉ Git: 

## **DANH SÁCH NHÓM**

| MSSV | Họ tên | Tài khoản Github | Công việc đã thực hiện | Đánh giá (tổng 100%) | Điểm đề nghị | Điểm vấn đáp |
| :---- | :---- | :---- | :---- | :---- | :---- | :---- |
| \<MSSV1\> | \<Họ tên sinh viên 1\> |  | \<Danh sách công việc sinh viên 1 đã thực hiện\> |  |  |  |
| \<MSSV2\> | \<Họ tên sinh viên 2\> |  | \<Danh sách công việc sinh viên 2 đã thực hiện\> |  |  |  |

## **BẢNG CHỨC NĂNG(10 điểm)**

Mỗi chức năng không thực hiện tốt sẽ bị trừ tương ứng với số điểm được điền trong cột TĐ.

| Chức năng |  | Điểm |  | Ghi chú |
| :---- | ----- | ----- | :---- | :---- |
|  | **TĐ** | **TĐG** | **GV** |  |
| **1\. Tổng quát** |  |  |  |  |
| Thiết kế UI/UX của ứng dụng | \-5 |  |  | Ứng dụng UI/UX dễ hiểu, đẹp và thân thiện người dùng |
| Kiến trúc của ứng dụng | \-3 |  |  | Cấu trúc code đẹp, phân tách rõ ràng business, components, services, actions, reducers.  |
| Báo cáo | \-1 |  |  |  |
| Phim demo | \-2 |  |  | Link video phasing 1: ….Link video phasing 2: ….Link video phasing 3: ….Link video phasing 4: …. |
| Quá trình thực hiện ứng dụng được đăng lên Git | \-7 |  |  |  |
| **2\. Xác thực và phân quyền** |  |  |  |  |
| Trang chủ | \-0,5 |  |  |  |
| Đăng ký tài khoản | \-0,5 |  |  | [Auth\_Sign\_Up](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/sign-up-email-password-15049211e0)  |
| Kiểm tra các ràng buộc về tên đăng nhập, mật khẩu nhập lại, ... | \-0,5 |  |  |  |
| Đăng nhập hệ thống với tài khoản đã tạo | \-0,5 |  |  | [Auth\_Sign\_In](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/sign-in-email-pass-15049355e0)  |
| Đăng xuất tài khoản | \-0,5 |  |  | [Auth\_Sign\_Out](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/logout-15049407e0)  |
| **3\. AI Chat** |  |  |  |  |
| Hiển thị nội dung chat | \-1 |  |  | [Jarvis\_Get\_Conversations\_History](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-conversation-history-11231191e0)  |
| Chat với AI Chat bot | \-1 |  |  | [Jarvis\_Send\_Message](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/send-message-11231192e0) |
| Giảm số lượng token khi chat | \-0,5 |  |  |  |
| Hỗ trợ thay đổi AI Agent | \-0,5 |  |  |  |
| Tạo thread chat mới | \-0,5 |  |  | [Jarvis\_Send\_Message](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/send-message-11231192e0) (conversation history is empty) |
| Xem danh sách lịch sử thread chat | \-0,5 |  |  | [Jarvis\_Get\_Conversations](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-conversations-11231187e0)  |
| Mở lịch sử chat | \-0,5 |  |  | [Jarvis\_Get\_Conversations\_History](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-conversation-history-11231191e0) |
| **4\. Tạo và quản lý AI BOT** |  |  |  |  |
| Tạo AI BOT | \-0,5 |  |  | [KB\_Create\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/create-assistant-11271664e0)  |
| Hiển thị/tìm kiếm AI BOT | \-0,5 |  |  | [KB\_Get\_Bots](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-assistants-11271665e0)  |
| Cập nhật và xoá AI BOT | \-0,5 |  |  | [KB\_Update\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/update-assistant-11271666e0) \+  [KB\_Delete\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/delete-assistant-11271667e0)  |
| Cập nhật prompt cho AI BOT | \-0,5 |  |  | [KB\_Update\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/update-assistant-11271666e0) (update instructions) |
| Giao tiếp với AI BOT đã tạo qua Chat widget | \-0,5 |  |  | [Jarvis\_Chat\_With\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/chat-with-bot-15052587e0)  |
| Thêm/xóa dữ liệu tri thức vào AI BOT | \-0,5 |  |  | [KB\_Import\_Knowledge\_To\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/import-knowledge-to-assistant-11271669e0)  |
| Preview và chat với AI BOT | \-0,5 |  |  | [KB\_Ask\_Bot](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/ask-assistant-11271674e0)  (chat with openAiThreadIdPlay) |
| Publish AI Chat ra Slack, Telegram, Messenger | \-0,5 |  |  | [KB\_Publish](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-configurations-11271705e0)  [https://jarvis.cx/help/knowledge-base/publish-bot/](https://jarvis.cx/help/knowledge-base/publish-bot/)  |
| **5\. Tạo AI Agent với Vertex AI/n8n phục vụ 1 business domain bất kì** |  |  |  |  |
| Tạo AI Agent ít nhất 3 workflow | \-2 |  |  |  |
| Tích hợp AI Agent vào 1 AI Chat trong hệ thống | \-1 |  |  |  |
| **6\. Tạo bộ dữ liệu tri thức** |  |  |  |  |
| Thêm bộ dữ liệu tri thức | \-0,5 |  |  | [KB\_Create\_Knowledge](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/create-knowledge-11271685e0)  |
| Hiển thị/tìm kiếm bộ dữ liệu tri thức | \-0,5 |  |  | [KB\_Get\_Knowledges](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-knowledges-11271686e0)  |
| Disable/delete nguồn dữ liệu | \-0,5 |  |  | [KB\_Delete\_Knowledge](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/delete-knowledge-11271690e0)  |
| Nạp dữ liệu từ file | \-0,5 |  |  | [KB\_Upload\_File](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/upload-a-local-file-11271694e0) \+ [https://jarvis.cx/help/knowledge-base/connectors/file](https://jarvis.cx/help/knowledge-base/connectors/file)  |
| Nạp dữ liệu từ URL website | \-0,5 |  |  | [KB\_Upload\_Web](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/upload-website-to-knowledge-11271704e0)  |
| Nạp dữ liệu từ Google Drive | \-0,5 |  |  | [KB\_Upload\_GG\_Drive](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/upload-data-from-gg-drive-11271698e0)  (Pending) \+ [https://jarvis.cx/help/knowledge-base/connectors/google-drive](https://jarvis.cx/help/knowledge-base/connectors/google-drive)  |
| Nạp dữ liệu từ Slack | \-0,5 |  |  | [KB\_Upload\_Slack](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/upload-data-from-slack-11271699e0)   [https://jarvis.cx/help/knowledge-base/connectors/slack](https://jarvis.cx/help/knowledge-base/connectors/slack)  |
| Nạp dữ liệu từ Confluence | \-0,5 |  |  | [KB\_Upload\_Confluence](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/upload-data-from-confluence-11271700e0) \+ [https://jarvis.cx/help/knowledge-base/connectors/confluence](https://jarvis.cx/help/knowledge-base/connectors/confluence)  |
| **7\. Quản lý và sử dụng prompt** |  |  |  |  |
| Hiển thị và tìm kiếm public prompt | \-0,5 |  |  | [Jarvis\_Get\_Prompts](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-prompts-11231212e0) (isPublic \=  true)  |
| Lọc prompt theo category | \-0.5 |  |  | [Jarvis\_Get\_Prompts](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-prompts-11231212e0)  |
| Thêm prompt vào favourite và xem danh sách favourite | \-0,5 |  |  | [Jarvis\_Add\_Prompt\_To\_Favorite](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/add-prompt-to-favorite-11231215e0) \+ [Jarvis\_Get\_Prompts](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-prompts-11231212e0) (isFavorite \=  true)  |
| Tạo mới 1 private prompt | \-0,5 |  |  | [Jarvis\_Create\_Prompt](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/create-prompt-11231211e0)  (isPublic \=  false)  |
| Hiển thị và tìm kiếm private prompt | \-0,5 |  |  | [Jarvis\_Get\_Prompts](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-prompts-11231212e0) (isPublic \=  false)  |
| Cập nhật và xóa private prompt | \-0,5 |  |  | [Jarvis\_Update\_Prompt](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/update-prompt-11231213e0) \+ [Jarvis\_Delete\_Prompt](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/delete-prompt-11231214e0)   |
| Sử dụng Prompt trong library | \-0,5 |  |  | Use content of prompt from list prompt |
| Sử dụng nhanh prompt trong Chat với slash (/) | \-0,5 |  |  | [Jarvis\_Get\_Prompts](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-prompts-11231212e0) |
| **8\. Nâng cấp tài khoản lên Pro & Monetization (IAP)** |  |  |  |  |
| Nâng cấp tài khoản | \-0,5 |  |  | [Link](https://dev.jarvis.cx/pricing) 4242 4242 4242 4242 |
| Hiển thị thông tin tài khoản Pro và cập nhật số token thành unlimited | \-0,5 |  |  | [Jarvis\_Get\_Usage](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-usage-11231176e0) \+ [Jarvis\_Get\_Token](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/get-usage-11231174e0)   |
| Gắn code quảng cáo và kiếm tiền qua quảng cáo | \-0,5 |  |  |  |
| Gắn IAP để nâng cấp lên TK PRO | \-0,5 |  |  |  |
| **9\. Hỏi đáp trên ảnh & files** |  |  |  |  |
| Upload ảnh để chat | \-0,5 |  |  | \<API\> |
| Chụp ảnh và chat với ảnh đã chụp | \-0,5 |  |  |  |
| **10\. Soạn email với AI** |  |  |  |  |
| Tạo tab riêng cho soạn theo email | \-0,5 |  |  |  |
| Thêm các AI actions để tạo draft email (Thanks, Sorry, Yes, No, Follow Up, Request for more information) | \-0,5 |  |  | [Jarvis\_Reply\_Ideas](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/suggest-reply-ideas-11490529e0) \+ [Jarvis\_Reponse\_Email](https://www.apidog.com/apidoc/shared-f30d2953-f010-4ef7-a360-69f9eaf457f7/response-email-11490528e0)   |
| **11\. Các chức năng nâng cao (cộng tối đa 1 điểm)** |  |  |  |  |
| Ứng dụng được publish trên store | 0,25 |  |  | Web hosting, Mobile app store (Apple store, Google Play store), Desktop app store (Apple store, Windows store)... |
| Số lượng người dùng tải ứng dụng | 0,25 |  |  | Cứ 10 người dùng tải mới được \+0,25đ. Tối đa được cộng 0,5 điểm. |
| Sử dụng Google Analytics/Sentry/Crashlytics… | 0,25 |  |  | Mỗi thư viện phù hợp được \+0,25. Tối đa được cộng 0.5 điểm. |
| Cấu hình CI/CD cho project | 0,25 |  |  |  |

