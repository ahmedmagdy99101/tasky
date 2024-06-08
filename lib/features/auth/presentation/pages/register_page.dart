import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:phone_form_field/phone_form_field.dart';
import '../../../../config/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';

import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _phoneNumberController =
  PhoneController(initialValue: PhoneNumber.parse('+20'));

  final _passwordController = TextEditingController();

  final _userNameController = TextEditingController();

  dynamic _levelValue;

  final _addressController = TextEditingController();

  final _experienceYearsController = TextEditingController();

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
          Navigator.of(context).pop();
        } else if (state is AuthLoaded) {
          Fluttertoast.showToast(
            msg: "تم التسجيل بنجاح",
            fontSize: 16,
            backgroundColor: Colors.white,
          );
        } else if (state is AuthFailure) {
          Fluttertoast.showToast(
            msg: state.message,
            fontSize: 16,
            backgroundColor: Colors.black,
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
                    Stack(
                      children: [
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
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              15.verticalSpace,
                              TextFormField(
                                controller: _userNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your User name";
                                  }

                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Name...',
                                ),
                              ),
                              15.verticalSpace,
                              PhoneFormField(
                                controller: _phoneNumberController,
                                validator: (value) {
                                  if (value!.isValid() == false) {
                                    return "Enter your phone number correctly";
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
                              15.verticalSpace,
                              TextFormField(
                                validator: (value) {
                                  final intValue = int.tryParse(value!);
                                  if (intValue == null) {
                                    return 'Must Be Number';
                                  }

                                  return null;
                                },
                                controller: _experienceYearsController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'Years of experience...',
                                ),
                              ),
                              15.verticalSpace,
                              Container(
                                width: 1.sw,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: const Color(0xffE4E4E4))),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      underline: const SizedBox(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 24,
                                        color: Color(0xff9E9E9E),
                                      ),
                                      // value: '',
                                      hint: const Text(
                                        'Choose experience Level',
                                        style: TextStyle(color: Color(0xff9E9E9E)),
                                      ),
                                      value: _levelValue,
                                      items: <String>[
                                        'fresh',
                                        'junior',
                                        'midLevel',
                                        'senior'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),

                                      onChanged: (value) {
                                        setState(() {
                                          _levelValue = value;
                                        });
                                      },
                                    )),
                              ),
                              15.verticalSpace,
                              TextFormField(
                                controller: _addressController,
                                decoration: const InputDecoration(
                                  hintText: 'Address...',
                                ),
                              ),
                              15.verticalSpace,
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your Password";
                                  }

                                  return null;
                                },
                                obscureText: true,
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
                      ],
                    ),
                    5.verticalSpace,
                    15.verticalSpace,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print(int.parse(
                            _experienceYearsController.text,
                          ).runtimeType);
                          BlocProvider.of<AuthCubit>(context).register(
                              phoneNumber:
                              "+${_phoneNumberController.value.countryCode}${_phoneNumberController.value.nsn}",
                              password: _passwordController.text,
                              displayName: _userNameController.text,
                              level: _levelValue,
                              experienceYears:
                              int.parse(_experienceYearsController.text),
                              address: _addressController.text);
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
                        'Sign up',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have any account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: const Color(0xFF7F7F7F)),
                        ),
                        GestureDetector(
                            onTap: () {
                              context.push('/login');
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
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
