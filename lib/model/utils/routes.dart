import 'package:b2connect_flutter/view/screens/cart_screen.dart';
import 'package:b2connect_flutter/view/screens/location_detail_screen.dart';
import 'package:b2connect_flutter/view/screens/shop_screen.dart';
import 'package:b2connect_flutter/view/screens/corporate_screen.dart';
import 'package:b2connect_flutter/view/screens/delete_account_screen.dart';
import 'package:b2connect_flutter/view/screens/edit_number_top_up_screen.dart';
import 'package:b2connect_flutter/view/screens/eid_details_screen.dart';
import 'package:b2connect_flutter/view/screens/job_detail_screen.dart';
import 'package:b2connect_flutter/view/screens/job_filter_screen.dart';
import 'package:b2connect_flutter/view/screens/job_screen.dart';
import 'package:b2connect_flutter/view/screens/job_search_screen.dart';
import 'package:b2connect_flutter/view/screens/media_screen.dart';
import 'package:b2connect_flutter/view/screens/money_screen.dart';
import 'package:b2connect_flutter/view/screens/spinner_screen.dart';
import 'package:b2connect_flutter/view/screens/top_up_categories_screen.dart';
import 'package:b2connect_flutter/view/screens/top_up_intro_screen.dart';
import 'package:b2connect_flutter/view/screens/travel_screen.dart';
import 'package:b2connect_flutter/view/screens/wellness_screen.dart';

import '../../view/screens/add_shipping_address.dart';
import '../../view/screens/cash_payment_intro_screen.dart';
import '../../view/screens/coming_soon_screen.dart';
import '../../view/screens/delete_confirmation_screen.dart';
import '../../view/screens/location_categories_screen.dart';
import '../../view/screens/locations_screen.dart';
import '../../view/screens/order_details_screen.dart';
import '../../view/screens/orders_screen.dart';
import '../../view/screens/notifications_list_screen.dart';
import '../../view/screens/points_screen.dart';
import '../../view/screens/rewards_payment_method_screen.dart';
import '../../view/screens/rewards_screen.dart';
import '../../view/screens/rewards_success_screen.dart';
import '../../view/screens/settings.dart';
import '../../view/screens/shipping_screen.dart';
import '../../view/screens/transactions.dart';
import '../../view/screens/transcation_details_screen.dart';
import '../../view/screens/upload_eid_image_screen.dart';
import '../../view/screens/wifi_plan.dart';
import '../../view/screens/wifi_screen.dart';
import '../../view/screens/wishlist_screen.dart';
import 'package:b2connect_flutter/view/screens/cash_payment_intro_screen.dart';
import 'package:b2connect_flutter/view/screens/order_details_screen.dart';
import 'package:b2connect_flutter/view/screens/orders_screen.dart';
import 'package:b2connect_flutter/view/screens/notifications_list_screen.dart';
import 'package:b2connect_flutter/view/screens/product_detail_screen.dart';
import 'package:b2connect_flutter/view/screens/settings.dart';
import 'package:b2connect_flutter/view/screens/transactions.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view/screens/transcation_details_screen.dart';
import 'package:b2connect_flutter/view/screens/wifi_plan.dart';
import 'package:b2connect_flutter/view/screens/wifi_screen.dart';
import 'package:flutter/material.dart';
import '../../view/screens/edit_personal_information_screen.dart';
import '../../view/screens/login_screen.dart';
import '../../view/screens/main_dashboard_screen.dart';
import '../../view/screens/main_profile_screen.dart';
import '../../view/screens/personal_information_screen.dart';
import '../../view/screens/scan_your_emirates_id_screen.dart';
import '../../view/screens/notification_detail_screen.dart';
import '../../view/screens/support_screen.dart';
import '../../view/screens/on_boarding_screen.dart';
import '../../view/screens/otp_screen.dart';
import '../../view/screens/signup_screen.dart';
import '../../view/screens/welcome_screen.dart';
import '../../view/screens/splash_screen.dart';

const SplashScreenRoute = '/splash-screen';
const WelcomeScreenRoute = '/Welcome-screen';
const SpinnerScreenRoute = '/Spinner-screen';
const SignupScreenRoute = '/signup-screen';
const OnBoardingRoute = '/on-boarding-screen';
//const SignUpForBt2Route = '/signupforbt2-Screen';
const OtpScreenRoute = '/otp-screen';
const HomeScreenRoute = '/home-screen';
const LoginScreenRoute = '/login-screen';
const WifiScreenV1Route = '/wifi-screen';
const WifiScreenRoute = '/wifi-screen';
const MainDashBoardRoute = '/maindashboard-screen';
const NotificationDetailScreenRoute = '/notification-detail-screen';
const SupportScreenRoute = '/support-screen';
const CameraSliderScreenRoute = '/camera-slider-screen';
const MainProfileScreenRoute = '/main-profile-screen';
const PersonalInformationScreenRoute = '/personal-information-screen';
const SortByScreenRoute = '/sort-by-screen';
const FilterScreenRoute = '/filter-screen';
const ScanYourEmiratesIDScreenRoute = '/ScanYourEmirates-Id-screen';
const ScanScreenRoute = '/scan-screen';
const EditPersonalInformationScreenRoute = '/edit-profile-information-screen';
const NotificationsListScreenRoute = '/notifications-list-screen';
const OrderDetailScreenRoute = '/order-detail-screen';
const EidDetailScreenRoute = '/eid-detail-screen';
const OrdersScreenRoute = '/orders-screen';
const CardInformationScreenRoute = 'card_information_screen';
const CartScreenRoute = 'cart_screen';
//const PaymentMethodScreenRoute = '/payment-method-screen';
const CashPaymentIntroScreenRoute = '/cash-Payment-intro-screen';
const TopUpIntroScreenRoute = '/topUp-Intro-screen';

