import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/ shared_model/cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  int totalPrice = 0;


  void totalPriceCalculator(List<CartModel> cartList) {
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
    if(cartModel.quantity>1){
      cartModel.quantity--;
      totalPrice -= cartModel.productModel.price;
      emit(CounterChanged());
      emit(TotalPriceChanged());
    }
  }
}
