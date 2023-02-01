import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/filter_model.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SortByListWidget extends StatefulWidget {
  final data;
  ValueChanged<dynamic>? action;
  String? tag;
  final active;
  final index;
  final categoryId;
  SortByListWidget({this.action, this.data, this.tag, this.active, this.index, this.categoryId});

  @override
  _SortByListWidgetState createState() => _SortByListWidgetState();
}

FilterData? _filterData;

class _SortByListWidgetState extends State<SortByListWidget> {

  @override
  void initState() {
    super.initState();

    _filterData = Provider.of<OffersProvider>(context, listen: false).filterData;
  }

  @override
  Widget build(BuildContext context) {
    //return RelativeBuilder(builder: (context, height, width, sy, sx) {
    return Consumer<OffersProvider>(builder: (context, i, _) {
      return GestureDetector(
        onTap: handleTap,
        child: Container(
          decoration: BoxDecoration(
            color:
                i.filterData.sortByListIndex == widget.index ? Color.fromRGBO(255, 235, 242, 1) : Colors.white,
          ),
          height: 55.h,
          // margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.data,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: i.filterData.sortByListIndex == widget.index
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> handleTap() async {
    Provider
        .of<OffersProvider>(context, listen: false)
        .handleSortByTap(widget.index, widget.tag);
   // await getOfferDetail();
    var count = 0;
    EasyLoading.show(status: AppLocalizations.of(context)!.translate('please_wait')!);
    await getOfferDetail().then((value) {
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ViewAllOffersScreen(
                  10,
                    sortBy: _filterData!.sortBy,
                    categoryId: widget.categoryId,
                    filterBy: _filterData!.filterBy,
                    filterByStock: _filterData!.filterByStock,
                    titleSortBy: widget.data
                    /*minPrice: minPrice,
                    maxPrice: maxPrice*/)),
      );
    });
    widget.action!(widget.tag!);
  }

  Future<void> getOfferDetail() async {
    await Provider.of<OffersProvider>(context, listen: false).getOffers(
        sortBy: _filterData!.sortBy,
        categoryId: widget.categoryId,
        perPage: 10,
        //minPrice: minPrice,
        //maxPrice: maxPrice,
        filterBy: _filterData!.filterBy,
        filterByStock: _filterData!.filterByStock);
  }
}
