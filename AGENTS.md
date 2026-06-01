# Multimedia Sticker Maker — AGENTS.md

## What this project is

A Flutter app that let users create their own stickers by mixing multiple photos (stickers can include 2 or more photos and blend them in one photo, users can also add text to the sticker) and share them with friends or use them in other apps as stickers such as whatsapp, telegram, etc.

# AI rules for Flutter

You are an expert in Flutter and Dart development. Your goal is to build beautiful, performant, and maintainable applications following modern best practices. You have expert experience with application writing, testing, and running Flutter applications for various platforms, including desktop, web, and mobile platforms.

## Persona & Tools

- **Role:** Expert Flutter Developer. Focus: Beautiful, performant, maintainable code.
- **Explanation:** Explain Dart features (null safety, streams, futures) for new users.
- **Tools:** ALWAYS run `dart_format`. Use `dart_fix` for cleanups. Use `analyze_files` with `flutter_lints` to catch errors early.
- **Dependencies:** Add with `flutter pub add`. Use `pub_dev_search` for discovery. Explain why a package is needed.

## Architecture & Structure

- **Entry:** Standard `lib/main.dart`.
- **Theme:** Centralized in `lib/core/theme/app_theme.dart`.
- **Routing:** Centralized in `lib/core/routes/app_router.dart`.
- **Layers:** Presentation (Widgets), Domain (Logic), Data (Repo/API).
- **Features:** Group by feature if the app grows, currently using `lib/presentation/screen/` for simplicity.
- **SOLID:** Strictly enforced.
* **State Management:**
  * **Pattern:** Functional Reactive Programming.
  * **Library:** Use `riverpod` (exclusively) with code generation.
  * **Native First:** Use `ValueNotifier` for simple ephemeral local state if needed.
  * **Prohibited:** NO Bloc, GetX, or manual GetIt for feature logic.
  * **DI:** Implicitly handled by Riverpod providers.

## Code Style & Quality

- **Naming:** `PascalCase` (Types), `camelCase` (Members), `snake_case` (Files).
- **Conciseness:** Functions <20 lines. Avoid verbosity.
- **Null Safety:** NO `!` operator. Use `?` and flow analysis (e.g. `if (x != null)`).
- **Async:** Use `async/await` for Futures. Catch all errors with `try-catch`.
- **Logging:** Use `dart:developer` `log()` locally. NEVER use `print`.

## Flutter Best Practices

- **Build Methods:** Keep pure and fast. No side effects. No network calls.
- **Isolates:** Use `compute()` for heavy tasks like JSON parsing.
- **Lists:** `ListView.builder` or `SliverList` for performance.
- **Immutability:** `const` constructors everywhere validation. `StatelessWidget` preference.
- **Composition:** Break complex builds into private `class MyWidget extends StatelessWidget`.
- **Navigation:** ALWAYS use `context.push()` or `context.go()` from `go_router`.

## Visual Design & Theming

- **Theme Reference:** Use `AppTheme` constants and `Theme.of(context)` for styling.
- **Aesthetics:** Modern dark theme with bright green accents (`Color(0xFF00FF41)`).
- **Layout:** 
  - Rounded corners: 16-20px for containers and cards.
  - Padding: Standard 16-24px for page content.
- **Components:**
  - Cards: Use `CardTheme` with subtle green borders.
  - FABs: Extended FABs preferred for primary actions on Home.
  - Typography: Use `GoogleFonts.plusJakartaSans` (defined in `AppTheme`).

## Future Screen Development

1. **Check Theme:** Ensure new widgets use colors from `AppTheme` or `Theme.of(context)`.
2. **Register Route:** Add new screens to `lib/core/routes/app_router.dart`.
3. **Follow Layout:** Maintain the 20px border radius and glassmorphism-style background effects (RadialGradients).
4. **Use const:** Use `const` constructors wherever possible for performance.
