# API Documentation

Base URL: `http://localhost:5000/api/v1`

## Auth

### POST /auth/login
Request:
```json
{ "phone": "9876543210" }
```
Response:
```json
{
  "success": true,
  "message": "OTP sent successfully",
  "data": { "phone": "9876543210", "otpForDev": "123456" }
}
```

### POST /auth/verify-otp
Request:
```json
{ "phone": "9876543210", "otp": "123456", "fcmToken": "optional" }
```
Response:
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "token": "jwt-token",
    "user": {
      "_id": "65f...",
      "phone": "9876543210",
      "role": "customer",
      "activeMode": "customer"
    }
  }
}
```

## User

### GET /user/profile
Header: `Authorization: Bearer <token>`

### PUT /user/profile
Request:
```json
{
  "name": "Satyam",
  "email": "satyam@example.com",
  "role": "both",
  "activeMode": "vendor",
  "address": "Mumbai",
  "location": { "type": "Point", "coordinates": [72.8777, 19.076] }
}
```

## Services

### GET /services?page=1&limit=10
### GET /services/:id

## Vendors

### GET /vendors?lat=19.076&lng=72.8777&page=1&limit=10
### GET /vendors/:id

## Bookings

### POST /bookings
Request:
```json
{
  "vendorId": "65f...",
  "serviceId": "65f...",
  "date": "2026-03-10",
  "time": "10:30"
}
```

### GET /bookings?page=1&limit=10
Returns customer bookings if active mode is customer, otherwise vendor jobs.

### PUT /bookings/:id/status
Request:
```json
{ "status": "accepted" }
```
Allowed: `accepted`, `rejected`, `completed`, `cancelled`

## Reviews

### POST /reviews
Request:
```json
{ "vendorId": "65f...", "rating": 5, "comment": "Great service" }
```

### GET /reviews/:vendorId
