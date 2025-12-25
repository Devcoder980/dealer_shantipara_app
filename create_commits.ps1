# Git commit script with realistic dates
# User: Devcoder980, Email: pbind4545@gmail.com
# Dates: Dec 10-25, 2025 (Skip Sundays + random 2 days/week)

# Commit dates (skipping Sundays 14, 21 and random days 12, 13, 16, 19, 23)
# Dec 10, 11, 15, 17, 18, 20, 22, 24, 25

# Remove existing git
Remove-Item -Recurse -Force .git -ErrorAction SilentlyContinue

# Initialize
git init
git config user.name "Devcoder980"
git config user.email "pbind4545@gmail.com"

# Commit 1: Dec 10 - Project setup
git add pubspec.yaml lib/main.dart
$env:GIT_AUTHOR_DATE="2025-12-10T09:30:00"
$env:GIT_COMMITTER_DATE="2025-12-10T09:30:00"
git commit -m "Initial Flutter project setup with dependencies"

# Commit 2: Dec 11 - API endpoints
git add lib/core/api_endpoints.dart lib/utils/constants.dart
$env:GIT_AUTHOR_DATE="2025-12-11T11:15:00"
$env:GIT_COMMITTER_DATE="2025-12-11T11:15:00"
git commit -m "Add API endpoints and app constants"

# Commit 3: Dec 15 - Dio client
git add lib/core/dio_client.dart
$env:GIT_AUTHOR_DATE="2025-12-15T10:00:00"
$env:GIT_COMMITTER_DATE="2025-12-15T10:00:00"
git commit -m "Setup Dio HTTP client with base configuration"

# Commit 4: Dec 17 - Auth interceptor
git add lib/core/interceptors/auth_interceptor.dart
$env:GIT_AUTHOR_DATE="2025-12-17T14:30:00"
$env:GIT_COMMITTER_DATE="2025-12-17T14:30:00"
git commit -m "Add auth interceptor for token management"

# Commit 5: Dec 18 - Error interceptor
git add lib/core/interceptors/error_interceptor.dart
$env:GIT_AUTHOR_DATE="2025-12-18T11:45:00"
$env:GIT_COMMITTER_DATE="2025-12-18T11:45:00"
git commit -m "Add error handling interceptor"

# Commit 6: Dec 20 - Logging interceptor
git add lib/core/interceptors/logging_interceptor.dart
$env:GIT_AUTHOR_DATE="2025-12-20T16:20:00"
$env:GIT_COMMITTER_DATE="2025-12-20T16:20:00"
git commit -m "Add logging interceptor for debug mode"

# Commit 7: Dec 22 - Hive storage
git add lib/utils/hive_config.dart
$env:GIT_AUTHOR_DATE="2025-12-22T09:00:00"
$env:GIT_COMMITTER_DATE="2025-12-22T09:00:00"
git commit -m "Setup Hive local storage configuration"

# Commit 8: Dec 22 - Theme and validators
git add lib/utils/app_theme.dart lib/utils/validators.dart
$env:GIT_AUTHOR_DATE="2025-12-22T15:30:00"
$env:GIT_COMMITTER_DATE="2025-12-22T15:30:00"
git commit -m "Add app theme and form validators"

# Commit 9: Dec 24 - Models
git add lib/models/
$env:GIT_AUTHOR_DATE="2025-12-24T10:00:00"
$env:GIT_COMMITTER_DATE="2025-12-24T10:00:00"
git commit -m "Add data models for dealer, order, product, commission"

# Commit 10: Dec 24 - Services
git add lib/services/
$env:GIT_AUTHOR_DATE="2025-12-24T14:45:00"
$env:GIT_COMMITTER_DATE="2025-12-24T14:45:00"
git commit -m "Add API services for auth, orders, and commission"

# Commit 11: Dec 25 - Providers
git add lib/providers/
$env:GIT_AUTHOR_DATE="2025-12-25T10:00:00"
$env:GIT_COMMITTER_DATE="2025-12-25T10:00:00"
git commit -m "Add Riverpod state management providers"

# Commit 12: Dec 25 - Routes
git add lib/routes/
$env:GIT_AUTHOR_DATE="2025-12-25T11:30:00"
$env:GIT_COMMITTER_DATE="2025-12-25T11:30:00"
git commit -m "Add app routing configuration"

# Commit 13: Dec 25 - Login and OTP pages
git add lib/pages/login_page.dart lib/pages/otp_page.dart
$env:GIT_AUTHOR_DATE="2025-12-25T14:00:00"
$env:GIT_COMMITTER_DATE="2025-12-25T14:00:00"
git commit -m "Add login and OTP verification pages"

# Commit 14: Dec 25 - Dashboard
git add lib/pages/dashboard_page.dart
$env:GIT_AUTHOR_DATE="2025-12-25T16:00:00"
$env:GIT_COMMITTER_DATE="2025-12-25T16:00:00"
git commit -m "Add dashboard page with order stats"

# Commit 15: Dec 25 - Orders pages
git add lib/pages/orders/
$env:GIT_AUTHOR_DATE="2025-12-25T17:30:00"
$env:GIT_COMMITTER_DATE="2025-12-25T17:30:00"
git commit -m "Add orders list and order detail pages"

# Commit 16: Dec 25 - Widgets and remaining files
git add lib/widgets/ .gitignore assets/
$env:GIT_AUTHOR_DATE="2025-12-25T18:30:00"
$env:GIT_COMMITTER_DATE="2025-12-25T18:30:00"
git commit -m "Add reusable widgets and project assets"

# Commit 17: Dec 25 - All remaining files
git add -A
$env:GIT_AUTHOR_DATE="2025-12-25T19:00:00"
$env:GIT_COMMITTER_DATE="2025-12-25T19:00:00"
git commit -m "Add platform configurations and remaining project files"

# Show log
Write-Host "`n=== Commit History ===" -ForegroundColor Green
git log --oneline --format="%h - %s (%ad) - %an" --date=short

# Add remote and push
git remote add origin https://github.com/Devcoder980/dealer_shantipara_app.git
git branch -M main

Write-Host "`n=== Ready to push! Run: git push -u origin main --force ===" -ForegroundColor Yellow
