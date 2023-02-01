
import 'package:b2connect_flutter/view/screens/view_all_service_screen.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

List<dynamic> _serviceTypeList = [
  {
    'name': 'More Time',
    'id': 'More Time',
  },
  /*{
    'name': 'More Credit',
    'id': 'More Credit',

  },
  {
    'name': 'More Data',
    'id': 'More Data',

  },*/
  {
    'name': 'eVoucher',
    'id': 'du eVoucher',

  },

];

int? _selectedIndex;


class ServiceTypeBottomSheet extends StatelessWidget {
  const ServiceTypeBottomSheet(this.serviceProviderList, {Key? key}) : super(key: key);

  final String? serviceProviderList;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text('Select an option',style: TextStyle(fontWeight: FontWeight.w500,
              fontSize: 18.sp,),),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: _serviceTypeList.length,
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration:
                  new BoxDecoration(
                      border: new Border(
                          bottom: new BorderSide(color: Colors.grey.shade300)
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ListTile(
                      title:
                      Text('${_serviceTypeList[index]['name']}',style: TextStyle(fontWeight: FontWeight.w500,),),
                      trailing: Icon(Icons.arrow_forward_ios),
                      selectedTileColor: Theme.of(context).primaryColor,
                      selected: _selectedIndex != null && _selectedIndex == index,
                      selectedColor: Colors.white,
                      onTap: () async {

                          EasyLoading.show(status: 'Please Wait...');

                          await getServiceDetail(
                              _serviceTypeList[index]['id'], context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewAllServiceScreen(
                                  name: _serviceTypeList[index]['name'],

                                )),
                          );

                      },
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
  Future<void> getServiceDetail(
       String _name, BuildContext context) async {
    await Provider.of<OffersProvider>(context, listen: false)
        .getOffers(/*categoryId: _categoryId,*/ perPage: 10, name: _name);
  }
}
