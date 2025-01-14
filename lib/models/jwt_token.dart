
class JwtToken {
  final String accessToken;
  final String refreshToken;

  JwtToken({
    required this.accessToken,
    required this.refreshToken,
  });

  factory JwtToken.fromJson(Map<String, dynamic> json) {
    return JwtToken(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
