import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/config/APIs/apis_urls.dart';
import 'package:tasky/config/theme/app_theme.dart';
import 'package:tasky/features/todo/domain/entities/todo.dart';
import 'package:tasky/features/todo/presentation/widgets/data_picker_field.dart';
import 'package:intl/intl.dart';

import '../cubit/update_todo_cubit/update_todo_cubit.dart';

class EditTaskPage extends StatefulWidget {
  final Todo task;
  const EditTaskPage({super.key, required this.task});
  @override
  EditTaskPageState createState() => EditTaskPageState();
}

class EditTaskPageState extends State<EditTaskPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController dateController;
  String? priority ;
  late DateTime selectedData = DateTime.now();
  @override
  void initState() {
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
    dateController = TextEditingController(
        text: DateFormat('d MMMM, yyyy').format(widget.task.createdAt));
    super.initState();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
        debugPrint(_image!.path.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateTodoCubit, UpdateTodoState>(
      listener: (context, state) {
        if (state is UpdateTodoSuccess) {
          context.go("/todos");
          Fluttertoast.showToast(
            msg: "This Task is updated",
            fontSize: 16,
            backgroundColor: Colors.black,
          );
        } else if (state is UpdateTodoFailure) {
          // context.pop();
          Fluttertoast.showToast(
            msg: state.message.toString(),
            fontSize: 16,
            backgroundColor: Colors.black,
          );
        }
        if (state is UploadUpdatedImageSuccess) {
          // context.pop();
          BlocProvider.of<UpdateTodoCubit>(context).updateTodo(
              todo: Todo(
            title: titleController.text,
            description: descriptionController.text,
            imageUrl: state.imagePath,
            createdAt: selectedData,
            priority: priority ?? widget.task.priority,
            id: widget.task.id,
            status: '',
            user: '',
            updatedAt: DateTime.now(),
          ));
        } else if (state is UploadUpdatedImageError) {
          // context.pop();
          Fluttertoast.showToast(
            msg: 'حدث خطأ أثناء محاولة رفع الصورة',
            fontSize: 16,
            backgroundColor: Colors.black,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 1,
            title: Text(
              "Edit task",
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
            leading: IconButton(
              onPressed: () {
                context.pop(true);
              },
              icon: Image.asset(
                "assets/icons/left_arrow.png",
                width: 24,
              ),
            ),
          ),

          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => _showImagePickerDialog(context),
                    child: DottedBorder(
                      color: AppTheme.primaryColor,
                      borderType: BorderType.RRect,
                      radius: Radius.circular(12.r),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 15.r),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: _image == null
                            ? Container(
                                width: double.infinity,
                                height: 225.h,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        '${ApisStrings.imageBaseUrl}${widget.task.imageUrl}'),
                                  ),
                                ),

                              )
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.file(
                                  width: 200,
                                  height: 200,
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Task title",
                    style: TextStyle(
                        color: const Color(0xFF6E6A7C),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  8.verticalSpace,
                  TextField(
                    controller: titleController,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                    decoration: InputDecoration(
                      hintText: 'Enter title here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "Task Description",
                    style: TextStyle(
                        color: const Color(0xFF6E6A7C),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  8.verticalSpace,
                  TextField(
                    controller: descriptionController,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                    maxLines: 6,
                    decoration: InputDecoration(
                      hintText: 'Enter description here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                  16.verticalSpace,
                  Text(
                    "Priority",
                    style: TextStyle(
                        color: const Color(0xFF6E6A7C),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  8.verticalSpace,
                  DropdownButtonFormField<String>(
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: AppTheme.primaryColor,
                      size: 30.w,
                    ),
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppTheme.primaryColor.withOpacity(0.1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    value: 'low',
                    items: <String>['low', 'medium', 'high']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(
                              Icons.flag_outlined,
                              size: 20.sp,
                              color: AppTheme.primaryColor,
                            ),
                            5.horizontalSpace,
                            Text('$value Priority'),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        priority = newValue;
                      });
                    },
                  ),
                  16.verticalSpace,
                  Text(
                    "Due date",
                    style: TextStyle(
                        color: const Color(0xFF6E6A7C),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  8.verticalSpace,
                  CustomDatePickerField(
                    initialDate: DateTime.now(),
                    label: "EndDate",
                    onDateSelected: (p0) {
                      setState(() {
                        selectedData = p0;
                        dateController.text =
                            "${p0.year}-${p0.month}-${p0.day}";
                      });
                      debugPrint(dateController.text);
                    },
                  ),
                  28.verticalSpace,
                  ElevatedButton(
                    onPressed: () {
                      // Add task logic here
                      if (_image == null) {
                        BlocProvider.of<UpdateTodoCubit>(context).updateTodo(
                            todo: Todo(
                          title: titleController.text,
                          description: descriptionController.text,
                          imageUrl: widget.task.imageUrl,
                          createdAt: selectedData,
                          priority: priority ?? widget.task.priority,
                          id: widget.task.id,
                          status: '',
                          user: '',
                          updatedAt: DateTime.now(),
                        ));
                      } else {
                        BlocProvider.of<UpdateTodoCubit>(context)
                            .uploadImage(imageFile: _image!);
                      }
                      // else {
                      //   if (titleController.text.isEmpty ||
                      //       descriptionController.text.isEmpty) {
                      //     Fluttertoast.showToast(
                      //       msg: "Must Be Enter Your title and Discreption",
                      //       fontSize: 16,
                      //       backgroundColor: Colors.black,
                      //     );
                      //   } else {
                      //     BlocProvider.of<UpdateTodoCubit>(context)
                      //         .uploadImage(imageFile: _image!);
                      //   }
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      // backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Edit task',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}


// For formatting date

