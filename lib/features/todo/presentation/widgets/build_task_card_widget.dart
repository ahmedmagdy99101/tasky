import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/todo.dart';

class BuildTaskCardWidget extends StatelessWidget {
  const BuildTaskCardWidget({
    super.key, required this.todoData,
  });
  final Todo todoData ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 5),
      child: Row(
        children: [
          Image.asset(
            'assets/images/item_image.png',
            width: 64.w,
            height: 64.h,
          ),
          10.horizontalSpace,
          SizedBox(
            width: 225.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                          "${todoData.title}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        )),
                    5.horizontalSpace,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: getStatusBackGroundColor(status: todoData.status),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:  Text(
                        "${todoData.status}",
                        style: TextStyle(color: getStatusTitleColor(status: todoData.status)),
                      ),
                    ),
                  ],
                ),
                Text(
                  "${todoData.description}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0x24252C99)),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.flag_outlined,
                            size: 16, color: getPriorityTitleColor(priority: todoData.priority)),
                        1.horizontalSpace,
                        Text(
                          "${todoData.priority}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: getPriorityTitleColor(priority: todoData.priority)),
                        ),
                      ],
                    ),
                    Text(
                      todoData.createdAt.toString().substring(0,10),
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          5.horizontalSpace,
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
                size: 24,
              ))
        ],
      ),
    );
  }

  Color getStatusTitleColor({required String status}) {
    switch(status) {
      case 'waiting':
        return const Color(0xFFFF7D53);
      case 'finished':
        return const Color(0xFF0087FF);
      case 'inprogress':
        return const Color(0xFF5F33E1);
      default:
        return const Color(0xFFFF7D53);
    }
  }
  Color getStatusBackGroundColor({required String status}) {
    switch(status) {
      case 'waiting':
        return const Color(0xFFFFE4F2);
      case 'inprogress':
        return const Color(0xFFF0ECFF);
      case 'finished':
        return const Color(0xFFE3F2FF);
      default:
        return const Color(0xFFFFE4F2);
    }
  }
  Color getPriorityTitleColor({required String priority}) {
    switch(priority) {
      case 'high':
        return const Color(0xFFFF7D53);
      case 'low':
        return const Color(0xFF0087FF);
      case 'medium':
        return const Color(0xFF5F33E1);
      default:
        return const Color(0xFFFF7D53);
    }
  }
}

/*
return Container(
      width: 1.sw,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 5),
      child: Row(
        children: [
          Image.asset(
            'assets/images/item_image.png',
            width: 64.w,
            height: 64.h,
          ),
          10.horizontalSpace,
          SizedBox(
            width: 225.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                      "Grocery Shopping App",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                          color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    )),
                    5.horizontalSpace,
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE4F2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Waiting",
                        style: TextStyle(color: Color(0xFFFF7D53)),
                      ),
                    ),
                  ],
                ),
                Text(
                  "This application is designed for super shops. By using",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: const Color(0x24252C99)),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.flag_outlined,
                            size: 16, color: AppTheme.primaryColor),
                        1.horizontalSpace,
                        Text(
                          "Medium",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                              color: AppTheme.primaryColor),
                        ),
                      ],
                    ),
                    Text(
                      "30/12/2022",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          5.horizontalSpace,
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
                size: 24,
              ))
        ],
      ),
    );
 */