class EndPoints {
  static const String baseUrl = 'https://nottr.app/api/';
  //endpoints
  static const String login = '${baseUrl}auth/login';
  static const String refreshForToken= '${baseUrl}accounts/sessions/current';
}