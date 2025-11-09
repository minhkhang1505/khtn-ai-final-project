# Milestone 2 (Frontend) — API Integration & Feature Completion

Status: In Progress  
Scope: Frontend only (Flutter). All backend APIs are available. This milestone wires the UI/ViewModels/Data layers to the API and finalizes UX with loading/error states and tests.

Labels to use: `milestone:2`, `frontend`, `flutter`, `api`, `integration`, `tests`

Docs: See `milestone2/PLAN_MILESTONE_2.md` for the full background and requirements.

---

## Master Issue — Milestone 2 Frontend Delivery

Use this master issue to track all child issues. Check items off only when the corresponding child issue is closed.

### Authentication & Authorization

- [ ] [AUTH-001] Setup Authentication Service & API Integration (Frontend)
- [ ] [AUTH-002] Implement Login Flow with Validation (Frontend)
- [ ] [AUTH-003] Implement Registration Flow with Email Verification (Frontend)
- [ ] [AUTH-004] Implement Password Reset & Forgot Password Flow (Frontend)
- [ ] [AUTH-005] Implement Social Authentication (Google) (Frontend)
- [ ] [AUTH-006] Implement User Session Management & Logout (Frontend)
- [ ] [AUTH-007] Authentication Error Handling & Retry Logic (Frontend)

### AI Chat

- [ ] [CHAT-001] Setup Chat API Service & Data Models (Frontend)
- [ ] [CHAT-002] Implement Real-Time Chat UI & Message Display (Frontend)
- [ ] [CHAT-003] Implement Message Input & Sending (Frontend)
- [ ] [CHAT-004] Implement Message History & Pagination (Frontend)
- [ ] [CHAT-005] Implement Bot Selection & Switching (Frontend)
- [ ] [CHAT-006] Implement Chat Drawer & Navigation (Frontend)
- [ ] [CHAT-007] Implement Message Search & Filtering (Frontend)
- [ ] [CHAT-008] Implement Chat Persistence & Offline Support (Frontend)
- [ ] [CHAT-009] Implement Chat Error Handling & Recovery (Frontend)

### Prompt Management

- [ ] [PROMPT-001] Setup Prompt API Service & Data Models (Frontend)
- [ ] [PROMPT-002] Implement Prompt List Display with Pagination (Frontend)
- [ ] [PROMPT-003] Implement Prompt Search & Filtering (Frontend)
- [ ] [PROMPT-004] Implement Create Prompt Functionality (Frontend)
- [ ] [PROMPT-005] Implement Edit Prompt Functionality (Frontend)
- [ ] [PROMPT-006] Implement Delete Prompt Functionality (Frontend)
- [ ] [PROMPT-007] Implement Prompt Detail View (Frontend)
- [ ] [PROMPT-008] Implement Prompt Categories Management (Frontend)
- [ ] [PROMPT-009] Implement Favorite/Save Prompts (Frontend)
- [ ] [PROMPT-010] Implement Prompt Usage Tracking (Frontend)
- [ ] [PROMPT-011] Implement Prompt Sharing & Visibility (Frontend)
- [ ] [PROMPT-012] Implement Prompt Usage in Chat (Frontend)

### Shared/Infrastructure

- [ ] API client & interceptors (Dio) wired to `api_service.dart`
- [ ] Secure token storage via `flutter_secure_storage`
- [ ] Request auth header injection + refresh token flow
- [ ] Navigation wiring in `presentation/routes/`
- [ ] Unit tests (>80% on new business logic) + Widget tests for key screens
- [ ] Lint/format: `flutter analyze` clean, `dart format` applied

---

## How to Use This File

- Create one GitHub issue per section below (copy its entire template).
- Apply labels: `milestone:2`, `frontend`, plus a feature label like `auth`, `chat`, or `prompts`.
- Link each created issue back to the Master Issue using “Linked issues.”

---

## ISSUE TEMPLATES (Frontend)

Each issue below is copy-paste ready. Replace square-bracket placeholders where needed. Keep scope FE-only.

