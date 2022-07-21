import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../widgets/custom_button.dart';

class passrecoverScreen extends StatefulWidget {
  // static const routeName = '/login-screen';
  const passrecoverScreen({Key? key}) : super(key: key);

  @override
  State<passrecoverScreen> createState() => _passrecoverScreenState();
}

class _passrecoverScreenState extends State<passrecoverScreen> {
  //final phoneController = TextEditingController();
  final TextEditingController _remailController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    _remailController.dispose();
  }

  // void passrecover() {
  //   // set loading to true
  //   String remail =_remailController.text.trim();
  //
  //   // signup user using our authmethodds
  //   //AuthMethods().signUpUserphone(context, phoneNumber: '+${country!.phoneCode}$phoneNumber',
  //   );
  //   // if string returned is sucess, user has been created
  //
  // }
  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _remailController.text.trim());
      showSnackBar(context, 'Password reset email sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (err) {
      showSnackBar(context, err.toString());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        elevation: 0,
        // backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('You will receive an email to reset your password'),
              const SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: _remailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Email',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 190,
                child: CustomButton(
                  onPressed: verifyEmail,
                  text: 'Reset Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
