import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view/widgets/sort_by_list_widget.dart';

class SortByScreen extends StatefulWidget {
  const SortByScreen(this.categoryId, {Key? key}) : super(key: key);

  final categoryId;

  @override
  _SortByScreenState createState() => _SortByScreenState();
}

class _SortByScreenState extends State<SortByScreen> {
  List<Map<String, dynamic>> _sortByList = [
    {"id": "1", "title": "Default"},
    {"id": "2", "title": "Price - Low to High"},
    {"id": "3", "title": "Price - High to Low"},
    {"id": "4", "title": "Name A - Z"},
    {"id": "5", "title": "Trends"},
  ];

//   void initState() {
//     super.initState();
// /*
//     getData();
// */
//     /* getOffers =
//         Provider
//             .of<OffersProvider>(context, listen: false)
//             .offersData;*/
//     /* _currentRangeValues = RangeValues(
//         getOffers == null ? 10 : getOffers.filterMeta.minPrice!.toDouble(),
//         getOffers == null ? 100 : getOffers.filterMeta.maxPrice!.toDouble());*/
//   }

  String tagId = ' ';

  void active(val) {
    setState(() {
      tagId = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        icon: Icons.clear,
        onTapIcon: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Sort By",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 27.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _sortByList.length,
                itemBuilder: (ctx, index) {
                  return SortByListWidget(
                    data: _sortByList[index]['title'],
                    tag: _sortByList[index]['id'],
                    index: index,
                    action: active,
                    categoryId: widget.categoryId,
                    active: tagId == _sortByList[index]['id'] ? true : false,
                  );
                }),
          ],
        ),
      ),
    );
  }
}
