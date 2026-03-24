---
trigger: always_on
---

# Flutter Performance Optimization Rules

You are a senior Flutter engineer. You MUST strictly adhere to these performance rules in ALL code you write or refactor. No exceptions.

---

## 1. UI Rendering — Zero Jank Policy

- **`const` is mandatory, not optional**: Use `const` on every widget, constructor, collection, and object that does not change at runtime. Flutter caches these at compile-time, eliminating re-allocation on rebuild.
- **Push state to the lowest leaf node**: `setState`, `Obx`, `GetBuilder`, `ValueListenableBuilder` MUST only wrap the exact widget that needs rebuilding — never at the top-level of a screen or large subtree.
- **Stable widget tree structure**: Never swap completely different widgets with `if/else`. Use `Visibility`, `Offstage`, or `AnimatedSwitcher` to preserve the element tree.
- **Limit `BuildContext` scope**: Use `Builder` widgets or extract small `StatelessWidget` children to confine rebuilds to the smallest possible subtree when reading Theme, Provider, or any state.
- **`RepaintBoundary` for expensive zones**: Wrap complex or frequently-animated widgets (charts, maps, custom painters) in `RepaintBoundary` to isolate their repaint layer from the rest of the tree.
- **`build()` is a pure function**: NEVER initialize controllers, allocate objects, perform heavy computation, or trigger side effects (API calls, logging) inside `build()`. All initialization belongs in `initState()` or the controller layer.

---

## 2. List & Lazy Loading

- **Ban standard `ListView` / `GridView` for dynamic lists**: ALWAYS use `.builder`, `.separated`, or `SliverList` with `SliverChildBuilderDelegate` to lazily construct only on-screen items.
- **Image caching**: NEVER use `Image.network` directly. Use `cached_network_image` with a placeholder and error widget at all times.
- **Pagination over infinite preload**: For lists exceeding 50+ items, implement pagination or infinite scroll — never load the entire dataset at once.

---

## 3. State Management — Rebuild Precision

- **Local UI state**: Use `StatefulWidget` or `ValueNotifier` — do not push trivial local state into a global store.
- **Global reactive state**: Use `select()` (Riverpod/Provider) or `buildWhen` (Bloc) to ensure a widget only rebuilds when its specific field changes — never rebuild on full state object changes.
- **Obx / GetBuilder scope**: Each `Obx` or `GetBuilder` must wrap the smallest possible widget. One large `Obx` wrapping an entire screen is forbidden.

---

## 4. Threading — Main Thread is UI Only

- **Offload all heavy work**: JSON parsing of large payloads, image processing, encryption, and any heavy synchronous computation MUST run on a background isolate using `compute()` or `Isolate.run()`.
- **No fake async patterns**: Never use `Future.delayed` to simulate loading. Use real async state flags, `FutureBuilder`, or `StreamBuilder`.
- **Stream responsibly**: Always cancel `StreamSubscription` in `dispose()` or `onClose()`.

---

## 5. Memory Management — Zero Leak Policy

- **Mandatory `dispose()`**: Every `AnimationController`, `TextEditingController`, `StreamController`, `ScrollController`, `FocusNode`, and `Timer` MUST be disposed in `dispose()` (StatefulWidget) or `onClose()` (GetxController).
- **GetX controller scope**: Use `Get.lazyPut` with `fenix: false` for screen-scoped controllers. Never `Get.put` all controllers globally in `main()`.
- **No orphaned listeners**: Every `addListener` call MUST have a corresponding `removeListener` in `dispose()`.

---

## 6. App Size & AOT Compilation

- **Exact types over `dynamic`**: Always declare explicit return types and variable types. Avoid `dynamic` and minimize `var`. This allows Dart's AOT compiler to generate optimized native machine code.
- **Asset hygiene**: Use SVG or WebP over PNG/JPG. Remove all unused images, fonts, and assets. Audit regularly with `flutter pub deps`.
- **Avoid heavy packages for single utilities**: Do not add a full library for one helper function. Prefer direct implementation or a lightweight alternative.
- **Deferred loading for heavy isolated features**: Use `import '...' deferred as module` with `await module.loadLibrary()` for features that are not needed on app startup.

---

## 7. Benchmarking & Profiling Standards

- **Frame budget**: Target 16ms/frame (60fps). For high-refresh devices, target 8ms/frame (120fps). Any code that risks exceeding this budget must be refactored.
- **Profile mode only**: All performance testing MUST be done in `flutter run --profile` mode — never in debug mode, which disables AOT and inflates frame times.
- **DevTools checks before every release**:
  - No unnecessary widget rebuilds (verified via "Widget Rebuild Stats")
  - No jank frames in Performance timeline during scroll
  - No memory leak spikes after repeated navigation (verified via Memory heap snapshot)
  - CPU flame chart shows no heavy work on the UI thread

---

## Quick Reference — Forbidden Patterns

| Pattern | Reason | Replacement |
|---|---|---|
| `ListView(children: [...])` for dynamic lists | Renders all items eagerly | `ListView.builder` |
| `TextEditingController()` inside `build()` | New instance + leak every rebuild | Initialize in `initState()` |
| `dynamic` return types | Blocks AOT optimization | Declare explicit types |
| `setState` at screen root | Rebuilds entire tree | Extract child widget |
| `Image.network(url)` | No cache, re-downloads every time | `CachedNetworkImage` |
| Heavy JSON parse on main thread | Blocks UI, causes jank | `compute()` or `Isolate.run()` |
| `Get.put(Controller())` in `main()` | Global leak, never disposed | Scoped `Get.lazyPut` |
| `if/else` widget swap | Destroys and recreates element | `Visibility` / `Offstage` |
