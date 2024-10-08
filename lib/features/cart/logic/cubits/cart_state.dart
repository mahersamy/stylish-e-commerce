part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CounterChanged extends CartState {}

final class TotalPriceChanged extends CartState {}


final class SetAddressLoading extends CartState {}

final class SetAddressSuccess extends CartState {}

final class SetAddressError extends CartState {}


final class SetAddressIndexSuccess extends CartState {}

final class RemoveAddress extends CartState {}


final class GetApiKeySuccess extends CartState {}


final class GetApiKeyError extends CartState {}


final class PaymentLoading extends CartState {}

final class PaymentProcessSuccess extends CartState {
   final String payUrl;
  PaymentProcessSuccess(this.payUrl);
}

final class PaymentProcessError extends CartState {}





