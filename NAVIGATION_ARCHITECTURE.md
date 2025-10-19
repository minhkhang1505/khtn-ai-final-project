# Navigation System Architecture

## 📊 System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                         main.dart                           │
│                                                               │
│  MaterialApp(                                                │
│    navigatorKey: NavigationService.navigatorKey  ←──────┐   │
│    initialRoute: AppRoutes.splash                       │   │
│    onGenerateRoute: RouteGenerator.generateRoute        │   │
│  )                                                       │   │
└───────────────────────────────────────────┬─────────────┘   │
                                            │                  │
                    ┌───────────────────────┴──────────────┐   │
                    ↓                                      │   │
         ┌──────────────────────┐                          │   │
         │   AppRoutes          │                          │   │
         │   (Route Constants)  │                          │   │
         ├──────────────────────┤                          │   │
         │ - splash             │                          │   │
         │ - home               │                          │   │
         │ - login              │                          │   │
         │ - profile            │                          │   │
         │ - settings           │                          │   │
         │ - details            │                          │   │
         │ - etc...             │                          │   │
         └──────────┬───────────┘                          │   │
                    │                                      │   │
                    ↓                                      │   │
         ┌──────────────────────┐                          │   │
         │  RouteGenerator      │                          │   │
         │  (Route Logic)       │                          │   │
         ├──────────────────────┤                          │   │
         │ generateRoute()      │                          │   │
         │   ↓                  │                          │   │
         │   Switch on route    │                          │   │
         │   name:              │                          │   │
         │   - Create widget    │                          │   │
         │   - Handle args      │                          │   │
         │   - Apply transition │                          │   │
         │   - Return Route     │                          │   │
         └──────────┬───────────┘                          │   │
                    │                                      │   │
                    │                                      │   │
         ┌──────────┴───────────┐                          │   │
         │  Page Widgets        │                          │   │
         ├──────────────────────┤                          │   │
         │ - SplashPage         │                          │   │
         │ - HomePage           │                          │   │
         │ - LoginPage          │                          │   │
         │ - ProfilePage        │                          │   │
         │ - etc...             │                          │   │
         └──────────────────────┘                          │   │
                                                           │   │
                                                           │   │
         ┌─────────────────────────────────────────────────┘   │
         │                                                     │
         ↓                                                     │
┌────────────────────────┐                                     │
│  NavigationService     │←────────────────────────────────────┘
│  (Helper Methods)      │
├────────────────────────┤
│ navigatorKey           │ ← Global key to access Navigator
├────────────────────────┤
│ Navigation Methods:    │
│ - navigateTo()         │
│ - replaceWith()        │
│ - navigateToAndRemove..│
│ - goBack()             │
│ - popUntil()           │
│ - popToRoot()          │
├────────────────────────┤
│ UI Helpers:            │
│ - showSuccess()        │
│ - showError()          │
│ - showWarning()        │
│ - showInfo()           │
│ - showDialogBox()      │
│ - showBottomSheet()    │
└────────────────────────┘
```

## 🔄 Navigation Flow Examples

### Example 1: App Launch Flow

```
App Start
    ↓
main.dart initializes
    ↓
MaterialApp created with initialRoute: AppRoutes.splash
    ↓
RouteGenerator.generateRoute(splash) called
    ↓
SplashPage displayed
    ↓
After 2 seconds...
    ↓
NavigationService.replaceWith(AppRoutes.home)
    ↓
RouteGenerator.generateRoute(home) called
    ↓
HomePage displayed
```

### Example 2: User Navigation Flow

```
User on HomePage
    ↓
Taps "Profile" button
    ↓
NavigationService.navigateTo(AppRoutes.profile)
    ↓
RouteGenerator.generateRoute(profile) called
    ↓
ProfilePage displayed
    ↓
User taps back button
    ↓
NavigationService.goBack()
    ↓
Returns to HomePage
```

### Example 3: Navigation with Arguments

```
User on HomePage
    ↓
Taps "Details" button
    ↓
NavigationService.navigateTo(
  AppRoutes.details,
  arguments: {'id': '123'}
)
    ↓
RouteGenerator.generateRoute(details) called
    ↓
Extract arguments from RouteSettings
    ↓
Create DetailsPage with arguments
    ↓
DetailsPage displayed with data
```

### Example 4: Logout Flow

```
User taps "Logout"
    ↓
