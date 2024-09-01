import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/auth_module/auth.state.dart';
import 'package:whereby_app/modules/auth_module/auth_cubit.dart';
import 'package:whereby_app/modules/home_module/onboarding_screen.dart';
import 'package:whereby_app/utils/fonts.dart';
import 'package:whereby_app/widgets/app_button.dart';
import 'package:url_launcher/url_launcher.dart';

class RolesView extends StatefulWidget {
  const RolesView({Key? key}) : super(key: key);

  @override
  State<RolesView> createState() => _RolesViewState();
}

class _RolesViewState extends State<RolesView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const OnboardingScreen(),
            ),
          );
        } else if (state is AuthError) {
          Fluttertoast.showToast(
            msg: "Login failed: login or password not correct",
            // ${state.message}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormBuilder(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    const SizedBox(height: 80),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                        children: [
                          const TextSpan(
                            text: 'Don’t have an account yet? ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: 'Register',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorConstants.buttonColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = handleRegisterTap,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    FormBuilderTextField(
                      name: 'email',
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle:
                            const TextStyle(color: ColorConstants.hintText),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.filledBorderColor,
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.filledBorderColor,
                              width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.filledBorderColor,
                              width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.errorColor, width: 1),
                        ),
                        hintStyle: const TextStyle(color: Colors.black),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: FontFamily.poppinsBold,
                        fontWeight: FontWeight.w600,
                      ),
                      validator: emailValidator,
                    ),
                    const SizedBox(height: 20),
                    FormBuilderTextField(
                      name: 'password',
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle:
                            const TextStyle(color: ColorConstants.hintText),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.filledBorderColor,
                              width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.filledBorderColor,
                              width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.filledBorderColor,
                              width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: const BorderSide(
                              color: ColorConstants.errorColor, width: 1),
                        ),
                        hintStyle: const TextStyle(color: Colors.amberAccent),
                        suffixIcon: IconButton(
                          icon: Icon(
                            color: ColorConstants.borderColor,
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: passwordValidator,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: FontFamily.poppinsBold,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: TextButton(
                      onPressed: () => handlePaswordTap(),
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: ColorConstants.buttonColor,
                          fontFamily: FontFamily.poppins,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              if (state is AuthLoading)
                const CircularProgressIndicator()
              else
                AppButton(
                  'Sign in',
                  onTap: () {
                    if (_formKey.currentState!.saveAndValidate()) {
                      final email =
                          _formKey.currentState!.fields['email']!.value;
                      final password =
                          _formKey.currentState!.fields['password']!.value;
                      context.read<AuthCubit>().getUserToken(email, password);
                    }
                  },
                  elevation: 0,
                  color: ColorConstants.buttonColor,
                  textColor: Colors.white,
                ),
              const SizedBox(height: 50),
            ],
          );
        },
      ),
    );
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Incorrect email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  void handleRegisterTap() async {
    final Uri url = Uri.parse('https://test.wetalk.co/sign-up/');

    if (await canLaunchUrl(url)) {
      await launchUrl(url,
          mode: LaunchMode.platformDefault); // Use platformDefault
    } else {
      throw 'Could not launch $url';
    }
  }

  void handlePaswordTap() async {
    final Uri url = Uri.parse('https://test.wetalk.co/forgot-password/');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
