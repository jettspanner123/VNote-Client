# VNote Client Architecture Guide

Welcome to the **VNote Client** codebase! This document provides an architectural overview, coding standards, design patterns, and state management details to help AI agents and developers write clean, consistent, and maintainable code in this Flutter repository.

---

## 🏛️ Project Directory Structure

The project follows a feature-oriented and layered architecture under the `lib/` directory:

```text
lib/
├── main.dart                      # App entry point, BLoC configuration, and routing
├── app.dart                       # Root MaterialApp setup
├── constants/                     # Global constants (colors, routes, component sizes)
│   ├── color_factory.dart         # Color definitions and AppColorMode (LIGHT / DARK)
│   ├── component_constants.dart   # Layout padding, margins, font sizes, and validation rules
│   ├── navigation_factory.dart    # App routing constants and screen transition helpers
│   └── ui_factory.dart            # Layout spacing definitions
├── extensions/                    # Extension methods (e.g., String helper extensions)
├── features/                      # UI screens and controllers grouped by feature
│   ├── splash_screen/             # Splash screen entry point
│   ├── landing_screen/            # Launch screen with call-to-actions
│   ├── onboarding_screen/         # Walkthrough pages for new users
│   ├── registration_screen/       # Login/Sign-up Forms
│   ├── home_screen/               # Main navigation shell with sub-tabs (Dashboard, Stats, Card, Profile)
│   ├── lock_screen/               # PIN protection screen
│   └── ...                        # Other feature screens
├── helpers/                       # Helper classes (e.g., NetworkHelper)
├── models/                        # Core data models and DTOs
│   ├── api/                       # API response wrappers & data payloads
│   └── mock/                      # Mock data representations
├── services/                      # App services and external API clients
│   ├── audio_service.dart         # Controls audio feedback
│   ├── mock_data_service.dart     # Generates mock data for widgets
│   └── network_service.dart       # API network calls for authentication, users, etc.
├── store/                         # Global State Management (BLoC files)
│   ├── global_bloc/               # Theme / Color mode BLoC state
│   └── home_scree_controller_bloc/# Active page selector BLoC state
└── utils/                         # Utilities (API, keyboard, UI, and environmental helpers)
    └── ui_helper.dart             # UI styling utility (fonts, status bar, color mapping)
```

---

## 🎨 Architecture & Coding Patterns

### 1. State Management (BLoC Pattern)
We use `flutter_bloc` for state management. 
- **Global States**: Registered in `main.dart`'s `MultiBlocProvider` (e.g., `GlobalColorModeControllerBloc` and `HomeScreenControllerBloc`).
- **Structure**: Each BLoC features three files:
  - `*.bloc.dart`: Standard BLoC implementing event handlers.
  - `*.event.dart`: Distinct events (e.g., `GlobalColorModeChangedToLight`).
  - `*.value.dart`: State representation class (e.g., `GlobalColorModeControllerState`).

*Coding Rule*: For any feature requiring cross-page state sharing or tab switches, use a BLoC in the `lib/store/` directory.

### 2. Navigation & Routing
- Named routes are defined as constants inside [NavigationFactory](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/constants/navigation_factory.dart) and registered inside `main.dart`.
- Page changes can be performed using standard named routes (`Navigator.pushNamed(context, NavigationFactory.lockScreen)`).
- Transition overrides (e.g., instant replacement) are exposed in `NavigationFactory.current.replacePage` or `pushPage`.

### 3. Light & Dark Mode (Theming)
Themes are managed globally through `GlobalColorModeControllerBloc` which yields `AppColorMode.LIGHT` or `AppColorMode.DARK`.
- Components query `context.watch<GlobalColorModeControllerBloc>()` to identify the active mode.
- Color mappings are resolved via [UIHelper](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/utils/ui_helper.dart) (e.g., `UIHelper.current.getBackgroundColorForColorMode(mode)`).
- Text elements that need automatic theme colors should utilize [ColorModeAwareTextComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/text/color_mode_aware_text.dart).

### 4. Typography
- Always use the custom font helper [UIHelper.current.funnelTextStyle](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/utils/ui_helper.dart#L24) or `UIHelper.current.newAmsterdamTextStyle` to build font styling.
- Do not instantiate raw `TextStyle` objects without checking if Google Fonts (`funnelSans` or `newAmsterdam`) is preferred.

### 5. Services & Singletons
Network and audio interactions are structured as singleton services.
- **API Client**: [NetworkService](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/services/network_service.dart) organizes HTTP operations into namespaces like `post.auth` and `get.user`.
- **Mock Data**: [MockDataService](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/services/mock_data_service.dart) supplies fallback data.
- **Audio feedback**: [AudioService](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/services/audio_service.dart) plays application sound effects.

### 6. Interactive Page Layouts (Stack & Positioned)
The main navigation shell ([HomeScreenController](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/features/home_screen/home.controller.dart)) overlays the body pages and custom floating navigation bar inside a `Stack`.
- Body pages must yield list views using [MainPageHolderComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/page/main_page_holder_component.dart).
- `MainPageHolderComponent` utilizes `Positioned.fill` internally, so parent controllers must serve it inside a `Stack` hierarchy.

---

## 🛠️ Developer / AI Agent Guidelines

1. **Avoid Hardcoded Colors**: Always pull colors from [ColorFactory](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/constants/color_factory.dart) or resolve them through `UIHelper`.
2. **Haptic Feedback**: Use `HapticFeedback.lightImpact()` or `HapticFeedback.mediumImpact()` when handling gestures/buttons (standard buttons already support this natively).
3. **Use Shared Components First**: Before writing customized inputs, labels, and buttons, check `.ai/components.md` to see if a matching component exists.
4. **Animated Interactions**: Maintain smooth transitions by wrapping scaling features in `AnimatedScale` or using custom route transitions where necessary.
