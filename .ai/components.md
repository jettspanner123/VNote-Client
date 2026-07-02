# VNote Client Shared Components Directory

This directory catalog outlines all available shared UI components, widgets, and utility view components within VNote App Client. 

Agents and developers must reuse these components to maintain the premium design system, smooth animations, and proper color-mode responsiveness.

---

## 🔘 Buttons

### [StandardButtonComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/buttons/regular_button.dart)
A styled primary button component with a tactile tap scale animation and loading indicator support.
- **Properties**:
  - `required Widget child`: Inner content (usually `StandardButtonText`).
  - `VoidCallback? onTap`: Action when clicked.
  - `bool isLoading`: If `true`, shows a `CupertinoActivityIndicator` instead of the child (default: `false`).
  - `Color backgroundColor`: Background color (default: `Colors.black`).
  - `Color tapBackgroundColor`: Color when held down (default: `ColorFactory.accentColor`).
  - `double borderRadius`: Border corner radius (default: `100`).
  - `bool wantTapAnimation`: Enables tactile shrink animation (default: `true`).
  - `Color loadingStateColor`: Color of loader indicator (default: `Colors.white`).

### [GhostButtonComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/buttons/ghost_button.dart)
A button featuring a blurred frosted-glass styling (`BackdropFilter` with blur `20.0`), ideal for floating panels and overlays.
- **Properties**:
  - `required Widget child`: Content.
  - `VoidCallback? onTap`: Click handler.
  - `double borderRadius`: default `100`.
  - `Color? backgroundColor`: Background override (default: translucent black).

### [OutlineButtonComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/buttons/outline_button.dart)
A transparent button with custom border lines and smooth size animation.
- **Properties**:
  - `required Widget child`: Inner widget.
  - `VoidCallback? onTap`: Action callback.
  - `double borderRadius`: Corner radius (default `100`).
  - `BoxBorder? border`: Custom borders (default is a light thin border).
  - `Color backgroundColor`: default `Colors.transparent`.

### [StandardButtonText](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/buttons/button_text.dart)
Helper text wrapper that standardizes the padding and font style for buttons.
- **Properties**:
  - `required String text`: Labels inside.
  - `double fontSize`: Size (default `ComponentConstants.standardButtonFontSize` / `15.0`).
  - `Color foregroundColor`: Color of text (default `Colors.white`).
  - `EdgeInsetsGeometry padding`: Padding inside standard button boundaries.

### [SlideSuccessionComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/buttons/slide_succession_component.dart)
A specialized "Slide to Confirm" slider button featuring rotating chevron to checkmark icons and spring physics.
- **Properties**:
  - `void Function(Offset confirmedCenter)? onConfirmed`: Triggered when the user slides the thumb to 75%+ of the track.
  - `GlobalKey? thumbKey`: Optional key for the slider thumb.

---

## 📝 Input Fields

### [StandardInputField](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/inputs/standard_input_field.dart)
An input form field pre-styled with consistent border highlights, validation error fields, custom placeholder texts, and focus listener events.
- **Properties**:
  - `required TextEditingController textController`: The input value controller.
  - `String placeholder`: Hint string (default: `"Enter Value."`).
  - `Icon? icon`: Prefix icon.
  - `FormFieldValidator<String>? validator`: Validator logic.
  - `TextInputType keyboardType`: System keyboard popup type.
  - `VoidCallback? onFocus` / `onFocusOut`: Custom focus handlers.
  - `Widget? prefixWidget`: Prepended widget.
  - `List<TextInputFormatter>? inputFormatters`: Text constraints.

### [OtpInputField](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/inputs/otp_input_field.dart)
A single character block input specifically designed for OTP verifications that auto-advances cursor focus to the next field.
- **Properties**:
  - `required TextEditingController textEditingController`: 1-char text controller.
  - `bool autoFocus`: Automatically focuses (default: `false`).
  - `bool wantNextFocus`: Focuses next element upon entering value (default: `true`).
  - `Function(String)? onChange`: Change listener.

### [StandardInputLabelComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/inputs/standard_input_label.dart)
Standardized input titles aligned left with optional secondary text (e.g. details/requirements) aligned right.
- **Properties**:
  - `required String text`: Primary label text.
  - `String? secondaryText`: Secondary instruction text on the right side.

---

## 🗂️ Navigation & Segments

### [SegmentedController](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/segment/segmented_controller.dart)
Custom container-style horizontal tab switcher supporting generic types.
- **Properties**:
  - `required List<SegmentControl<SegmentType>> segments`: List of segment options (value & label pairs).
  - `required SegmentType selected`: Current active value.
  - `required ValueChanged<SegmentType> onSelectionChange`: Switch listener.

---

## 🔤 Typography & Section Headers

