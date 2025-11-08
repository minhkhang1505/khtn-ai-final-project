# High-Level Design - KHTN AI Final Project

This document outlines the overall design of the KHTN AI Final Project, covering user flows, state management strategy, and the complete architecture overview.

---

## Table of Contents

1. [User Flow & Screens](#1-user-flow--screens)
2. [State Management Plan](#2-state-management-plan)
3. [Architecture Overview](#3-architecture-overview)

---

## 1. User Flow & Screens

### 1.1 Navigation Map

#### **Complete Application Navigation Tree with Entry Points**

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                   KHTN AI APPLICATION NAVIGATION FLOW                         │
│                          (Complete User Journey)                              │
└──────────────────────────────────────────────────────────────────────────────┘

                               ┌─────────────────┐
                               │  🚀 App Start   │
                               └────────┬────────┘
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
        ┌───────────▼──────────┐       │       ┌───────────▼──────────┐
        │  NATIVE SETUP        │       │       │  CHECK PREFERENCES   │
        │  ├─ Init Services    │       │       │  ├─ Load Token       │
        │  ├─ Setup DI         │       │       │  ├─ Load Theme       │
        │  ├─ Init Providers   │       │       │  └─ Load Language    │
        │  └─ Setup Routes     │       │       └────────────┬─────────┘
        └───────────┬──────────┘       │                    │
                    │                   │                    │
                    └───────────────────┼────────────────────┘
                                        │
                        ┌───────────────▼────────────────┐
                        │ SPLASH SCREEN (2 seconds)     │
                        │ ├─ Display Logo               │
                        │ ├─ Load Assets                │
                        │ ├─ Initialize Theme           │
                        │ └─ Check Authentication Token │
                        └───────┬──────────────┬─────────┘
                                │              │
                 ┌──────────────┘              └──────────────┐
                 │                                            │
        ┌────────▼──────────────┐          ┌────────────────▼───────┐
        │   NO TOKEN FOUND      │          │   TOKEN FOUND & VALID  │
        │   (First Time User)   │          │   (Returning User)     │
        └────────┬──────────────┘          └────────┬───────────────┘
                 │                                   │
                 │                    ┌──────────────▼────────┐
                 │                    │  VALIDATE TOKEN       │
                 │                    │  ├─ Check Expiration  │
                 │                    │  ├─ Verify Signature  │
                 │                    │  └─ Check Refresh     │
                 │                    └──┬───────────┬────────┘
                 │                       │           │
                 │          ┌────────────┘           └────────────┐
                 │          │                                      │
                 │   ┌──────▼─────────────┐          ┌───────────▼──────┐
                 │   │ TOKEN EXPIRED      │          │ TOKEN VALID      │
                 │   │ ├─ Refresh Token   │          │                  │
                 │   │ ├─ If Success →    │          │ ✓ Navigate to    │
                 │   │ │   Go to Main Page│          │   MAIN PAGE      │
                 │   │ └─ If Fail →       │          │                  │
                 │   │     Fallthrough    │          │ Route: /main     │
                 │   └──────┬─────────────┘          └──────────────────┘
                 │          │
                 │          └────────────────┐
                 │                           │
        ┌────────▼──────────────┐  ┌────────▼──────────────┐
        │  AUTH FLOW            │  │ DASHBOARD (Main Page)│
        │  Route: /auth/*       │  │ Route: /main         │
        └────────┬──────────────┘  └────────┬─────────────┘
                 │                          │
         ┌───────┴───────┐                  │
         │               │                  │
    ┌────▼────┐      ┌───▼──────┐          │
    │ Login   │      │Register  │          │
    │ Page    │      │ Page     │          │
    └────┬────┘      └────┬─────┘          │
         │                │                │
    ┌────▼────┐      ┌────▼─────┐         │
    │Verify   │      │Verify    │         │
    │Email    │      │Email     │         │
    │(OTP)    │      │(OTP)     │         │
    └────┬────┘      └────┬─────┘         │
         │                │                │
         └────────┬───────┘                │
                  │                        │
         ┌────────▼──────────┐             │
         │ SUCCESS           │             │
         │ Store Token       │             │
         │ Update AuthVM     │             │
         └────────┬──────────┘             │
                  │                        │
                  └────────┬───────────────┘
                           │
                    ┌──────▼────────────────────────────────────────────┐
                    │           MAIN PAGE (Dashboard)                   │
                    │           Route: /main                            │
                    └──────┬─────────────────────────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┬──────────────┬──────────────┐
         │                 │                 │              │              │
    ┌────▼────┐       ┌────▼─────┐     ┌────▼────┐    ┌───▼────┐    ┌──▼─────┐
    │  Bots   │       │ Agents   │     │Prompts  │    │Knowledge│   │Account│
    │ Tab (0) │       │ Tab (1)  │     │Tab (2)  │    │Tab (3) │    │Tab(4) │
    │ 🤖      │       │ 👤       │     │📋       │    │📚      │    │⚙️     │
    └────┬────┘       └────┬─────┘     └────┬────┘    └───┬────┘    └──┬────┘
         │                 │                │              │           │
    ┌────▼──────────┐ ┌────▼──────────┐ ┌──▼───────────┐ ┌▼─────┐ ┌──▼──────┐
    │ /bots         │ │ /agents       │ │ /prompts     │ │/know │ │/profile│
    │               │ │               │ │              │ │ledge │ │         │
    │ • Bot List    │ │• Agent List   │ │• Prompt List │ │• KB  │ │ • User │
    │ • Search      │ │• Search       │ │• Categories  │ │ List │ │  Info  │
    │ • Filter by   │ │• Filter       │ │• Search      │ │• Type│ │ • Edit │
    │   Category    │ │• Status badge │ │• Used by     │ │Filter│ │ • Theme│
    │ • Create Btn  │ │• Create Btn   │ │• Create Btn  │ │      │ │ • Lang │
    │               │ │               │ │              │ │      │ │ • Logout│
    └────┬──────────┘ └────┬──────────┘ └──┬───────────┘ └┬────┘ └──┬──────┘
         │                 │                │              │        │
    ┌────▼──────────────────────────────────┴──────────────┴────────┴─────────┐
    │                                                                          │
    │           SECONDARY NAVIGATION STACK (Feature-Scoped)                   │
    │                                                                          │
    │  ┌──────────────────────────────────────────────────────────────────┐   │
    │  │ BOT DETAILS FLOW                                                 │   │
    │  │ Route: /bots                                                     │   │
    │  │ ├─ Tap Bot Card → Bot Details Page                              │   │
    │  │ │  ├─ View Name, Description, Model, Prompt                     │   │
    │  │ │  ├─ View Subagents List                                        │   │
    │  │ │  ├─ Edit Button → Create Bot Page (populated)                 │   │
    │  │ │  └─ Delete Button → Confirmation Dialog                       │   │
    │  │ │                                                                │   │
    │  │ └─ Create Bot Button → Create Bot Page (/bots/new)              │   │
    │  │    ├─ Form: Name (TextInput)                                    │   │
    │  │    ├─ Description (TextInput)                                   │   │
    │  │    ├─ Category (Dropdown: Classification, Chat, etc.)           │   │
    │  │    ├─ AI Model (Dropdown: GPT-4, Claude, Custom)                │   │
    │  │    ├─ Prompt (TextEditor - Rich Text)                           │   │
    │  │    ├─ Visibility (Radio: Public, Private, Team)                 │   │
    │  │    ├─ Subagents (Multi-select)                                  │   │
    │  │    └─ Save/Cancel Buttons                                       │   │
    │  └──────────────────────────────────────────────────────────────────┘   │
    │                                                                          │
    │  ┌──────────────────────────────────────────────────────────────────┐   │
    │  │ AGENT DETAILS FLOW                                               │   │
    │  │ Route: /agents                                                   │   │
    │  │ ├─ Tap Agent Card → Agent Details Page                           │   │
    │  │ │  ├─ View Agent Info, Assigned Bots, Metrics                    │   │
    │  │ │  ├─ Edit Button → Create Agent Page (populated)                │   │
    │  │ │  └─ Delete Button → Confirmation Dialog                        │   │
    │  │ │                                                                │   │
    │  │ └─ Create Agent Button → Create Agent Page (/agents/new)         │   │
    │  │    ├─ Form: Name, Description                                   │   │
    │  │    ├─ Model Selection (Dropdown)                                │   │
    │  │    ├─ Configuration (JSON Editor)                               │   │
    │  │    └─ Save/Cancel Buttons                                       │   │
    │  └──────────────────────────────────────────────────────────────────┘   │
    │                                                                          │
    │  ┌──────────────────────────────────────────────────────────────────┐   │
    │  │ PROMPT DETAILS FLOW                                              │   │
    │  │ Route: /prompts                                                  │   │
    │  │ ├─ Tap Prompt Card → Prompt Details                              │   │
    │  │ │  ├─ View Prompt Text, Variables, Usage                         │   │
    │  │ │  ├─ Edit Button → Create Prompt Page (populated)               │   │
    │  │ │  └─ Delete Button → Confirmation Dialog                        │   │
    │  │ │                                                                │   │
    │  │ └─ Create Prompt Button → Create Prompt Page (/prompts/new)      │   │
    │  │    ├─ Form: Title, Category, Prompt Text (Editor)                │   │
    │  │    ├─ Variables Definition (Key-Value Pairs)                     │   │
    │  │    ├─ Tags (Multi-select)                                        │   │
    │  │    └─ Save/Cancel Buttons                                        │   │
    │  └──────────────────────────────────────────────────────────────────┘   │
    │                                                                          │
    │  ┌──────────────────────────────────────────────────────────────────┐   │
    │  │ KNOWLEDGE BASE FLOW                                              │   │
    │  │ Route: /knowledge                                                │   │
    │  │ ├─ Tap Knowledge Card → Knowledge Details                        │   │
    │  │ │  ├─ View Source Metadata, Content Preview                      │   │
    │  │ │  ├─ Download/Export Button                                     │   │
    │  │ │  └─ Delete Button → Confirmation Dialog                        │   │
    │  │ │                                                                │   │
    │  │ └─ Upload New Button → New Knowledge Page (/knowledge/new)       │   │
    │  │    ├─ Form: Name, Source Type (Dropdown)                         │   │
    │  │    ├─ File Upload / URL Input (based on type)                    │   │
    │  │    ├─ Progress Indicator (during upload)                         │   │
    │  │    └─ Save/Cancel Buttons                                        │   │
    │  └──────────────────────────────────────────────────────────────────┘   │
    │                                                                          │
    │  ┌──────────────────────────────────────────────────────────────────┐   │
    │  │ ACCOUNT/SETTINGS FLOW                                            │   │
    │  │ Route: /profile                                                  │   │
    │  │ ├─ Profile Tab → Account Page                                    │   │
    │  │ │  ├─ View: Avatar, Name, Email, Account Stats                   │   │
    │  │ │  ├─ Edit Profile Button → Edit Profile Page                    │   │
    │  │ │  │  ├─ Form: Name, Email, Avatar Upload                        │   │
    │  │ │  │  └─ Save/Cancel Buttons                                      │   │
    │  │ │  │                                                              │   │
    │  │ │  └─ Settings Button → Settings Page (/settings)                │   │
    │  │ │     ├─ Theme: Toggle Light/Dark                                │   │
    │  │ │     ├─ Language: Dropdown (EN, VI, etc.)                        │   │
    │  │ │     ├─ Notifications: Toggle Enable/Disable                    │   │
    │  │ │     ├─ Privacy: Dropdown (Public, Private)                     │   │
    │  │ │     └─ Logout Button → Confirmation → /auth/login              │   │
    │  │ │                                                                │   │
    │  │ └─ Direct from Profile: Logout Button                            │   │
    │  │    └─ Clears Token → Redirects to /auth/login                    │   │
    │  └──────────────────────────────────────────────────────────────────┘   │
    │                                                                          │
    └──────────────────────────────────────────────────────────────────────────┘

                            ┌──────────────────┐
                            │ SPECIAL FLOWS    │
                            └──────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
   ┌────▼──────────┐           ┌────▼──────────┐          ┌───▼──────┐
   │ FORGOT PWD    │           │ ERROR DIALOG  │          │ OFFLINE  │
   │ Route:        │           │               │          │ MODE     │
   │ /auth/forgot  │           │ ├─ Network    │          │          │
   │               │           │ ├─ Server     │          │ • Cache  │
   │ • Email Input │           │ ├─ Parse      │          │   data   │
   │ • Send OTP    │           │ └─ General    │          │ • Retry  │
   │ • Verify OTP  │           │               │          │   later  │
   │ • Set new pwd │           │ ✓ Dismiss/    │          │          │
   │               │           │   Retry       │          │          │
   └───────────────┘           └───────────────┘          └──────────┘
```

#### **Navigation Route Mapping Reference**

| No. | Screen Name        | Route Path              | Parent Flow   | Navigation Method |
| --- | ------------------ | ----------------------- | ------------- | ----------------- |
| 1   | Splash             | `/`                     | Initial       | Auto-redirect     |
| 2   | Login              | `/auth/login`           | Auth          | Push/Replace      |
| 3   | Register           | `/auth/register`        | Auth          | Push              |
| 4   | Forgot Password    | `/auth/forgot-password` | Auth          | Push              |
| 5   | Verify Email (OTP) | `/auth/verify-email`    | Auth/Register | Push              |
| 6   | Main Dashboard     | `/main`                 | Post-Auth     | Replace           |
| 7   | Bots List          | `/bots`                 | Main          | BottomNav         |
| 8   | Bot Details        | `/bots/details`         | Bots          | Push              |
| 9   | Create Bot         | `/bots/new`             | Bots          | Push              |
| 10  | Edit Bot           | `/bots/edit`            | Bot Details   | Push              |
| 11  | Agents List        | `/agents`               | Main          | BottomNav         |
| 12  | Agent Details      | `/agents/details`       | Agents        | Push              |
| 13  | Create Agent       | `/agents/new`           | Agents        | Push              |
| 14  | Prompts List       | `/prompts`              | Main          | BottomNav         |
| 15  | Prompt Details     | `/prompts/details`      | Prompts       | Push              |
| 16  | Create Prompt      | `/prompts/new`          | Prompts       | Push              |
| 17  | Knowledge Base     | `/knowledge`            | Main          | BottomNav         |
| 18  | Knowledge Details  | `/knowledge/details`    | Knowledge     | Push              |
| 19  | Upload Knowledge   | `/knowledge/new`        | Knowledge     | Push              |
| 20  | Account/Profile    | `/profile`              | Main          | BottomNav         |
| 21  | Edit Profile       | `/profile/edit`         | Account       | Push              |
| 22  | Settings           | `/settings`             | Account       | Push              |

### 1.2 Screen Inventory & Descriptions

#### **Authentication Flow**

| Screen                 | Route                               | Purpose                         | Key Components                                                                       |
| ---------------------- | ----------------------------------- | ------------------------------- | ------------------------------------------------------------------------------------ |
| **Splash**             | `/`                                 | Initial app loading screen      | Logo, Loading indicator, Theme initialization                                        |
| **Login**              | `/auth/login`                       | User login interface            | Email/Username field, Password field, Login button, Links to Register/ForgotPassword |
| **Register**           | `/auth/register`                    | New user registration           | Email field, Password field, Confirm Password, Terms acceptance, Register button     |
| **Forgot Password**    | `/auth/forgot-password`             | Password recovery initiation    | Email input, Send OTP button, Back to Login                                          |
| **Reset Password**     | `/auth/reset-password`              | Password reset with OTP         | OTP input field, New password field, Confirm password, Submit button                 |
| **Verification Email** | `/auth/register/verification-email` | Email verification after signup | Email display, OTP input, Resend button, Verification confirmation                   |

#### **Main Dashboard**

| Screen        | Route   | Purpose                            | Key Components                                                                         |
| ------------- | ------- | ---------------------------------- | -------------------------------------------------------------------------------------- |
| **Main Page** | `/main` | Central hub with bottom navigation | Bottom NavBar (Bots, Agents, Prompts, Knowledge, Account), Feature tabs, Quick actions |

#### **Bot Management**

| Screen          | Route                   | Purpose                 | Key Components                                                                         |
| --------------- | ----------------------- | ----------------------- | -------------------------------------------------------------------------------------- |
| **Bots List**   | `/bots`                 | View all available bots | Bot cards, Search bar, Category filters, Create button, Status indicators              |
| **Bot Details** | `/bots/{id}` (implicit) | View bot configuration  | Bot info, Model selection, Status, Prompt display, Subagents list, Edit/Delete buttons |
| **Create Bot**  | `/bots/new`             | Create new bot          | Form: Name, Description, Category, AI Model dropdown, Prompt editor, Save button       |
| **Edit Bot**    | `/bots/edit`            | Modify existing bot     | Same as Create Bot with pre-filled values, Update/Delete buttons                       |

#### **Agent Management**

| Screen            | Route                     | Purpose                  | Key Components                                                               |
| ----------------- | ------------------------- | ------------------------ | ---------------------------------------------------------------------------- |
| **Agents List**   | `/agents`                 | View all agents          | Agent cards, Search bar, Filter options, Create button, Status badges        |
| **Agent Details** | `/agents/{id}` (implicit) | View agent configuration | Agent info, Assigned bots, Performance metrics, Edit/Delete buttons          |
| **Create Agent**  | `/agents/new`             | Create new AI agent      | Form: Name, Description, Model selection, Configuration options, Save button |
| **Edit Agent**    | `/agents/edit`            | Modify existing agent    | Same as Create Agent with pre-filled values, Update/Delete buttons           |

#### **Prompt Management**

| Screen             | Route              | Purpose             | Key Components                                                                     |
| ------------------ | ------------------ | ------------------- | ---------------------------------------------------------------------------------- |
| **Prompts List**   | `/prompts`         | View all prompts    | Prompt cards, Category filter, Search bar, Create button, Usage stats              |
| **Prompt Details** | `/prompts/details` | View prompt content | Prompt text, Category, Variables, Templates, Usage history, Edit/Delete buttons    |
| **Create Prompt**  | `/prompts/new`     | Create new prompt   | Form: Title, Category, Prompt text editor, Variables definition, Tags, Save button |

#### **Knowledge Management**

| Screen                   | Route                | Purpose                | Key Components                                                                      |
| ------------------------ | -------------------- | ---------------------- | ----------------------------------------------------------------------------------- |
| **Knowledge Base**       | `/knowledge`         | View knowledge sources | Knowledge cards, Type filter, Search bar, Upload button, Statistics                 |
| **Knowledge Details**    | `/knowledge/details` | View source content    | Source metadata, Content preview, Upload date, Edit/Delete buttons                  |
| **New Knowledge Source** | `/knowledge/new`     | Add knowledge source   | Form: Name, Source type (Document/API/Database), File upload/URL input, Save button |

#### **Account Management**

| Screen           | Route                                | Purpose                 | Key Components                                                           |
| ---------------- | ------------------------------------ | ----------------------- | ------------------------------------------------------------------------ |
| **Account**      | `/profile` (implied in MainPage tab) | User profile & settings | User avatar, Name, Email, Account stats, Settings links                  |
| **Edit Profile** | `/profile/edit`                      | Modify user information | Form: Name, Email, Profile picture upload, Save button                   |
| **Settings**     | `/settings`                          | App preferences         | Theme toggle, Language selection, Notification settings, Privacy options |

### 1.3 Navigation Patterns

#### **Primary Navigation: Bottom Tab Bar**

Located on the Main Page (`/main`), provides quick access to:

- 🤖 **Bots** → `/bots`
- 👤 **Agents** → `/agents`
- 📋 **Prompts** → `/prompts`
- 📚 **Knowledge** → `/knowledge`
- ⚙️ **Account** → Profile tab (in MainPage)

#### **Secondary Navigation: Stack Navigation**

Feature-specific screens stack on top of main navigation:

- List → Details → Edit/Create (examples: Bot Details → Edit Bot)
- Inline operations (Create new items, View history)

#### **Dialog & Bottom Sheets**

- Confirmation dialogs (Delete actions)
- Inline creation forms (Quick add)
- Filtering/sorting options

#### **Auth Bypass**

- Splash screen checks authentication status
- If token exists → Direct to Main Page
- If no token → Redirect to Login Page
- After login → Store token, navigate to Main Page

---

## 2. State Management Plan

### 2.1 State Management Architecture

#### **Complete State Hierarchy with Property Details**

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                STATE MANAGEMENT HIERARCHY & LIFECYCLE                         │
│                     (3-Level State Organization)                              │
└──────────────────────────────────────────────────────────────────────────────┘

╔══════════════════════════════════════════════════════════════════════════════╗
║                          LEVEL 1: APP-WIDE STATE                             ║
║                      (Singleton - Lives with App)                            ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ AuthViewModel (extends ChangeNotifier)                                  │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │                                                                         │ ║
║  │ STATE PROPERTIES:                                                       │ ║
║  │  • _token: String? → Authentication JWT token (persistent)             │ ║
║  │  • _user: UserEntity? → Logged-in user details (name, email, id)       │ ║
║  │  • _isAuthenticated: bool → Is user logged in (derived from token)     │ ║
║  │  • _isLoading: bool → Auth operation in progress (login/register)      │ ║
║  │  • _error: String? → Last auth error message (cleared on retry)        │ ║
║  │  • _refreshToken: String? → For token renewal (persistent)             │ ║
║  │  • _tokenExpiry: DateTime? → When token expires                        │ ║
║  │  • _lastAuthTime: DateTime? → Timestamp of last auth activity          │ ║
║  │                                                                         │ ║
║  │ PUBLIC GETTERS:                                                        │ ║
║  │  • String? get token → Access current auth token                       │ ║
║  │  • UserEntity? get user → Get current user info                        │ ║
║  │  • bool get isAuthenticated → Check if user is logged in              │ ║
║  │  • bool get isLoading → Check if auth operation is running             │ ║
║  │  • String? get error → Get last error message                          │ ║
║  │                                                                         │ ║
║  │ KEY METHODS:                                                            │ ║
║  │  • Future<void> login(email, password) → Authenticate user             │ ║
║  │  • Future<void> register(email, password, name) → Create account       │ ║
║  │  • Future<void> logout() → Clear token, reset state                    │ ║
║  │  • Future<void> refreshToken() → Get new token using refresh token    │ ║
║  │  • Future<void> verifyEmail(otp) → Verify email with OTP               │ ║
║  │  • void updateUser(user) → Update user profile info                    │ ║
║  │  • bool isTokenValid() → Check if token still valid                    │ ║
║  │                                                                         │ ║
║  │ USAGE IN UI:                                                            │ ║
║  │  • context.watch<AuthViewModel>() → Listen for auth state changes      │ ║
║  │  • Used by: Splash, Login, Register, Navigation guards                 │ ║
║  │  • Triggers: LoginPage → Auth Success → Main Page                      │ ║
║  │                                                                         │ ║
║  │ STORAGE:                                                                │ ║
║  │  • Token saved to SharedPreferences (persistent across restarts)        │ ║
║  │  • User data cached after login                                        │ ║
║  │  • Refresh token stored securely for token renewal                     │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ AppSettingsViewModel (extends ChangeNotifier)                           │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │                                                                         │ ║
║  │ STATE PROPERTIES:                                                       │ ║
║  │  • _themeMode: ThemeMode → Light/Dark/System (persistent)              │ ║
║  │  • _language: String → App language code ('en', 'vi', etc.)            │ ║
║  │  • _notificationsEnabled: bool → Push notification toggle              │ ║
║  │  • _soundEnabled: bool → Notification sound toggle                     │ ║
║  │  • _vibrationEnabled: bool → Haptic feedback toggle                    │ ║
║  │  • _fontSize: double → Text size multiplier (0.8 to 1.5)               │ ║
║  │  • _privacyLevel: String → Public/Private/Friends-Only                 │ ║
║  │  • _lastSettingsSync: DateTime? → When settings last synced            │ ║
║  │                                                                         │ ║
║  │ PUBLIC GETTERS:                                                        │ ║
║  │  • ThemeMode get themeMode → Current app theme                         │ ║
║  │  • String get language → Current language setting                      │ ║
║  │  • bool get notificationsEnabled → Notifications on/off                │ ║
║  │  • double get fontSize → Text size multiplier                          │ ║
║  │                                                                         │ ║
║  │ KEY METHODS:                                                            │ ║
║  │  • void setThemeMode(ThemeMode) → Switch theme, notify, save           │ ║
║  │  • void setLanguage(String) → Change app language, refresh UI          │ ║
║  │  • void toggleNotifications() → Enable/disable push notifications      │ ║
║  │  • void setFontSize(double) → Change text size globally                │ ║
║  │  • void setPrivacyLevel(String) → Update privacy setting               │ ║
║  │  • Future<void> loadSettings() → Load from SharedPreferences           │ ║
║  │  • Future<void> saveSettings() → Persist current settings              │ ║
║  │                                                                         │ ║
║  │ USAGE IN UI:                                                            │ ║
║  │  • context.watch<AppSettingsViewModel>() → Watch theme changes         │ ║
║  │  • MaterialApp.theme updated automatically when themeMode changes      │ ║
║  │  • Used by: Settings Page, All screens (for styling)                   │ ║
║  │  • Applies to: Colors, fonts, brightness globally                      │ ║
║  │                                                                         │ ║
║  │ STORAGE:                                                                │ ║
║  │  • All settings saved to SharedPreferences (persistent)                 │ ║
║  │  • Theme applied on app start before splash screen                     │ ║
║  │  • Changes synced immediately and saved                                │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ NetworkViewModel (extends ChangeNotifier)                              │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │                                                                         │ ║
║  │ STATE PROPERTIES:                                                       │ ║
║  │  • _isConnected: bool → Has internet connection (real-time)            │ ║
║  │  • _connectionType: String → 'wifi', 'cellular', 'none'               │ ║
║  │  • _isSlowConnection: bool → Connection speed is slow                  │ ║
║  │  • _lastConnectionCheck: DateTime? → Last connectivity check           │ ║
║  │  • _connectionListener: StreamSubscription → Listen for changes        │ ║
║  │                                                                         │ ║
║  │ PUBLIC GETTERS:                                                        │ ║
║  │  • bool get isConnected → Online/offline status                        │ ║
║  │  • String get connectionType → Current connection type                 │ ║
║  │  • bool get isSlowConnection → True if connection is slow              │ ║
║  │                                                                         │ ║
║  │ KEY METHODS:                                                            │ ║
║  │  • Future<void> checkConnectivity() → Check current connectivity       │ ║
║  │  • void startListeningToConnectivity() → Monitor connection changes    │ ║
║  │  • void stopListeningToConnectivity() → Stop monitoring                │ ║
║  │  • Future<bool> hasInternetConnection() → True if internet available   │ ║
║  │                                                                         │ ║
║  │ USAGE IN UI:                                                            │ ║
║  │  • context.watch<NetworkViewModel>() → Show offline indicator          │ ║
║  │  • Disable API calls when offline, show cached data                    │ ║
║  │  • Display network status banner when disconnected                     │ ║
║  │  • Used by: All feature pages, data loading logic                      │ ║
║  │                                                                         │ ║
║  │ INITIALIZATION:                                                         │ ║
║  │  • Listens to connectivity_plus package events                         │ ║
║  │  • Updates in real-time when connection changes                        │ ║
║  │  • Initialized once at app startup in main.dart                        │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
╚══════════════════════════════════════════════════════════════════════════════╝


╔══════════════════════════════════════════════════════════════════════════════╗
║                       LEVEL 2: FEATURE-LEVEL STATE                           ║
║              (Created per feature, disposed when leaving feature)             ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ BotViewModel (extends ChangeNotifier)                                   │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │ Scope: Bots feature tab (created on first access, disposed on app exit) │ ║
║  │                                                                         │ ║
║  │ STATE PROPERTIES:                                                       │ ║
║  │  • _bots: List<BotEntity> → All available bots (from API)              │ ║
║  │  • _selectedBot: BotEntity? → Currently selected/viewed bot            │ ║
║  │  • _filteredBots: List<BotEntity> → Bots after filtering               │ ║
║  │  • _isLoading: bool → Data fetch in progress                           │ ║
║  │  • _isDeleting: bool → Delete operation in progress                    │ ║
║  │  • _error: String? → Last error message                                │ ║
║  │  • _searchQuery: String → Current search text                          │ ║
║  │  • _selectedCategory: String? → Active category filter                 │ ║
║  │  • _sortBy: String → 'name', 'date', 'popularity'                      │ ║
║  │  • _pageIndex: int → Pagination current page                           │ ║
║  │  • _hasMoreData: bool → Are there more pages to load                   │ ║
║  │                                                                         │ ║
║  │ PUBLIC GETTERS:                                                        │ ║
║  │  • List<BotEntity> get bots → Get all bots list                        │ ║
║  │  • List<BotEntity> get filteredBots → Get filtered list                │ ║
║  │  • BotEntity? get selectedBot → Get currently selected bot             │ ║
║  │  • bool get isLoading → Is loading state                               │ ║
║  │  • String? get error → Get error message                               │ ║
║  │                                                                         │ ║
║  │ KEY METHODS:                                                            │ ║
║  │  • Future<void> loadBots() → Fetch all bots from API                   │ ║
║  │  • Future<void> searchBots(query) → Filter bots by search query        │ ║
║  │  • void filterByCategory(category) → Filter bots by category           │ ║
║  │  • Future<void> createBot(botData) → Create new bot                    │ ║
║  │  • Future<void> updateBot(id, botData) → Update existing bot           │ ║
║  │  • Future<void> deleteBot(id) → Delete bot, update list                │ ║
║  │  • void selectBot(bot) → Set selected bot                              │ ║
║  │  • void clearFilters() → Reset all filters                             │ ║
║  │  • Future<void> loadMoreBots() → Load next page of results             │ ║
║  │                                                                         │ ║
║  │ DATA FLOW:                                                              │ ║
║  │  1. loadBots() called → _isLoading = true, notifyListeners()           │ ║
║  │  2. BotRepository.getAllBots() → fetch from API                        │ ║
║  │  3. Success → _bots = data, _error = null                              │ ║
║  │  4. Failure → _error = message, _bots stays same                       │ ║
║  │  5. _isLoading = false, notifyListeners() → UI rebuilds                │ ║
║  │                                                                         │ ║
║  │ USAGE IN UI:                                                            │ ║
║  │  • BotsPage: context.watch<BotViewModel>().bots → display list         │ ║
║  │  • BotCard: onClick → context.read<BotViewModel>().selectBot()         │ ║
║  │  • Search: onChanged → context.read<BotViewModel>().searchBots()       │ ║
║  │  • Delete: onTap → context.read<BotViewModel>().deleteBot(id)          │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ AgentViewModel (extends ChangeNotifier)                                │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │ Similar structure to BotViewModel for agent management                  │ ║
║  │                                                                         │ ║
║  │ STATE: _agents, _selectedAgent, _isLoading, _error, _searchQuery, etc. │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ PromptViewModel (extends ChangeNotifier)                               │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │ Manages prompt templates and custom prompts                            │ ║
║  │                                                                         │ ║
║  │ STATE: _prompts, _selectedPrompt, _categories, _isLoading, _error      │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ KnowledgeViewModel (extends ChangeNotifier)                            │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │ Manages knowledge base and file uploads                                │ ║
║  │                                                                         │ ║
║  │ STATE: _knowledgeSources, _uploadProgress, _isLoading, _error          │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
╚══════════════════════════════════════════════════════════════════════════════╝


╔══════════════════════════════════════════════════════════════════════════════╗
║                      LEVEL 3: PAGE/WIDGET LOCAL STATE                        ║
║            (Created when page opens, disposed when page closes)              ║
╠══════════════════════════════════════════════════════════════════════════════╣
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ LoginPage (StatefulWidget)                                              │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │                                                                         │ ║
║  │ LOCAL STATE (via setState):                                             │ ║
║  │  • _emailController: TextEditingController → Email input field         │ ║
║  │  • _passwordController: TextEditingController → Password input         │ ║
║  │  • _isPasswordHidden: bool → Toggle password visibility                │ ║
║  │  • _rememberMe: bool → "Remember me" checkbox                          │ ║
║  │  • _isSubmitting: bool → Form submission in progress                   │ ║
║  │  • _formKey: GlobalKey<FormState> → Form validation key                │ ║
║  │                                                                         │ ║
║  │ WIDGET BUILD FLOW:                                                      │ ║
║  │  1. Build: _emailController.text used for email field value            │ ║
║  │  2. Toggle icon click: setState(() { _isPasswordHidden = !... })       │ ║
║  │  3. UI rebuilds: new Icon based on _isPasswordHidden                   │ ║
║  │  4. Login button: _isSubmitting used to disable button during submit   │ ║
║  │                                                                         │ ║
║  │ WATCH FROM VIEWMODEL:                                                   │ ║
║  │  • final authVM = context.watch<AuthViewModel>()                       │ ║
║  │  • Display authVM.error if login failed                                │ ║
║  │  • Show loading spinner if authVM.isLoading                            │ ║
║  │                                                                         │ ║
║  │ READ FROM VIEWMODEL:                                                    │ ║
║  │  • onPressed: () async {                                               │ ║
║  │      await context.read<AuthViewModel>().login(                        │ ║
║  │        _emailController.text,                                          │ ║
║  │        _passwordController.text,                                       │ ║
║  │      );                                                                 │ ║
║  │    }                                                                    │ ║
║  │                                                                         │ ║
║  │ CLEANUP:                                                                │ ║
║  │  • dispose(): _emailController.dispose()                               │ ║
║  │  • dispose(): _passwordController.dispose()                            │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ CreateBotPage (StatefulWidget)                                          │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │                                                                         │ ║
║  │ LOCAL STATE (Form field states):                                        │ ║
║  │  • _nameController: TextEditingController → Bot name input             │ ║
║  │  • _descriptionController: TextEditingController → Bot description     │ ║
║  │  • _promptController: TextEditingController → Bot prompt/system msg    │ ║
║  │  • _selectedCategory: String? → Dropdown selection                     │ ║
║  │  • _selectedModel: String? → AI model selection                        │ ║
║  │  • _selectedVisibility: String? → Public/Private/Team                  │ ║
║  │  • _selectedSubagents: List<String> → Multi-select subagents           │ ║
║  │  • _isSubmitting: bool → Form submission in progress                   │ ║
║  │  • _formKey: GlobalKey<FormState> → Validation                         │ ║
║  │                                                                         │ ║
║  │ FORM VALIDATION:                                                        │ ║
║  │  • _formKey.currentState?.validate() called on submit                   │ ║
║  │  • Each field has validator: (value) { ... }                           │ ║
║  │  • Shows error text below field if validation fails                    │ ║
║  │                                                                         │ ║
║  │ SUBMIT FLOW:                                                            │ ║
║  │  1. Check form valid: if (!_formKey.currentState!.validate()) return   │ ║
║  │  2. setState(_isSubmitting = true) → Disable submit button             │ ║
║  │  3. context.read<BotViewModel>().createBot(...)                        │ ║
║  │  4. On success: Navigator.pop() to go back                             │ ║
║  │  5. On error: setState(_isSubmitting = false), show error              │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ MainPage (StatefulWidget)                                               │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │                                                                         │ ║
║  │ LOCAL STATE:                                                            │ ║
║  │  • _selectedIndex: int → Currently selected BottomNav item (0-4)       │ ║
║  │  • _pages: List<Widget> → List of 5 feature pages (immutable)          │ ║
║  │                                                                         │ ║
║  │ BUILD FLOW:                                                             │ ║
║  │  1. Build: _pages[_selectedIndex] used to show current page            │ ║
║  │  2. BottomNavigationBar.onTap(index):                                   │ ║
║  │     setState(() { _selectedIndex = index; })                           │ ║
║  │  3. Current nav item highlight: icon color = _selectedIndex == index   │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
║  ┌─────────────────────────────────────────────────────────────────────────┐ ║
║  │ BotsPage (Stateless with Provider)                                      │ ║
║  │ ─────────────────────────────────────────────────────────────────────── │ ║
║  │ Most of state comes from BotViewModel (feature-level)                   │ ║
║  │ Only local state: search controller for immediate filtering             │ ║
║  │                                                                         │ ║
║  │ WATCH VIEWMODEL:                                                        │ ║
║  │  • final botVM = context.watch<BotViewModel>()                         │ ║
║  │  • bots = botVM.bots → show list                                        │ ║
║  │  • isLoading = botVM.isLoading → show/hide spinner                      │ ║
║  │  • error = botVM.error → show error message                            │ ║
║  │                                                                         │ ║
║  └─────────────────────────────────────────────────────────────────────────┘ ║
║                                                                               ║
╚══════════════════════════════════════════════════════════════════════════════╝


                            MEMORY & LIFECYCLE

┌──────────────────────────────────────────────────────────────────────────────┐
│ STATE LIFESPAN CHART                                                         │
├──────────────────────────────────────────────────────────────────────────────┤
│                                                                              │
│ App Starts    │ Auth Success    │ Main Page    │ Leave Bots    │ App Dies   │
│       │       │        │        │      │       │       │       │     │      │
│       ▼       ▼        ▼        ▼      ▼       ▼       ▼       ▼     ▼      │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ AuthViewModel ────────────────────────────────────────────────►     │   │
│  │ AppSettings ────────────────────────────────────────────────►       │   │
│  │ NetworkVM ──────────────────────────────────────────────────►       │   │
│  │ (App-wide, never disposed)                                         │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                              │
│                   ┌──────────────────────────────┐                          │
│                   │ BotViewModel ────────────────►                          │
│                   │ AgentViewModel ────────────►                            │
│                   │ (Feature-level, survive tab switches)                  │
│                   └──────────────────────────────┘                          │
│                                                                              │
│                            ┌──────────┐                                     │
│                            │ LoginPage│  (destroyed when login succeeds)    │
│                            └──────────┘                                     │
│                                                                              │
│                                  ┌──────────────┐                           │
│                                  │ CreateBotPage│ (destroyed on pop)        │
│                                  └──────────────┘                           │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

#### **State Access Patterns in Code**

```dart
// Pattern 1: WATCH STATE (Listen for changes)
// ============================================
// Use when: You need to rebuild when state changes
// Triggers: Widget rebuild every time notifyListeners() is called

@override
Widget build(BuildContext context) {
  // Watch BotViewModel - rebuilds when any property changes
  final botVM = context.watch<BotViewModel>();

  return ListView(
    children: botVM.bots.map((bot) {
      return BotCard(bot: bot); // Rebuilds for each bot change
    }).toList(),
  );
}


// Pattern 2: READ STATE (Access once, no listening)
// ==================================================
// Use when: You only need current value for action (no rebuild needed)
// Example: Button click, navigation, one-time data access

ElevatedButton(
  onPressed: () {
    // Read without listening - doesn't rebuild on changes
    final bots = context.read<BotViewModel>().bots;

    // Can use data immediately for action
    if (bots.isNotEmpty) {
      context.read<NavigationService>().navigateTo('/bots/details');
    }
  },
  child: Text('Load Bots'),
)


// Pattern 3: COMBINED WATCH + READ
// =================================
// Use when: Watch some state, read other state

@override
Widget build(BuildContext context) {
  // Watch loading state and bots list
  final isLoading = context.watch<BotViewModel>().isLoading;
  final bots = context.watch<BotViewModel>().bots;

  // Read error handler (no need to watch, just use on error)
  final showError = (String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  };

  if (isLoading) return LoadingSpinner();
  return ListView(children: ...);
}


// Pattern 4: STATEFUL WIDGET LOCAL STATE
// =======================================
// Use for: Form fields, temporary UI state, pagination

class CreateBotPage extends StatefulWidget {
  @override
  State<CreateBotPage> createState() => _CreateBotPageState();
}

class _CreateBotPageState extends State<CreateBotPage> {
  // Local controllers (not ViewModel)
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _nameController,
      onChanged: (value) {
        setState(() {}); // Only rebuilds this widget
      },
    );
  }
}


// Pattern 5: VIEWMODEL ACTION CALL
// ================================
// Use when: Calling ViewModel methods to mutate state

Future<void> _handleBotDelete(BuildContext context, String botId) async {
  try {
    // Call ViewModel method
    await context.read<BotViewModel>().deleteBot(botId);

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Bot deleted successfully')),
    );

    // Navigate back after deletion
    Navigator.pop(context);
  } catch (e) {
    // Handle error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}


// Pattern 6: CONDITIONAL RENDERING BASED ON STATE
// ================================================
// Use when: Different UI based on state values

@override
Widget build(BuildContext context) {
  final authVM = context.watch<AuthViewModel>();
  final botVM = context.watch<BotViewModel>();

  // Multi-level conditional rendering
  if (!authVM.isAuthenticated) {
    return LoginPage(); // Not authenticated
  } else if (botVM.isLoading) {
    return LoadingScreen(); // Loading data
  } else if (botVM.error != null) {
    return ErrorScreen(message: botVM.error!); // Error occurred
  } else if (botVM.bots.isEmpty) {
    return EmptyState(); // No data
  } else {
    return BotListView(bots: botVM.bots); // Success case
  }
}
```

### 2.2 State Management Pattern: MVVM with Provider

#### **Architecture Pattern: Model-View-ViewModel (MVVM)**

```
┌─────────────────────────────────────────────────────────────┐
│                     MVVM PATTERN                             │
└─────────────────────────────────────────────────────────────┘

View (UI Layer)                 ViewModel                 Model/State
────────────────────────────    ──────────────────        ──────────

┌──────────────────┐            ┌─────────────────┐
│  Bot List Page   │  ────→     │  BotViewModel   │  ────→  Backend API
│  (Stateless)     │            │ (ChangeNotifier)│        (via Repository)
│                  │            │                 │
│  • Renders bots  │   ◄────    │ • loadBots()    │   ◄────
│  • Shows loading │   event    │ • _bots list    │  response
│  • Shows errors  │  (user     │ • filtering()   │  (notify)
│  • Search input  │  actions)  │ • _isLoading    │
│                  │            │ • _error        │
└──────────────────┘            │ • notifyListeners
      ▲ Listen                   └─────────────────┘
      │ (Provider.watch)              ▲ Calls
      │                               │ Use cases
      └───────────────────────────────┘
```

#### **ChangeNotifier Pattern Usage**

```dart
// Example: BotViewModel structure
class BotViewModel extends ChangeNotifier {
  // STATE
  final BotRepository _botRepository;
  List<BotModel> _bots = [];
  BotModel? _selectedBot;
  bool _isLoading = false;
  String? _error;

  // GETTERS
  List<BotModel> get bots => _bots;
  BotModel? get selectedBot => _selectedBot;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ACTIONS (mutate state, notify listeners)
  Future<void> loadBots() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _bots = await _botRepository.getAllBots();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteBot(String id) async {
    try {
      await _botRepository.deleteBot(id);
      _bots.removeWhere((bot) => bot.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
```

### 2.3 State Scope Matrix

| State Type         | Scope    | Owner (ViewModel)          | Lifespan                | Access Pattern                                            |
| ------------------ | -------- | -------------------------- | ----------------------- | --------------------------------------------------------- |
| **Authentication** | App-wide | `AuthViewModel`            | App lifetime            | `Provider.of<AuthViewModel>(context)` or `context.read()` |
| **Bot List**       | Feature  | `BotViewModel`             | While on Bots feature   | `Provider.of<BotViewModel>(context)`                      |
| **Bot Selection**  | Page     | `BotViewModel`             | While viewing bots      | Local to `BotsPage`                                       |
| **Create Form**    | Page     | Local state/StatefulWidget | While on create page    | Local `setState()` or mini-ChangeNotifier                 |
| **Theme**          | App-wide | `AppSettingsViewModel`     | App lifetime            | `Provider.of<AppSettingsViewModel>(context)`              |
| **Network Status** | App-wide | `NetworkViewModel`         | App lifetime            | `Provider.of<NetworkViewModel>(context)`                  |
| **Search Query**   | Page     | TextEditingController      | While on page           | Local to page widget                                      |
| **Loading State**  | Feature  | `BotViewModel`             | During async operations | Via `BotViewModel.isLoading`                              |

### 2.4 Provider Setup (Dependency Injection)

#### **Root Widget Setup (main.dart)**

```dart
void main() {
  // Setup service locator
  setupServiceLocator();
  runApp(
    MultiProvider(
      providers: [
        // App-wide providers (created once, survive app lifecycle)
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider<AppSettingsViewModel>(
          create: (_) => AppSettingsViewModel(),
        ),
        ChangeNotifierProvider<NetworkViewModel>(
          create: (_) => NetworkViewModel(),
        ),

        // Feature-level providers (created on demand, disposed when not needed)
        ChangeNotifierProvider<BotViewModel>(
          create: (_) => BotViewModel(
            repository: getIt<BotRepository>(),
          ),
          lazy: false, // Load immediately when needed
        ),
        ChangeNotifierProvider<AgentViewModel>(
          create: (_) => AgentViewModel(
            repository: getIt<AgentRepository>(),
          ),
          lazy: true, // Load on first access
        ),
      ],
      child: const MyApp(),
    ),
  );
}
```

### 2.5 State Access Patterns

#### **Reading State (Display Data)**

```dart
// Pattern 1: watch() - Listen for changes (triggers rebuild on update)
Widget build(BuildContext context) {
  final bots = context.watch<BotViewModel>().bots;
  final isLoading = context.watch<BotViewModel>().isLoading;

  if (isLoading) return LoadingIndicator();
  return ListView(children: bots);
}

// Pattern 2: read() - Access state once without listening (no rebuild)
void navigateToBot(BuildContext context) {
  final bot = context.read<BotViewModel>().selectedBot;
  context.read<NavigationService>().navigateTo('/bots/detail', args: bot);
}

// Pattern 3: Provider.of() - Manual access (older style)
final viewModel = Provider.of<BotViewModel>(context, listen: false);
```

#### **Modifying State (Triggering Actions)**

```dart
// In UI Widget (e.g., button onPressed)
onPressed: () {
  // Access ViewModel and call action method
  context.read<BotViewModel>().deleteBot(botId);

  // Or async operation with loading state
  context.read<BotViewModel>().loadBots();
}
```

### 2.6 State Flow Diagram (Example: Loading Bots)

```
User Action               UI State Update            Data Flow
──────────────            ──────────────            ──────────

1. User Taps              ┌──────────────┐
   "Load Bots"            │ UI Calls:    │
                          │ loadBots()   │
                          └──────┬───────┘
                                 │
2. Loading Starts         ┌──────▼───────┐
                          │ ViewModel    │
                          │ _isLoading   │
                          │ = true       │
                          │notifyListen  │
                          │ers()         │
                          └──────┬───────┘
                                 │
                          ┌──────▼───────┐
                          │UI rebuilds:  │
                          │Shows spinner │
                          └──────┬───────┘
                                 │
3. ViewModel              ┌──────▼───────────────────┐
   Fetches Data           │ repository.getAllBots()  │
   (Async)                │ ├─ HTTP Request          │
                          │ ├─ Parse Response       │
                          │ └─ Return BotModel List │
                          └──────┬───────────────────┘
                                 │
4. Success or Error       ┌──────▼────────┐
                          │ ViewModel:    │
                          │ _isLoading=   │
                          │ false         │
                          │ _bots = data  │
                          │ _error = null │
                          │notifyListen   │
                          │ers()          │
                          └──────┬────────┘
                                 │
5. UI Rebuilds            ┌──────▼──────────────┐
   with Data              │ Shows bot list      │
                          │ (Loading hidden)    │
                          └─────────────────────┘
```

---

## 3. Architecture Overview

### 3.1 Layered Architecture Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                   LAYERED ARCHITECTURE                           │
│                  (Clean Architecture)                            │
└─────────────────────────────────────────────────────────────────┘

╔═════════════════════════════════════════════════════════════════╗
║                  PRESENTATION LAYER (UI)                         ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Views (Stateless Widgets)                                 │  ║
║  │  • BotsList, BotDetails, CreateBot, EditBot              │  ║
║  │  • AgentsList, AgentDetails, CreateAgent, EditAgent      │  ║
║  │  • PromptsList, PromptDetails, CreatePrompt              │  ║
║  │  • KnowledgeList, KnowledgeDetails, NewKnowledge         │  ║
║  │  • LoginPage, RegisterPage, SplashPage                   │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ ViewModels (ChangeNotifier)                               │  ║
║  │  • BotViewModel (manages bot list, details, CRUD)         │  ║
║  │  • AgentViewModel (manages agents state)                  │  ║
║  │  • PromptViewModel (manages prompts state)                │  ║
║  │  • AuthViewModel (manages auth state, token)              │  ║
║  │  • AppSettingsViewModel (theme, language, prefs)          │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Common Widgets & Services                                 │  ║
║  │  • custom_app_bar, custom_text_field, buttons            │  ║
║  │  • navigation_service, api_service                       │  ║
║  │  • route_generator, app_routes                           │  ║
║  └───────────────────────────────────────────────────────────┘  ║
╚═════════════════════════════════════════════════════════════════╝
           △ Calls Use Cases & Services
           │ Displays Data
           │ (Unaware of Data/Domain layers)
           │

╔═════════════════════════════════════════════════════════════════╗
║                  DOMAIN LAYER (Business Rules)                  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Entities (Core Business Objects)                          │  ║
║  │  • BotEntity, AgentEntity, PromptEntity                   │  ║
║  │  • UserEntity, KnowledgeSourceEntity                      │  ║
║  │  • WorkflowEntity, MessageEntity                          │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Repositories (Abstract Interfaces)                        │  ║
║  │  • BotRepository (abstract methods)                       │  ║
║  │  • AgentRepository (abstract methods)                     │  ║
║  │  • AuthRepository (abstract methods)                      │  ║
║  │  • PromptRepository, KnowledgeRepository                  │  ║
║  │  ┌─ Concrete impl comes from Data layer                 │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Use Cases (Application-Specific Business Logic)           │  ║
║  │  • GetAllBotsUseCase → calls BotRepository.getAll()      │  ║
║  │  • CreateBotUseCase → calls BotRepository.create()       │  ║
║  │  • DeleteBotUseCase → calls BotRepository.delete()       │  ║
║  │  • GetAgentUseCase, UpdateAgentUseCase                    │  ║
║  │  • Similar patterns for Prompt, Knowledge, Auth          │  ║
║  │  ┌─ UseCases return Either<Failure, Success>           │  ║
║  │  ┌─ (using dartz package)                               │  ║
║  └───────────────────────────────────────────────────────────┘  ║
╚═════════════════════════════════════════════════════════════════╝
           △ Calls Repositories
           │ (Does not depend on Data layer directly)
           │
           ▼

╔═════════════════════════════════════════════════════════════════╗
║                  DATA LAYER (Implementation)                    ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Data Sources (Abstractions for Data Access)               │  ║
║  │                                                            │  ║
║  │ Remote Data Sources:                                      │  ║
║  │  • BotRemoteDataSource (abstract interface)              │  ║
║  │  • AgentRemoteDataSource                                  │  ║
║  │  • AuthRemoteDataSource                                   │  ║
║  │  ├─ Make HTTP calls to backend APIs                      │  ║
║  │  ├─ Handle serialization/deserialization                │  ║
║  │  └─ Manage request/response transformations             │  ║
║  │                                                            │  ║
║  │ Local Data Sources:                                       │  ║
║  │  • BotLocalDataSource (abstract interface)               │  ║
║  │  • SharedPreferencesDataSource (caching)                │  ║
║  │  ├─ Store/retrieve data from local storage              │  ║
║  │  └─ Manage cache lifecycle                              │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Models (DTOs - Data Transfer Objects)                     │  ║
║  │  • BotModel extends BotEntity                             │  ║
║  │  • AgentModel extends AgentEntity                         │  ║
║  │  • PromptModel, KnowledgeModel, UserModel                │  ║
║  │  ├─ Include toJson/fromJson for serialization           │  ║
║  │  ├─ Extend domain entities                              │  ║
║  │  └─ Framework-specific adaptations                      │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Repositories (Implementations)                            │  ║
║  │  • BotRepositoryImpl implements BotRepository             │  ║
║  │  • AgentRepositoryImpl implements AgentRepository         │  ║
║  │  • AuthRepositoryImpl implements AuthRepository           │  ║
║  │  ┌─ Orchestrate Remote & Local DataSources             │  ║
║  │  ├─ Implement caching logic                            │  ║
║  │  ├─ Handle data transformation (Model → Entity)        │  ║
║  │  └─ Return Either<Failure, Data>                       │  ║
║  └───────────────────────────────────────────────────────────┘  ║
╚═════════════════════════════════════════════════════════════════╝
           △ Calls HTTP/Local APIs
           │
           ▼

╔═════════════════════════════════════════════════════════════════╗
║                  CORE LAYER (Cross-Cutting)                     ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Constants & Configuration                                 │  ║
║  │  • app_constants.dart (API endpoints, timeouts)          │  ║
║  │  • categories.dart (predefined categories)               │  ║
║  │  • languages.dart (supported languages)                  │  ║
║  │  • sample_prompts.dart (example prompts)                 │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Error Handling                                             │  ║
║  │  • Failure abstract class (for Either results)           │  ║
║  │  • ServerFailure, NetworkFailure, ParseFailure           │  ║
║  │  • Custom exception handling & logging                   │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Network Utilities                                          │  ║
║  │  • HTTP client configuration                              │  ║
║  │  • Interceptors for auth headers                          │  ║
║  │  • Request/response logging                              │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Utilities & Helpers                                       │  ║
║  │  • responsive_helper.dart (screen size detection)         │  ║
║  │  • validator.dart (form validation)                       │  ║
║  │  • formatter.dart (date/number formatting)                │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Theme & Styling                                            │  ║
║  │  • theme.dart (Material Design theme)                    │  ║
║  │  • app_radius.dart (border radius constants)              │  ║
║  │  • Consistent colors, typography, spacing               │  ║
║  └───────────────────────────────────────────────────────────┘  ║
║  ┌───────────────────────────────────────────────────────────┐  ║
║  │ Dependency Injection (DI Container)                       │  ║
║  │  • service_locator.dart (get_it setup)                   │  ║
║  │  • Register all instances, singletons                    │  ║
║  │  • Central place for dependency wiring                   │  ║
║  └───────────────────────────────────────────────────────────┘  ║
╚═════════════════════════════════════════════════════════════════╝
           ▲
           │ Uses shared utilities & DI
           │
           └─ Used by all layers

╔═════════════════════════════════════════════════════════════════╗
║                  EXTERNAL LAYER (Outside App)                   ║
║  • Backend APIs (REST/GraphQL endpoints)                       ║
║  • Third-party Services (AI model APIs)                        ║
║  • Local Storage (SharedPreferences, SQLite)                   ║
║  • Device Services (Notifications, Camera, etc.)               ║
╚═════════════════════════════════════════════════════════════════╝
```

### 3.2 Complete Data Flow (End-to-End Example: Load Bots)

```
┌───────────────────────────────────────────────────────────────────┐
│            USER LOADS BOT LIST - COMPLETE DATA FLOW               │
└───────────────────────────────────────────────────────────────────┘

STEP 1: USER ACTION
═══════════════════════════════════════════════════════════════════
UI (BotsList Widget)
    │
    ├─ User taps "Load Bots" button
    ├─ onPressed: () { context.read<BotViewModel>().loadBots(); }
    │
    └─→ BotViewModel.loadBots() [METHOD CALL]


STEP 2: PRESENTATION LAYER - BUSINESS LOGIC
═══════════════════════════════════════════════════════════════════
BotViewModel (ChangeNotifier)
    │
    ├─ State Update: _isLoading = true
    ├─ notifyListeners() → UI rebuilds with loading spinner
    │
    ├─ Call: _botRepository.getAllBots()
    │  (Repository is injected via constructor)
    │
    └─→ [Wait for response]


STEP 3: DOMAIN LAYER - USE CASE LOGIC
═══════════════════════════════════════════════════════════════════
BotRepository (from Domain/Repositories)
    │
    ├─ Intercept call at repository interface
    ├─ (Actual impl in Data layer)
    │
    └─→ BotRepositoryImpl.getAllBots() [DELEGATION]


STEP 4: DATA LAYER - DATA ACCESS
═══════════════════════════════════════════════════════════════════
BotRepositoryImpl (Data/Repositories)
    │
    ├─ Logic: Orchestrate data sources
    ├─ Try: Fetch from local cache first
    │  │   ├─ Check SharedPreferences for cached bots
    │  │   ├─ If found & fresh → Return cached data
    │  │   └─ Else: Proceed to remote
    │  │
    │  └─ Catch: Cache miss or stale
    │
    ├─ Call: _botRemoteDataSource.getAllBots()
    │
    └─→ BotRemoteDataSource.getAllBots() [HTTP REQUEST]


STEP 5: REMOTE DATA SOURCE - HTTP CALL
═══════════════════════════════════════════════════════════════════
BotRemoteDataSource (Data/Datasources/Remote)
    │
    ├─ Prepare HTTP request:
    │  ├─ URL: app_constants.BASE_URL + '/api/bots'
    │  ├─ Method: GET
    │  ├─ Headers: {
    │  │    'Authorization': 'Bearer $token',
    │  │    'Content-Type': 'application/json'
    │  │  }
    │
    ├─ HTTP Call: http.get(url, headers: headers)
    │
    ├─ Response received from Backend API
    │
    └─→ [Parse Response]


STEP 6: RESPONSE PARSING
═══════════════════════════════════════════════════════════════════
BotRemoteDataSource (continued)
    │
    ├─ Check status code
    │
    ├─ If 200 OK:
    │  ├─ Parse JSON: jsonDecode(response.body)
    │  ├─ Map to Models: BotModel.fromJson(botJson)
    │  └─ Return: List<BotModel>
    │
    ├─ Else (4xx/5xx):
    │  ├─ Throw: ServerException('Error: ${response.statusCode}')
    │
    └─→ BotRepositoryImpl (Back to Data layer)


STEP 7: DATA LAYER - CACHING & RETURN
═══════════════════════════════════════════════════════════════════
BotRepositoryImpl (continued)
    │
    ├─ Receive: List<BotModel> from remote
    │
    ├─ Cache to Local:
    │  ├─ Convert models to JSON
    │  └─ Save to SharedPreferences
    │
    ├─ Convert Models to Entities:
    │  └─ List<BotEntity> = models.map((m) => m.toEntity())
    │
    ├─ Return Either:
    │  └─ Right<List<BotEntity>> (Success case)
    │
    └─→ BotViewModel (Back to Presentation)


STEP 8: PRESENTATION LAYER - STATE UPDATE
═══════════════════════════════════════════════════════════════════
BotViewModel (continued)
    │
    ├─ Receive: Right<List<BotEntity>>
    │
    ├─ Extract data & Update state:
    │  ├─ _bots = (response as Right).value
    │  ├─ _isLoading = false
    │  ├─ _error = null
    │
    ├─ Notify Listeners:
    │  └─ notifyListeners()
    │
    └─→ UI Rebuild with new data


STEP 9: UI REBUILD & DISPLAY
═══════════════════════════════════════════════════════════════════
BotsList Widget
    │
    ├─ Rebuild triggered by notifyListeners()
    │
    ├─ Read updated state:
    │  ├─ context.watch<BotViewModel>().bots → List<BotEntity>
    │  ├─ context.watch<BotViewModel>().isLoading → false
    │
    ├─ Conditional rendering:
    │  ├─ If isLoading → Show loading spinner
    │  ├─ Else If error → Show error message
    │  ├─ Else → Build ListView with bot cards
    │
    └─→ User sees bot list on screen

┌───────────────────────────────────────────────────────────────────┐
│ TOTAL FLOW: User Click → ViewModel → Repository → DataSources   │
│             → HTTP API → Parse → Cache → Back through layers    │
│             → State Update → UI Rebuild → Display Data           │
└───────────────────────────────────────────────────────────────────┘
```

### 3.3 Error Handling Flow

```
┌─────────────────────────────────────────────────────────────┐
│            ERROR HANDLING ARCHITECTURE                       │
└─────────────────────────────────────────────────────────────┘

                    ERROR OCCURS
                         │
                         ▼
        ┌────────────────────────────────┐
        │   Identify Error Type          │
        │                                │
        │ 1. Network Error               │
        │    (No internet, timeout)      │
        │                                │
        │ 2. Server Error                │
        │    (5xx response)              │
        │                                │
        │ 3. Client Error                │
        │    (4xx response, validation)  │
        │                                │
        │ 4. Parse Error                 │
        │    (Invalid JSON)              │
        │                                │
        │ 5. Local Error                 │
        │    (Storage, permissions)      │
        └────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │   Create Failure Object        │
        │                                │
        │ • NetworkFailure               │
        │ • ServerFailure                │
        │ • ClientFailure                │
        │ • ParseFailure                 │
        │ • LocalFailure                 │
        └────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │   Return Either Result         │
        │                                │
        │ Left<Failure>                  │
        │  └─ Contains error details     │
        │     (message, type, etc.)      │
        │                                │
        │ OR                             │
        │                                │
        │ Right<Success>                 │
        │  └─ Contains result data       │
        └────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │  ViewModel Handles Result      │
        │                                │
        │ try {                          │
        │   result.fold(                 │
        │     (failure) => {             │
        │       _error = failure.msg     │
        │       notifyListeners()        │
        │     },                         │
        │     (data) => {                │
        │       _data = data             │
        │       _error = null            │
        │       notifyListeners()        │
        │     }                          │
        │   )                            │
        │ } catch (e) { /* fallback */ } │
        └────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │   UI Displays Error Message    │
        │                                │
        │ • Toast notification           │
        │ • Error banner                 │
        │ • Retry button                 │
        │ • Clear user-facing message    │
        └────────────────────────────────┘
```

### 3.4 Key Dependencies Between Layers

```
DEPENDENCY GRAPH

Presentation Layer
    │
    ├─ Depends on: Domain (Use Cases, Entities, Repositories)
    ├─ Depends on: Core (Constants, Utils, Theme, DI)
    ├─ Depends on: Provider (State Management)
    └─ Does NOT depend on: Data layer (abstractions only)

Domain Layer
    │
    ├─ Depends on: Core (for base types, error handling)
    ├─ Depends on: dartz (for Either type)
    └─ Does NOT depend on: Presentation or Data layer

Data Layer
    │
    ├─ Depends on: Domain (implements Repository interfaces)
    ├─ Depends on: Core (Constants, error handling)
    ├─ Depends on: http (for HTTP calls)
    ├─ Depends on: shared_preferences (for caching)
    └─ Does NOT depend on: Presentation layer

Core Layer
    │
    └─ Independent (no other layer dependencies)
```

### 3.5 Feature-Level Architecture (Example: Bot Management)

```
┌─────────────────────────────────────────────────────────────┐
│           BOT FEATURE - COMPLETE ARCHITECTURE               │
└─────────────────────────────────────────────────────────────┘

PRESENTATION LAYER (lib/presentation)
├─ views/bots/
│  ├─ bots_page.dart
│  │  ├─ Displays list of bots
│  │  ├─ Consumes BotViewModel
│  │  └─ Navigates to details/edit/create
│  │
│  ├─ bot_details.dart
│  │  ├─ Shows bot information
│  │  └─ Actions: Edit, Delete, Chat
│  │
│  ├─ create_bot_page.dart
│  │  ├─ Form for new bot
│  │  ├─ Validation logic
│  │  └─ Submit to ViewModel
│  │
│  ├─ edit_bot_page.dart
│  │  ├─ Form with pre-filled data
│  │  └─ Update via ViewModel
│  │
│  └─ widgets/
│     ├─ bot_card.dart
│     ├─ bot_list_item.dart
│     └─ bot_form.dart
│
├─ viewmodels/
│  └─ bot_view_model.dart
│     ├─ Properties: _bots, _selectedBot, _isLoading, _error
│     ├─ Methods: loadBots(), createBot(), updateBot(), deleteBot()
│     ├─ Calls: BotRepository (injected)
│     └─ Notifies: Listeners on state change

DOMAIN LAYER (lib/domain)
├─ entities/
│  └─ bot_entity.dart
│     ├─ Properties: id, name, description, model, prompt, etc.
│     └─ Represents pure business object
│
├─ repositories/
│  └─ bot_repository.dart (INTERFACE)
│     ├─ abstract Future<Either<Failure, List<BotEntity>>> getAll()
│     ├─ abstract Future<Either<Failure, BotEntity>> create(...)
│     ├─ abstract Future<Either<Failure, BotEntity>> update(...)
│     └─ abstract Future<Either<Failure, void>> delete(id)
│
└─ usecases/ (Optional, for complex logic)
   ├─ get_all_bots_usecase.dart
   ├─ create_bot_usecase.dart
   └─ delete_bot_usecase.dart

DATA LAYER (lib/data)
├─ models/
│  └─ bot_model.dart
│     ├─ Extends BotEntity
│     ├─ Methods: fromJson(), toJson()
│     ├─ toEntity() → converts to domain entity
│     └─ Contains framework-specific data handling
│
├─ datasources/
│  ├─ remote/
│  │  ├─ bot_remote_data_source.dart (INTERFACE)
│  │  │  ├─ abstract Future<List<BotModel>> getAllBots()
│  │  │  ├─ abstract Future<BotModel> createBot(...)
│  │  │  └─ Makes HTTP calls to backend
│  │  │
│  │  └─ bot_remote_data_source_impl.dart
│  │     ├─ Implements abstract interface
│  │     ├─ Uses http.Client for API calls
│  │     ├─ Handles response parsing
│  │     └─ Throws ServerException on errors
│  │
│  └─ local/
│     ├─ bot_local_data_source.dart (INTERFACE)
│     │  ├─ abstract Future<void> cacheBots(List<BotModel>)
│     │  ├─ abstract Future<List<BotModel>> getCachedBots()
│     │  └─ For offline storage
│     │
│     └─ bot_local_data_source_impl.dart
│        ├─ Uses SharedPreferences
│        └─ Manages local cache
│
└─ repositories/
   ├─ bot_repository.dart (IMPLEMENTATION)
   │  ├─ Implements domain BotRepository interface
   │  ├─ Injected with:
   │  │  ├─ BotRemoteDataSource
   │  │  ├─ BotLocalDataSource
   │  │  └─ NetworkInfo (connectivity check)
   │  │
   │  ├─ Logic:
   │  │  ├─ If online: Fetch from remote, cache locally
   │  │  ├─ If offline: Return cached data
   │  │  ├─ Transform Model → Entity
   │  │  └─ Wrap result in Either<Failure, Success>
   │  │
   │  └─ Methods:
   │     ├─ Future<Either<Failure, List<BotEntity>>> getAll()
   │     ├─ Future<Either<Failure, BotEntity>> create(...)
   │     └─ (Exception handling with try-catch)

CORE LAYER (lib/core)
├─ constants/
│  └─ app_constants.dart
│     ├─ API_BASE_URL = 'https://api.example.com'
│     ├─ BOT_ENDPOINT = '/api/bots'
│     └─ REQUEST_TIMEOUT_SECONDS = 30
│
├─ errors/
│  ├─ failures.dart
│  │  ├─ abstract class Failure
│  │  ├─ class ServerFailure extends Failure
│  │  ├─ class NetworkFailure extends Failure
│  │  ├─ class ClientFailure extends Failure
│  │  └─ class ParseFailure extends Failure
│  │
│  └─ exceptions.dart
│     ├─ class ServerException
│     ├─ class NetworkException
│     └─ class ParseException
│
└─ network/
   ├─ network_info.dart
   │  └─ abstract bool isConnected() (checks internet)
   │
   └─ http_client_config.dart
      ├─ Configure HTTP client
      ├─ Add auth interceptors
      └─ Setup request/response logging
```

### 3.6 Data Transformation Flow (Model → Entity)

```
JSON from API
    │
    ▼
┌─────────────────────────────────┐
│ HTTP Response Body (String)     │
│                                 │
│ {                               │
│   "id": "1",                    │
│   "name": "Chat Bot",           │
│   "model": "GPT-4",             │
│   ...                           │
│ }                               │
└─────────────────────────────────┘
    │
    │ jsonDecode()
    ▼
┌─────────────────────────────────┐
│ Map<String, dynamic>            │
│                                 │
│ {                               │
│   'id': '1',                    │
│   'name': 'Chat Bot',           │
│   'model': 'GPT-4',             │
│   ...                           │
│ }                               │
└─────────────────────────────────┘
    │
    │ BotModel.fromJson(map)
    ▼
┌─────────────────────────────────┐
│ BotModel (extends BotEntity)    │
│ • All fields typed              │
│ • Validation done               │
│ • Serialization methods ready   │
│ • JSON methods: toJson()        │
│ • Entity method: toEntity()     │
└─────────────────────────────────┘
    │
    │ .toEntity()
    ▼
┌─────────────────────────────────┐
│ BotEntity (Pure Domain Object)  │
│ • Business object               │
│ • No framework dependencies     │
│ • Used in ViewModel & UI        │
│ • Immutable (using equatable)   │
└─────────────────────────────────┘
    │
    │ Passed to ViewModel
    ▼
┌─────────────────────────────────┐
│ BotViewModel                    │
│ • Stores BotEntity list         │
│ • Notifies listeners            │
│ • UI reads from ViewModel       │
└─────────────────────────────────┘
    │
    │ Watched by UI
    ▼
┌─────────────────────────────────┐
│ Bot Card Widget                 │
│ • Receives BotEntity            │
│ • Renders bot information       │
│ • User sees bot data            │
└─────────────────────────────────┘
```

---

## Summary

### 3.7 Architecture Summary Table

| Aspect                   | Technology/Pattern        | Details                                 |
| ------------------------ | ------------------------- | --------------------------------------- |
| **Overall Pattern**      | Clean Architecture + MVVM | Separation of concerns across 4 layers  |
| **State Management**     | Provider (ChangeNotifier) | App-wide & feature-level ViewModels     |
| **Dependency Injection** | get_it                    | Service locator for wiring dependencies |
| **Error Handling**       | Either<Failure, Success>  | Functional error handling with dartz    |
| **API Communication**    | http package              | RESTful API client with custom headers  |
| **Local Storage**        | SharedPreferences         | Key-value caching & user preferences    |
| **Navigation**           | Material Navigation       | RouteGenerator with named routes        |
| **Async Operations**     | Future-based              | Async/await with Provider listeners     |
| **Data Transformation**  | Model → Entity            | DTOs converted to domain entities       |
| **Null Safety**          | Dart null safety          | Full null safety with ? and ! operators |

---

## Document Version

- **Version:** 1.0.0
- **Last Updated:** November 2025
- **Author:** KHTN AI Project Team
- **Status:** Draft - Ready for review and team discussion
