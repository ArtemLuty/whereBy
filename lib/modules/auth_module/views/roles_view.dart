import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:whereby_app/constants/colors.dart';
import 'package:whereby_app/modules/chime_module/chime_sdk.dart';
import 'package:whereby_app/modules/home_module/home_screen.dart';
import 'package:whereby_app/utils/fonts.dart';
import 'package:whereby_app/widgets/app_button.dart';

class RolesView extends StatefulWidget {
  const RolesView({Key? key}) : super(key: key);

  @override
  State<RolesView> createState() => _RolesViewState();
}

class _RolesViewState extends State<RolesView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isPasswordVisible = false;

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  void tokenValid() {
    if (_scanBarcode.length == 156) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Іncorrect email';
    }
    return null; // Return null if validation succeeds
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null; // Return null if validation succeeds
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 80,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                height: 15,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 10, color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Don’t have an account yet? ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
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
                  labelStyle: const TextStyle(color: ColorConstants.hintText),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: ColorConstants.filledBorderColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: ColorConstants.filledBorderColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: ColorConstants.filledBorderColor, width: 1),
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
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(color: ColorConstants.hintText),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: ColorConstants.filledBorderColor, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: ColorConstants.filledBorderColor, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                        color: ColorConstants.filledBorderColor, width: 1),
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
                obscureText: !_isPasswordVisible,
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
                onPressed: () {
                  // Forgot password functionality
                },
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
        AppButton(
          'Sign in',
          onTap: () {
            if (_formKey.currentState!.saveAndValidate()) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            }
          },
          elevation: 0,
          color: ColorConstants.buttonColor,
          textColor: Colors.white,
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  void handleRegisterTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
