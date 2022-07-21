import 'package:flutter/material.dart';
import 'package:superit/screens/signin_screen.dart';

import '../widgets/custom_button.dart';
import 'login_screen.dart';





class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);
  //
  // void navigateToLoginScreen(BuildContext context) {
  //   Navigator.pushNamed(context, LoginScreen.routeName);
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(

      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Welcome To Superit',
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height / 9),
              Image.asset(
               // 'assets/bg.png',
                'assets/landing.png',
                height: 391,
                width: 391,
                //color: Color.fromRGBO(0, 167, 131, 1),
              ),
              // SizedBox(height: size.height / 9),
              // const Padding(
              //   padding: EdgeInsets.all(15.0),
              //
              // ),
              const SizedBox(height:80),
              SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                  text: 'LOG IN',
                  onPressed: ()
                  // {final User? user = Provider.of<UserProvider>(context).getUser;}
                  =>Navigator.of(context).push(

                    MaterialPageRoute(
                      builder: (context) => const SigninScreen(),
                    ),
                  ),
                  // onPressed: () => navigateToLoginScreen(context),

                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: size.width * 0.75,
                child: CustomButton(
                  text: 'CONTINUE',
                  onPressed: ()
                  // {final User? user = Provider.of<UserProvider>(context).getUser;}
                  =>Navigator.of(context).push(

                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                  ),
                // onPressed: () => navigateToLoginScreen(context),

                ),
              ),
            ],
          ),
        ),
     ),
    );
  }
}
