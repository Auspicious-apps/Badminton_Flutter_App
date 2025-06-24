import 'dart:async';

import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/modules/merchandise/model%20/AddToCartModel.dart';
import 'package:badminton/modules/merchandise/model%20/AddToCartListModel.dart';
import 'package:badminton/repository/endpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../model/cart_item_model.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  AddToCart cartDAta = AddToCart();
  Rx<AddToCartList> cartListData = AddToCartList().obs;
  RxBool loading = false.obs;
  final localStorage = Get.find<LocalStorage>();
  // Add debounce timer
  Timer? _debounceTimer;
  
  // Track pending operations to prevent duplicates
  Map<String, bool> _pendingOperations = {};
  
  @override
  void onInit() {
    final token = localStorage.getAuthToken();
    if(token!=null){
      GetAddtocart();
    }
    super.onInit();
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  void addToCart(CartItem item) {
    // Check if item already exists in cart
    int existingIndex = cartItems.indexWhere((element) => element.productId == item.productId);

    if (existingIndex >= 0) {
      // Update quantity if item exists
      cartItems[existingIndex].quantity += item.quantity;
      print(cartItems[existingIndex].quantity);
      print(cartItems[existingIndex].productId);

      // Find the cart item ID from the API response data
      String? cartId = findCartIdByProductId(item.productId);
      if (cartId != null) {
        // Apply debounce to update cart
        _debounceCartUpdate(cartId, cartItems[existingIndex].quantity);
      }

      cartItems.refresh();
    } else {
      cartItems.add(item);
      print(item.quantity);
      print(item.productId);

      // Apply debounce to add to cart
      _debounceAddToCart(item.productId);
    }
  }

  // Debounce add to cart
  void _debounceAddToCart(String productId) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      Addtocart(productId);
    });
  }

  // Debounce update cart
  void _debounceCartUpdate(String cartId, int quantity) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      updateCartItemQuantity(cartId, quantity);
    });
  }

  // Find cart ID from the API response data
  String? findCartIdByProductId(String productId) {
    if (cartListData.value.data != null) {
      for (var item in cartListData.value.data!) {
        if (item.productId?.sId == productId) {
          return item.sId;
        }
      }
    }
    return null;
  }

  // Update cart item quantity on the server
  void updateCartItemQuantity(String cartId, int quantity) async {
    Map<String, dynamic> requestModel = {
      "cartId": cartId,
      "quantity": quantity
    };

    try {
      final response = await _apiRepository.AddToCartUpdate(dataBody: requestModel);
      print(response);
      // Refresh cart after update
      GetAddtocart();
    } catch (e) {
      debugPrint('Error updating cart: $e');
      Get.snackbar('Error', 'Failed to update cart item');
    }
  }


  void Addtocart(String cartId) async {
    Map<String, dynamic> requestModel;

    requestModel = AuthRequestModel.AddToCartRequest(
    id: cartId
    );
    try {
      final response = await _apiRepository.AddToCartApiCall(dataBody: requestModel);
      print(response);
      GetAddtocart();
    } catch (e) {
      debugPrint('Error sending message: $e');
      var snackbar = Get.snackbar('Error', 'Failed to send message');
    }

  }

  void RemoveAddtocart(String cartId) async {
    loading.value = true;
    try {
      Map<String, dynamic> requestModel = {
        "cartId": cartId,

      };

      final response = await _apiRepository.RemoveAddToCartApiCall(dataBody: requestModel);
      print(response);
      
      // Refresh cart after removal
      GetAddtocart();
    } catch (e) {
      debugPrint('Error removing cart item: $e');
      Get.snackbar('Error', 'Failed to remove cart item');
    } finally {
      loading.value = false;
    }
  }

  void GetAddtocart() async {
    loading.value = true;
    try {
      final response = await _apiRepository.GetAddToCartApiCall();
      if (response != null) {
        cartListData.value = response;
        // Convert API response to CartItem objects
        cartItems.clear();
        if (cartListData.value.data != null) {
          for (var item in cartListData.value.data!) {
            cartItems.add(CartItem(
              productId: item.productId?.sId ?? '',
              productName: item.productId?.productName ?? 'Product',
              imageUrl: item.productId?.primaryImage != null ?
                "$imageBaseUrl${item.productId?.primaryImage}" : AppAssets.rackettt,
              price: item.productId?.actualPrice?.toDouble() ?? 0.0,
              discountedPrice: item.productId?.discountedPrice?.toDouble() ?? 0.0,
              quantity: item.quantity?.toInt() ?? 1
            ));
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching cart: $e');
      // Get.snackbar('Error', 'Failed to fetch cart items');
    } finally {
      loading.value = false;
    }
  }

  void refreshCart() {
    GetAddtocart();
  }

  void removeFromCart(String productId) {
    int index = cartItems.indexWhere((element) => element.productId == productId);
    if (index >= 0) {
      // Find the cart ID before removing the item
      String? cartId = findCartIdByProductId(productId);
      
      // Remove item from local cart
      cartItems.removeAt(index);
      cartItems.refresh();
      
      // Call API to remove item
      if (cartId != null) {
        RemoveAddtocart(cartId);
      }
    }
  }

  void updateQuantity(String productId, int quantity) {
    print("hello>>>>>>>");
    int index = cartItems.indexWhere((element) => element.productId == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        // Find the cart ID before removing the item
        String? cartId = findCartIdByProductId(productId);
        
        // Remove item from local cart
        cartItems.removeAt(index);
        cartItems.refresh();
        
        // Call API to remove item
        if (cartId != null) {
          RemoveAddtocart(cartId);
        }
      } else {
        cartItems[index].quantity = quantity;
        
        // Update quantity on server with debounce
        String? cartId = findCartIdByProductId(productId);
        if (cartId != null) {
          _debounceCartUpdate(cartId, quantity);
        }
        cartItems.refresh();
      }
    }
  }



  // void OrderCartProducts(String productId, int quantity) {
  //   print("hello>>>>>>>");
  //   int index = cartItems.indexWhere((element) => element.productId == productId);
  //   if (index >= 0) {
  //     if (quantity <= 0) {
  //       // Find the cart ID before removing the item
  //       String? cartId = findCartIdByProductId(productId);
  //
  //       // Remove item from local cart
  //       cartItems.removeAt(index);
  //       cartItems.refresh();
  //
  //       // Call API to remove item
  //       if (cartId != null) {
  //         RemoveAddtocart(cartId);
  //       }
  //     } else {
  //       cartItems[index].quantity = quantity;
  //
  //       // Update quantity on server with debounce
  //       String? cartId = findCartIdByProductId(productId);
  //       if (cartId != null) {
  //         _debounceCartUpdate(cartId, quantity);
  //       }
  //       cartItems.refresh();
  //     }
  //   }
  // }
  
  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  // Calculate total amount based on discounted price
  double get totalAmount => cartItems.fold(
    0, (sum, item) => sum + ((item.discountedPrice > 0 ? item.discountedPrice : item.price) * item.quantity)
  );

  int getItemQuantity(String productId) {
    final index = cartItems.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      return cartItems[index].quantity;
    }
    return 0;
  }




  void clearCart() async {
    loading.value = true;
    try {
      // Remove each item one by one
      for (var item in cartItems) {
        String? cartId = findCartIdByProductId(item.productId);
        if (cartId != null) {
          // Create request model for delete operation
          Map<String, dynamic> requestModel = {
            "cartId": cartId,
            "quantity": 0
          };
          
          // Use the PUT method with quantity 0 to remove item
          await _apiRepository.AddToCartUpdate(dataBody: requestModel);
        }
      }
      
      // Clear local cart
      cartItems.clear();
      cartItems.refresh();
      
      // Refresh cart after clearing
      GetAddtocart();
    } catch (e) {
      debugPrint('Error clearing cart: $e');
      Get.snackbar('Error', 'Failed to clear cart');
    } finally {
      loading.value = false;
    }
  }
}
