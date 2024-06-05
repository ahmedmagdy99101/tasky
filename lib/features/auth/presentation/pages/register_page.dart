import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../config/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // SvgPicture.asset(
                  //   'assets/images/art.svg',
                  //   width: 1.sw,
                  //   height: 275.h,
                  // ),
                  Center(
                    child: Image.asset(
                      "assets/images/art.png",
                      width: 290.w,
                      height: 300.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        220.verticalSpace,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),

                          ),
                        ),
                        15.verticalSpace,
                        TextFormField(
                          decoration:  const InputDecoration(
                            hintText: 'Name...',
                          ),),
                        15.verticalSpace,
                        PhoneFormField(
                          initialValue: PhoneNumber.parse('+20'),
                          decoration: const InputDecoration(
                            hintText: '123 456-7890',
                          ),
                          // or use the controller
                          // validator: PhoneValidator.compose(
                          //     [PhoneValidator.required(), PhoneValidator.validMobile()]),
                          countrySelectorNavigator: const CountrySelectorNavigator.page(),
                          onChanged: (phoneNumber) => print('changed into $phoneNumber'),
                          enabled: true,
                          isCountrySelectionEnabled: true,
                          isCountryButtonPersistent: true,

                          countryButtonStyle: const CountryButtonStyle(
                              showDialCode: true,
                              showIsoCode: false,
                              showFlag: true,
                              flagSize: 24
                          ),),
                        15.verticalSpace,
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration:  const InputDecoration(
                            hintText: 'Years of experience...',
                          ),

                        ),
                        15.verticalSpace,
                      Container(
                        width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: const Color(0xffE4E4E4)
                          )
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            underline: const SizedBox(),
                           padding: const EdgeInsets.symmetric(horizontal: 15),
                           icon: const Icon(Icons.keyboard_arrow_down_outlined ,size: 24,color: Color(0xff9E9E9E),),
                           // value: '',
                            hint: const Text('Choose experience Level',style: TextStyle(color: Color(0xff9E9E9E)),),
                            items: <String>['senior', 'fresh','junior' ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: const TextStyle(color: Colors.black),),
                              );
                            }).toList(),
                            onChanged: (value) {


                            },
                          )
                        ),
                      ),
                        15.verticalSpace,
                        TextFormField(
                          decoration:  const InputDecoration(
                            hintText: 'Address...',
                          ),),
                        15.verticalSpace,
                        TextFormField(
                          obscureText: true,
                          decoration:  InputDecoration(
                            hintText: 'Password...',
                            suffixIcon: IconButton(onPressed: (){}, icon:  const Icon(Icons.visibility_outlined,size: 24,color: Colors.grey,)),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              5.verticalSpace,

              15.verticalSpace,
              ElevatedButton(
                onPressed: () {

                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    fixedSize: WidgetStateProperty.all(Size(331.w, 49.h))
                ),
                child:  Text(
                  'Sign up',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),),
              15.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("Already have any account? " ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14.sp,color: const Color(0xFF7F7F7F)), ),
                  GestureDetector(
                      onTap: (){
                        context.push('/login');
                      },
                      child:  Text("Sign in",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14.sp,color: AppTheme.primaryColor,decoration: TextDecoration.underline,decorationColor: AppTheme.primaryColor), )),
                ],
              ),
              // BlocConsumer<AuthCubit, AuthState>(
              //   listener: (context, state) {
              //     if (state is AuthLoaded) {
              //       context.go('/todos');
              //     } else if (state is AuthFailure) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(state.message)),
              //       );
              //     }
              //   },
              //   builder: (context, state) {
              //     if (state is AuthLoading) {
              //       return CircularProgressIndicator();
              //     }
              //     return ElevatedButton(
              //       onPressed: () {
              //         context.read<AuthCubit>().register(
              //           _phoneNumberController.text,
              //           _passwordController.text,
              //         );
              //       },
              //       child: Text('Register'),
              //     );
              //   },
              // ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