### [SectionHeadingComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/text/section_heading_component.dart)
Standard heading for card sections with optional "See More" clickable text.
- **Properties**:
  - `required String text`: Section label text.
  - `String? secondaryButtonText`: Right-aligned secondary action text.
  - `VoidCallback? onSecondaryButtonTap`: Secondary action handler.

### [ColorModeAwareTextComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/text/color_mode_aware_text.dart)
A text component that automatically adapts its color based on the current theme mode.
- **Properties**:
  - `required String text`: Content string.
  - `required TextStyle? style`: Underlying typography styles.
  - `Color lightColor`: Color in Light Mode (default: `Colors.black`).
  - `Color darkColor`: Color in Dark Mode (default: `Colors.white`).

---

## 🖼️ Pages & Layout Wrappers

### [AppbarComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/page/appbar.dart)
The primary header wrapper which aligns action icons and screen headings.
- **Properties**:
  - `required List<Widget> children`: Heading content or trailing icons.
  - `bool? positioned`: Wraps children in a `Positioned(top: 70)` container if `true` (default: `true`).

### [AppbarActionButton](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/page/appbar_action_button.dart)
An interactive icon button inside the app bar that supports scaling animations and expands dynamically into custom popup menus (e.g. settings popups) when clicked.
- **Properties**:
  - `required Widget child`: Default icon or image state.
  - `Widget? expandInto`: Panel widget displayed when expanded.
  - `double? expandHeight` / `expandWidth`: Popup boundaries when expanded.
  - `VoidCallback? onTap`: Action callback.

### [MainPageHolderComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/page/main_page_holder_component.dart)
A generic list view container positioned using `Positioned.fill` constraints. Must be rendered under stack layouts.
- **Properties**:
  - `required List<Widget> children`: Scrollable contents.

### [ApplicationBarBackButtonComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/page/application_bar_back_button.dart)
A round, high-contrast back button with micro-scale click responses that runs `Navigator.pop` by default.

### [ApplicationBarDismissButtonComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/page/application_bar_dismiss_button.dart)
A round, high-contrast close button with micro-scale click responses that runs `Navigator.pop` by default.

---

## 🧩 Shared Complex Views

### [StandardButtonWithDismissKeyboardComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/views/submit_button_with_dismiss_keyboard_button.dart)
A highly optimized submit action panel.
- **Key Features**:
  1. Shows a quick "dismiss keyboard" arrow button alongside the submit button when the input keyboard is up.
  2. Embeds an optional confirmation exit button (`secondaryButtonChild`) that prompts "Want To Exit?" with confirmation sub-options when clicked, preventing accidental progress losses.
- **Properties**:
  - `required Widget child`: Content of main submit button.
  - `VoidCallback? onTap`: Action handler.
  - `Widget? secondaryButtonChild`: Label for cancel button.
  - `VoidCallback? secondaryOnTap`: Confirmation exit handler.
  - `bool isLoading`: Shows loading indicators inside primary button.

### [TransactionDetailSheet](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/others/transaction_detail_sheet.dart)
A highly reusable bottom sheet container designed to display comprehensive details of a mock transaction with theme-aware styling and status badges.
- **Methods**:
  - `static void show(BuildContext context, TransactionMockModel transaction)`: Triggers and shows the modal sheet.
- **Properties**:
  - `required TransactionMockModel transaction`: The transaction model whose details will be displayed.

### [DateRangePickerSheet](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/others/date_range_picker_sheet.dart)
A reusable date range selector center dialog modal designed to gather a starting and ending date with theme-responsive calendar date pickers and side-by-side action buttons.
- **Methods**:
  - `static void show(BuildContext context)`: Triggers and shows the date range dialog.

### [CustomDatePicker](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/components/others/custom_date_picker.dart)
A highly reusable, custom calendar date picker dialog built using a Sunday-first grid. Features custom scale animations, haptic micro-taps, a quick Month & Year navigation panel, and full light/dark theme responsiveness.
- **Methods**:
  - `static Future<DateTime?> show(BuildContext context, {required DateTime initialDate, required DateTime firstDate, required DateTime lastDate})`: Displays the calendar dialog and returns a Future resolving to the selected date or `null` if cancelled.
- **Properties**:
  - `required DateTime initialDate`: The initially selected date.
  - `required DateTime firstDate`: The earliest allowable date in selection grid.
  - `required DateTime lastDate`: The latest allowable date in selection grid.

---

## ⚡ Interactions & Animations

### [OnTapScaleInteractionComponent](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/interaction/tap_scale_interaction.dart)
A layout wrapper widget that scales elements on pointer updates.
- **Properties**:
  - `required Widget child`: Nested widget to animate.
  - `required OnTapScaleInteractionValue config`: Scale animation settings.

### [CircleRevealRouteAnimation](file:///Users/jettspanner123/JavaDevelopment/VNoteApp/VNote-Client/lib/shared/animations/circle_reveal_route_animation.dart)
A custom route transition that opens a new page using a circular clip expansion animation focused around the click trigger origin.
