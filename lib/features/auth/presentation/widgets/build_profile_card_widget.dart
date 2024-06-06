import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildProfileCardWidget extends StatelessWidget {
  const BuildProfileCardWidget({
    super.key, required this.title, required this.subTitle, this.icon,
  });
  final String title;
  final String subTitle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
      decoration:  BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey
              ),),
              Text(subTitle,style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF24252C).withOpacity(0.6)
              ),),
            ],
          ),
          if(icon != null) icon ?? const SizedBox() ,
        ],
      ),
    );
  }
}