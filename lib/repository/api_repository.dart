import 'dart:convert';
import 'dart:io';

import 'package:badminton/modules/auth_module/models/otpVerificationResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/Payment_ResponseModel.dart';
import 'package:badminton/modules/creategames/model/BookingResponseModel.dart';
import 'package:badminton/modules/creategames/model/venue_data_model.dart';
import 'package:badminton/modules/merchandise/model%20/AddToCartListModel.dart';
import 'package:badminton/modules/merchandise/model%20/AllmerchandiseModel.dart';
import 'package:badminton/modules/merchandise/model%20/product_detail_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../models/notification_model.dart';
import '../modules/auth_module/models/forget_password_responsemodel.dart';
import '../modules/auth_module/models/resend_otp_responsemodel.dat.dart';
import '../modules/auth_module/models/user_response_model.dart';
import '../modules/cart/model/OrderResponse.dart';
import '../modules/cart/model/myOrderDetailResponseModel.dart';
import '../modules/cart/model/my_orders_responseModel.dart';
import '../modules/cart/model/transaction_history_response.dart';
import '../modules/chat_module /models/ChatMessageList.dart';
import '../modules/chat_module /models/ChatModels.dart';
import '../modules/chat_module /models/messages.dart';
import '../modules/courtscreens/models/BookingDetailResponseModel.dart';
import '../modules/courtscreens/models/BookingResponseModel.dart';
import '../modules/courtscreens/models/court_detail_model.dart';
import '../modules/creategames/model/AllBookingsResponseModel.dart';
import '../modules/creategames/model/upload_Score_responseModel.dart';
import '../modules/home /models/getOpenResponseModel.dart';
import '../modules/home /models/home_response_model.dart';
import '../modules/merchandise/model /AddToCartModel.dart';
import '../modules/merchandise/model /ContentModel.dart';
import '../modules/playgame/model/Join_Open_match.dart';
import '../modules/playgame/model/join_Booking_detail.dart';
import '../modules/profile/models/AllUsersModel.dart';
import '../modules/profile/models/Get_friend_request_model.dart';
import '../modules/profile/models/blocklist_datamodel.dart';
import '../modules/profile/models/friend_Request_Responsemodel.dart';
import '../modules/profile/models/get_user_by_id_model.dart';
import '../modules/profile/models/individual_chat_start.dart';
import '../modules/profile/models/packgeModel.dart';
import 'dio_client.dart';
import 'endpoint.dart';
import 'media.dart';
import 'network_exceptions.dart';
import 'package:dio/dio.dart' show MultipartFile, MediaType;

enum UploadFileType { image, video, unknown }
class APIRepository {
  static late DioClient? dioClient;
  var deviceName, deviceType, deviceID, deviceVersion;

  APIRepository() {
    var dio = Dio();

    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    dioClient = DioClient(baseUrl, dio);
    // getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = "ANDROID"; /* androidDeviceInfo.model;*/
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.systemName;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }

