import 'package:flutter/material.dart';
import 'package:parkea/data/services/yappy_payment_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum YappyPaymentResult { success, cancelled, error }

class YappyPaymentPage extends StatefulWidget {
  final String paymentUrl;

  const YappyPaymentPage({super.key, required this.paymentUrl});

  @override
  State<YappyPaymentPage> createState() => _YappyPaymentPageState();
}

class _YappyPaymentPageState extends State<YappyPaymentPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (_) => setState(() {
            _isLoading = false;
            _hasError = true;
          }),
          onNavigationRequest: (request) {
            if (YappyPaymentService.isSuccessUrl(request.url)) {
              _finish(YappyPaymentResult.success);
              return NavigationDecision.prevent;
            }
            if (YappyPaymentService.isCancelUrl(request.url)) {
              _finish(YappyPaymentResult.cancelled);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _finish(YappyPaymentResult result) {
    if (mounted) Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://yappy.com.pa/img/logo-yappy.png',
              height: 24,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
            const SizedBox(width: 8),
            const Text('Pago con Yappy'),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          tooltip: 'Cancelar pago',
          onPressed: () => _finish(YappyPaymentResult.cancelled),
        ),
      ),
      body: Stack(
        children: [
          if (_hasError)
            _ErrorView(onRetry: () {
              setState(() => _hasError = false);
              _controller.reload();
            })
          else
            WebViewWidget(controller: _controller),
          if (_isLoading && !_hasError)
            const Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final VoidCallback onRetry;

  const _ErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            Text(
              'No se pudo cargar la página de pago',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
