import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/custom_app_theme.dart';
import 'package:badminton/firebase_options.dart';
import 'package:badminton/modules/courtscreens/bindings/booking_detail_binding.dart';
import 'package:badminton/modules/courtscreens/view/bookingDetail.dart';
import 'package:badminton/modules/profile/bindings/package_bindings.dart';
import 'package:badminton/repository/api_repository.dart';
import 'package:badminton/repository/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:badminton/services/notification_service.dart';
import 'modules/auth_module/binding /changepassword_binding.dart';
import 'modules/auth_module/binding /forget_password_binding.dart';
import 'modules/auth_module/binding /login_binding.dart';
import 'modules/auth_module/binding /otpbinding.dart';
import 'modules/auth_module/binding /signup_binding.dart';
import 'modules/auth_module/view/changepassword_screen.dart';
import 'modules/auth_module/view/forgetpasswordscreen.dart';
import 'modules/auth_module/view/login_screen.dart';
import 'modules/auth_module/view/otp_verification screen.dart';
import 'modules/auth_module/view/signup_sceen.dart';
import 'modules/cart/bindings/my_order_detail_binding.dart';
import 'modules/cart/bindings/my_orders_bindings.dart';
import 'modules/cart/bindings/orderAddressBinding.dart';
import 'modules/cart/bindings/orderSummaryBinding.dart';
import 'modules/cart/controller/cart_controller.dart';
import 'package:badminton/modules/notification/view/notification_view.dart';
import 'package:badminton/modules/notification/controller/notification_controller.dart';

import 'modules/cart/view/My_Orders.dart';
import 'modules/cart/view/myOrderDetailPage.dart';
import 'modules/cart/view/orderAddress.dart';
import 'modules/cart/view/orderSummary.dart';
import 'modules/chat_module /bindings/chat_Controller_binding.dart';
import 'modules/chat_module /bindings/messaging_binding.dart';
import 'modules/chat_module /view/chat_Scree.dart';
import 'modules/chat_module /view/messaging.dart';
import 'modules/courtscreens/bindings/confirm_payment_binding.dart';
import 'modules/courtscreens/bindings/court_detail_binding.dart';
import 'modules/courtscreens/view/confirm_payment.dart';
import 'modules/courtscreens/view/court_detail_view.dart';
import 'modules/creategames/binding/create_game_binding.dart';
import 'modules/creategames/binding/get_all_bookings_bindings.dart';
import 'modules/creategames/binding/mybookingbindings.dart';
import 'modules/creategames/binding/upload_score_binding.dart';
import 'modules/creategames/view/create_game_view.dart';
import 'modules/creategames/view/getMyBookings.dart';
import 'modules/creategames/view/getallbookings.dart';
import 'modules/creategames/view/upload_score.dart';
import 'modules/home /binding/dashboard_binding.dart';
import 'modules/home /view/dashboard_screen.dart';
import 'modules/merchandise/binding /Refferral_binding.dart';
import 'modules/merchandise/binding /merchandise_binding.dart';
import 'modules/merchandise/binding /play_coins_bindings.dart';
import 'modules/merchandise/binding /privacy_policy_binding.dart';
import 'modules/merchandise/binding /product_detail_binding.dart';
import 'modules/merchandise/view /Referal_Screen.dart';
import 'modules/merchandise/view /merchandise_view.dart';
import 'modules/merchandise/view /play_Coins_screen.dart';
import 'modules/merchandise/view /privacy_Policy.dart';
import 'modules/merchandise/view /productdetailview.dart';
import 'modules/notification/bindings/notificationbinding.dart';
import 'modules/playgame/bindings/Join_Game_Booking_Binding.dart';
import 'modules/playgame/bindings/join_game_bindings.dart';
import 'modules/playgame/view/joinGameBookingScreen.dart';
import 'modules/playgame/view/join_game_detail.dart';
import 'modules/profile/bindings/all_friend_request_binding.dart';
import 'modules/profile/bindings/all_users_bindings.dart';
import 'modules/profile/bindings/blocklist_binding.dart';
import 'modules/profile/bindings/edit_profile_bindings.dart';
import 'modules/profile/bindings/friend_request_binding.dart';
import 'modules/profile/bindings/user_profile_info_binding.dart';
import 'modules/profile/view/all_friendRequests.dart';
import 'modules/profile/view/allusers.dart';
import 'modules/profile/view/block_list.dart';
import 'modules/profile/view/edit_profile_screen.dart';
import 'modules/profile/view/friend_request_view.dart';
import 'modules/profile/view/packages.dart';
import 'modules/profile/view/user_profile_info.dart';
import 'modules/splash/binding /splash_binding.dart';
import 'modules/splash/binding /splash_second_binding.dart';
import 'modules/splash/view/splash_screen.dart';
import 'modules/splash/view/splashsecond_screen.dart';

