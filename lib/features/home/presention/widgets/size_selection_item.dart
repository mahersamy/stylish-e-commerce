import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';

class SizeSelectionItem extends StatefulWidget {
   SizeSelectionItem({super.key, required this.sizes });

  int _currentIndex = 0;
  final List<String> sizes;

  @override
  State<SizeSelectionItem> createState() => _SizeSelectionItemState();
}

class _SizeSelectionItemState extends State<SizeSelectionItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 300.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context,index)=>sizeItem(index,widget.sizes[index]),
        separatorBuilder: (context,index)=>SizedBox(width: 10.w,),
        itemCount: widget.sizes.length,
      ),
    );
  }



  Widget sizeItem(int index,String size) {
    return InkWell(
      onTap: (){
        setState(() {
          widget._currentIndex = index;
        });
      },
      child: Container(
        height: 30.h,
        width: 42.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.neutral4, width: 1.0),
          color: widget._currentIndex == index ? AppColors.neutral1 : AppColors.neutral9,
        ),
        child: Center(child: Text(size,style:Theme.of(context).textTheme.labelSmall!.copyWith(color: widget._currentIndex == index ? AppColors.neutral9 : AppColors.neutral1),)),

      ),
    );
  }


}
