import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:flutter/material.dart';

// Widget noInternet(context){
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       //crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Container(
//             height: 70,
//             child: Image.asset('assets/images/no_internet.png')
//         ),
//         SizedBox(height: 5,),
//         Text(AppLocalizations.of(context)!.translate('error')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//         SizedBox(height: 5,),
//         Text(AppLocalizations.of(context)!.translate('error_desc')!,textAlign: TextAlign.center,)
//       ],
//     ),
//   );
// }

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 70,
              child: Image.asset('assets/images/no_internet.png')
          ),
          SizedBox(height: 5,),
          Text(AppLocalizations.of(context)!.translate('error')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(AppLocalizations.of(context)!.translate('error_desc')!,textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
