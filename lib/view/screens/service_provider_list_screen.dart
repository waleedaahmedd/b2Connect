import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/service_provider_items_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ServiceProviderListScreen extends StatelessWidget {
  final List<dynamic> _serviceProviderList;
  final String _screenName;
  final String? validator;

  const ServiceProviderListScreen(this._serviceProviderList,this._screenName, {this.validator}) : super();


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBarWithCartNotificationWidget(
        title: 'Service Providers',
        onTapIcon: () {
          navigationService.closeScreen();
        },
      ),
      body: WillPopScope(
        onWillPop: () {
         /* i.fitnessBlogsList.clear();
          i.healthBlogsList.clear();
          // i.mediaBlogsList.clear();
          i.paymentsBlogsList.clear();
          i.meditationBlogsList.clear();*/
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: double.infinity,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              addRepaintBoundaries: false,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                childAspectRatio: 0.98.w,
                //ScreenSize.productCardWidth / ScreenSize.productCardHeight,
                crossAxisCount: 2,
              ),
              //shrinkWrap: true,
              itemCount: _serviceProviderList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                   /* Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PopularDetailsScreen(
                              _blogList,
                              index,
                            )));*/
                  },
                  child:
                  ServiceProviderItemsWidget(index,_serviceProviderList,validator: validator == null? 'Wrong Input' : validator),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
