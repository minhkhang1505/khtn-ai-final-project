# KHTN AI Final Project

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.9.2-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.9.2-blue?logo=dart)
![Version](https://img.shields.io/badge/Version-1.0.0-green)
<!-- ![License](https://img.shields.io/badge/License-MIT-brightgreen) -->

**A comprehensive AI-powered multi-agent platform for workflow automation and intelligent bot management built with Flutter.**

</div>

---

## Table of Contents

- [Project Title & Description](#-project-title--description)
- [Features](#-features)
- [Team Members](#-team-members)
- [Screenshots & Demo](#-screenshots--demo)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Installation & Setup](#-installation--setup)
- [Architecture Overview](#-architecture-overview)

---

## Project Title & Description

### KHTN AI Final Project

An intelligent, enterprise-grade Flutter application designed to streamline workflow automation and AI agent management. The platform empowers users to create, manage, and orchestrate multiple AI agents, leverage pre-built workflows, configure knowledge sources, and generate intelligent prompts—all within a clean, intuitive mobile interface.

**Purpose:** To provide a unified platform for managing complex AI-driven workflows, enabling seamless collaboration between human users and intelligent bots through a modern, responsive mobile application.

**Target Users:** Developers, AI researchers, enterprise teams, and business users who need to orchestrate AI workflows without deep technical expertise.

---

## ✨ Features

- **Multi-Agent Management**

  - Create, edit, and delete AI agents with custom configurations
  - Assign agents to specific bots and workflows
  - Real-time agent status monitoring

- **Bot Management**

  - Design and manage intelligent bots with customizable behaviors
  - Configure bot responses and interaction patterns
  - Search and filter bots by category and functionality

- **Workflow Automation**

  - Build complex workflows with sequential and conditional steps
  - Visual workflow editor for intuitive design
  - Track workflow execution and performance metrics

- **Knowledge Management**

  - Support for multiple knowledge source types (documents, APIs, databases)
  - Upload and manage knowledge bases
  - Semantic search across knowledge sources

- **Prompt Engineering**

  - Create and manage AI prompts for different use cases
  - Template-based prompt generation
  - Version control for prompt iterations

- **Chat Interface**

  - Real-time chat with bots and agents
  - Message history and context management
  - Rich media support (text, images, documents)

- **User Account Management**

  - Secure authentication and authorization
  - User profile customization
  - Appearance settings and preferences

- **Responsive Design**
  - Fully responsive UI that adapts to multiple screen sizes
  - Dark mode and light mode support
  - Accessible interface for all user types

---

## Team Members

- **Nguyen Minh Khang**

  - GitHub: [@minhkhang1505](https://github.com/minhkhang1505)
  - Email: minhkhang.dev@gmail.com

- **Do Thai Hoc**
  - GitHub: [@hocvn](https://github.com/hocvn)
  - Email: minhkhang.dev@gmail.com

---

## Screenshots & Demo

### Demo (YouTube)

<a href="https://youtu.be/3AQxvRG4u5E" target="_blank">
  <img src="https://img.shields.io/badge/Watch%20Demo-YouTube-red?logo=youtube" alt="Watch Demo">
</a>

---

## Currently Used Tech Stack

### Frontend Framework

- **Flutter** (stable channel) - Cross-platform mobile development framework
- **Dart** (^3.9.2) - Modern, statically-typed programming language

### State Management & Dependency Injection

- **Provider** (^6.1.5+1) - ChangeNotifier-based reactive state management
<!-- - **get_it** (^7.7.0) - Service locator for dependency injection -->

### Networking & API Integration

<!-- - **http** (^1.2.2) - HTTP client for RESTful API communication -->

- **google_fonts** (^6.3.2) - Google Fonts integration

<!-- ### Local Storage & Persistence

- **shared_preferences** (^2.3.2) - Key-value storage for app preferences

### Connectivity & Networking Utils

- **internet_connection_checker_plus** (^2.5.2) - Network connectivity detection

### Functional Programming

- **dartz** (^0.10.1) - Functional programming tools (Either, Tasks)
- **equatable** (^2.0.5) - Simplified equality comparison -->

### UI Components & Widgets

- **flutter_svg** (^2.0.10+1) - SVG rendering support
- **cupertino_icons** (^1.0.8) - iOS-style icons
- **pinput** (^5.0.2) - PIN/OTP input widgets
- **flutter_pin_code_widget** (^0.1.2) - PIN code input
- **flutter_otp_text_field** (^1.5.1+1) - OTP text field
- **flutter_typeahead** (^5.2.0) - Autocomplete/typeahead search
- **flutter_chat_bubble** (^2.0.2) - Chat bubble widget

### File & Data Handling

- **file_picker** (^10.3.3) - File selection and upload

<!-- ### Development & Linting

- **flutter_lints** (^5.0.0) - Recommended linting rules for Flutter -->

---

## Project Structure

```
lib/
├── core/                          # Cross-cutting concerns
│   ├── constants/                 # App-wide constants
│   ├── theme/                     # App theming and styling
│   ├── utils/                     # Utility functions
│   ├── errors/                    # Error handling
│   ├── network/                   # Network utilities
│   └── di/                        # Dependency injection setup
│
├── data/                          # Data layer (implementation)
│   ├── datasources/               # Data access (remote/local)
│   │   ├── local/                 # Local data sources (e.g., cache, sqlite)
│   │   └── remote/                # Remote data sources (API clients, network)
│   ├── models/                    # DTOs, serializers and mappers
│   │   ├── agent_model.dart       # Data transfer object for Agent
│   │   ├── bot_model.dart         # DTO for Bot
│   │   ├── knowledge_model.dart   # DTO for Knowledge source
│   │   ├── message_model.dart     # DTO for Chat messages
│   │   ├── prompt_model.dart      # DTO for Prompt objects
│   │   ├── workflow_model.dart    # DTO for Workflow
│   │   └── workflow_step_model.dart # DTO for Workflow steps
│   └── repositories/              # Repository implementations (data -> domain)
│       ├── agent_repository_impl.dart
│       ├── bot_repository_impl.dart
│       ├── knowledge_repository_impl.dart
│       └── chat_repository_impl.dart
│
├── domain/                        # Domain layer (business rules)
│   ├── entities/                  # Core business objects (pure models)
│   │   ├── agent.dart             # Agent entity (id, name, config)
│   │   ├── bot.dart               # Bot entity
│   │   ├── message.dart           # Message entity used in domain logic
│   │   └── prompt.dart            # Prompt entity
│   ├── models/                    # Domain-specific models / enums
│   │   └── knowledge_source_type.dart
│   ├── repositories/              # Repository interfaces (contracts)
│   │   ├── agent_repository.dart  # Interface: AgentRepository
│   │   ├── bot_repository.dart    # Interface: BotRepository
│   │   ├── knowledge_repository.dart
│   │   └── chat_repository.dart
│   └── usecases/                  # Application business logic (use-cases)
│       ├── agent/
│       │   ├── get_agents.dart
│       │   ├── get_agent_by_id.dart
│       │   ├── create_agent.dart
│       │   └── update_agent.dart
│       ├── bot/
│       │   ├── get_bots.dart
│       │   ├── create_bot.dart
│       │   └── update_bot.dart
│       ├── knowledge/
│       │   ├── upload_knowledge.dart
│       │   └── search_knowledge.dart
│       └── chat/
│           ├── send_message.dart
│           └── get_chat_history.dart
│
├── presentation/                  # Presentation layer (MVVM)
│   ├── routes/                    # Navigation & routing
│   ├── services/                  # UI services
│   ├── viewmodels/                # ViewModels (ChangeNotifier)
│   └── views/                     # UI screens by feature
│       ├── account/               # Account & settings screens
│       ├── agents/                # Agent management screens
│       ├── auth/                  # Authentication screens
│       ├── bots/                  # Bot management screens
│       ├── chat/                  # Chat interface screens
│       ├── knowledge/             # Knowledge management screens
│       ├── main/                  # Main/home screens
│       ├── prompts/               # Prompt management screens
│       └── splash/                # Splash screen
│
└── main.dart                      # App entry point
```

### Notes:
- Removed detailed widget files to focus on repositories, models, viewmodels, and views.
- The `lib/` directory is organized to follow Clean Architecture principles, ensuring scalability and maintainability.
- Each layer (core, data, domain, presentation) has a specific responsibility, making the codebase modular and testable.

---

## Installation & Setup

### Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.9.2 or compatible) - [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Dart SDK** (^3.9.2) - Included with Flutter
- **Xcode** (for iOS development) - macOS only
- **Android Studio** (for Android development)
- **Git** - For version control
- **VS Code** or **Android Studio** - Recommended IDE

### Step 1: Clone the Repository

```bash
git clone https://github.com/minhkhang1505/khtn-ai-final-project.git
cd khtn-ai-final-project
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

This command downloads and installs all required packages listed in `pubspec.yaml`.

### Step 3: Set Up Flutter Environment (Optional)

Verify your Flutter installation:

```bash
flutter doctor
```

Resolve any issues indicated by the doctor output.

### Step 4: Configure Target Platforms

#### For iOS:

```bash
cd ios
pod install
cd ..
```

#### For Android:

No additional setup needed if Android Studio is properly configured.

### Step 5: Run the Application

**On a connected device or emulator:**

```bash
flutter run
```

**On a specific device:**

```bash
flutter devices                    # List available devices
flutter run -d <device_id>         # Run on specific device
```

**In release mode (optimized):**

```bash
flutter run --release
```

### Step 6: Verify Installation

After running the app, verify the following screens appear correctly:

- [ ] Splash screen displays
- [ ] Authentication screens load
- [ ] Main dashboard appears
- [ ] Navigation between features works

---



<!-- ### Application Screens

| Screen               | Description                                           |
| -------------------- | ----------------------------------------------------- |
| **Splash Screen**    | Initial app loading screen with branding              |
| **Authentication**   | Login and registration flows with validation          |
| **Dashboard**        | Main hub showing bots, agents, prompts, and knowledge |
| **Agent Management** | Create, edit, and manage AI agents                    |
| **Bot Management**   | Bot creation, configuration, and monitoring           |
| **Workflow Builder** | Visual workflow design and automation                 |
| **Chat Interface**   | Real-time conversation with bots                      |
| **Knowledge Base**   | Upload and manage knowledge sources                   |
| **Account Settings** | User profile and app preferences                      |

### Demo Features

- **Real-time Chat:** Interact with configured bots in real-time
- **Drag-and-Drop Workflows:** Intuitive workflow creation (if implemented)
- **Dark Mode Toggle:** Theme switching for user preference
- **Responsive Design:** Seamless experience on phones and tablets

_Note: Actual screenshots to be added in a future update. For now, build and run the app to see the current UI._ -->

<!-- --- -->

<!-- ## API Reference

### Base Configuration

- **Base URL:** Configured in `services/api_service.dart`
- **Authentication:** Token-based (details to be documented)
- **Content Type:** JSON

### Main Endpoints (Placeholder)

#### Agents

- `GET /api/agents` - Retrieve all agents
- `POST /api/agents` - Create new agent
- `PUT /api/agents/{id}` - Update agent
- `DELETE /api/agents/{id}` - Delete agent

#### Bots

- `GET /api/bots` - Retrieve all bots
- `POST /api/bots` - Create new bot
- `PUT /api/bots/{id}` - Update bot
- `DELETE /api/bots/{id}` - Delete bot

#### Workflows

- `GET /api/workflows` - Retrieve workflows
- `POST /api/workflows` - Create workflow
- `PUT /api/workflows/{id}` - Update workflow
- `DELETE /api/workflows/{id}` - Delete workflow

#### Knowledge

- `GET /api/knowledge` - List knowledge sources
- `POST /api/knowledge` - Upload knowledge
- `DELETE /api/knowledge/{id}` - Delete knowledge source

#### Prompts

- `GET /api/prompts` - Retrieve prompts
- `POST /api/prompts` - Create prompt
- `PUT /api/prompts/{id}` - Update prompt
- `DELETE /api/prompts/{id}` - Delete prompt

#### Chat

- `POST /api/chat/send` - Send message
- `GET /api/chat/history/{botId}` - Retrieve chat history
- `WS /api/chat/ws` - WebSocket connection (if real-time supported)

_Note: Detailed API documentation with request/response examples to follow. See `services/api_service.dart` for actual implementation._ -->

---

## Architecture Overview

### Clean Architecture + MVVM Pattern

This project combines **Clean Architecture** principles with **MVVM** (Model-View-ViewModel) on the presentation layer.

#### Layer Responsibilities

```
┌─────────────────────────────────┐
│     Presentation (MVVM)         │  ← UI Layer
│ Views → ViewModels → State      │
└──────────────┬──────────────────┘
               ↓
┌──────────────────────────────────┐
│     Domain (Business Rules)      │  ← Core Logic
│ Entities → Repositories → UseCases│
└──────────────┬───────────────────┘
               ↓
┌──────────────────────────────────┐
│     Data (Implementation)        │  ← Data Sources
│ Models → DataSources → Repos     │
└──────────────┬───────────────────┘
               ↓
     ┌─────────────────┐
     │  External APIs  │  ← External Services
     │  Local Storage  │
     └─────────────────┘
```

<!-- #### Layer Details

**Domain Layer**

- Contains pure business logic independent of frameworks
- Defines entities (core business objects) and repository contracts
- Implements use cases for specific business operations
- No dependencies on other layers

**Data Layer**

- Implements repository interfaces from domain layer
- Contains models (DTOs) for data transformation
- Manages data sources (remote APIs, local storage)
- Orchestrates data retrieval and caching

**Presentation Layer**

- Organizes UI using MVVM pattern
- **Views:** Simple UI screens with minimal logic
- **ViewModels:** Business logic for UI, state management with ChangeNotifier
- **State:** Optional actions/reducers for explicit state transitions
- **Common:** Shared widgets and styling utilities
- **Services:** Navigation, toasts, and other UI services
- **Routes:** Centralized navigation configuration

**Core Layer**

- Cross-cutting concerns (errors, utilities, constants)
- Network configuration and utilities
- Theme management
- Dependency injection setup

#### Benefits

 - **Testability:** Each layer can be tested independently
 - **Maintainability:** Clear separation of concerns
 - **Scalability:** Easy to add new features without affecting existing code
 - **Reusability:** Domain logic is framework-agnostic
 - **Flexibility:** Can swap implementations (data sources, UI frameworks) -->

<!-- ---

## How to Add a New Feature

### Example: Adding a "Reports" Feature

#### Step 1: Domain Layer

Create business logic and entities:

```
domain/
├── entities/
│   └── report_entity.dart
├── repositories/
│   └── report_repository.dart (interface)
└── usecases/
    ├── get_reports.dart
    ├── create_report.dart
    └── export_report.dart
```

#### Step 2: Data Layer

Implement data access:

```
data/
├── models/
│   └── report_model.dart
├── datasources/
│   └── remote/
│       └── report_remote_data_source.dart
└── repositories/
    └── report_repository_impl.dart
```

#### Step 3: Presentation Layer

Build the UI:

```
presentation/
├── views/
│   └── reports/
│       ├── reports_page.dart
│       ├── report_detail_page.dart
│       └── widgets/
│           ├── report_card.dart
│           └── report_filters.dart
├── viewmodels/
│   └── report_view_model.dart
├── state/
│   └── reports/
│       ├── report_actions.dart
│       ├── report_reducer.dart
│       └── report_state.dart (optional)
└── routes/
    └── Update app_routes.dart with report routes
```

#### Step 4: Dependency Injection

Register in DI container:

```dart
// di/service_locator.dart
getIt.registerSingleton<ReportRemoteDataSource>(
  ReportRemoteDataSourceImpl(getIt<http.Client>()),
);

getIt.registerSingleton<ReportRepository>(
  ReportRepositoryImpl(getIt<ReportRemoteDataSource>()),
);

getIt.registerSingleton<GetReportsUseCase>(
  GetReportsUseCase(getIt<ReportRepository>()),
);

getIt.registerSingleton<ReportViewModel>(
  ReportViewModel(getIt<GetReportsUseCase>()),
);
```

#### Step 5: Navigation Setup

Add route in `routes/app_routes.dart`:

```dart
static const String reports = '/reports';
static const String reportDetail = '/reports/:id';
```

Update `routes/route_generator.dart` with route generation logic. -->

<!-- #### Step 6: Testing

Add unit tests for each layer:

```
test/
├── domain/
│   └── usecases/
│       └── get_reports_test.dart
├── data/
│   └── repositories/
│       └── report_repository_test.dart
└── presentation/
    └── viewmodels/
        └── report_view_model_test.dart
``` -->

<!-- #### Best Practices

- ✅ Keep layers independent and testable
- ✅ Use meaningful entity and model names
- ✅ Document complex business logic
- ✅ Add unit tests before UI implementation
- ✅ Follow existing code style and patterns
- ✅ Use Either type from dartz for error handling

---

## Contributing

We welcome contributions from the community! Follow these guidelines to contribute effectively.

### Getting Started

1. **Fork the Repository**

   ```bash
   # Click "Fork" on GitHub
   ```

2. **Clone Your Fork**

   ```bash
   git clone https://github.com/<your-username>/khtn-ai-final-project.git
   cd khtn-ai-final-project
   ```

3. **Add Upstream Remote**
   ```bash
   git remote add upstream https://github.com/minhkhang1505/khtn-ai-final-project.git
   ```

### Development Workflow

1. **Create a Feature Branch**

   ```bash
   git checkout -b feat/your-feature-name
   ```

2. **Make Your Changes**

   - Follow the architecture guidelines
   - Write clean, documented code
   - Add unit tests for new logic

3. **Run Tests & Linting**

   ```bash
   flutter analyze
   flutter test
   flutter pub get
   ```

4. **Commit with Conventional Commits**

   ```bash
   git commit -m "feat(feature-name): add new functionality"
   ```

   **Commit Types:**

   - `feat` - New feature
   - `fix` - Bug fix
   - `docs` - Documentation changes
   - `style` - Code style changes (no logic change)
   - `refactor` - Code refactoring
   - `perf` - Performance improvements
   - `test` - Adding or updating tests
   - `chore` - Build/tooling changes
   - `ci` - CI/CD changes -->

<!-- 5. **Push to Your Fork**

   ```bash
   git push origin feat/your-feature-name
   ```

6. **Create a Pull Request**
   - Go to the original repository
   - Click "New Pull Request"
   - Compare your branch with `main` or `name-of-milestone`
   - Provide a clear description of your changes

### Pull Request Guidelines

- **Title:** Follow conventional commits format
- **Description:** Clearly explain what and why
- **Screenshots:** Include UI changes or new features
- **Tests:** Ensure all tests pass locally
- **Linked Issues:** Reference related issues using `#issue-number`

### Coding Standards

- **Follow Dart Style Guide:** Use `dart format`
- **Enable Linting:** Adhere to `analysis_options.yaml`
- **Layer Separation:** Keep domain/data/presentation layers distinct
- **Error Handling:** Use Either types from dartz for error management
- **Comments:** Document complex logic with clear comments
- **Naming:** Use descriptive, readable names for variables and functions

--- -->

<!-- ## License

This project is licensed under the **MIT License** - see below for details.

### MIT License

```
MIT License

Copyright (c) 2025 KHTN AI Final Project Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

You are free to use, modify, and distribute this software for commercial and non-commercial purposes.

--- -->



<!-- ## Acknowledgements

### Libraries & Frameworks

- **Flutter & Dart Team** - For the excellent mobile development framework
- **Provider** - Clean and simple state management solution
- **Dartz** - Functional programming in Dart
- **Google Fonts** - Beautiful typography

### Icons & Design

- **Material Design** - UI design principles and components
- **Cupertino Icons** - iOS-style icon set
- **Flutter SVG** - SVG rendering capabilities

### Community & Inspiration

- **Clean Architecture** principles by Robert C. Martin
- **MVVM** pattern best practices from the Flutter community
- **Open Source Community** - For inspiration and collaboration

### Special Thanks

- HCMUS Advanced Mobile Development Course instructors and peers
- All contributors and issue reporters
- The Flutter and Dart communities for continuous support
