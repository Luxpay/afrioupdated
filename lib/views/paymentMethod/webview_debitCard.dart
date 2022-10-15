import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../page_controller.dart';

class WebViewDebitCardTransfer extends StatefulWidget {
  final String? debitUrl;
  const WebViewDebitCardTransfer({Key? key, required this.debitUrl})
      : super(key: key);

  @override
  State<WebViewDebitCardTransfer> createState() =>
      _WebViewDebitCardTransferState();
}

class _WebViewDebitCardTransferState extends State<WebViewDebitCardTransfer> {
  late WebViewController controller;

  double? progress;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                controller.clearCache();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppPageController()));
              },
              icon: Icon(Icons.clear)),
          actions: [
            IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    controller.goBack();
                  } else {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            IconButton(
                onPressed: () {
                  controller.reload();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
                value: progress,
                color: Colors.blue,
                backgroundColor: Colors.black12),
            Expanded(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: '${widget.debitUrl}',
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onProgress: (int progress) {
                  print("WebView is loading (progress : $progress%)");
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
          ],
        ));
  }
}