ViewModel clears user session
    ↓
NavigationService.navigateToAndRemoveUntil(AppRoutes.login)
    ↓
Clear entire navigation stack
    ↓
LoginPage displayed
    ↓
User cannot go back (stack is empty)
```

## 🗂️ File Structure

```
lib/
├── main.dart                                    # App entry point
└── presentation/
    ├── routes/
    │   ├── app_routes.dart                     # Route constants
    │   ├── route_generator.dart                # Route logic
    │   ├── navigation_examples.dart            # Code examples
    │   └── README.md                           # Full documentation
    ├── services/
    │   └── navigation_service.dart             # Navigation helpers
    └── views/
        ├── splash/
        │   └── splash_page.dart                # Splash screen
        └── home/
            └── home_page.dart                  # Home page
```

## 🎯 Data Flow Diagram

```
┌─────────────────┐
│  User Action    │
│  (Tap button)   │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  Widget/View    │
│  onPressed: () {│
│    Navigation   │
│    Service.     │
│    navigateTo() │
│  }              │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ Navigation      │
│ Service         │
│ (Uses global    │
│  navigator key) │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ MaterialApp     │
│ onGenerateRoute │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ RouteGenerator  │
│ - Check route   │
│ - Get args      │
│ - Build widget  │
│ - Apply trans.  │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│ New Page Widget │
│ Displayed       │
└─────────────────┘
```

## 🔐 Type Safety Flow

```
Developer writes:
NavigationService.navigateTo(AppRoutes.profile)
                                       ↑
                                       │
                              Uses constant from
                              AppRoutes class
                                       ↓
                           IDE provides autocomplete
                           and type checking
                                       ↓
                           Cannot use invalid
                           route names
                                       ↓
                           Compile-time safety ✅
```

## 🎨 Custom Transition Flow

```
Route registered with transition:
RouteGenerator.generateRoute() {
  case AppRoutes.profile:
    return _buildRoute(
      builder: (_) => ProfilePage(),
      transition: RouteTransition.fade,  ← Specify here
    );
}
    ↓
_buildRoute() checks transition type
    ↓
Switch on RouteTransition enum
    ↓
Call appropriate transition builder:
- _fadeRoute()
- _slideRoute()
- _scaleRoute()
- MaterialPageRoute (default)
    ↓
PageRouteBuilder with custom animation
    ↓
Smooth animated transition ✨
```

## 📱 ViewModel Integration

```
┌──────────────────┐
│   View           │
│   (Listens to    │
│    ViewModel)    │
└────────┬─────────┘
         │
         ↓
┌──────────────────┐
│   ViewModel      │
│   (Business      │
│    Logic)        │
├──────────────────┤
│ onLoginSuccess() │
│   {              │
│     // No need   │
│     // BuildCtx! │
│     Navigation   │
│     Service.     │
│     navigateTo() │
│   }              │
└────────┬─────────┘
         │
         ↓
┌──────────────────┐
│ NavigationService│
│ (Has global key) │
└────────┬─────────┘
         │
         ↓
┌──────────────────┐
│ Navigation       │
│ Happens!         │
└──────────────────┘
```

## 🚨 Error Handling Flow

```
User navigates to undefined route
    ↓
RouteGenerator.generateRoute() called
    ↓
Switch statement has no matching case
    ↓
Falls through to default case
    ↓
_errorRoute() called
    ↓
Error page displayed with:
- Error icon
- "Route Not Found" message
- Route name that was attempted
- "Go Home" button
```

## 🎓 Learning Path

```
1. Start Here
   ↓
   Read NAVIGATION_SETUP.md (this file)

2. Understand Concepts
   ↓
   Read lib/presentation/routes/README.md

3. See Examples
   ↓
   Check lib/presentation/routes/navigation_examples.dart

4. Run the App
   ↓
   flutter run
   Try the demo on HomePage

5. Add Your First Route
   ↓
   Follow the "Adding New Routes" guide

6. Integrate with Your Features
   ↓
   Use NavigationService in your ViewModels

7. Advanced Usage
   ↓
   Custom transitions, type-safe arguments, etc.
```

---

**This architecture provides:**

- ✅ Clean separation of concerns
- ✅ Type safety
- ✅ Easy testing
- ✅ Scalability
- ✅ Maintainability
- ✅ Developer-friendly
- ✅ Production-ready
