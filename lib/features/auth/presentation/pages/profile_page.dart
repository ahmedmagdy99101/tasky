import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasky/config/theme/app_theme.dart';

import '../widgets/build_profile_card_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 1,
        title: Text("Profile",style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w700),),
            leading:  IconButton(onPressed: () {
              context.pop();

            }, icon: Image.asset("assets/icons/left_arrow.png",width: 24,),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
        child: Column(
          children: [
            const BuildProfileCardWidget(title: 'NAME', subTitle: 'Ahmed Magdy',),
            BuildProfileCardWidget(title: 'PHONE', subTitle: '+20 123 456-7890',icon: IconButton(onPressed: () {  }, icon: Image.asset("assets/icons/copy.png",width: 24,color: AppTheme.primaryColor,),),),
            const BuildProfileCardWidget(title: 'LEVEL', subTitle: 'Senior',),
            const BuildProfileCardWidget(title: 'YEARS OF EXPERIENCE', subTitle: '7 years',),
            const BuildProfileCardWidget(title: 'Location', subTitle: 'Fayyum, Egypt',),
          ],
        ),
      ),
    );
  }
}


