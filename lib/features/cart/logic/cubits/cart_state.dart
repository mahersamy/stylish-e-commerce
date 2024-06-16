part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CounterChanged extends CartState {}

final class TotalPriceChanged extends CartState {}
