import 'package:b2connect_flutter/model/models/offers_models/installment_Option_model.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class IncDecButton extends StatefulWidget {
  final int? value;
  final int? priceNow;
  final List<InstallmentPrices>? priceLater;
  final int? id;
  final bool? isEdit;
  final int? categoryId;
  const IncDecButton({
    Key? key,
    this.value,
    this.priceNow,
    this.priceLater,
    this.id,
    this.isEdit,
    this.categoryId
  }) : super(key: key);

  @override
  _IncDecButtonState createState() => _IncDecButtonState();
}

class _IncDecButtonState extends State<IncDecButton> {
  int value=0;
  @override
  void initState() {
    super.initState();
    setState(() {
      value=widget.value!;
    });
  }

  void add() {
    setState(() {
      value++;
      Provider.of<PayByProvider>(context,listen: false).addToCartList(widget.id!);

      //Provider.of<OffersProvider>(context,listen: false).productIds.add(widget.id);
      Provider.of<OffersProvider>(context,listen: false).saveTotalNow(widget.priceNow!.toDouble());
      if (widget.categoryId == 54 || widget.categoryId == 118) {
        Provider.of<OffersProvider>(context,listen: false).set3xInstallmentPrice(widget.priceLater![0].monthlyPrice!.toDouble(),widget.priceLater![0].monthlyPriceAddon!.toDouble());
        Provider.of<OffersProvider>(context,listen: false).set6xInstallmentPrice(widget.priceLater![1].monthlyPrice!.toDouble(),widget.priceLater![1].monthlyPriceAddon!.toDouble());
      }
      else{
        Provider.of<OffersProvider>(context,listen: false).addOtherProductsPriceWithEmiProduct(widget.priceNow!.toDouble());
      }
      //Provider.of<OffersProvider>(context,listen: false).updationOfInstallmentPrice();
    });
  }

  void minus() {
    setState(() {
      if (value != 1) {
        value--;
        Provider.of<PayByProvider>(context,listen: false).removeItemQuantityFromCartList(widget.id!);

        // removeWhere((element) => element==widget.id);
        Provider.of<OffersProvider>(context,listen: false).minusTotalNow(widget.priceNow!.toDouble());

        if (widget.categoryId == 54 || widget.categoryId == 118) {
          Provider.of<OffersProvider>(context,listen: false).remove3xInstallmentPrice(widget.priceLater![0].monthlyPrice!.toDouble(),widget.priceLater![0].monthlyPriceAddon!.toDouble());
          Provider.of<OffersProvider>(context,listen: false).remove6xInstallmentPrice(widget.priceLater![1].monthlyPrice!.toDouble(),widget.priceLater![1].monthlyPriceAddon!.toDouble());
        }
        else{
          Provider.of<OffersProvider>(context,listen: false).removeOtherProductsPriceWithEmiProduct(widget.priceNow!.toDouble());
        }

      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
            border: Border.all(
                color: Colors.grey[200]!, width: 1.w),
          ),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          height: 28.h,
          width: 35.w,
          child:
          widget.isEdit!? InkWell(
            onTap://(){},
            minus,
            child: Icon(
              Icons.remove,
              color: Colors.black,
              size: 18.h,
            ),
          ):Icon(
            Icons.remove,
            color: Colors.grey[300],
            size: 18.h,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 5, bottom: 5),
          color: Colors.grey.shade200,
          height: 28.h,
          width: 35.w,
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey[200]!, width: 1.w),
          ),
          padding: EdgeInsets.only(
              top: 5, bottom: 5),
          height: 28.h,
          width: 35.w,
          child:widget.isEdit!? InkWell(
            onTap: //(){},
            add,
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 18.h,
            ),
          ):Icon(
            Icons.add,
            color: Colors.grey[300],
            size: 18.h,
          ),
        ),
      ],
    );
  }
}