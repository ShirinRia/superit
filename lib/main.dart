import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superit/providers/user_provider.dart';
import 'package:superit/responsive/mobile_screen_layout.dart';
import 'package:superit/responsive/responsive_layout.dart';
import 'package:superit/responsive/web_screen_layout.dart';
import 'package:superit/screens/landing_screen.dart';
import 'package:superit/screens/login_screen.dart';
import 'package:superit/utils/colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        //   apiKey: "AIzaSyAfLIUYqj_iC3i6yaCmLRzRhg6TOFAcF1M",
        // //  authDomain: "superit-3a1f4.firebaseapp.com",
        //   projectId: "superit-3a1f4",
        //   storageBucket: "superit-3a1f4.appspot.com",
        //   messagingSenderId: "382341091683",
        //   appId: "1:382341091683:web:caea544d062d2129cac356"
          apiKey: "AIzaSyCRrS1jjNHes7cVFMSZS3M_PqYHY5J5M28",
         // authDomain: "superit-f81ce.firebaseapp.com",
          projectId: "superit-f81ce",
          storageBucket: "superit-f81ce.appspot.com",
          messagingSenderId: "525504687169",
          appId: "1:525504687169:web:492f3b654edae0e6696ac0"

         //  apiKey: "AIzaSyCRrS1jjNHes7cVFMSZS3M_PqYHY5J5M28",
         // // authDomain: "superit-f81ce.firebaseapp.com",
         //  projectId: "superit-f81ce",
         //  storageBucket: "superit-f81ce.appspot.com",
         //  messagingSenderId: "525504687169",
         //  appId: "1:525504687169:web:c096feee931d6ee5696ac0"
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SuperIt',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home:

        //LandingScreen()
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot==null){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

           if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              }
              else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const LandingScreen();
          },
        ),
      ),
    );
  }
}
