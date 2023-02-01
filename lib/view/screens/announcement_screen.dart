import 'package:b2connect_flutter/model/announcement_model.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/blogs_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'announcement_details_screen.dart';

class AnnouncementScreen extends StatelessWidget {
  final List<Announcement> _announcementList;
  final String _screenName;
  const AnnouncementScreen(this._announcementList, this._screenName) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBarWithCartNotificationWidget(
        title: _screenName,
        onTapIcon: () {
          navigationService.closeScreen();
        },
      ) /*AppBar(
          leading: IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                i.fitnessBlogsList.clear();
                i.healthBlogsList.clear();
               // i.mediaBlogsList.clear();
                i.paymentsBlogsList.clear();
                i.meditationBlogsList.clear();
                navigationService.closeScreen();
              },
              icon: Icon(Icons.arrow_back_ios)),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: false,
          toolbarHeight: height * 0.08,
          title: Text(
            _screenName,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenSize.appbarText,
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: gradientColor),
          ),
        )*/,
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child:_announcementList.length == 0? Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Image(
              image: AssetImage(
                "assets/images/error.jpg",
              ),
              width: 200.w,
              height: 200.h,
              fit: BoxFit.fill,
            ),
          ),
        ): Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: double.infinity,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              addRepaintBoundaries: false,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 2.0,
                childAspectRatio: 0.59.w,
                //ScreenSize.productCardWidth / ScreenSize.productCardHeight,
                crossAxisCount: 2,
              ),
              //shrinkWrap: true,
              itemCount: _announcementList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    EasyLoading.show(
                        status: 'Please Wait...');
                    Provider.of<BlogsProvider>(context, listen: false).getAnnouncementDetail(id: _announcementList[index].id).then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AnnouncementDetailsScreen(announcementDetails: Provider.of<BlogsProvider>(context, listen: false).announcementDetails, screenName: 'Announcement',)),
                      );
                      // navigationService.navigateTo(AnnouncementScreenRoute);
                    });
                  },
                  child: Container(
                      child: Wrap(
                        children: [
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, top: 10.0, bottom: 10.0),
                              child: Container(
                                //width: 150,
                                child: Column(
                                  //crossAxisAlignment:
                                  // CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0.r),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          height: 130.h,
                                          imageUrl: _announcementList[index].image!.isNotEmpty
                                              ? _announcementList[index].image!
                                              : 'assets/images/not_found1.png',
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                  'assets/images/placeholder1.png'),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                                child: Image.asset(
                                                  'assets/images/not_found1.png',
                                                  height: 100,
                                                ),
                                              ),
                                          fit: BoxFit.cover,
                                        ),
                                      ), /*Image.network(
                                              i.moneyPopularList[index].mediaURLs!.first,
                                              fit: BoxFit.fitHeight,
                                              height: 120,
                                            ),*/
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      height: 40.h,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${_announcementList[index].title}",
                                          overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          /*
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,*/
                                          //textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${_announcementList[index].category}",
                                       /* overflow: TextOverflow.ellipsis,
                                        maxLines: 2,*/
                                        //textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 12,color: Colors.grey),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}