---

### [AUTH-001] Setup Authentication Service & API Integration (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `api`, `auth`

Description:
Implement the frontend auth infrastructure using Dio + interceptors and secure token storage. Integrate existing backend endpoints via a Remote Data Source and Repository. No backend changes.

APIs: `POST /auth/login`, `POST /auth/register`, `POST /auth/refresh-token`, `POST /auth/logout`, `POST /auth/forgot-password`, `POST /auth/verify-email`, `POST /auth/reset-password`, `POST /auth/google/callback`

Tasks:

- [ ] Add dependencies in `pubspec.yaml`: `dio`, `flutter_secure_storage`, `google_sign_in`
- [ ] Extend `lib/presentation/services/api_service.dart` with Dio client, base options, and logging in debug
- [ ] Implement interceptors for: auth header injection, refresh token on 401, exponential backoff retry for idempotent requests
- [ ] Create `lib/data/datasources/remote/auth_remote_data_source.dart` with methods for all auth endpoints
- [ ] Create `lib/data/repositories/auth_repository_impl.dart` and map API DTOs to domain models/entities as needed
- [ ] Implement token storage with `flutter_secure_storage` (access, refresh) + helpers in a small `TokenStorage` utility
- [ ] Wire dependency injection (simple service locator or Provider initialization) to expose repository to ViewModels
- [ ] Unit tests: data source (happy/error), repository mapping, interceptor behavior (mock Dio)

Acceptance Criteria:

- [ ] All auth endpoints are callable from FE through repository methods
- [ ] Tokens securely stored and read; refresh flow retried automatically
- [ ] Unit tests cover success and failure paths
- [ ] `flutter analyze` PASS, `dart format` applied

Files to touch:

- `lib/presentation/services/api_service.dart`
- `lib/data/datasources/remote/auth_remote_data_source.dart`
- `lib/data/repositories/auth_repository_impl.dart`
- `lib/domain/repositories/` (add interfaces as needed)
- `lib/core/network/` (optional: errors, interceptors, result types)
- `pubspec.yaml`
- `test/` specs

---

### [AUTH-002] Implement Login Flow with Validation (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `auth`, `ui`

Description:
Connect login UI to API. Add form validation, loading, error handling, and “Remember Me” using secure storage.

Tasks:

- [ ] Create `LoginViewModel` (Provider/ChangeNotifier) with states: idle/loading/success/error
- [ ] Validate email/password (frontend) and show inline messages
- [ ] Call repository login; handle 4xx invalid credentials vs network errors
- [ ] Remember Me: securely cache email (optional) and tokens via token storage
- [ ] UX: disable button while loading; show snackbars/dialogs for errors
- [ ] Navigation to home on success via `presentation/routes/`
- [ ] Widget/Unit tests for ViewModel and validators

Acceptance Criteria:

- [ ] Valid credentials log in and route to home
- [ ] Invalid credentials show proper messages; loading states work
- [ ] Remember Me persists securely

Files:

- `lib/presentation/views/auth/login/` (UI)
- `lib/presentation/viewmodels/login_view_model.dart`
- `lib/presentation/routes/route_generator.dart`
- `test/` specs

---

### [AUTH-003] Implement Registration Flow with Email Verification (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `auth`, `ui`

Tasks:

- [ ] Create `RegisterViewModel` with form validation and password strength meter
- [ ] Integrate register API; handle conflict/email-taken errors
- [ ] Email verification screen: OTP or link entry (UI + ViewModel)
- [ ] UX: success/failed states; loading indicators
- [ ] Tests for validators and ViewModel logic

Acceptance Criteria:

- [ ] User can register; receives verification step
- [ ] Verification completes and updates local session state

Files:

- `lib/presentation/views/auth/register/`
- `lib/presentation/viewmodels/register_view_model.dart`
- `lib/presentation/viewmodels/verify_email_view_model.dart`
- `test/`

---

### [AUTH-004] Implement Password Reset & Forgot Password Flow (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `auth`, `ui`

