import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/config/APIs/apis_urls.dart';
import 'package:tasky/config/theme/app_theme.dart';
import '../../domain/entities/todo.dart';
import '../cubit/todo_cubit.dart';
import '../widgets/data_picker_field.dart';

class TodoDetailsPage extends StatefulWidget {
  final Todo task;

  const TodoDetailsPage({super.key, required this.task});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  late TextEditingController priorityController;
  late TextEditingController statusController;
  late TextEditingController dateController = TextEditingController();
  final CustomPopupMenuController controller = CustomPopupMenuController();
  @override
  void initState() {
    priorityController = TextEditingController(text: "${widget.task.priority} Priority");
    statusController = TextEditingController(text: widget.task.status);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1,
        title: Text(
          "Task Details",
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Image.asset(
            "assets/icons/left_arrow.png",
            width: 24,
          ),
        ),
        actions: [
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
                          context.push("/edit", extra: widget.task);
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
                                    child: const Text('Delete'),
                                    onPressed: () {
                                      BlocProvider.of<TodoCubit>(
                                          context)
                                          .deleteTodoMethod(
                                          widget.task.id);

                                      Navigator.of(context)
                                          .pop(); // Dismiss the dialog

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
            verticalMargin: -10,
            controller: controller,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Icon(Icons.more_vert_rounded,
                  color: Colors.black),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 225.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:
                    '${ApisStrings.imageBaseUrl}${widget.task.imageUrl}',
                    placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                     Image.asset(
                      'assets/images/task_image.png',
                    ),
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   height: 225.h,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         fit: BoxFit.contain,
              //         image: AssetImage(
              //             'assets/images/task_image.png')),
              //   ),
              //
              // ),

            16.verticalSpace,
              Text(
                widget.task.title,
                style:
                TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
              ),
              8.verticalSpace,
              Text(
                widget.task.description,
                style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400,color: Colors.grey),
              ),
              16.verticalSpace,
              DatePickerField(
                dateTime: widget.task.createdAt,
              ),
              8.verticalSpace,
              TextField(
                controller: statusController,
                style:  TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700,fontSize: 16.sp),
                decoration: InputDecoration(
                  enabled: false,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppTheme.primaryColor,
                    size: 40.w,
                  ),
                  filled: true,
                  fillColor: AppTheme.primaryColor.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onChanged: (String? newValue) {},
              ),
              8.verticalSpace,
              TextField(
                controller: priorityController,
                style:  TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.w700,fontSize: 16.sp),
                decoration: InputDecoration(
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  enabled: false,
                  suffixIcon: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppTheme.primaryColor,
                    size: 40.w,
                  ),
                  prefixIcon: const Icon(Icons.flag_outlined,
                      size: 24, color: AppTheme.primaryColor),
                  filled: true,
                //  prefixIconConstraints: BoxConstraints(maxWidth: 30),
                  fillColor: AppTheme.primaryColor.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                onChanged: (String? newValue) {},
              ),
              SizedBox(height: 16.h),
              Center(
                child: QrImageView(
                  data: widget.task.id, // Replace with your data
                  version: QrVersions.auto,
                  size: 400.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}