import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class CircularCategoryItem extends StatelessWidget {
  const CircularCategoryItem({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(radius: 35.w,child: ClipOval(
            child: Image.network(image,fit: BoxFit.fill,height: 100.h,width: 100.w,),
          ),),
          SizedBox(height: 5.sp,),
          Text(name,style: Theme.of(context).textTheme.labelSmall,),
        ],
      ),
    );
  }
}
