import 'dart:async';
import 'dart:io';

import 'package:badminton/repository/endpoint.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/media.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/user_response_model.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isUploading = false.obs;
  RxString profilePicUrl = ''.obs;
  RxString pickimagece = ''.obs;
  final ImagePicker _picker = ImagePicker();
  Rx<File?> pickedImage = Rx<File?>(null);
  late userResponseModel responseModel; // Changed to late for initialization
  MediaUploadResponseModel? mediaUploadResponseModel; // Allow null initially
  final APIRepository _apiRepository = Get.find<APIRepository>();
  RxDouble uploadProgress = 0.0.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddress = TextEditingController();
  final phoneController = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController(); // Renamed for consistency

  Rx<Country> selectedCountry = Rx<Country>(
    Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'India',
      example: '7012345678',
      displayName: 'India',
      displayNameNoCountryCode: 'India',
      e164Key: '',
    ),
  );

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    if (Get.arguments != null) {
      responseModel = Get.arguments["userdata"] ?? userResponseModel();
      firstNameController.text = responseModel.data?.firstName ?? "";
      lastNameController.text = responseModel.data?.lastName ?? "";
      emailAddress.text = responseModel.data?.email ?? "";
      phoneController.text = responseModel.data?.phoneNumber ?? "";
      profilePicUrl.value = "${responseModel.data?.profilePic}" ?? "";
    }
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailAddress.dispose();
    phoneController.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  Future<MediaUploadResponseModel?> callUploadMedia(File file) async {
    try {
      isLoading.value = true;
      isUploading.value = true;
      final response = await _apiRepository.mediaUploadApiCall(file);
      mediaUploadResponseModel = response;
      pickimagece.value = "";
      profilePicUrl.value =
          response.data?.imageKey ?? ''; // Update profilePicUrl
      hitSignupApiCall();

      return response;
    } catch (e, stackTrace) {
      isLoading.value = false;
      isUploading.value = false;
      debugPrint('Error during media upload: $e\nStack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to upload media. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      return null;
    }
  }

  Future<void> hitSignupApiCall() async {
    try {
      Get.closeAllSnackbars();

      final requestModel = AuthRequestModel.updateProfile(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        oldPassword: confirmPassword.text.trim(),
        password: newPassword.text.trim(),
        profilePic: profilePicUrl.value.isNotEmpty
            ? profilePicUrl.value
            : pickimagece.value, // Use uploaded image URL
      );

      final response =
          await _apiRepository.updateProfile(dataBody: requestModel);

      responseModel = response; // Update responseModel
      Get.back();

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e, stackTrace) {
      isLoading.value = false;
      debugPrint('Error during profile update: $e\nStack trace: $stackTrace');
      Get.snackbar(
        'Error',
        'Failed to update profile: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 85,
      );
      if (image != null) {
        pickedImage.value = File(image.path);
        debugPrint(
            'Image picked: ${image.path}, size: ${await image.length()} bytes');
        // Optionally upload immediately after picking
      } else {
        Get.snackbar('Info', 'No image selected');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }
}
