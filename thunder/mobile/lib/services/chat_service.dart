class ChatService {
  Future<List<Map<String, String>>> getMessages(String bookingId) async {
    return [
      {"from": "vendor", "text": "Hello, I will reach in 10 mins."},
      {"from": "customer", "text": "Thanks!"}
    ];
  }
}
