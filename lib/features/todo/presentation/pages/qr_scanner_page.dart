import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/config/theme/app_theme.dart';
import 'package:tasky/features/todo/presentation/cubit/single_todo/single_todo_cubit.dart';

class QRScannerPage extends StatelessWidget {
  MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleTodoCubit, SingleTodoState>(
      listener: (context, state) {
        if (state is SingleTodoSuccess) {
          context.pushReplacement("/todo", extra: state.todo);
        } else if (state is SingleTodoFailure) {
          context.pop(true);
          Fluttertoast.showToast(
            msg: state.message,
            fontSize: 16,
            backgroundColor: Colors.black,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.primaryColor,
          appBar: AppBar(
            backgroundColor: AppTheme.primaryColor,
        leading: const SizedBox(),
            actions: [

              IconButton(
                  onPressed: (){
                context.pop();
              },
               style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.black38)),
                  icon: const Icon(Icons.close,color: Colors.white,)),
              10.horizontalSpace,
            ],
          ),
          body: Column(
         //   mainAxisAlignment: MainAxisAlignment.center,
            children: [
              50.verticalSpace,
              Image.asset("assets/images/logo.png",width: 200.w,),
              50.verticalSpace,
               Text("Scan Task Barcode",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
              20.verticalSpace,
              Center(
                child: Container(
                  width: 300.w,
                  height: 400.h,
                  decoration: BoxDecoration(
                   // borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white)
                  ),
                  child: MobileScanner(
                    controller: controller,

                    onDetect: (BarcodeCapture barcode) {
                      if (barcode.raw != null) {
                        final String code = barcode.barcodes[0].displayValue!;
                        BlocProvider.of<SingleTodoCubit>(context).fetchSingleTodo(code);

                        debugPrint(
                            "ldhfvhef;kvhkjdf${barcode.barcodes[0].displayValue!} cfffffff ${barcode.raw.toString()}");
                      }
                    },
                    // onDetect: (barcode, args) {
                    //   if (barcode.rawValue != null) {
                    //     final String code = barcode.rawValue!;
                    //     context.go('/todo/$code');
                    //   }
                    // },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
