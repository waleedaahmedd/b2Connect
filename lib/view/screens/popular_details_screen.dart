import 'package:b2connect_flutter/model/models/blogs_model/blogs.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_html_css/simple_html_css.dart';

import '../../screen_size.dart';


class PopularDetailsScreen extends StatelessWidget {
  final int? _id;
  final List<Blogs>? _blogsList;

  const PopularDetailsScreen(this._blogsList, this._id) : super();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              navigationService.closeScreen();
            },
            icon: Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: height * 0.08,
        title: Text(
          'Blog',
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenSize.appbarText,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: gradientColor),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                child: Text(
                  '${_blogsList![_id!].category.toString()}'
                      .toUpperCase(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                '${_blogsList![_id!].title.toString()}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                width: double.infinity,
                height: 200,
                imageUrl: _blogsList![_id!].mediaURLs!.isNotEmpty
                    ? _blogsList![_id!].mediaURLs!.first
                    : 'assets/images/not_found1.png',
                placeholder: (context, url) =>
                    Image.asset('assets/images/placeholder1.png'),
                errorWidget: (context, url, error) => Center(
                  child: Image.asset(
                    'assets/images/not_found1.png',
                    // height: 100,
                  ),
                ),
                fit: BoxFit.fill,
              ), /*Image.network(
                  i.moneyPopularList[id!].mediaURLs!.first,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200,
                ),*/
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: HTML.toRichText(
                    context, _blogsList![_id!].fullText.toString())),
            SizedBox(
              height: 20,
            ),
            Text(
              'Tags',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(
              //spacing: 10,
              children:
                  List<Widget>.generate(_blogsList![_id!].tags!.length,
                      // place the length of the array here
                      (int index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 10.0),
                      child: Text(
                        '${_blogsList![_id!].tags![index].name.toString()}'
                            .toUpperCase(),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      )),
    );
  }
}