const AddShippingAddressScreenRoute = '/add-shipping-address-screen';
const SettingsScreenRoute = '/setting-screen';
const TransactionsScreenRoute = '/transaction-screen';
const WifiPlanScreenRoute = '/wifi-plan-screen';
//const TopUpScreenRoute = '/top-up-screen';
const ViewAllOffersScreenRoute = '/view-all-offers-screen';

const TransactionsDetailScreenRoute = '/transcation-details-screen';
const ProductDetailScreenRoute = '/product-details-screen';
const ShippingScreenRoute = 'shipping-screen';
const WishlistScreenRoute = '/wishlist-screen';
const ShopScreenRoute = '/shop-screen';
//const OrderReviewScreenRoute='/order-preview-screen';
// const SuccessScreenRoute='/success-screen-route';
const MoneyScreenRoute = '/money-screen-route';
const CorporateScreenRoute = '/corporate-screen-route';
const WellnessScreenRoute = '/wellness-screen-route';
const MediaScreenRoute = '/media-screen-route';
const EditNumberTopUpScreenRoute = '/edit-number-topup-screen-route';
const TopUpCategoriesScreenRoute = '/topup-categories-screen-route';

const JobScreenRoute = '/job-screen-route';
const JobDetailScreenRoute = '/job-detail-screen-route';
const JobSearchScreenRoute = '/job-search-screen-route';
const JobFilterScreenRoute = '/job-filter-screen-route';
const DeleteAccountScreenRoute = '/delete-account-screen-route';
const DeleteConfirmationScreenRoute = '/delete-confirmation-screen-route';
const ComingSoonScreenRoute = '/coming-soon-screen-route';
const LocationsScreenRoute = '/locations-screen-route';
const LocationDetailScreenRoute = '/locations-detail-screen-route';
const UploadEidImageScreenRoute = '/upload-eid-image-screen-route';
const PointsScreenRoute = '/points-screen-route';
const RewardsScreenRoute = '/rewards-screen-route';
const RewardsPaymentMethodScreenRoute = '/rewards-payment-method-screen-route';
const RewardsSuccessScreenRoute = '/rewards-success-screen-route';






const TravelScreenRoute = '/travel-screen-route';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case PersonalInformationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PersonalInformationScreen());

    case RewardsSuccessScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => RewardsSuccessScreen());

    case RewardsPaymentMethodScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => RewardsPaymentMethodScreen());

    case RewardsScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => RewardsScreen());

    case ComingSoonScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ComingSoonScreen());

    case UploadEidImageScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => UploadEidImageScreen());

    case LocationDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LocationDetailScreen());

    case LocationsScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LocationsScreen());

    case ScanYourEmiratesIDScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ScanYourEmiratesIDScreen());

    case DeleteAccountScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DeleteAccountScreen());

    case DeleteConfirmationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => DeleteConfirmationScreen());

    case TopUpCategoriesScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => TopUpCategoriesScreen());

    case JobScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => JobScreen());

    case JobDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => JobDetailScreen());

    case TravelScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => TravelScreen());

    case JobSearchScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => JobSearchScreen());

    case JobFilterScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => JobFilterScreen());

    case EditNumberTopUpScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EditNumberTopUpScreen());

    case EditPersonalInformationScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EditPersonalInformationScreen());

    case SplashScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen());

    case ShippingScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ShippingScreen());

    case AddShippingAddressScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => AddShippingAddress());

    case ViewAllOffersScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ViewAllOffersScreen(10));

    case WelcomeScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WelcomeScreen());

    case SpinnerScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SpinnerScreen());

    case WishlistScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WishlistScreen());

    case SignupScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SignupScreen());

    case OnBoardingRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => OnBoardingScreen());

    case CartScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => CartScreen());

    case OtpScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => OtpScreen());

    case MoneyScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MoneyScreen());

    case CorporateScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CorporateScreen());

    case WellnessScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WellnessScreen());

    case MediaScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MediaScreen());

    /* case TopUpScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => EditNumberTopUpScreen());*/

    case HomeScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainDashBoard(
                selectedIndex: 0,
              ));

    /*case SortByScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SortByScreen());*/

    /*case FilterScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => NewFilterScreen());*/

    case ShopScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => ShopScreen());

    case WifiPlanScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => WifiPlanScreen());

    case WifiScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => WifiScreen());

    case LoginScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => LoginScreen());

    case NotificationDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => NotificationDetailScreen());

    case NotificationsListScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => NotificationsListScreen());

    case SupportScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => SupportScreen());

    case MainProfileScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => MainProfileScreen());

    case OrdersScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => OrdersScreen());

    case CashPaymentIntroScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => CashPaymentIntroScreen());

    case TopUpIntroScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => TopUpIntroScreen());

    case SettingsScreenRoute:
      return MaterialPageRoute(builder: (BuildContext context) => Settings());

    case TransactionsScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => Transactions());

    case OrderDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => OrderDetailScreen());

    case EidDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => EidDetailsScreen());

    case TransactionsDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => TransactionDetailsScreen());

    case ProductDetailScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => ProductDetailScreen());

    case PointsScreenRoute:
      return MaterialPageRoute(
          builder: (BuildContext context) => PointsScreen());

    default:
      return MaterialPageRoute(
          builder: (BuildContext context) => OnBoardingScreen());
  }
}