Tasks:

- [ ] Forgot Password UI + ViewModel to trigger email
- [ ] OTP/Code entry UI + ViewModel to verify
- [ ] Reset Password UI with strength check and confirm match
- [ ] Integrate `/auth/forgot-password`, `/auth/reset-password`
- [ ] UX: success/error states; clear tokens & session after reset
- [ ] Tests for happy/error paths

Acceptance Criteria:

- [ ] User can request and complete password reset
- [ ] Session invalidated as required

Files:

- `lib/presentation/views/auth/`
- `lib/presentation/viewmodels/`
- `test/`

---

### [AUTH-005] Implement Social Authentication (Google) (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `auth`, `google`

Tasks:

- [ ] Add `google_sign_in` dependency and platform setup for iOS/Android/macOS/web as applicable
- [ ] Implement Google Sign-In button and flow in login screen
- [ ] Exchange Google token with backend via `/auth/google/callback`
- [ ] On success, persist tokens via secure storage; navigate to home
- [ ] Tests: mock GoogleSignIn and repository

Acceptance Criteria:

- [ ] Google sign-in completes; backend validates; session created

Files:

- `lib/presentation/views/auth/login/`
- `lib/presentation/viewmodels/login_view_model.dart`
- `pubspec.yaml`, platform configs
- `test/`

---

### [AUTH-006] Implement User Session Management & Logout (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `auth`

Tasks:

- [ ] Auto-restore session on app start if token valid (splash)
- [ ] Add Logout action: clear secure storage, memory caches, local DBs
- [ ] Auto-logout on refresh failure/expiry with user notification
- [ ] Tests for restoration and logout

Acceptance Criteria:

- [ ] Session persists across restarts; logout fully clears state

Files:

- `lib/presentation/views/splash/splash_page.dart`
- `lib/presentation/viewmodels/session_view_model.dart`
- `lib/presentation/services/navigation_service.dart`
- `test/`

---

### [AUTH-007] Authentication Error Handling & Retry Logic (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `auth`, `reliability`

Tasks:

- [ ] Centralize error mapping (HTTP -> user-friendly messages)
- [ ] Exponential backoff retry for transient errors (safe methods)
- [ ] Add unobtrusive error toasts/snackbars + retry buttons where relevant
- [ ] Logging hooks for debugging (only in debug builds)
- [ ] Tests for retry and error mapping

Acceptance Criteria:

- [ ] Network/auth errors handled gracefully with clear messages

Files:

- `lib/core/errors/` and `lib/core/network/`
- `lib/presentation/services/api_service.dart`
- `test/`

---

### [CHAT-001] Setup Chat API Service & Data Models (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `api`

APIs: `GET/POST /chat/conversations`, `GET/POST /chat/conversations/{id}/messages`, `DELETE /chat/conversations/{id}`, `GET /chat/bots`

Tasks:

- [ ] Create `lib/data/datasources/remote/chat_remote_data_source.dart`
- [ ] Implement repository and map to existing models: `lib/data/models/message_model.dart`, `bot_model.dart`
- [ ] Persist minimal message history (in memory first); define DB interface for offline later
- [ ] Unit tests: data source and repository

Acceptance Criteria:

- [ ] FE can list conversations, fetch messages, send, and delete via repository

Files:

- `lib/data/datasources/remote/chat_remote_data_source.dart`
- `lib/data/repositories/chat_repository_impl.dart`
- `lib/domain/repositories/`
- `test/`

---

### [CHAT-002] Implement Real-Time Chat UI & Message Display (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `ui`

Tasks:

- [ ] Enhance `lib/presentation/views/chat/chat_page.dart` to render message bubbles (sent/received)
- [ ] Show timestamps, sender, and loading placeholders
- [ ] Auto-scroll to latest; handle long lists efficiently
- [ ] ViewModel to drive message list state
- [ ] Widget tests for list rendering edge cases

Acceptance Criteria:

