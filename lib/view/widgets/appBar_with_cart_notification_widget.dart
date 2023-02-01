import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view/widgets/web_view_page.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class AppBarWithCartNotificationWidget extends StatelessWidget implements PreferredSizeWidget{

  final Function() onTapIcon;
  final String title;
  final Widget? leadingWidget;
  final IconData? icon;
  final bool? tawasalIcon;
  final bool? showPoints;

  const AppBarWithCartNotificationWidget({this.leadingWidget,required this.title,this.icon,required this.onTapIcon, this.tawasalIcon, this.showPoints}) : super();

  @override
  Widget build(BuildContext context) {
    final IconData? iconImage = icon ?? Icons.arrow_back_ios;
    //var height = MediaQuery.of(context).size.height;

    return AppBar(
      leading: leadingWidget == null? IconButton(
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
          onPressed: () {
            onTapIcon();
          },
          icon: Icon(iconImage)): leadingWidget,
      automaticallyImplyLeading: false,
      elevation: 0,
      centerTitle: false,
      //toolbarHeight: height * 0.08,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
          if(showPoints == true)
          Text(
            'B2 Points 2100',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
      actions: [
        Visibility(
          visible:
          tawasalIcon?? false,
          child: GestureDetector(
              child: Image.asset('assets/images/tawasal.png',scale: 4,),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebViewPage(
                  url:
                  "https://testwebz.twl.ae/",
                  title: "Tawasal",
                ),
              ),
            );
          },),
        ),
        InkWell(
          onTap: () async {
            await Provider.of<AuthProvider>(context, listen: false)
                .callNotifications(context, '1', '30')
                .then((value) {

              //  _notificationData.addAll(value);
              navigationService.navigateTo(NotificationsListScreenRoute);

            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 20.h, //ScreenSize.appbarIconSize,
            ),
          ),
        ),
      /*  Stack(
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<OffersProvider>(context, listen: false).comingFromCart == false?
                goBackToCart(context): navigationService.navigateTo(CartScreenRoute);
                //navigationService.navigateTo(NotificationsScreenRoute);
              },
              child: Container(
                height: 30.h,
                width: 30.w,
                // color: Colors.red,
                margin: EdgeInsets.only(
                  right: 10.w,
                  top: 10.h,
                ),
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 20.h, //ScreenSize.appbarIconSize,
                ),
              ),
            ),
            Consumer<PayByProvider>(builder: (context, i, _) {
              return Positioned(
                left: 17.w,
                top: 10.h,
                child: i.totalCartCount == null || i.totalCartCount == 0
                    ? Text(' ')
                    :  Container(
                  width: 15.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text('${i.totalCartCount}',
                        style: TextStyle(color: pink, fontSize: 10)),

                    //Text('${Provider.of<OffersProvider>(context,listen: false).productIds.length}',style: TextStyle(color: Colors.white,fontSize: 10)),
                  ),
                ),
              );
            }),
          ],
        ),*/
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(gradient: gradientColor),
      ),
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  goBackToCart(BuildContext context) {
    Provider.of<OffersProvider>(context, listen: false).setComingFromCart(true);
    Navigator.pop(context, false);
  }
}
