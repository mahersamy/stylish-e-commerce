import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/shared_widgets/custom_circular.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';
import 'package:stylish/features/home/presention/widgets/custom_grid_view.dart';

import '../../../../core/helpers/toast_helper.dart';


class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    _fetchFavoriteProducts();
  }

  void _fetchFavoriteProducts() {
    BlocProvider.of<HomeCubit>(context).getAllFavoriteProduct();
  }

  // Future<void> _onWillPop(bool value) async {
  //   _fetchFavoriteProducts();// Allow the pop to happen
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener:(context, state) {
        if(state is GetAllFavoriteProductError){
          ToastHelper().showErrorToast("Something went wrong");
        }
      },
      builder: (context, state) {
        print(state);
        if(state is GetAllFavoriteProductSuccess){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomGridView(products: state.productModels),
          );
        }else{
          return const Center(child: CustomCircular());
        }
      },
    );
  }
}
