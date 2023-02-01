import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/job_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class JobScreen extends StatefulWidget {
  const JobScreen({Key? key}) : super(key: key);

  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  bool _connectedToInternet = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<JobProvider>().jobCategoriesList = null;

    setDefaultValues();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobProvider>(builder: (context, i, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            navigationService.closeScreen();
          },
        ),
        body: i.jobCategoriesList == null
            ? Container()
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(
                                  context)!
                                  .translate('select_job_category')!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 80.0),
                            child: GridView.builder(
                              itemCount:
                                  i.jobCategoriesList!.categories!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectCategory(i, index);
                                  },
                                  child: Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: i.jobCategorySelected ==
                                                  i
                                                      .jobCategoriesList!
                                                      .categories![index]
                                                      .categoryId
                                              ? Theme.of(context).primaryColor
                                              : Colors.grey,
                                          width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                i.jobCategoriesList!
                                                    .categories![index].name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 10.h,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              )),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: i
                                                                    .jobCategoriesList!
                                                                    .categories![
                                                                        index]
                                                                    .image ==
                                                                ""
                                                            ? Image.asset(
                                                                'assets/images/not_found1.png',
                                                                // height: 100.h,
                                                              )
                                                            : CachedNetworkImage(
                                                                // width: 100.w,
                                                                // height: 100.h,
                                                                imageUrl: i
                                                                    .jobCategoriesList!
                                                                    .categories![
                                                                        index]
                                                                    .image!,
                                                                height: 40.h,

                                                                placeholder: (context,
                                                                        url) =>
                                                                    Image.asset(
                                                                  'assets/images/placeholder1.png',
                                                                ),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    Image.asset(
                                                                  'assets/images/not_found1.png',
                                                                  // height: 100,
                                                                ),
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                      ))),
                                              SizedBox(
                                                height: 20.h,
                                                width: 20.w,
                                                child: Transform.scale(
                                                  scale: 1.5,
                                                  child: Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    side: BorderSide(
                                                      width: 1,
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                    value: i.jobCategorySelected ==
                                                            i
                                                                .jobCategoriesList!
                                                                .categories![
                                                                    index]
                                                                .categoryId
                                                        ? true
                                                        : false,
                                                    onChanged: (bool? value) {
                                                      selectCategory(i, index);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      childAspectRatio: 3 / 2.3,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                          height: 50.h,
                          width: double.infinity,
                          onPressed: () async {
                            i.jobSelectedCategoryCount == 0
                                ? EasyLoading.showError('No Job found')
                                : moveToJobScreen(i);
                          },
                          text: i.jobCategorySelected == ''
                              ? '${AppLocalizations.of(
                              context)!
                              .translate('show')!} ${i.jobCategoriesList!.totalJobCount!} ${AppLocalizations.of(
                              context)!
                              .translate('jobs')!}'
                              : '${AppLocalizations.of(
                              context)!
                              .translate('show')!} ${i.jobSelectedCategoryCount} ${AppLocalizations.of(
                              context)!
                              .translate('jobs')!}',
                        ),
                      ],
                    ),
                  )
                ],
              ),
      );
    });
  }

  getJobCategoryData() async {
    EasyLoading.show(status: 'Please Wait...');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await context.read<JobProvider>().getJobCategories();
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  getJobListData() async {
    EasyLoading.show(status: 'Please Wait...');
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await context.read<JobProvider>().getJobList();
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  moveToJobScreen(JobProvider i) async {
    i.clearJobProvider();
    i.jobList.clear();
    await getJobListData();
    navigationService.navigateTo(JobSearchScreenRoute);
  }

  Future<void> setDefaultValues() async {
    await getJobCategoryData();
    context.read<JobProvider>().setJobCategorySelected('');
  }

  void selectCategory(JobProvider i, int index) {
    i.jobCategorySelected == i.jobCategoriesList!.categories![index].categoryId
        ? i.setJobCategorySelected('')
        : i.setJobCategorySelected(
            i.jobCategoriesList!.categories![index].categoryId!);
    i.setJobSelectedCategoryCount(
        i.jobCategoriesList!.categories![index].jobCount!);
  }
}
