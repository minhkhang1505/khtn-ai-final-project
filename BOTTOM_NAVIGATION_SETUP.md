# Bottom Navigation Bar Setup

## Overview

The app now features a bottom navigation bar with 6 main sections:

1. **Chat** - Chat conversations
2. **Bots** - AI bots management
3. **Agents** - AI agents management
4. **Knowledge** - Knowledge base
5. **Prompts** - Prompt templates
6. **Account** - User profile and settings

## Structure

```
lib/presentation/views/
├── main/
│   └── main_page.dart          # Main container with BottomNavigationBar
├── chat/
│   └── chat_page.dart          # Chat conversations list
├── bots/
│   └── bots_page.dart          # Bots management (grid view)
├── agents/
│   └── agents_page.dart        # Agents management (list view)
├── knowledge/
│   └── knowledge_page.dart     # Knowledge base with categories
├── prompts/
│   └── prompts_page.dart       # Prompt templates library
└── account/
    └── account_page.dart       # User profile and settings
```

## Navigation Flow

```
App Start
    ↓
SplashPage (2 seconds)
    ↓
MainPage (with BottomNavigationBar)
    ├── Tab 0: ChatPage
    ├── Tab 1: BotsPage
    ├── Tab 2: AgentsPage
    ├── Tab 3: KnowledgePage
    ├── Tab 4: PromptsPage
    └── Tab 5: AccountPage
```

## Features by Page

### 1. ChatPage 💬

- List of chat conversations
- Unread message badges
- Floating action button to start new chat
- Card-based UI with avatars

### 2. BotsPage 🤖

- Grid view of AI bots
- Status indicators (Active/Inactive)
- Search functionality
- Floating action button to create new bot

### 3. AgentsPage 🧠

- List view of AI agents
- Efficiency metrics
- Active/Inactive status
- Popup menu for actions (Edit/Delete)
- Extended floating action button

### 4. KnowledgePage 📚

- Statistics cards (Total Items, Categories)
- Expandable category sections
- Nested article lists
- Search and sort functionality

### 5. PromptsPage 📝

- Search bar
- Category filters (chips)
- Prompt cards with ratings
- Bookmark functionality
- Download count display
- Extended floating action button

### 6. AccountPage 👤

- Profile header with gradient
- User statistics (Chats, Bots, Prompts)
- Settings menu items
- Logout functionality
- Version information

## How to Use

### Running the App

```bash
flutter run
```

The app will:

1. Show splash screen (2 seconds)
2. Navigate to MainPage with Chat tab selected
3. Allow navigation between tabs using bottom navigation bar

### Navigating to MainPage Directly

```dart
NavigationService.navigateTo(AppRoutes.main);
```

### Accessing Individual Pages

The pages are integrated into the bottom navigation bar and managed by `MainPage`. They're not directly accessible via routes to maintain the bottom navigation state.

## Customization

### Changing Tab Order

Edit `_pages` list in `main_page.dart`:

```dart
final List<Widget> _pages = const <Widget>[
  ChatPage(),      // Index 0
  BotsPage(),      // Index 1
  AgentsPage(),    // Index 2
  KnowledgePage(), // Index 3
  PromptsPage(),   // Index 4
  AccountPage(),   // Index 5
];
```

### Changing Tab Icons

Edit `items` in the `BottomNavigationBar`:

```dart
BottomNavigationBarItem(
  icon: Icon(Icons.your_icon_outlined),
  activeIcon: Icon(Icons.your_icon),
  label: 'Your Label',
),
```

### Changing Colors

The bottom navigation bar uses theme colors:

- Selected item: `Theme.of(context).colorScheme.primary`
- Unselected items: `Colors.grey`

Customize in `main.dart`:

```dart
theme: ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.yourColor),
),
```

## Adding New Tab

1. **Create the page** (e.g., `settings_page.dart`)
2. **Import it** in `main_page.dart`
3. **Add to \_pages list**:

```dart
final List<Widget> _pages = const <Widget>[
  // ... existing pages
  SettingsPage(), // New page
];
```

4. **Add BottomNavigationBarItem**:

```dart
BottomNavigationBarItem(
  icon: Icon(Icons.settings_outlined),
  activeIcon: Icon(Icons.settings),
  label: 'Settings',
),
```

## Design Patterns

### Chat Page

- **Pattern**: List view with cards
- **Best for**: Conversations, messages, notifications
- **Features**: Badges, timestamps, avatars

### Bots Page

- **Pattern**: Grid view with cards
- **Best for**: Items that benefit from visual representation
- **Features**: Status indicators, compact layout

### Agents Page

- **Pattern**: Detailed list view
- **Best for**: Items needing more information
- **Features**: Metrics, actions menu, rich details

### Knowledge Page

- **Pattern**: Expandable sections
- **Best for**: Hierarchical data
- **Features**: Categories, statistics, nested lists

### Prompts Page

- **Pattern**: Searchable list with filters
- **Best for**: Large collections needing filtering
- **Features**: Search, categories, ratings, bookmarks

### Account Page

- **Pattern**: Profile header + menu list
- **Best for**: User settings and profile
- **Features**: Stats, gradient header, menu items

## State Management

Currently using `setState` for tab switching. For more complex state:

### With Provider:

```dart
class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
```

### With Riverpod:

```dart
final selectedIndexProvider = StateProvider<int>((ref) => 0);
```

## Tips

### Persisting Tab State

To remember the last selected tab:

```dart
// Save on tab change
await SharedPreferences.getInstance()
  .then((prefs) => prefs.setInt('last_tab', index));

// Load on init
final prefs = await SharedPreferences.getInstance();
setState(() {
  _selectedIndex = prefs.getInt('last_tab') ?? 0;
});
```

### Deep Linking to Specific Tab

```dart
// In route_generator.dart
case AppRoutes.main:
  final args = settings.arguments as Map<String, dynamic>?;
  return _buildRoute(
    settings: settings,
    builder: (_) => MainPage(initialIndex: args?['tab'] ?? 0),
  );
```

### Badge Notifications

Use the `badge` package or create custom:

```dart
Stack(
  children: [
    Icon(Icons.chat),
    Positioned(
      right: 0,
      top: 0,
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        constraints: BoxConstraints(
          minWidth: 16,
          minHeight: 16,
        ),
        child: Text(
          '5',
          style: TextStyle(fontSize: 10, color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  ],
)
```

## Troubleshooting

### Bottom Navigation Not Showing

- Ensure `MainPage` is used as the route destination
- Check that Scaffold has `bottomNavigationBar` property

### Tab Not Switching

- Verify `_onItemTapped` is called
- Check `setState` is updating `_selectedIndex`
- Ensure `currentIndex` is set to `_selectedIndex`

### Pages Not Displaying

- Verify all page imports
- Check `_pages` list has correct widgets
- Ensure index matches between `_pages` and `items`

## Future Enhancements

- [ ] Add badge counts for notifications
- [ ] Implement tab state persistence
- [ ] Add smooth tab switching animations
- [ ] Implement nested navigation per tab
- [ ] Add gesture-based tab switching
- [ ] Implement tab-specific FAB actions
- [ ] Add pull-to-refresh on each tab
- [ ] Implement search across all tabs

---

**Version**: 1.0.0  
**Last Updated**: October 19, 2025  
**Status**: ✅ Ready to Use
