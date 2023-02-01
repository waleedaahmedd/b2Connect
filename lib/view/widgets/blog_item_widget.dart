import 'package:b2connect_flutter/model/models/blogs_model/blogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlogItemWidget extends StatelessWidget {

  final List<Blogs> _blogsList;
  final  int _blogsIndex;
  const BlogItemWidget(this._blogsList, this._blogsIndex) : super();



  @override
  Widget build(BuildContext context) {
    return Wrap(
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
                        imageUrl: _blogsList[_blogsIndex]
                            .mediaURLs!.isNotEmpty
                            ? _blogsList[_blogsIndex].mediaURLs!
                            .first
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
                  Container(
                    height: 40,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${_blogsList[_blogsIndex].title}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        //textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
