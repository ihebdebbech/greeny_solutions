abstract class AppConfig {
  abstract String baseUrl;
}

class DevConfiguration implements AppConfig {
  @override
  String baseUrl = "";
}

class ProdConfiguration implements AppConfig {
  @override
  String baseUrl = "";
}
