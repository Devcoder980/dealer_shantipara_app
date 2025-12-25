# 🏭 Shanti Patra Dealer App

A Flutter mobile application for Shanti Patra dealers to manage orders, track commissions, and monitor business performance.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-00D1B2?style=for-the-badge&logo=flutter&logoColor=white)

---

## 📱 Features

- **OTP Authentication** - Secure login via email OTP
- **Dashboard** - View order statistics and quick insights
- **Orders Management** - Browse, filter, and track order status
- **Order Details** - View complete order info with product details
- **Commission Tracking** - Monthly commission summary and breakdown
- **Offline Storage** - Local data persistence with Hive

---

## 🏗️ Architecture

```
lib/
├── core/                    # API & Networking
│   ├── api_endpoints.dart   # API endpoint constants
│   ├── dio_client.dart      # Dio HTTP client singleton
│   └── interceptors/        # Request/Response interceptors
│       ├── auth_interceptor.dart
│       ├── error_interceptor.dart
│       └── logging_interceptor.dart
├── models/                  # Data Models
│   ├── dealer.dart
│   ├── order.dart
│   ├── product.dart
│   └── commission.dart
├── pages/                   # UI Screens
│   ├── login_page.dart
│   ├── otp_page.dart
│   ├── dashboard_page.dart
│   └── orders/
├── providers/               # Riverpod State Management
│   ├── auth_provider.dart
│   ├── order_provider.dart
│   └── commission_provider.dart
├── services/                # API Services
│   ├── auth_service.dart
│   ├── order_service.dart
│   └── commission_service.dart
├── utils/                   # Utilities
│   ├── hive_config.dart     # Local storage
│   ├── app_theme.dart       # App theming
│   ├── constants.dart       # App constants
│   └── validators.dart      # Form validation
├── widgets/                 # Reusable Components
└── routes/                  # App Navigation
```

---

## 🛠️ Tech Stack

| Technology | Purpose |
|------------|---------|
| **Flutter** | Cross-platform UI framework |
| **Dart** | Programming language |
| **Dio** | HTTP client with interceptors |
| **Riverpod** | State management |
| **Hive** | Local storage |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.5.0 or higher)
- Dart SDK (3.5.0 or higher)
- Android Studio / VS Code

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Devcoder980/dealer_shantipara_app.git
   cd dealer_shantipara_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Build APK

```bash
flutter build apk --release
```

---

## 📡 API Integration

Base URL: `https://dealer.shantipatra.com/api/v1`

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/dealer/auth/send-otp` | POST | Send OTP to email |
| `/dealer/auth/verify-otp` | POST | Verify OTP & login |
| `/dealer/orders/stats` | GET | Get order statistics |
| `/dealer/orders` | GET | Get orders list |
| `/dealer/orders/:soNumber` | GET | Get order details |
| `/dealer/commission/summary` | GET | Get commission summary |

---

## 📂 Key Files

| File | Description |
|------|-------------|
| `lib/main.dart` | App entry point |
| `lib/core/dio_client.dart` | HTTP client configuration |
| `lib/utils/hive_config.dart` | Local storage setup |
| `lib/providers/auth_provider.dart` | Authentication state |

---

## 📄 License

This project is proprietary software developed for Shanti Patra Pvt. Ltd.

---

## 👨‍💻 Developer

**Devcoder980**

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Devcoder980)
