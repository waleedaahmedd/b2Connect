import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/storage_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../view_model/providers/web_view_provider.dart';

var navigationService = locator<NavigationService>();
var storageService = locator<StorageService>();

Future<Widget> showOnWillPop(context) async {
  var navigationService = locator<NavigationService>();
  return await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(AppLocalizations.of(context)!.translate('exist')!,
              style: new TextStyle(color: Colors.black, fontSize: 20.0)),
          content:
              new Text(AppLocalizations.of(context)!.translate('exit_conset')!),
          actions: <Widget>[
            // ignore: deprecated_member_use
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: new Text(AppLocalizations.of(context)!.translate('yes')!,
                  style: new TextStyle(fontSize: 18.0)),
            ),
            // ignore: deprecated_member_use
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () => navigationService.closeScreen(),
              // this line dismisses the dialog
              child: new Text(
                  AppLocalizations.of(context)!.translate('cancel')!,
                  style: new TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ) ??
      false;
}

Future<Widget> logOutConset(context) async {
  var navigationService = locator<NavigationService>();
  return await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(AppLocalizations.of(context)!.translate('logOut')!,
              style: new TextStyle(color: Colors.black, fontSize: 20.0)),
          content: new Text(
              AppLocalizations.of(context)!.translate('logout_conset')!),
          actions: <Widget>[
            // ignore: deprecated_member_use
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                await Provider.of<WebViewProvider>(context, listen: false)
                    .onClearCache();
                await storageService.setBoolData('isShowHome', false);
                navigationService.navigateTo(LoginScreenRoute);
                Provider.of<PayByProvider>(context, listen: false)
                    .getTotalCartCount(0);
                context.read<OffersProvider>().b2PayTag = true;
              },
              child: new Text(AppLocalizations.of(context)!.translate('yes')!,
                  style: new TextStyle(fontSize: 18.0)),
            ),
            // ignore: deprecated_member_use
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () => navigationService.closeScreen(),
              // this line dismisses the dialog
              child: new Text(
                  AppLocalizations.of(context)!.translate('cancel')!,
                  style: new TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      ) ??
      false;
}

Future<bool> customDialogBox(
    {required BuildContext context,
    required Function onYes,
    required String title,
    required String description}) async {
  var navigationService = locator<NavigationService>();
  bool confirm = false;
  await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text(title,
              style: new TextStyle(color: Colors.black, fontSize: 20.0)),
          content: new Text(description),
          actions: <Widget>[
            // ignore: deprecated_member_use
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                confirm = true;
                navigationService.closeScreen();

               // onYes();
              },
              child: new Text(AppLocalizations.of(context)!.translate('yes')!,
                  style: new TextStyle(fontSize: 18.0)),
            ),
            // ignore: deprecated_member_use
            new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                navigationService.closeScreen();
                confirm = false;
              },
              // this line dismisses the dialog
              child: new Text(
                  AppLocalizations.of(context)!.translate('cancel')!,
                  style: new TextStyle(fontSize: 18.0)),
            )
          ],
        ),
      );
  return confirm;
}
