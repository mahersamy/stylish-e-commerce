import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:stylish/features/home/data/models/product_model.dart';
import 'package:stylish/features/search/data/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());
  final SearchRepo searchRepo;

  TextEditingController searchController = TextEditingController();
  final List<ProductModel> productList = [];

  void search(String query) {
    emit(SearchLoading());
    searchRepo.search(query).then((value) {
      value.fold(
        (l) {
          emit(SearchError());
          
        },
        (r) {
          productList.clear();
          productList.addAll(r);
          emit(SearchSuccess());
        },
      );
    });
  }
}
