abstract class AppConfig {
  abstract String baseUrl;
}

class DevConfiguration implements AppConfig {
  @override
  String baseUrl = "http://10.0.2.2:3000/";
}

class ProdConfiguration implements AppConfig {
  @override
  String baseUrl = "";
}
