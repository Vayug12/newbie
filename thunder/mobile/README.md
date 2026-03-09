# Flutter Mobile App Setup

## Prerequisites
- Flutter 3.22+
- Android Studio / VS Code

## Run
1. Copy `.env.example` to `.env`
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Start app:
   ```bash
   flutter run
   ```

## Folder Structure
```
lib/
  core/
  models/
  services/
  providers/
  screens/
  widgets/
```

## Included Screens
- Auth: Login, OTP Verification
- Customer: Home, Service Categories, Vendor List, Vendor Details, Booking, My Bookings
- Vendor: Dashboard, Booking Requests, My Jobs, Earnings
- Shared: Profile, Chat, Notifications, Mode Switch
