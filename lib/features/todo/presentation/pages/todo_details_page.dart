import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/config/theme/app_theme.dart';
import '../../domain/entities/todo.dart';
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
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (value) {
              // Handle actions like Edit and Delete
            },
            itemBuilder: (BuildContext context) {
              return {'Edit', 'Delete'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
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
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                          'assets/images/task_image.png')),
                ),
                // child: Image.network(
                //     'https://th.bing.com/th/id/OIP.wKI5dF0Peu_tv1mfB2xs3AHaFj?rs=1&pid=ImgDetMain',
                //     height: 100,width: double.infinity,),
        //       NetworkImage(
        //           'https://image.shutterstock.com/image-vector/green-shop-cart-leaf-logo-260nw-710191522.jpg')),
        // ),
              ),

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
                  data: "${widget.task.id}", // Replace with your data
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