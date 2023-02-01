import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../view_model/providers/location_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';

class LocationDetailScreen extends StatefulWidget {
  const LocationDetailScreen({Key? key}) : super(key: key);

  @override
  _LocationDetailScreenState createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {

  static const LatLng _center = const LatLng(24.467600, 39.605440);

  final Set<Marker> _markers = {Marker(
  // This marker id can be anything that uniquely identifies each marker.
  markerId: MarkerId(_center.toString()),
  position: _center,
  infoWindow: InfoWindow(
  title: 'Really cool place',
  snippet: '5 Star Rating',
  ),
  icon: BitmapDescriptor.defaultMarker,
  )};

  LatLng _lastMapPosition = _center;

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  Completer<GoogleMapController> _controller = Completer();

   CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.467600, 39.605440),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          Navigator.pop(context);
        },
      ),
      body:
          Consumer<LocationProvider>(builder: (context, _locationProvider, _) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 400.h,
                    child:GoogleMap(
                      onCameraMove: _onCameraMove,
                      markers: _markers,
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Al Madina Supermarket',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          '1.2 km away',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w200,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Fresh fruits, vegetables, diary products and meat available',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w200),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              color: Theme.of(context).primaryColor,
                              size: 18.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '971501234567',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                color: Theme.of(context).primaryColor,
                                size: 18.h),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              '9AM - 9PM',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        SizedBox(height: 70.h)
                      ],
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
                      Uri url = Uri.parse("tel:+971501234567");
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    text: 'Call Now',
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
