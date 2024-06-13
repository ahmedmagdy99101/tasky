import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/config/APIs/apis_urls.dart';

import '../../domain/entities/todo.dart';
import '../cubit/todo_cubit.dart';

class BuildTaskCardWidget extends StatelessWidget {
  const BuildTaskCardWidget({
    super.key, required this.todoData,
  });
  final Todo todoData ;
  @override
  Widget build(BuildContext context) {
    CustomPopupMenuController controller = CustomPopupMenuController();
    return Container(
      width: 1.sw,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 5),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                '${ApisStrings.imageBaseUrl}${todoData.imageUrl}',
                placeholder: (context, url) =>
                 Center(child: Image.asset("assets/images/loading.gif",width: 100,height: 100,),),
                errorWidget: (context, url, error) =>
                    Image.asset(
                      'assets/images/item_image.png',
                      width: 60.w,
                      height: 60.h,
                    ),
              ),
            ),
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
                  "${todoData.description.trim()}",
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
          CustomPopupMenu(
            arrowColor: Colors.white,
            pressType: PressType.singleClick,
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                alignment: Alignment.center,
                width: 90.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.hideMenu();
                          context.push("/edit", extra: todoData);
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(),
                      GestureDetector(
                        onTap: () {
                          controller.hideMenu();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete Task'),
                                content: const Text(
                                    'Are you sure you want to delete this task?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete',style: TextStyle(
                                     ),),
                                    onPressed: () {
                                      BlocProvider.of<TodoCubit>(
                                          context)
                                          .deleteTodoMethod(todoData.id);

                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog
                                      // ScaffoldMessenger.of(context)
                                      //     .showSnackBar(
                                      //   SnackBar(
                                      //       content:
                                      //           Text(widget.task.id)),
                                      // );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: const Color(0xFFFF7D53),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // verticalMargin: -10,
            controller: controller,
            child: Container(
              padding: const EdgeInsets.all(12),
              child:
              const Icon(Icons.more_vert_rounded, color: Colors.black),
            ),
          ),
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