class TwinTokens {
    final String accessToken;
    final String refreshToken;

    const TwinTokens({required this.accessToken, required this.refreshToken});

    factory TwinTokens.fromJson(Map<String, dynamic> json) {
        return TwinTokens(accessToken: json['accessToken'] as String, refreshToken: json['refreshToken'] as String);
    }

    Map<String, dynamic> toJson() {
        return {'accessToken': accessToken, 'refreshToken': refreshToken};
    }
}
