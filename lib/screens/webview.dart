import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  PaymentWebView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  PaymentWebViewState createState() => PaymentWebViewState();
}

late String getUrlPref;

class PaymentWebViewState extends State<PaymentWebView> {
  Widget build(BuildContext context) {
    final responseArgument = ModalRoute.of(context)!.settings.arguments as Map;

    print("URL: ${responseArgument['response']}");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        initialUrl: responseArgument['response'],
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) async {
          Map<String, dynamic> dataToSend = {};
          if (url.contains("AUTHORISED")) {
            Uri.parse(url).queryParameters.forEach((key, value) {
              dataToSend[key] = value;
            });
            print('Respuesta: ' + dataToSend.toString());
            Navigator.pushNamedAndRemoveUntil(
                context, '/success', (r) => false);
          } else if (url.contains("REFUSED")) {
            Navigator.pushNamedAndRemoveUntil(context, '/fail', (r) => false);
          }
        },
      ),
    );
  }
}