- [ ] Messages display correctly; smooth scrolling; proper empty/loading states

Files:

- `lib/presentation/views/chat/`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `test/`

---

### [CHAT-003] Implement Message Input & Sending (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `ui`

Tasks:

- [ ] Input field with validation (non-empty, max length)
- [ ] Send action triggers repository; show pending/sending states
- [ ] Disable send while sending; display errors and allow retry
- [ ] Character counter (optional)
- [ ] Tests for ViewModel send flow

Acceptance Criteria:

- [ ] User can type and send; empty messages prevented; clear feedback

Files:

- `lib/presentation/views/chat/widgets/`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `test/`

---

### [CHAT-004] Implement Message History & Pagination (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `pagination`

Tasks:

- [ ] Load initial history on open; infinite scroll up to load older messages
- [ ] Pull-to-refresh for latest
- [ ] Integrate repository paginated endpoints
- [ ] Tests for pagination logic and edge cases

Acceptance Criteria:

- [ ] History loads correctly; pagination and refresh work smoothly

Files:

- `lib/presentation/viewmodels/chat_view_model.dart`
- `lib/presentation/views/chat/`
- `test/`

---

### [CHAT-005] Implement Bot Selection & Switching (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `ui`

Tasks:

- [ ] Implement/Enhance `bot_option_menu.dart`/`ai_model_option_menu.dart` for bot list
- [ ] Fetch bots via repository; persist selected bot (local preference)
- [ ] Clear/adjust context on switch; update header
- [ ] Tests for selection logic

Acceptance Criteria:

- [ ] Users can select/switch bots; chat context updates accordingly

Files:

- `lib/presentation/common/widgets/bot_search_bar.dart`
- `lib/presentation/common/widgets/ai_model_option_menu.dart`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `test/`

---

### [CHAT-006] Implement Chat Drawer & Navigation (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `ui`

Tasks:

- [ ] Enhance `chat_drawer.dart` to show conversation list
- [ ] Open conversation loads its history
- [ ] New conversation button; delete action (with confirm)
- [ ] Wire navigation via `presentation/routes/`
- [ ] Tests for drawer interactions

Acceptance Criteria:

- [ ] Drawer lists conversations; open/new/delete all work

Files:

- `lib/presentation/views/chat/widgets/`
- `lib/presentation/routes/`
- `test/`

---

### [CHAT-007] Implement Message Search & Filtering (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `search`

Tasks:

- [ ] Search input in chat
- [ ] Filter messages locally or via API as available
- [ ] Highlight results; handle no-results states
- [ ] Tests for search logic

Acceptance Criteria:

- [ ] Users can search messages with accurate highlighted results

Files:

- `lib/presentation/views/chat/`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `test/`

---

### [CHAT-008] Implement Chat Persistence & Offline Support (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `offline`

Tasks:

- [ ] Add `hive` (or SQLite) and define simple local schemas for messages/conversations
- [ ] Queue outgoing messages while offline; sync on reconnect
- [ ] Show offline indicator
- [ ] Tests for persistence and queueing

Acceptance Criteria:

- [ ] Messages persist locally; offline sends queue and deliver on reconnect

Files:

- `lib/data/datasources/local/`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `pubspec.yaml`
- `test/`

---

### [CHAT-009] Implement Chat Error Handling & Recovery (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `chat`, `reliability`

Tasks:

- [ ] Retry failed messages (per-message retry button)
- [ ] Automatic reconnection/backoff
- [ ] Clear error notifications and statuses
- [ ] Tests

Acceptance Criteria:

- [ ] Failed messages can be retried; reconnection works and is visible

Files:

- `lib/presentation/views/chat/`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `test/`

---

### [PROMPT-001] Setup Prompt API Service & Data Models (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `api`

APIs: `GET /prompts`, `POST /prompts`, `GET /prompts/{id}`, `PUT /prompts/{id}`, `DELETE /prompts/{id}`, `GET /prompts/categories`, `GET /prompts/search`, `POST/DELETE /prompts/{id}/favorite`, `GET /prompts/{id}/stats`

