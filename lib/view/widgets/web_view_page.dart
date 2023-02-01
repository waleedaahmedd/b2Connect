
import 'dart:io';

import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../view_model/providers/web_view_provider.dart';
import 'appBar_with_cart_notification_widget.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({required this.url, required this.title}) : super();

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  NavigationService navigationService = locator<NavigationService>();
  UtilService utilsService = locator<UtilService>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<WebViewProvider>(builder: (context, i, _) {
      return Scaffold(
        appBar: AppBarWithCartNotificationWidget(
          title: widget.title,
          onTapIcon: () {
            navigationService.closeScreen();
          },
        ),
        body: Stack(
          children: [
            Visibility(
              visible: _isLoading,
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            WebView(
              // key: _key,
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                i.cookieManager = CookieManager();
                i.setWebViewController(webViewController);
              },
              onPageFinished: (finish) {
                //EasyLoading.dismiss();
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ],
        ),
      );
    });

  }
}

//       Container(
//         child: WebView(
//
//           initialUrl: widget.url,
//           javascriptMode: JavascriptMode.unrestricted,
//         ),
//       ),
//     );
//   }
// }
