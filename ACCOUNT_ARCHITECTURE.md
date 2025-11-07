# Account Page Architecture

## Component Hierarchy

```
AccountPage (StatefulWidget)
  └── Scaffold
        ├── AppBar
        │   └── AccountHeader
        │       └── User Profile (avatar, name, email)
        │
        └── Body (SingleChildScrollView)
              └── Column
                    ├── UpgradeBanner (conditional)
                    │   └── Dismissible upgrade promotion
                    │
                    ├── SubscriptionSection
                    │   ├── Current plan info
                    │   └── Upgrade buttons
                    │
                    ├── AppearanceSection
                    │   └── Dark mode toggle
                    │
                    ├── AccountActionsSection
                    │   └── Logout button
                    │
                    └── AccountFooter
                        └── App version
```

## State Management Flow

```
_AccountPageState
    │
    ├── _showUpgradeBanner (bool)
    │   └── Controls visibility of UpgradeBanner
    │
    └── Callback Methods:
        ├── _dismissUpgradeBanner() → setState(_showUpgradeBanner = false)
        ├── _showUpgradeDialog() → showDialog(UpgradeDialog)
        ├── _onUpgradeConfirmed() → TODO: Upgrade logic
        ├── _onThemeChanged() → TODO: Theme change logic
        └── _onLogout() → TODO: Logout logic
```

## Data Flow

```
Constants (account_constants.dart)
    ├── avatarSize (48.0)
    ├── freePlan (SubscriptionPlan)
    ├── proPlan (SubscriptionPlan)
    └── appVersion ('1.0.0')
         │
         └─→ Used by widgets via imports

Models (account_models.dart)
    ├── User
    ├── Geo
    ├── PlanFeature
    └── SubscriptionPlan
         │
         └─→ Passed as props to widgets
```

## Reusability Examples

### Example 1: Use UpgradeBanner elsewhere

```dart
UpgradeBanner(
  onDismiss: () { /* handle dismiss */ },
  onTap: () { /* handle tap */ },
)
```

### Example 2: Use AppearanceSection in settings page

```dart
AppearanceSection(
  isDarkMode: isDarkMode,
  onThemeChanged: (value) { /* handle change */ },
)
```

### Example 3: Reuse SubscriptionPlan data

```dart
final myPlanFeatures = proPlan.features;
myPlanFeatures.forEach((feature) {
  print('${feature.title}: ${feature.description}');
});
```

## Size Reduction

| Metric          | Before        | After    | Reduction              |
| --------------- | ------------- | -------- | ---------------------- |
| Main file       | 470 lines     | 85 lines | **81.9%**              |
| Total files     | 1             | 12       | Better organization    |
| Avg file size   | 470           | 60       | Smaller, focused files |
| Duplicated code | Yes (dialogs) | No       | 100% eliminated        |

## Import Map

```
account_page.dart
    ├── → account_models.dart (User, Geo, SubscriptionPlan)
    ├── → account_constants.dart (freePlan, proPlan, appVersion)
    └── → widgets.dart (barrel export)
             ├── → account_header.dart
             ├── → upgrade_banner.dart
             ├── → subscription_section.dart
             ├── → upgrade_dialog.dart
             ├── → appearance_section.dart
             ├── → account_actions_section.dart
             ├── → account_footer.dart
             └── → account_section_container.dart
```

## Extension Points

These are the cleanest places to add new features:

1. **New Setting**: Create widget in `widgets/` + add to main page Column
2. **New Plan Feature**: Edit `proPlan.features` in `account_constants.dart`
3. **New User Property**: Add to `User` model in `account_models.dart`
4. **Styling Change**: Update shared widgets (`AccountSectionContainer`, etc.)
