class NetworkConstants {
  static final current = NetworkConstants();
  final String hostname = "Uddeshyas-MacBook-Air.local";
  final String port = "8080";
  String get baseURL => 'http://$hostname:$port';
}

enum NetworkServiceAccessModifiers {
  private("private"),
  public("public"),
  internal("internal");

  final String accessModifiers;
  const NetworkServiceAccessModifiers(this.accessModifiers);
}

enum NetworkServiceEndpoints {
  auth("auth"),
  user("user"),
  business("business"),
  transactions("transaction");

  final String endpoint;
  const NetworkServiceEndpoints(this.endpoint);
}

enum NetworkServiceSubEndpoints {
  login("login"),
  register("register"),
  getAllUsers("getAllUsers");

  final String subEndpoint;
  const NetworkServiceSubEndpoints(this.subEndpoint);
}

enum UserRole {
  user("USER"),
  admin("ADMIN"),
  superAdmin("SUPER_ADMIN");

  final String value;
  const UserRole(this.value);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere((e) => e.value == value);
  }
}

enum UserLanguage {
  english("ENGLISH"),
  hindi("HINDI"),
  hinglish("HINGLISH"),
  punjabi("PUNJABI"),
  kannada("KANNADA"),
  tamil("TAMIL");

  final String value;
  const UserLanguage(this.value);

  static UserLanguage fromString(String value) {
    return UserLanguage.values.firstWhere((e) => e.value == value);
  }
}