Tasks:

- [ ] Create `lib/data/datasources/remote/prompt_remote_data_source.dart`
- [ ] Implement repository and map to `lib/data/models/prompt_model.dart`
- [ ] Basic caching layer (in-memory; optional local DB)
- [ ] Unit tests for data source and repository

Acceptance Criteria:

- [ ] FE can fetch, create, update, delete, and favorite prompts via repository

Files:

- `lib/data/datasources/remote/prompt_remote_data_source.dart`
- `lib/data/repositories/prompt_repository_impl.dart`
- `lib/domain/repositories/`
- `test/`

---

### [PROMPT-002] Implement Prompt List Display with Pagination (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `ui`, `pagination`

Tasks:

- [ ] Fetch prompts with pagination; show loading and empty states
- [ ] Pull-to-refresh; error UI with retry
- [ ] ViewModel to manage list state
- [ ] Tests for pagination and empty/error states

Acceptance Criteria:

- [ ] Prompts display with smooth pagination and refresh

Files:

- `lib/presentation/views/prompts/prompts_page.dart`
- `lib/presentation/viewmodels/prompts_list_view_model.dart`
- `test/`

---

### [PROMPT-003] Implement Prompt Search & Filtering (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `search`

Tasks:

- [ ] Search input in prompts app bar
- [ ] Integrate categories and tag filters
- [ ] Sorting options (e.g., recent, popular)
- [ ] Tests for query building and results rendering

Acceptance Criteria:

- [ ] Search and filters work with clear result states

Files:

- `lib/presentation/views/prompts/widgets/prompts_app_bar.dart`
- `lib/presentation/viewmodels/prompts_filters_view_model.dart`
- `test/`

---

### [PROMPT-004] Implement Create Prompt Functionality (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `ui`

Tasks:

- [ ] Enhance `newprompt` UI with validation
- [ ] Integrate create API; include category selection and template selection
- [ ] Optional: preview before save; handle uploads if needed
- [ ] Tests for form validation and success path

Acceptance Criteria:

- [ ] Users can create prompts and see confirmation

Files:

- `lib/presentation/views/prompts/newprompt/`
- `lib/presentation/viewmodels/create_prompt_view_model.dart`
- `test/`

---

### [PROMPT-005] Implement Edit Prompt Functionality (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `ui`

Tasks:

- [ ] Edit page loads prompt details; track dirty fields
- [ ] Integrate update API; confirm before save
- [ ] UX for success/error
- [ ] Tests

Acceptance Criteria:

- [ ] Editing works; prior values shown; changes persisted

Files:

- `lib/presentation/views/prompts/promptdetail/`
- `lib/presentation/viewmodels/edit_prompt_view_model.dart`
- `test/`

---

### [PROMPT-006] Implement Delete Prompt Functionality (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `ui`

Tasks:

- [ ] Delete confirmation dialog
- [ ] Integrate delete API; update list state
- [ ] Handle errors; optional undo
- [ ] Tests

Acceptance Criteria:

- [ ] Deletion updates UI; errors gracefully handled

Files:

- `lib/presentation/views/prompts/`
- `lib/presentation/viewmodels/prompts_list_view_model.dart`
- `test/`

---

### [PROMPT-007] Implement Prompt Detail View (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `ui`

Tasks:

- [ ] Detail page shows full info, usage stats, dates
- [ ] Action buttons: edit, delete, use
- [ ] Tests for rendering logic

Acceptance Criteria:

- [ ] Detail displays correctly; actions visible and functional

Files:

- `lib/presentation/views/prompts/promptdetail/`
- `lib/presentation/viewmodels/prompt_detail_view_model.dart`
- `test/`

---

### [PROMPT-008] Implement Prompt Categories Management (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `ui`

Tasks:

- [ ] Fetch categories and cache
- [ ] Category selection UX in create/edit
- [ ] Category tabs/filtering in list
- [ ] Tests for category filter behavior

