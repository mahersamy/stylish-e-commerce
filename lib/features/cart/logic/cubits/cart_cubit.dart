import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:stylish/features/cart/data/models/address_model.dart';
import 'package:stylish/features/cart/data/repository/cart_repo.dart';

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
   if(formKey.currentState!.validate()){
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
    CartRepo().setAddress(addressList).then((value) {
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
        emit(SetAddressSuccess());
      });
    });
  }

  void setAddressIndex(int index) {
    addressIndex = index;
    emit(SetAddressIndexSuccess());
  }

  void removeAddress(int index){
    addressList.removeAt(index);
    addressIndex =addressList.length-1;
    setAddressList();
    emit(RemoveAddress());
    }
}
