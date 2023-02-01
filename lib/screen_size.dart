import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenSize {
  //HOME SCREEN//
  static late final appbarIconSize;
  static late final appbarImage;
  static late final appbarText;
  static late final buttonHeight;
  static late final categoryImage;
  static late final productCardHeight;
  static late final productCardImage;
  static late final productCardPrice;
  static late final productCardSalePrice;
  static late final productCardText;
  static late final productCardTextWidth;
  static late final productCardWidth;
  static late final productContainerText;
  static late final productIcon;
  static late final productPrice;
  static late final productRate;
  static late final productSalePrice;
  static late final sliderHeight;
  static late final appbarHeight;
  static late final fontSize;

  //HOME SCREEN//
  //SUPPORT SCREEN//
  static late final supportIcons;
  static late final supportContainerHeight;
  static late final supportContainerWidth;

  //SUPPORT SCREEN//


  static screen(mediaWidth, mediaHeight) {
    print('width' + mediaWidth.toString());

    fontSize = mediaWidth / mediaHeight * 10;
print('fontSize: $fontSize');
    if (mediaWidth > 100 && mediaWidth < 400) {
      //HOME SCREEN//
      appbarText = 18.sp;
      appbarHeight = 60.h;
      appbarImage = 2.0;
      appbarIconSize = 3.0;
      buttonHeight = 35.0.h;
      sliderHeight = 170.0.h;
      categoryImage = 3.5;

      productCardHeight = 1.03.h;
      productCardWidth = 0.63.h;

      productCardText = 12.sp;
      productCardTextWidth = 130.w;
      productCardImage = 2.5;
      productContainerText = 11.sp;
      productCardSalePrice = 11.sp;
      productCardPrice = 9.sp;
      productIcon = 20.0.h;
      productRate = 12.sp;
      //HOME SCREEN//

      //SUPPORT SCREEN//
      supportIcons = 25.h;
      supportContainerHeight = 28.h;
      supportContainerWidth = 25.w;
      //SUPPORT SCREEN//
print('productCardHeight : $productCardHeight');
    } else if (mediaWidth > 400 && mediaWidth < 600) {
      //HOME SCREEN//
      appbarText = 14.sp;
      appbarHeight = 60.h;
      appbarImage = 1.0;
      appbarIconSize = 3.0;
      buttonHeight = 35.0.h;
      sliderHeight = 190.0.h;

      productCardHeight = 0.95.h;
      productCardWidth = 0.59.h;

      categoryImage = 3.0;
      productCardText = 11.sp;
      productCardImage = 2.0;
      productContainerText = 10.sp;
      productCardSalePrice = 11.sp;
      productCardTextWidth = 125.w;
      productCardPrice = 9.sp;
      productIcon = 20.0.h;
      productRate = 10.sp;
      //HOME SCREEN//

      //SUPPORT SCREEN//
      supportIcons = 25.h;
      supportContainerHeight = 28.h;
      supportContainerWidth = 25.w;
      //SUPPORT SCREEN//
      print('productCardHeight : $productCardHeight');
    } else if (mediaWidth > 600) {
      //HOME SCREEN//
      appbarText = 15.sp;
      appbarHeight = 60.h;
      appbarImage = 1.0;
      appbarIconSize = 3.0;
      buttonHeight = 35.0.h;
      sliderHeight = 200.0.h;
      categoryImage = 2.5;

      productCardHeight = 0.8.h;
      productCardWidth = 0.51.h;

      productCardText = 12.sp;
      productCardTextWidth = 125.w;
      productCardImage = 2.0;
      productContainerText = 10.sp;
      productCardSalePrice = 11.sp;
      productCardPrice = 9.sp;
      productIcon = 20.0.h;
      productRate = 10.sp;
      //HOME SCREEN//

      //SUPPORT SCREEN//
      supportIcons = 25.h;
      supportContainerHeight = 28.h;
      supportContainerWidth = 25.w;
      //SUPPORT SCREEN//
      print('productCardHeight : $productCardHeight');
    }
  }
}
