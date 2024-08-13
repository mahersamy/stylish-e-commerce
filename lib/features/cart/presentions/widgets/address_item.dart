import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../data/models/address_model.dart';




class AddressItem extends StatelessWidget {
  AddressItem({super.key, required this.addressModel,required this.isSelect});
  final AddressModel addressModel;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.neutral7.withOpacity(0.5),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20).w,
      child: Row(
        children: [
          if(isSelect == true)
            Container(
            width: 5.w,
            color: AppColors.mainColor,
            height: 100.h,
          ),
          SizedBox(width: 10.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${addressModel.firstName} ${addressModel.lastName}",style: Theme.of(context).textTheme.headlineSmall,),
              Text(addressModel.streetAddress,style: Theme.of(context).textTheme.labelSmall,),
              Text(addressModel.email,style: Theme.of(context).textTheme.labelSmall,),
              Text(addressModel.phoneNumber,style: Theme.of(context).textTheme.labelSmall,),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              if(isSelect == true)
                Container(
                padding: const EdgeInsets.all(5).w,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(6.w),bottomLeft: Radius.circular(6.w)),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: Text("Default",style: Theme.of(context).textTheme.displaySmall,),
              ),
                SizedBox(height: 20.h,),
              const Icon(Icons.arrow_forward_ios,size: 22,),],
          ),
        ],
      ),
    );
  }
}
