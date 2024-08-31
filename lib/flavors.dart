enum Flavor {
  development,
  stage,
  production,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.development:
        return 'Desarrollo';
      case Flavor.stage:
        return 'Stage';
      case Flavor.production:
        return 'Produccion';
      default:
        return 'title';
    }
  }
  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.development:
        return "cct-api-dev.froggysoft.app";
      case Flavor.stage:
        return "cct-api-stg.froggysoft.app";
      case Flavor.production:
        return "cct-api.froggysoft.app";
      default:
        throw Exception("Unknown flavor for baseUri");
    }
  }
}
