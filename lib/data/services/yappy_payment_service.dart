// Configuración e integración con el Botón de Pago Yappy de Banco General Panamá.
// Documentación oficial: https://yappy.com.pa/boton-de-pago
// Cuando tengas las credenciales, reemplaza los placeholders en YappyConfig.

class YappyConfig {
  YappyConfig._();

  // TODO: Reemplazar con las credenciales reales de Banco General
  static const String merchantId = 'YOUR_MERCHANT_ID';
  static const String secretKey = 'YOUR_SECRET_KEY';

  /// URL base del Botón de Pago Yappy (sandbox / producción)
  static const String baseUrl =
      'https://pay.yappy.com.pa/yappy/api/boton/v1/';

  /// URLs de retorno — deben coincidir con las configuradas en el portal de Banco General
  static const String successUrl = 'https://parkea.app/yappy/success';
  static const String cancelUrl = 'https://parkea.app/yappy/cancel';
}

class YappyPaymentService {
  /// Construye la URL de pago de Yappy con los parámetros del ticket.
  ///
  /// En producción el hash HMAC-SHA256 debe generarse en el **backend**
  /// para no exponer [YappyConfig.secretKey] en el cliente.
  static Uri buildPaymentUrl({
    required String reference,
    required double amount,
    required String description,
  }) {
    return Uri.parse(YappyConfig.baseUrl).replace(
      queryParameters: {
        'id_sucursal': YappyConfig.merchantId,
        'total': amount.toStringAsFixed(2),
        'descripcion': description,
        'referencia': reference,
        'url_success': YappyConfig.successUrl,
        'url_cancel': YappyConfig.cancelUrl,
        // TODO: Agregar hash HMAC-SHA256 generado desde el backend
        // 'hash': backendGeneratedHash,
      },
    );
  }

  /// Devuelve `true` si la URL corresponde al retorno de pago exitoso.
  static bool isSuccessUrl(String url) =>
      url.startsWith(YappyConfig.successUrl);

  /// Devuelve `true` si la URL corresponde a cancelación.
  static bool isCancelUrl(String url) =>
      url.startsWith(YappyConfig.cancelUrl);
}
