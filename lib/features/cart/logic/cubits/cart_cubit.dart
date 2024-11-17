import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stylish/features/cart/data/models/address_model.dart';
import 'package:stylish/features/cart/data/repository/cart_repo.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/ shared_model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  final CartRepo cartRepo;

  int totalPrice = 0;

  List<CartModel> cartList = [];

  List<AddressModel> addressList = [];

  int addressIndex = 0;

  WebViewController? webViewController;

  String payUrl = "";
  static const String _apiKey = 'ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpFNU1UYzVMQ0p1WVcxbElqb2lNVGN5TURJMk5qYzBNUzR4TnpRME1EVWlmUS5DbGVrZFY1OFloMUZWVEZKRVN2TlVHM0o2OGZRa0gtZFhnbmctTm11RUpnU1BYQ3podTVybFZVYzJVdzZRMnpqRFBkMDhwZ3BNb19JRzFiaXNTV05DQQ==';

  void totalPriceCalculator(List<CartModel> cartList) {
    totalPrice = 0;
    for (var element in cartList) {
      totalPrice += element.productModel.price * element.quantity;
    }
    emit(TotalPriceChanged());
  }

  void increment(CartModel cartModel) {
    cartModel.quantity++;
    totalPrice += cartModel.productModel.price;
    emit(CounterChanged());
    emit(TotalPriceChanged());
  }

  void decrement(CartModel cartModel) {
    if (cartModel.quantity > 1) {
      cartModel.quantity--;
      totalPrice -= cartModel.productModel.price;
      emit(CounterChanged());
      emit(TotalPriceChanged());
    } else {
      delete(cartModel);
    }
  }

  void delete(CartModel cartModel) {
    totalPrice -= cartModel.productModel.price * cartModel.quantity;
    cartList.remove(cartModel);
    emit(CounterChanged());
    emit(TotalPriceChanged());
  }

  void setAddress() {
    emit(SetAddressLoading());
    if (formKey.currentState!.validate()) {
      addressList.add(AddressModel(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        streetAddress: streetAddressController.text,
        city: cityController.text,
        country: countryController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
      ));
      setAddressList();
    }
  }

  void setAddressList() {
    cartRepo.setAddress(addressList).then((value) {
      value.fold((l) {
        emit(SetAddressError());
      }, (r) {
        emit(SetAddressSuccess());
      });
    });
  }

  void getAddress() {
    cartRepo.getAddress().then((value) {
      value.fold((l) {
        emit(SetAddressError());
      }, (r) {
        addressList = r;
        print(addressList.isEmpty);
        print("#######################################################################3");
        emit(SetAddressSuccess());
      });
    });
  }

  void setAddressIndex(int index) {
    addressIndex = index;
    emit(SetAddressIndexSuccess());
  }

  void removeAddress(int index) {
    addressList.removeAt(index);
    addressIndex = addressList.length - 1;
    setAddressList();
    emit(RemoveAddress());
  }

  void pay() {
    emit(PaymentLoading());
    cartRepo.getAuthToken(_apiKey).then((value) {
      value.fold((l) {
        emit(GetApiKeyError());
      }, (authToken) {
        emit(GetApiKeySuccess());
        cartRepo
            .payOrder(
          address: addressList[addressIndex],
          cart: cartList,
          authToken: authToken,
          total: totalPrice * 100,
        )
            .then((value) {
          value.fold((l) {
            emit(PaymentProcessError());
          }, (payUrl) async{
            this.payUrl = payUrl;
            // await openPayUrl();
            emit(PaymentProcessSuccess(payUrl));
          });
        });
      });
    });
  }

  // Future<void> openPayUrl() async {
  //   if (webViewController == null) {
  //     webViewController = WebViewController();
  //     await webViewController!.setJavaScriptMode(JavaScriptMode.unrestricted);
  //   }
  //   await webViewController!.loadRequest(Uri.parse("https://www.youtube.com/"));
  // }
}
