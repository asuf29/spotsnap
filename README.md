# SnapSpot

**Seyahat ve sosyal medya içerik üretimi için AI destekli mobil uygulama.**

SnapSpot, fotoğraf çekmek isteyen gezginler ve içerik üreticileri için tasarlanmış bir rehberdir. Dünyanın dört bir yanındaki fotoğraf noktalarını keşfedin, poz ve kombin önerileri alın, çekim gününüz için altın saate göre optimize edilmiş rotalar oluşturun ve favorilerinizi, moodboard'larınızı ve bucket list'inizi tek bir yerde yönetin.

---

## İçindekiler

- [Özellikler](#özellikler)
- [Uygulama Akışı](#uygulama-akışı)
- [Teknoloji Yığını](#teknoloji-yığını)
- [Mimari](#mimari)
- [Proje Yapısı](#proje-yapısı)
- [Kurulum ve Çalıştırma](#kurulum-ve-çalıştırma)
- [Opsiyonel Entegrasyonlar](#opsiyonel-entegrasyonlar)
- [Yerelleştirme](#yerelleştirme)
- [Özellik Durumu](#özellik-durumu)

---

## Özellikler

### Keşfet
Şehir bazlı fotoğraf noktalarını **Reels** ve **Grid** görünümlerinde gezin. Kategori filtreleri, arama ve trend şehirlerle Paris'ten Santorini'ye kadar ilham verici lokasyonları bulun. Her spot için vibe etiketleri, kalabalık göstergesi ve detaylı bilgi sayfaları sunulur.

### Akıllı Rota Planlama
Çekim gününüz için birden fazla spot seçin; uygulama rotayı **altın saat** (gün doğumu / batımı) önceliğine göre optimize eder. Harita üzerinde durakları görün, zaman çizelgesini takip edin ve yürüyüş sürelerini planlayın.

### AI İçerik Araçları
**Oluştur** sekmesinden üç araç:

| Araç | Açıklama |
|------|----------|
| **AI Poz Asistanı** | Spot ve vibe'a göre poz önerileri, lens ve açı ipuçları |
| **Kombin Planlayıcı** | Konsept görünümler, renk uyumu ve gardırop önerileri |
| **Fotoğraf Asistanı** | Çekim anında kullanılabilecek AI rehberi |

### Sosyal ve Kişiselleştirme
Favoriler, bucket list, moodboard'lar ve kayıtlı şehirler. Kullanıcıların kendi spot önerilerini gönderebildiği UGC akışı. Sosyal durum cihazda kalıcı olarak saklanır.

### Diğer
- Altın saat için yerel bildirimler
- Premium abonelik (RevenueCat veya demo modu)
- Opsiyonel Firebase Auth ve push bildirimleri
- Hero geçişleri ve özel sayfa animasyonları
- Shimmer yükleme placeholder'ları
- Native paylaşım sayfası ile spot paylaşımı
- Açık / koyu tema ve tam **Türkçe / İngilizce** yerelleştirme

---

## Uygulama Akışı

```
Splash → Onboarding → Giriş (opsiyonel)
              ↓
┌─────────────────────────────────────────────┐
│  Ana Sayfa │ Keşfet │ Plan │ Oluştur │ Profil │
└─────────────────────────────────────────────┘
       │          │       │        │         │
   Trend      Reels/   Rota    Poz /     Ayarlar,
   şehirler   Grid     harita  Kombin    Premium,
   öne çıkan           planı   Foto AI   Sosyal
```

Alt navigasyon `StatefulShellRoute` ile yönetilir; spot detayı ve diğer tam ekran sayfalar kök navigator üzerinden açılır.

---

## Teknoloji Yığını

Projede kullanılan bağımlılıklar (`pubspec.yaml`):

| Paket | Kullanım |
|-------|----------|
| **Flutter** 3.x (Dart SDK ^3.10) | UI çerçevesi |
| **flutter_riverpod** | Durum yönetimi |
| **go_router** | Routing ve shell navigasyon |
| **google_fonts** | Tipografi |
| **flutter_animate** | Sayfa ve liste animasyonları |
| **dio** | REST API istemcisi |
| **shared_preferences** | Auth, tema, sosyal durum ve dil kalıcılığı |
| **cached_network_image** | Spot fotoğrafları için önbellekli görüntü yükleme |
| **flutter_map** + **latlong2** | Rota haritası ve koordinatlar |
| **firebase_core**, **firebase_auth**, **firebase_messaging** | Giriş ve push token yönetimi (`USE_FIREBASE` ile) |
| **purchases_flutter** | In-app abonelik (`REVENUECAT_API_KEY` ile; yoksa demo modu) |
| **flutter_local_notifications** + **timezone** | Altın saat yerel bildirimleri |
| **share_plus** | Native paylaşım sayfası |
| **flutter_localizations** + **intl** | TR / EN yerelleştirme (ARB) |

Harita karoları `flutter_map` üzerinden yüklenir: varsayılan Carto Voyager; Mapbox için [Opsiyonel Entegrasyonlar](#opsiyonel-entegrasyonlar).

---

## Mimari

Proje **Clean Architecture** prensiplerine uygun, **feature-first** bir klasör yapısı kullanır:

```
feature/
├── domain/       → entity, repository arayüzleri
├── data/         → repository implementasyonları, datasource, DTO
└── presentation/ → sayfalar, widget'lar, Riverpod provider'ları
```

`core/` katmanı yapılandırma, ağ, tema, router ve bootstrap işlemlerini; `shared/` katmanı ortak widget'ları ve provider'ları barındırır.

Runtime yapılandırma `--dart-define` ile `AppConfig` üzerinden okunur; harici servisler (API, Mapbox, Firebase, RevenueCat) tamamen opsiyoneldir.

---

## Proje Yapısı

```
lib/
├── core/
│   ├── bootstrap/      # Uygulama başlatma
│   ├── config/         # AppConfig (dart-define)
│   ├── firebase/       # Firebase bootstrap
│   ├── network/        # Dio API client
│   ├── router/         # go_router, geçiş animasyonları
│   └── theme/          # Renkler, spacing, tema
├── shared/
│   ├── providers/      # Locale, shell navigasyon, create context
│   └── widgets/        # Design system, shell, ortak bileşenler
├── l10n/               # app_en.arb, app_tr.arb
└── features/
    ├── auth/           # Splash, onboarding, giriş
    ├── home/           # Ana sayfa
    ├── discover/       # Keşfet (Reels + Grid)
    ├── spot/           # Spot detay
    ├── route/          # Akıllı rota ve harita
    ├── plan/           # Plan sekmesi
    ├── create/         # Oluştur hub
    ├── pose/           # AI Poz Asistanı
    ├── outfit/         # Kombin Planlayıcı
    ├── photo_assistant/# Fotoğraf Asistanı
    ├── social/         # Favoriler, moodboard, bucket list, UGC
    ├── profile/        # Profil ve ayarlar
    ├── subscription/   # Premium / paywall
    ├── notifications/  # Yerel bildirimler
    └── design_system/  # Bileşen önizleme sayfası
```

---

## Kurulum ve Çalıştırma

### Gereksinimler
- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.x
- Xcode (iOS) ve/veya Android Studio (Android) — hedef platforma göre

### Hızlı başlangıç

```bash
flutter pub get
flutter run
```

Backend tanımlanmadığında uygulama `assets/mock_api/cities.json` ve `spots.json` dosyalarından mock veri yükler.

Mock veriyi yeniden üretmek için:

```bash
dart run tool/generate_mock_api.dart
```

---

## Opsiyonel Entegrasyonlar

Tüm entegrasyonlar `--dart-define` ile çalışma zamanında etkinleştirilir.

### Mapbox harita karoları

```bash
flutter run --dart-define=MAPBOX_TOKEN=pk.your_token_here
```

### Uzak API

Backend'iniz `assets/mock_api/` ile aynı JSON şemasını kullanmalıdır:

```bash
flutter run --dart-define=API_BASE_URL=https://api.example.com/v1
```

### RevenueCat abonelikleri

```bash
flutter run --dart-define=REVENUECAT_API_KEY=appl_xxx_or_goog_xxx
```

Anahtar verilmezse premium **demo modu** ile (yerel flag) açılır. RevenueCat'te `premium` entitlement id'sini yapılandırın.

### Firebase Auth ve push

1. `flutterfire configure` çalıştırın ve `lib/firebase_options.dart` dosyasını güncelleyin.
2. Runtime'da etkinleştirin:

```bash
flutter run --dart-define=USE_FIREBASE=true
```

Firebase etkinken e-posta/şifre girişi kullanılır (min. 6 karakter). FCM token, Firebase başlatıldığında loglanır.

### Tüm seçenekler bir arada (örnek)

```bash
flutter run \
  --dart-define=API_BASE_URL=https://api.example.com/v1 \
  --dart-define=MAPBOX_TOKEN=pk.your_token \
  --dart-define=REVENUECAT_API_KEY=appl_xxx \
  --dart-define=USE_FIREBASE=true
```

---

## Yerelleştirme

Uygulama **Türkçe** ve **İngilizce** dillerini destekler. Dil değişimi: **Profil → Dil**.

String kaynakları:
- `lib/l10n/app_en.arb`
- `lib/l10n/app_tr.arb`

---

## Özellik Durumu

| Alan | Durum |
|------|-------|
| Keşfet (Reels + Grid) | ✅ |
| AI Poz / Kombin / Fotoğraf Asistanı | ✅ |
| Akıllı Rota + Harita | ✅ |
| Sosyal (favoriler, bucket list, moodboard, UGC) | ✅ |
| Kalıcı sosyal durum | ✅ |
| Mock / uzak API | ✅ |
| Mapbox (opsiyonel) | ✅ |
| Auth kalıcılığı (onboarding atlama) | ✅ |
| Önbellekli spot fotoğrafları | ✅ |
| Premium paywall + RevenueCat / demo IAP | ✅ |
| Firebase Auth (opsiyonel) | ✅ |
| Altın saat yerel bildirimleri | ✅ |
| TR / EN tam yerelleştirme | ✅ |
| Hero görüntü geçişleri | ✅ |
| Özel sayfa geçişleri (slide-up, fade-scale) | ✅ |
| Shimmer yükleme placeholder'ları | ✅ |
| Spot paylaşımı (native share sheet) | ✅ |

### Design System önizleme

Bileşen kütüphanesini görmek için: **Profil → Design System** veya `/design-system` rotası.

---

## Lisans

Bu proje şu an `publish_to: 'none'` ile özel geliştirme amaçlıdır.
