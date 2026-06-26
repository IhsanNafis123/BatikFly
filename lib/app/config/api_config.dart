class ApiConfig {
  // ===========================
  // GANTI SESUAI IP BACKEND
  // ===========================

  static const String baseUrl =
      "http://192.168.101.76:5000";

  // ===========================
  // AUTH
  // ===========================

  static const String login =
      "$baseUrl/auth/login";

  static const String googleLogin =
      "$baseUrl/auth/google";

  static const String registerRequestOtp =
      "$baseUrl/auth/register/request-otp";

  static const String verifyOtp =
      "$baseUrl/auth/register/verify-otp";

  static const String profile =
      "$baseUrl/auth/profile";

  // ===========================
  // DESIGN
  // ===========================

  static const String generateDesign =
      "$baseUrl/design/generate";

  static const String getMotifs =
      "$baseUrl/design/motifs";

  static const String saveDesign =
      "$baseUrl/design/save";

  // ===========================
  // FITTING
  // ===========================
  static const String fittingSave = "$baseUrl/api/fitting/save";
  static const String fittingVton = "$baseUrl/api/fitting/generate-vton";


  // ===========================
  // GALLERY
  // ===========================

  static const String gallery =
      "$baseUrl/gallery";
}