Acceptance Criteria:

- [ ] Categories load; selection and filtering work

Files:

- `lib/presentation/views/prompts/`
- `lib/presentation/common/widgets/category_option_menu.dart`
- `lib/presentation/viewmodels/prompts_filters_view_model.dart`
- `test/`

---

### [PROMPT-009] Implement Favorite/Save Prompts (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `favorites`

Tasks:

- [ ] Toggle favorite state; sync with backend
- [ ] Optional local cache of favorites; separate tab or filter
- [ ] Tests for optimistic update and rollback

Acceptance Criteria:

- [ ] Favorite/unfavorite works and persists locally/remotely

Files:

- `lib/presentation/views/prompts/`
- `lib/presentation/viewmodels/prompts_list_view_model.dart`
- `test/`

---

### [PROMPT-010] Implement Prompt Usage Tracking (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `analytics`

Tasks:

- [ ] Ensure usage is logged via backend on “use” actions
- [ ] Display usage count in list and detail
- [ ] Optional: basic trend visualization
- [ ] Tests for counters

Acceptance Criteria:

- [ ] Usage counts update after actions and render correctly

Files:

- `lib/presentation/views/prompts/`
- `lib/presentation/viewmodels/prompt_detail_view_model.dart`
- `test/`

---

### [PROMPT-011] Implement Prompt Sharing & Visibility (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `sharing`

Tasks:

- [ ] Public/private toggle and indicator
- [ ] Share link generation and UI
- [ ] Public prompt discovery view (if applicable)
- [ ] Tests

Acceptance Criteria:

- [ ] Visibility toggles work; shared prompts discoverable as per API

Files:

- `lib/presentation/views/prompts/`
- `lib/presentation/viewmodels/`
- `test/`

---

### [PROMPT-012] Implement Prompt Usage in Chat (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `prompts`, `chat`

Tasks:

- [ ] Select prompt within chat; inject into outgoing message input
- [ ] Display active prompt in chat header
- [ ] Tests for prompt injection logic

Acceptance Criteria:

- [ ] Prompts can be applied to chat; context clearly shown

Files:

- `lib/presentation/views/chat/`
- `lib/presentation/viewmodels/chat_view_model.dart`
- `lib/presentation/viewmodels/prompts_list_view_model.dart`
- `test/`

---

## Shared/Infrastructure Issue (optional single issue)

Title: API Client, Security, Navigation, and Testing Baseline (Frontend)

Labels: `milestone:2`, `frontend`, `flutter`, `infrastructure`, `testing`

Tasks:

- [ ] Dio client with interceptors in `api_service.dart`
- [ ] `flutter_secure_storage` wired for tokens; migrate away from SharedPreferences for secrets
- [ ] Global error mapping and retry logic utilities
- [ ] Route updates in `presentation/routes/` (new screens and flows)
- [ ] Test scaffolding: unit and widget test baselines; CI workflow (if any)
- [ ] Lint/format: `flutter analyze` clean; `dart format` applied

Acceptance Criteria:

- [ ] Stable API client and navigation; tests in place and green

---

## Definition of Done (applies to each issue)

- [ ] Code follows project architecture (`data`/`domain`/`presentation`)
- [ ] Unit tests (>80% coverage on new logic) and key widget tests
- [ ] No breaking changes to existing UI unless specified
- [ ] Documentation updated where applicable
- [ ] `dart format` applied; `flutter analyze` PASS
- [ ] Verified on iOS and Android simulators/emulators for the changed flows

---

## Notes

- Reuse and extend existing models under `lib/data/models/` (e.g., `message_model.dart`, `prompt_model.dart`, `bot_model.dart`).
- Keep business logic in ViewModels (Provider/ChangeNotifier) and avoid API calls directly from UI widgets.
- Implement interceptors for auth header injection + transparent token refresh; do not store tokens in SharedPreferences.
- Use navigation helpers under `lib/presentation/routes/` and `lib/presentation/services/navigation_service.dart`.
