// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:superit/screens/signup_screen.dart';
//
// import '../resources/auth_methods.dart';
// import '../responsive/mobile_screen_layout.dart';
// import '../responsive/responsive_layout.dart';
// import '../responsive/web_screen_layout.dart';
// import '../utils/colors.dart';
// import '../utils/global_variable.dart';
// import '../utils/utils.dart';
// import '../widgets/text_field_input.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     super.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//   }
//
//   void loginUser() async {
//     setState(() {
//       _isLoading = true;
//     });
//     String res = await AuthMethods().loginUser(
//         email: _emailController.text, password: _passwordController.text);
//     // if (res == 'success') {
//     //   Navigator.of(context).pushAndRemoveUntil(
//     //       MaterialPageRoute(
//     //         builder: (context) => const ResponsiveLayout(
//     //           mobileScreenLayout: MobileScreenLayout(),
//     //           webScreenLayout: WebScreenLayout(),
//     //         ),
//     //       ),
//     //       (route) => false);
//     //
//     //   setState(() {
//     //     _isLoading = false;
//     //   });
//     // } else {
//     //   setState(() {
//     //     _isLoading = false;
//     //   });
//     //   showSnackBar(context, res);
//     // }
//     if (res == 'success') {
//
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => const ResponsiveLayout(
//             mobileScreenLayout: MobileScreenLayout(),
//             webScreenLayout: WebScreenLayout(),
//           ),
//         ),
//       );
//
//       //
//     } else {
//       showSnackBar( context,res);
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SafeArea(
//         child: Container(
//           padding: MediaQuery.of(context).size.width > webScreenSize
//               ? EdgeInsets.symmetric(
//                   horizontal: MediaQuery.of(context).size.width / 3)
//               : const EdgeInsets.symmetric(horizontal: 32),
//           width: double.infinity,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Flexible(
//                 child: Container(),
//                 flex: 2,
//               ),
//               SvgPicture.asset(
//                 'assets/superit.svg',
//                 color: primaryColor,
//                 height: 64,
//               ),
//               const SizedBox(
//                 height: 64,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your email',
//                 textInputType: TextInputType.emailAddress,
//                 textEditingController: _emailController,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               TextFieldInput(
//                 hintText: 'Enter your password',
//                 textInputType: TextInputType.text,
//                 textEditingController: _passwordController,
//                 isPass: true,
//               ),
//               const SizedBox(
//                 height: 24,
//               ),
//               InkWell(
//                 child: Container(
//                   child:
//                       // !_isLoading
//                       //     ? const Text(
//                       //         'Log in',
//                       //       )
//                       //     : const CircularProgressIndicator(
//                       //         color: primaryColor,
//                       //       ),
//                       _isLoading
//                           ? const Center(
//                               child: CircularProgressIndicator(
//                                 color: primaryColor,
//                               ),
//                             )
//                           : const Text('Log In'),
//                   width: double.infinity,
//                   alignment: Alignment.center,
//                   padding: const EdgeInsets.symmetric(vertical: 12),
//                   decoration: const ShapeDecoration(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4)),
//                     ),
//                     color: blueColor,
//                   ),
//                 ),
//                 onTap: loginUser,
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Flexible(
//                 child: Container(),
//                 flex: 2,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     child: const Text(
//                       'Dont have an account?',
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 8),
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => const SignupScreen(),
//                       ),
//                     ),
//                     child: Container(
//                       child: const Text(
//                         ' Signup.',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       padding: const EdgeInsets.symmetric(vertical: 8),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';


import '../resources/auth_methods.dart';

import '../widgets/custom_button.dart';




class LoginScreen extends StatefulWidget {
  // static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //final phoneController = TextEditingController();
  final TextEditingController _phoneController  = TextEditingController();
  Country? country;

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  // void sendPhoneNumber(){
  //   String phoneNumber = _phoneController.text.trim();
  //   if (country != null && phoneNumber.isNotEmpty) {
  //     // ref
  //     //     .read(authControllerProvider)
  //     //     .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
  //
  //   AuthMethods().signInWithPhone(
  //         context, '+${country!.phoneCode}$phoneNumber');
  //   } else {
  //     showSnackBar(context: context, content: 'Fill out all the fields');
  //   }
  //   // await AuthMethods().signInWithPhone(
  //   //     context, '+${country!.phoneCode}$phoneNumber');
  // }

  void signUpUser() {
    // set loading to true
    String phoneNumber = _phoneController.text.trim();

    // signup user using our authmethodds
    AuthMethods().signUpUserphone(context, phoneNumber: '+${country!.phoneCode}$phoneNumber',
    );
    // if string returned is sucess, user has been created



  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        // backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('For Continue we need to verify your phone number.'),
              const SizedBox(height: 10),
              TextButton(
                onPressed: pickCountry,
                child: const Text('Pick Country'),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  if (country != null)
                    Text('+${country!.phoneCode}'),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: size.width * 0.7,
                    child: TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.6),
              SizedBox(
                width: 90,
                child: CustomButton(
                  onPressed: signUpUser,
                  text: 'NEXT',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
