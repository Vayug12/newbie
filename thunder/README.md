# Service Marketplace (Urban Company style)

This workspace contains:
- `backend/` Node.js + Express + MongoDB REST API
- `mobile/` Flutter app supporting Customer and Vendor modes in one app

## Features Implemented
- OTP-based login + JWT auth
- Customer and vendor mode toggle
- Services, vendors, bookings, reviews APIs
- Booking lifecycle status updates
- Razorpay order creation integration
- Firebase push notification integration point
- Pagination for list APIs
- Clean Flutter structure with providers + reusable widgets

## Quick Start

### Backend
```bash
cd backend
cp .env.example .env
npm install
npm run dev
```

### Mobile
```bash
cd mobile
cp .env.example .env
flutter pub get
flutter run
```

## API Docs
- See `backend/src/docs/api.md`
