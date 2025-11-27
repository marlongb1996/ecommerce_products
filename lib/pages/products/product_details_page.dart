import 'package:ecommerce_products/core/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final String thumbnail;
  final String description;

  const ProductDetailPage({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final WebViewController _controller;
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      final position = await determinePosition();
      setState(() {
        _latitude = position.latitude;
        _longitude = position.longitude;
      });

      final html = '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <style>
            html, body { margin:0; padding:0; height:100%; width:100%; }
            iframe { width:100%; height:100%; border:0; }
          </style>
        </head>
        <body>
          <iframe
            src="https://www.google.com/maps?q=$_latitude,$_longitude&z=15&output=embed"
            allowfullscreen>
          </iframe>
        </body>
      </html>
      ''';

      _controller.loadHtmlString(html);
    } catch (e) {
      debugPrint('Error al obtener ubicación: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          SizedBox(
            height: screenHeight / 1.5,
            width: double.infinity,
            child:  _latitude != null && _longitude != null
                ? WebViewWidget(controller: _controller)
                : const Center(child: CircularProgressIndicator()),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.thumbnail,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(widget.description),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Confirmar compra"),
                        content: const Text("¿Desea confirmar la compra?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("No"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("Sí"),
                          ),
                        ],
                      );
                    },
                  );

                  if (confirm == true) {
                    if(context.mounted){
                      await showDialog<void>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Compra realizada"),
                          content: const Text("¡Su compra se ha realizado correctamente!"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).popUntil((route) => route.isFirst);
                              },
                              child: const Text("Aceptar"),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                child: const Text("Comprar"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