// Define the background handler as a top-level function
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase if not already initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  
  // Print message data
  debugPrint('Handling a background message: ${message.messageId}');
  debugPrint('Message data: ${message.data}');
  debugPrint('Message notification: ${message.notification?.title}');
  
  // No need to show a notification here as the system will do it automatically
  // for background messages on Android and iOS
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  await GetStorage.init();

  // Initialize dependencies
  Get.put(APIRepository());
  Get.lazyPut<LocalStorage>(() => LocalStorage(), fenix: true);

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize notification service
  final notificationService = NotificationService();
  await notificationService.init();
  Get.put(notificationService, permanent: true);

  // Initialize cart controller
  Get.put(CartController(), permanent: true);

  // Determine initial route
  String initialRoute = '/splash';
  final localStorage = Get.find<LocalStorage>();
  final apiRepository = Get.find<APIRepository>();
  final token = localStorage.getAuthToken();

  // Check onboarded status
  final bool? isOnboarded = localStorage.getOnboarded();
  if (isOnboarded == true) {
    initialRoute = '/login';
  } else {
    initialRoute = '/splash';
  }

  if (token != null && token.isNotEmpty) {
    try {
      // Call the profile API
      await apiRepository.getuser();
      // If API call is successful, set initial route to dashboard
      initialRoute = '/dashboard';
    } catch (e) {
      // If API call fails (e.g., invalid token), redirect to login
      initialRoute = '/login';
      localStorage.removeAuthToken();
    }
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(CustomAppTheme.designWidth, CustomAppTheme.designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          initialRoute: initialRoute,
          getPages: [
            GetPage(
              name: '/splash',
              page: () => const SplashScreen(),
              binding: SplashBinding(),
            ),
            GetPage(
              name: '/splashSecond',
              page: () => const SplashSecond(),
              binding: SplashSecondBinding(),
            ),
            GetPage(
              name: '/signup',
              page: () => const PgSignup(),
              binding: SignupBinding(),
            ),
            GetPage(
              name: '/otpVerification',
              page: () => const PgOtpVerification(),
              binding: OtpVerificationBinding(),
            ),
            GetPage(
              name: '/login',
              page: () => const PgSignin(),
              binding: LoginBinding(),
            ),
            GetPage(
              name: '/forget',
              page: () => const PgForgotPassword(),
              binding: ForgotPasswordBinding(),
            ),
            GetPage(
              name: '/changePass',
              page: () => const PgChangePassword(),
              binding: ChangepasswordBinding(),
            ),
            GetPage(
              name: '/dashboard',
              page: () => const PgDashBoard(),
              binding: DashboardBinding(),
            ),
            GetPage(
              name: '/creategame',
              page: () => const PgVenues(),
              binding: VenueBinding(),
            ),
            GetPage(
              name: '/courtdetail',
              page: () => const PgCourtdetail(),
              binding: PgCourtdetailBinding(),
            ),
            GetPage(
              name: '/allusers',
              page: () => const AllUsers(),
              binding: AllUsersBindings(),
            ),
            GetPage(
              name: '/userprofiledetail',
              page: () => const PgProfileDetail(),
              binding: PgProfileDetailBinding(),
            ),
            GetPage(
              name: '/requests',
              page: () => const PgFriends(),
              binding: FriendsBinding(),
            ),

            GetPage(
              name: '/allRequests',
              page: () => const PgFriendRequests(),
              binding: FriendRequestsBinding(),
            ),
            GetPage(
              name: '/block-list',
              page: () => const PgBlockList(),
              binding: BlockListBinding(),
            ),
            GetPage(
              name: '/confirm_payment',
              page: () =>  PgConfirmpayment(),
              binding: PgConfirmPaymentBinding(),
            ),
            GetPage(
              name: '/allbookings',
              page: () =>  Getallbookings(),
              binding: GetAllBookingsBindings(),
            ),
            GetPage(
              name: '/mybookings',
              page: () =>  Getmybookings(),
              binding: GetMyBookingsBindings(),
            ),
            GetPage(
              name: '/uploadScore',
              page: () =>  UploadScoreById(),
              binding: UploadScoreBinding(),
            ),
            GetPage(
              name: '/editProfile',
              page: () =>  EditProfileScreen(),
              binding: EditProfileBindings(),
            ),
            GetPage(
              name: '/join_game_detail',
              page: () =>  PgJoinGameDetail(),
              binding: PgJoinGameDetailBinding(),
            ),

            GetPage(
              name: '/joinGamePayment',
              page: () =>  PgJoinConfirmpayment(),
              binding: PgJoinPaymentBinding(),
            ),

            GetPage(
              name: '/messages',
              page: () =>  PgMessages(),
              binding: MessagesBinding(),
            ),

            GetPage(
              name: '/chat_screen',
              page: () =>  PgChatView(),
              binding: ChatBinding(),
            ),

            GetPage(
              name: '/merchandise',
              page: () =>  PgMerchandise(),
              binding: MerchandiseBinding(),
            ),

            GetPage(
              name: '/productdetail',
              page: () =>  PgProductDetail(),
              binding: PgProductDetailBinding(),
            ),


            GetPage(
              name: '/orderAddress',
              page: () =>  Orderaddress(),
              binding: OrderAddressBinding(),
            ),


            GetPage(
              name: '/orderSummary',
              page: () =>  PgOrderSummary(),
              binding: PgOrderSummaryBinding(),
            ),

            GetPage(
              name: '/my_orders',
              page: () =>  PgMyOrders(),
              binding: PgMyOrderBindings(),
            ),

            GetPage(
              name: '/my_orders_detail',
              page: () =>  Myorderdetailpage(),
              binding: MyOrderDetailBinding(),
            ),

            GetPage(
              name: '/PrivacyPolicy',
              page: () =>  PgPrivacyPolicy(),
              binding: PrivacyPolicyBinding(),
            ),


            GetPage(
              name: '/TrasactionHistory',
              page: () =>  PgPlayCoins(),
              binding: PlayCoinsBinding(),
            ),


            GetPage(
              name: '/Referrals',
              page: () =>  PgReferCode(),
              binding: ReferCodeBinding(),
            ),
            GetPage(
              name: '/notification',
              page: () =>  NotificationView(),
              binding: Notificationbinding()

            ),

            GetPage(
                name: '/package_screen',
                page: () =>  PgPackagesView(),
                binding: PgPackagesBinding()

            ),
            GetPage(
                name: '/booking_detail',
                page: () =>  BookingDetailPage(),
                binding: BookingDetailBinding()

            ),
          ],
        );
      },
    );
  }
}
