import 'package:flutter/material.dart';


import '../resources/auth_methods.dart';

// class  extends StatelessWidget {
//   const ({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }



class OTPScreen extends StatelessWidget {
  static const String routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen( {
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  void verifyOTP( BuildContext context, String userOTP) {
    // ref.read(authControllerProvider).verifyOTP(
    //       context,
    //       verificationId,
    //       userOTP,
    //     );
    AuthMethods().verifyOTP(context: context, userOTP: userOTP, verificationId: verificationId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying your number'),
        elevation: 0,
        //backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('We have sent an SMS with a code.'),
            SizedBox(
              width: size.width * 0.5,
              child: TextField(
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                   verifyOTP(context, val.trim());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
