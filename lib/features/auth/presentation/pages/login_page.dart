import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../config/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/custom_text_field.dart';
import 'package:go_router/go_router.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _phoneNumberController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/art.png",
                width: 1.sw,
                height: 455.h,
                fit: BoxFit.fitWidth,
              ),
              5.verticalSpace,
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(

                  children: [
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w700),

                      ),
                    ),
                    20.verticalSpace,
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
                    20.verticalSpace,
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
              20.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  context.go('/todos');
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppTheme.primaryColor),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    fixedSize: WidgetStateProperty.all(Size(331.w, 49.h))
                ),
                child:  Text(
                  'Sign In',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),),
              20.verticalSpace,
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn’t have any account? " ,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Color(0xFF7F7F7F)), ),
                  GestureDetector(
                      onTap: (){
                        context.push('/register');
                      },
                      child: const Text("Sign Up here",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14,color: AppTheme.primaryColor,decoration: TextDecoration.underline,decorationColor: AppTheme.primaryColor), )),
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
              //       return const CircularProgressIndicator();
              //     }
              //     return ElevatedButton(
              //       onPressed: () {
              //         context.read<AuthCubit>().login(
              //           _phoneNumberController.text,
              //           _passwordController.text,
              //         );
              //       },
              //       child: const Text('Login'),
              //     );
              //   },
              // ),
              // TextButton(
              //   onPressed: () {
              //     context.push('/register');
              //   },
              //   child: const Text('Register'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