  // ****************************Signup*****************************
  Future signupApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(signupEndPoint, data: json.encode(dataBody!));
      return userResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future logoutApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(logOutEndPoint, data: json.encode(dataBody!),skipAuth: false);
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  Future updateProfile({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.put(updateProfileEndPoints, data: json.encode(dataBody!),skipAuth: false);
      return userResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  // ****************************email Verify *****************************
  Future emailVerifyApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(emailVerifyEndPoint,
          data: json.encode(dataBody!), skipAuth: false);
      return OtpVerification.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  // ****************************email Verify *****************************
  Future resendOtpApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(resendOtpEndPoints, data: json.encode(dataBody!));
      return ResendOtpResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future forgetPassApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(forgetPasswordEndPoints, data: json.encode(dataBody!));
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future resetPassApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .patch(resetEndPoints, data: json.encode(dataBody!), skipAuth: false);
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future forgetVerifyOtpApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(forgetOtpVerifyEndPoints,
          data: json.encode(dataBody!), skipAuth: false);
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future bookCourtApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(bookingEndPoints,
          data: json.encode(dataBody!), skipAuth: false);
      return BookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future JoinCourtApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(JoinbookingEndPoints,
          data: json.encode(dataBody!), skipAuth: false);
      return JoinOpenMatchResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future MessageApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(MessageChatApi,
          data: json.encode(dataBody!), skipAuth: false);
      return Messages.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future IndividualChatCreate({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(IndividualChatCreateApi,
          data: json.encode(dataBody!), skipAuth: false);
      return IndividualStartChat.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future PaymentApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(paymentEndPoints,
          data: json.encode(dataBody!), skipAuth: false);
      return PaymentResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  UploadFileType getFileType(String filePath) {
  final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp'];
  final videoExtensions = ['.mp4', '.avi', '.mkv', '.mov', '.wmv'];

  final ext = filePath.toLowerCase().split('.').last;

  if (imageExtensions.contains('.$ext')) {
  return UploadFileType.image;
  } else if (videoExtensions.contains('.$ext')) {
  return UploadFileType.video;
  } else {
  return UploadFileType.unknown;
  }
  }


  Future<MediaUploadResponseModel> mediaUploadApiCall(File file) async {
    try {
      final type = getFileType(file.path); // e.g., returns MediaTypeEnum.image or similar
      final fileExtension = file.path.split('.').last.toLowerCase();

      final multipart = await MultipartFile.fromFile(
        file.path,
        filename: file.uri.pathSegments.last,
        contentType: MediaType(type.name, fileExtension), // Use Dio's MediaType
      );




      final formData = FormData.fromMap({"image": multipart});

      final response = await dioClient!.post(
        fileUploadEndPoint,
        data: formData,
        skipAuth: false
      );

      return MediaUploadResponseModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }


  Future uploadScore({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(uploadScoreEndPoints,
          data: json.encode(dataBody!), skipAuth: false);
      return UploadScoreResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  // ****************************login*****************************
  Future loginApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
          await dioClient!.post(loginEndPoints, data: json.encode(dataBody!));
      return userResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future getuser({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.get(getProfileEndPoint,skipAuth: false);
      return userResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getMerchandise({Map<String, dynamic>? dataBody,query}) async {
    try {
      final response =
      await dioClient!.get(getMerchandiseEndPoint,skipAuth: false,queryParameters: query);
      return AllMerchadiseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future getMerchandiseById({Map<String, dynamic>? dataBody,query,required String? Id}) async {
    try {
      final response =
      await dioClient!.get("${getMerchandiseEndPoint}/$Id",skipAuth: false,queryParameters: query);
      return ProductDetailModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future getjoinBookingDetail({required String? Id}) async {
    try {
      final response =
      await dioClient!.get("${getJoinBookingDetail}/$Id",skipAuth: false);
      return JoinBookingDetail.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future socialLoginApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(socialLoginEndPoint, data: json.encode(dataBody!));
      return userResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future<HomeDataModel> getHomeDataApi({
    Map<String, dynamic>? dataBody,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dioClient!.get(
        getHomeDataEndPoints,
        skipAuth: false,
        queryParameters: query,
      );
      return HomeDataModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future<VenueDataModel> getVenueDataApi({

    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dioClient!.get(
        getVenuesDataEndPoints,
        skipAuth: false,
        queryParameters: query,
      );
      return VenueDataModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }




  Future<AllUsersModel> getAllUsers({

    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dioClient!.get(
        getAllUserEndPoints,
        skipAuth: false,
        queryParameters: query,
      );
      return AllUsersModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }


  Future<GetUserIdResponseModel> getUserId({
    required String? id,
  }) async {
    try {
      print(">>>>>>>>id>>>>>>>>>>>>>>>>>>${id}");
      final response = await dioClient!.get(
        "${getUserByIdEndPoints}/${id}",
        skipAuth: false,
      );
      return GetUserIdResponseModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future<GetRequestsResponseModel> getRequest(query) async {
    try {

      final response = await dioClient!.get(
        "${getRequestEndPoints}",
        skipAuth: false,
        queryParameters: query
      );
      return GetRequestsResponseModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }


  Future<BlocklistModel> getBlockedUsers(query) async {
    try {
      final response = await dioClient!.get(
          "${getRequestEndPoints}",
          skipAuth: false,
          queryParameters: query
      );
      return BlocklistModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future<GetCourtDetailResponseModel> getCourtDetail(query) async {
    try {
      final response = await dioClient!.get(
          "${courtInfoEndPoints}",
          skipAuth: false,
          queryParameters: query
      );
      return GetCourtDetailResponseModel.fromJson(response);
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future sendFriendRequest({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(sendRequestEndPoints, data: json.encode(dataBody!),skipAuth: false);
      return FriendRequestResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future confirmFriendRequest({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(confirmRequestEndPoints, data: json.encode(dataBody!),skipAuth: false);
      return  ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future blockFriendRequest({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!
          .post(blockRequestEndPoints, data: json.encode(dataBody!),skipAuth: false);
      return  ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future getAllBookings({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.get(getBookingsEndPoints,skipAuth: false);
      return UpcomingBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future getAllopenBookings({Map<String, dynamic>? dataBody,query}) async {
    try {
      final response =
      await dioClient!.get(getopenBookingsEndPoints,skipAuth: false,queryParameters: query);
      return GetOpenResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  Future getchat({Map<String, dynamic>? dataBody,query}) async {
    try {
      final response =
      await dioClient!.get(getChatMessages,skipAuth: false,queryParameters: query);
      return ChatMessages.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future getchatList({Map<String, dynamic>? dataBody,query, required String? Id}) async {
    try {
      final response =
      await dioClient!.get("${getChatMessagesList}/${Id}",skipAuth: false,queryParameters: query);
      return ChatMessagesList.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  Future uploadScoreBooking({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.get(getAllBookingsEndPoints,skipAuth: false);
      return AllBookingResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future CancleBookingApi({Map<String, dynamic>? dataBody}) async {
    try {
      final response =
      await dioClient!.post(cancelBooking,skipAuth: false,data: dataBody);
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  //***************************ADD TO CART*******************************************

  Future AddToCartApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(AddtocartApi,
          data: json.encode(dataBody!), skipAuth: false);
      return AddToCart.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future GetAddToCartApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.get(AddtocartApi, skipAuth: false);
      return AddToCartList.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future MyOrderDetailApiCall({Map<String, dynamic>? dataBody,required String? OrderId}) async {
    try {
      final response = await dioClient!.get("${myOderDetailEndPoints}/${OrderId}", skipAuth: false);
      return MyOrderDetailResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future GetMyOrders({Map<String, dynamic>? dataBody,query}) async {
    try {
      final response = await dioClient!.get(MyOrders, skipAuth: false,queryParameters: query);
      return My_Orders_Response.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future GetContentApi() async {
    try {
      final response = await dioClient!.get(ContentEndPoint, skipAuth: false);
      return ContentResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future GetTrasactions() async {
    try {
      final response = await dioClient!.get(TransactionHistoryEndPoint, skipAuth: false);
      return TransactionResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future RemoveAddToCartApiCall({Map<String, dynamic>? dataBody}) async {
    try {
      // If cartId is provided, delete specific item, otherwise clear entire cart
      // final String endpoint = cartId != null ? "$AddtocartApi/$cartId" : AddtocartApi;
      final response = await DioClient.delete(AddtocartApi,
          data: json.encode(dataBody!), skipAuth: false);
      return AddToCartList.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future OrderCartApiCall({Map<String, dynamic>? dataBody}) async {
    try {

      final response = await dioClient!.post(OrderPostApi,
          data: json.encode(dataBody!), skipAuth: false);
      return OrderCreateResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future AddToCartUpdate({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.put(AddtocartApi,
          data: json.encode(dataBody!), skipAuth: false);
      return ForgetPasswordModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future<NotificationResponse?> getNotifications({query}) async {
    try {
      final response = await dioClient!.get(
        notificationsEndPoint,
        skipAuth: false,
        queryParameters: query
      );
      return NotificationResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

  Future<PackagesResponseModel?> getPackages({query}) async {
    try {
      final response = await dioClient!.get(
          packagesEndPoint,
          skipAuth: false,
          queryParameters: query
      );
      return PackagesResponseModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }


  Future<OrderCreateResponse?> BuyPackages({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
          packagesEndPoint,
          skipAuth: false,
        data: json.encode(dataBody!),
      );
      return OrderCreateResponse.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  Future<BookingDetailModel?> getBookingDetailApi({query,String?id}) async {
    try {
      final response = await dioClient!.get(
          "${BookingDetailEndPoint}/${id}",
          skipAuth: false,
          queryParameters: query
      );
      return BookingDetailModel.fromJson(response);
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }



  //
  Future<dynamic> markNotificationAsRead({Map<String, dynamic>? dataBody}) async {
    try {
      final response = await dioClient!.post(
        "${notificationsEndPoint}",
        skipAuth: false, data: json.encode(dataBody),
      );
      return response;
    } catch (e) {
      return Future.error(NetworkExceptions.getDioException(e));
    }
  }

}
