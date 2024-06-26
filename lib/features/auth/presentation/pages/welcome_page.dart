import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/config/theme/app_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //10.verticalSpace,
            Image.asset(
              "assets/images/art.png",
              width: 1.sw,
              height: 455.h,
              fit: BoxFit.fitWidth,
            ),
            35.verticalSpace,
            SizedBox(
                width: 235.w,
                child: Text(
                  "Task Management & To-Do List",
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                )),
            16.verticalSpace,
            SizedBox(
                width: 235.w,
                child: Text(
                  "This productive tool is designed to help you better manage your taskproject-wise conveniently!",
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                )),
            30.verticalSpace,
            ElevatedButton(
              onPressed: () {
                context.push('/login');
              },
              style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppTheme.primaryColor),
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  fixedSize: WidgetStateProperty.all(Size(331.w, 49.h))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Let’s Start',
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  8.horizontalSpace,
                  Image.asset(
                    "assets/icons/right_arrow.png",
                    width: 24,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
