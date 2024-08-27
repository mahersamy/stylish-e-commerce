import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/home/presention/widgets/custom_grid_view.dart';
import 'package:stylish/features/search/logic/cubits/search_cubit.dart';

import '../widgets/search_text_field.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current){
        return current is SearchSuccess;
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: SearchTextField(
            controller: BlocProvider.of<SearchCubit>(context).searchController,
            onFieldSubmitted: (String? string) {
              BlocProvider.of<SearchCubit>(context).search(string??"");
            },
          ), centerTitle: true,),
          body: ConditionalBuilder(
            condition: state is SearchLoading,
            fallback: (context) => Padding(
              padding: const EdgeInsets.only(left: 10.0).w,
              child: CustomGridView(
                products: BlocProvider.of<SearchCubit>(context).productList,
              ),
            ),
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),


        );
      },
    );
  }
}
