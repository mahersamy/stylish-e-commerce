import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/helpers/extentions.dart';

import '../../features/home/logic/cubits/home_cubit.dart';
import '../routes/app_route.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index){
        if(index == 2){
          context.pushNamed(Routes.cartScreen,arguments:BlocProvider.of<HomeCubit>(context).cartList);
        }else if(index == 3){
          context.pushNamed(Routes.searchScreen);

        }else if(index == 4){
          context.pushNamed(Routes.settingScreen);

        }else{
          BlocProvider.of<HomeCubit>(context).changeIndex(index);
        }

      },
      currentIndex: BlocProvider.of<HomeCubit>(context).currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}
