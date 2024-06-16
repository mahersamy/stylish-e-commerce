part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}


final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

final class GetCategoryProductSuccess extends HomeState {
  final List<ProductModel> productModels;

  GetCategoryProductSuccess({required this.productModels});
}

final class GetCategoryProductError extends HomeState {
  final String message;

  GetCategoryProductError({required this.message});
}

final class GetCategoryProductLoading extends HomeState {}



final class GetFavoriteProductError extends HomeState {}



final class GetAllFavoriteProductLoading extends HomeState {}

final class GetAllFavoriteProductSuccess extends HomeState {
  final List<ProductModel> productModels;

  GetAllFavoriteProductSuccess({required this.productModels});

}
final class GetAllFavoriteProductError extends HomeState {}



final class SetFavoriteProductSuccess extends HomeState {}

final class SetFavoriteProductError extends HomeState {}




final class AddToCartSuccess extends HomeState {}
final class UpdateCartSuccess extends HomeState {}



