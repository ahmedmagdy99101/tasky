import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Column(
          children: [
            Image.asset(
              "assets/images/art2.png",
              width: 1.sw,
              height: 485.h,
              fit: BoxFit.fitWidth,
            ),
            5.verticalSpace,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(

                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),

                    ),
                  ),
                ],
              ),
            ),
            CustomTextField(
              controller: _phoneNumberController,
              labelText: 'Phone Number',
            ),
            CustomTextField(
              controller: _passwordController,
              labelText: 'Password',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoaded) {
                  context.go('/todos');
                } else if (state is AuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthCubit>().login(
                      _phoneNumberController.text,
                      _passwordController.text,
                    );
                  },
                  child: const Text('Login'),
                );
              },
            ),
            TextButton(
              onPressed: () {
                context.push('/register');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
