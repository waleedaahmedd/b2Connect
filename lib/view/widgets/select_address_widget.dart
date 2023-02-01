import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class SelectAddressBottomSheet extends StatefulWidget {
  const SelectAddressBottomSheet({Key? key}) : super(key: key);

  @override
  _SelectAddressBottomSheetState createState() =>
      _SelectAddressBottomSheetState();
}

class _SelectAddressBottomSheetState extends State<SelectAddressBottomSheet> {
  var navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      child: new Wrap(
        children: <Widget>[
          Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                thickness: 1,
                // height: 20.h,
              ),
              SizedBox(
                height: 10.h,
              ),
             Container(
               height: 110.h,
               width: double.infinity,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [

                   ElevatedButton(
                     onPressed: () {
                       navigationService.navigateTo(AddShippingAddressScreenRoute);


                     },
                     style: ElevatedButton.styleFrom(
                       elevation: 0,
                       primary: Colors.transparent,
                     ),
                     child: Text(
                       AppLocalizations.of(context)!.translate('shipping_address1')!,
                       style: TextStyle(
                         color: Theme.of(context).primaryColor,
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w700,
                       ),
                       textAlign: TextAlign.start,
                     ),
                   ),

                   ElevatedButton(
                     onPressed: () {
                       navigationService.navigateTo(AddShippingAddressScreenRoute);
                     },
                     style: ElevatedButton.styleFrom(
                       elevation: 0,
                       primary: Colors.transparent,
                     ),
                     child: Text(
                       AppLocalizations.of(context)!.translate('billing_address1')!,
                       style: TextStyle(
                         color: Theme.of(context).primaryColor,
                         fontSize: 16.sp,
                         fontWeight: FontWeight.w700,
                       ),
                       textAlign: TextAlign.start,
                     ),
                   ),
                 ],
               ),
             ),
              SizedBox(
                height: height * 0.010,
              ),
              Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Container(
                  height: 6,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
