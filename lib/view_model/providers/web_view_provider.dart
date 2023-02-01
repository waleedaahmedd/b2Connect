import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewProvider with ChangeNotifier {
  /* Completer<WebViewController> webViewOnCompleteController =
  Completer<WebViewController>();*/

  WebViewController? _webViewController;

  CookieManager? cookieManager;

  setWebViewController(WebViewController value) {
    _webViewController = value;
    notifyListeners();
  }

  Future<void> onClearCache() async {
    if (_webViewController != null) {
      await _webViewController!.clearCache();
      if (cookieManager != null) {
        await cookieManager!.clearCookies();
      }
    }
  }
}
