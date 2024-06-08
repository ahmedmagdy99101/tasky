import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/config/theme/app_theme.dart';
import 'package:tasky/storage.dart';
import '../../../../injection_container.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/build_profile_card_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1,
        title: Text(
          "Profile",
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
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileIsLoaded) {
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  BuildProfileCardWidget(
                    title: 'NAME',
                    subTitle: state.profileModel.displayName ?? "",
                  ),
                  BuildProfileCardWidget(
                    title: 'PHONE',
                    subTitle: state.profileModel.username ?? "",
                    icon: IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: state.profileModel.username ?? ''))
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: 'Copied to clipboard',
                            fontSize: 16,
                            backgroundColor: Colors.black,
                          );
                        });
                      },
                      icon: Image.asset(
                        "assets/icons/copy.png",
                        width: 24,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  BuildProfileCardWidget(
                    title: 'LEVEL',
                    subTitle: state.profileModel.level ?? "",
                  ),
                  BuildProfileCardWidget(
                    title: 'YEARS OF EXPERIENCE',
                    subTitle:
                    '${state.profileModel.experienceYears ?? 0} years',
                  ),
                  BuildProfileCardWidget(
                    title: 'Location',
                    subTitle: state.profileModel.address ?? "",
                  ),
                ],
              ),
            );
          } else if (state is ProfileIsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileFailure) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.replace('/login');
                  AppSharedPreferences.sharedPreferences
                      .remove("accessToken");
                },
                style: ButtonStyle(
                    backgroundColor:
                    WidgetStateProperty.all(AppTheme.primaryColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                    fixedSize: WidgetStateProperty.all(Size(331.w, 49.h))),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );

  }
}
