import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/home/logic/cubits/home_cubit.dart';



class ColorSelectionItem extends StatefulWidget {
  const ColorSelectionItem({super.key, required this.colors});

  final List<String> colors;

  @override
  State<ColorSelectionItem> createState() => _ColorSelectionItemState();
}

class _ColorSelectionItemState extends State<ColorSelectionItem> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeCubit>(context).selectedColor=widget.colors[_currentIndex];


    return SizedBox(
      height: 48.h,
      width: double.infinity,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context,index)=>colorItem(index,widget.colors[index]),
        separatorBuilder: (context, index) => SizedBox(width: 10.w,),

      ),
    );
  }

  Widget colorItem(int index,String color) {
    return SizedBox(
      height: 35.h,
      width: 35.w,
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = index;
                BlocProvider.of<HomeCubit>(context).selectedColor=widget.colors[index];
              });
            },
            child: Container(
              height: 50.h,
              width: 35.w,
              decoration: BoxDecoration(
                color: Color(int.parse(color)),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: _currentIndex == index ? 15.0 : 0.0, // Conditional height
              width: _currentIndex == index ? 15.0 : 0.0, // Conditional width
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index
                    ? Colors.white // Your secondary color
                    : Colors.transparent,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
