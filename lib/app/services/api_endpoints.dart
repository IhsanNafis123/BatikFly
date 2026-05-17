class ApiEndpoints {
  // Ganti URL ini saja jika nanti server di-hosting atau ganti IP
  static const String baseUrl = "http://192.168.101.121:5000";

  // Auth Endpoints
  static const String register = "$baseUrl/register";
  static const String login = "$baseUrl/login";

  // Nanti Anda bisa tambahkan endpoint OTP di sini
  static const String forgotPassword = "$baseUrl/forgot-password";
}
