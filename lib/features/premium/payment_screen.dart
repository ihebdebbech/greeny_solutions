import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:greeny_solution/features/deseaseDetection/camera_view.dart';
import 'package:greeny_solution/features/premium/payment_controller.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final String link;
  final Widget  nextWidget; 

  PaymentScreen({required this.link,required this.nextWidget});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  StreamSubscription? _sub;
  late InAppWebViewController webViewController;
  final webviewcontroller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
  
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

 

  

  @override
  Widget build(BuildContext context) {
    Uri url = Uri.parse(widget.link);
    webviewcontroller.loadRequest(url);

    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: WebUri(widget.link), // <-- Initial URL to load
          ),
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onUpdateVisitedHistory: (controller, uri, androidIsReload) {
            String url = uri.toString(); // Get the current URL
            print(url);
            // Example: Close the WebView and navigate to a new screen based on URL
            if (url.contains('success')) {
              print("success detected");
              
              Future.delayed(Duration(seconds: 4), () {
   
             Get.off(widget.nextWidget);
              });
            }
          },
        ),
      ),
    );
  }
}
