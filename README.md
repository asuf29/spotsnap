# SnapSpot

AI-powered travel and social content creation app — discover photo spots, plan outfits & poses, and build optimized shoot routes.

## Stack

- **Flutter** 3.x · **Riverpod** · **go_router**
- **Clean Architecture** (feature-first)
- **shared_preferences** — social & theme persistence
- **dio** — REST API (remote or mock assets)
- **flutter_map** — Carto (default) or **Mapbox** (optional)
- **purchases_flutter** — RevenueCat IAP (optional)
- **firebase_core / firebase_auth / firebase_messaging** — Auth & push (optional)
- **flutter_local_notifications** — Golden hour reminders
- **share_plus** — Native share sheet
- **flutter_animate** — Onboarding & splash animations

## Run

```bash
flutter pub get
flutter run
```

### Optional: Mapbox tiles

```bash
flutter run --dart-define=MAPBOX_TOKEN=pk.your_token_here
```

### Optional: Remote API

Point to your backend (same JSON shape as `assets/mock_api/`):

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com/v1
```

Without `API_BASE_URL`, the app loads **`assets/mock_api/cities.json`** and **`spots.json`** (bundled mock API).

### Optional: RevenueCat subscriptions

```bash
flutter run --dart-define=REVENUECAT_API_KEY=appl_xxx_or_goog_xxx
```

Without a key, premium unlocks via **demo mode** (local flag). Configure entitlement id `premium` in RevenueCat.

### Optional: Firebase Auth & push

1. Run `flutterfire configure` and replace `lib/firebase_options.dart`.
2. Enable Firebase at runtime:

```bash
flutter run --dart-define=USE_FIREBASE=true
```

Email/password sign-in uses Firebase when enabled (min 6 characters). FCM token is logged when Firebase initializes.

### Localization (EN / TR)

Strings live in `lib/l10n/app_en.arb` and `app_tr.arb`. Switch language in **Profile → Language**.

Regenerate mock JSON from seed:

```bash
dart run tool/generate_mock_api.dart
```

## Project structure

```
lib/
├── core/           → config, network, bootstrap, theme, router
├── shared/         → widgets, providers, locale
├── l10n/           → app_en.arb, app_tr.arb
└── features/
    ├── auth/ discover/ spot/ pose/ outfit/ route/
    ├── create/ photo_assistant/ social/ plan/ profile/
    ├── subscription/ notifications/
```

## Features

| Area | Status |
|------|--------|
| Discover (Reels + Grid) | ✅ |
| AI Pose / Outfit / Photo Assistant | ✅ |
| Smart Route + Map | ✅ |
| Social (favorites, bucket list, moodboards, UGC) | ✅ |
| Persistent social state | ✅ |
| Mock / remote API | ✅ |
| Mapbox (optional) | ✅ |
| Auth persistence (skip onboarding) | ✅ |
| Spot photos (cached) | ✅ |
| Premium paywall + RevenueCat / demo IAP | ✅ |
| Firebase Auth (optional) | ✅ |
| Golden hour local notifications | ✅ |
| TR / EN localization (full) | ✅ |
| Hero image transitions | ✅ |
| Custom page transitions (slide-up, fade-scale) | ✅ |
| Shimmer loading placeholders | ✅ |
| Share spot (native share sheet) | ✅ |

## Design system preview

**Profile → Design System** or `/design-system`
