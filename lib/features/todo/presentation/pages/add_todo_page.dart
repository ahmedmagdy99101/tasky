import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/config/theme/app_theme.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../../domain/entities/todo.dart';
import '../cubit/add_todo_cubit/add_todo_cubit.dart';
import '../widgets/data_picker_field.dart';


class AddTodoPage extends StatefulWidget {
  const AddTodoPage({super.key});
  @override
  AddTodoPageState createState() => AddTodoPageState();
}

class AddTodoPageState extends State<AddTodoPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? priority = "low";
  DateTime selectedData = DateTime.now();

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
    return BlocConsumer<CreateTodoCubit, AddTodoState>(
      listener: (context, state) {
        // if (state is CreateTodoLoading) {
        //   showDialog(
        //
        //     context: context,
        //     builder: (context) => AlertDialog(
        //       backgroundColor: Colors.transparent,
        //       content: SizedBox(
        //
        //           width: 100.w,
        //           height: 100.h,
        //           child: const Center(child: CircularProgressIndicator())),
        //     ),
        //   );
        // }
        if (state is CreateTodoSuccess) {
          context.pop();
          Fluttertoast.showToast(
            msg: state.message.toString(),
            fontSize: 16,
            backgroundColor: Colors.black,
          );
        } else if (state is CreateTodoError) {
         // context.pop();
          Fluttertoast.showToast(
            msg: state.message.toString(),
            fontSize: 16,
            backgroundColor: Colors.black,
          );
        }
        if(state is UploadImageSuccess){
        // context.pop();
          BlocProvider.of<CreateTodoCubit>(context).addTodo(
            todo: Todo(
              title: titleController.text,
              description: descriptionController.text.trim(),
              imageUrl: state.imagePath,
              createdAt: selectedData,
              priority: priority ?? "low", id: '', status: '', user: '', updatedAt: DateTime.now(),
            )
            );
        }
        else if (state is UploadImageError) {
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
              "Add new task",
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
          // appBar: AppBar(
          //   forceMaterialTransparency: true,
          //   title: Text(
          //     'Add new task',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 20.w,
          //       fontWeight: FontWeight.w700,
          //     ),
          //   ),
          // ),
          body:state is CreateTodoLoading ? Center(child: Image.asset("assets/images/loading.gif",width: 100,height: 100,),): Padding(
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
                            ? Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: AppTheme.primaryColor,
                                size: 24.sp,
                              ),
                              8.horizontalSpace,
                              Text(
                                'Add Img',
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontSize: 19.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        )
                            : FittedBox(
                          fit: BoxFit.cover,
                          child: Image.file(width: 200,height: 200,
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
                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),
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
                    style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),
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
                        Fluttertoast.showToast(
                          msg: "Pick your image",
                          fontSize: 16,
                          backgroundColor: Colors.black,
                        );
                      } else {
                        if (titleController.text.isEmpty ||
                            descriptionController.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Must Be Enter Your title and Discreption",
                            fontSize: 16,
                            backgroundColor: Colors.black,
                          );
                        } else {
                          BlocProvider.of<CreateTodoCubit>(context).uploadImage(imageFile: _image!);


                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50.h),
                      // backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Add task',
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

