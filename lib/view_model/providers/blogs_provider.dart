
import 'package:b2connect_flutter/model/announcement_model.dart';
import 'package:b2connect_flutter/model/models/blogs_model/blogs.dart';
import 'package:b2connect_flutter/model/services/http_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Repository/repository_pattern.dart';

class BlogsProvider with ChangeNotifier {
  Repository? http = locator<HttpService>();

  get utilsService => null;
  List<Blogs> wellnessBlogsList = [];
  List<Blogs> moneyBlogsList = [];
  List<Blogs> mediaBlogsList = [];
  List<Blogs> healthBlogsList = [];
  List<Blogs> fitnessBlogsList = [];
  List<Blogs> meditationBlogsList = [];
  List<Blogs> paymentsBlogsList = [];
  List<Announcement> announcementList = [];
  Announcement? announcementDetails;

  Future<dynamic> getAnnouncementList() async {
    try {
      var response = await http!.getAnnouncements();
      if (response.statusCode == 200) {
        announcementList.clear();
        for (var data in response.data) {
          announcementList.add(Announcement.fromJson(data));
        }
        EasyLoading.dismiss();
        return response;
      } else {
        return utilsService.showToast("Something went wrong, Please Try again");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<dynamic> getAnnouncementDetail({int? id}) async {
    try {
      var response = await http!.getAnnouncementsDetail(id);
      if (response.statusCode == 200) {
        announcementDetails = Announcement.fromJson(response.data);
        EasyLoading.dismiss();
        return response;
      } else {
        return utilsService.showToast("Something went wrong, Please Try again");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<dynamic> getBlogsContent({
    int? page,
    String? category,
    String? screen,
  }) async {
    try {
      var response = await http!.getBlogs(page!, category!);
      if (response.statusCode == 200) {
        for (var data in response.data) {
          //  popularList.clear();
          if (screen == 'money') {
            moneyBlogsList.add(Blogs.fromJson(data));
          } else if (screen == 'health') {
            healthBlogsList.add(Blogs.fromJson(data));
          } else if (screen == 'wellness') {
            wellnessBlogsList.add(Blogs.fromJson(data));
          } else if (screen == 'media') {
            mediaBlogsList.add(Blogs.fromJson(data));
          } else if (screen == 'fitness') {
            fitnessBlogsList.add(Blogs.fromJson(data));
          } else if (screen == 'meditation') {
            meditationBlogsList.add(Blogs.fromJson(data));
          } else if (screen == 'payments') {
            paymentsBlogsList.add(Blogs.fromJson(data));
          }
        }
        EasyLoading.dismiss();
        return response;
      } else {
        return utilsService.showToast("Something went wrong, Please Try again");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }
}
