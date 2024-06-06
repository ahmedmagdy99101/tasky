import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_form_field/phone_form_field.dart';
import '../../../../config/theme/app_theme.dart';
import '../../../todo/presentation/pages/todo_list_page.dart';
import '../cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneNumberController = PhoneController(
    initialValue: PhoneNumber.parse('+20'),
  );

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool securTogel = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SizedBox(
                  width: 100.w,
                  height: 100.h,
                  child: const Center(child: CircularProgressIndicator())),
            ),
          );
        } else if (state is AuthLoaded) {
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TodoListPage(),
          ));
        } else if (state is AuthFailure) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(state.message.toString()),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Form(
            key: _formKey,
            child: SafeArea(
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
                              style: TextStyle(
                                  fontSize: 24.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                          20.verticalSpace,
                          PhoneFormField(
                            controller: _phoneNumberController,
                            validator: (value) {
                              if (value!.isValidLength() == false) {
                                return "You Should Enter Your Phone Number";
                              }
                              return null;
                            },

                            decoration: const InputDecoration(
                              hintText: '123 456-7890',
                            ),
                            // or use the controller
                            // validator: PhoneValidator.compose(
                            //     [PhoneValidator.required(), PhoneValidator.validMobile()]),
                            countrySelectorNavigator:
                            const CountrySelectorNavigator.page(),
                            onChanged: (phoneNumber) =>
                                print('changed into $phoneNumber'),
                            enabled: true,
                            isCountrySelectionEnabled: true,
                            isCountryButtonPersistent: true,

                            countryButtonStyle: const CountryButtonStyle(
                                showDialCode: true,
                                showIsoCode: false,
                                showFlag: true,
                                flagSize: 24),
                          ),
                          20.verticalSpace,
                          TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "You Should Enter password";
                              }

                              return null;
                            },
                            obscureText: securTogel,
                            decoration: InputDecoration(
                              hintText: 'Password...',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      securTogel = !securTogel;
                                    });
                                  },
                                  icon: securTogel == false
                                      ? const Icon(
                                    Icons.visibility_outlined,
                                    size: 24,
                                    color: Colors.grey,
                                  )
                                      : const Icon(
                                    Icons.visibility_off_outlined,
                                    size: 24,
                                    color: Colors.grey,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    ElevatedButton(
                      onPressed: () {
                        // context.go('/todos');
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(context).login(
                              "+${_phoneNumberController.value.countryCode}${_phoneNumberController.value.nsn}",
                              _passwordController.text);
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          WidgetStateProperty.all(AppTheme.primaryColor),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                          fixedSize:
                          WidgetStateProperty.all(Size(331.w, 49.h))),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn’t have any account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Color(0xFF7F7F7F)),
                        ),
                        GestureDetector(
                            onTap: () {
                              context.push('/register');
                            },
                            child: const Text(
                              "Sign Up here",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: AppTheme.primaryColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppTheme.primaryColor),
                            )),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
