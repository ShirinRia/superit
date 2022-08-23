
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';




class UserInformationScreen extends StatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
 State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //File? image;
  Uint8List? image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    nameController.dispose();
    _fullnameController.dispose();
    _bioController.dispose();
  }

  // void selectImage() async {
  //   image = await pickImageFromGallery(context);
  //   setState(() {});
  // }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      image = im;
    });
  }
  // void storeUserData() async {
  //   String name = nameController.text.trim();
  //   String bio = _bioController.text.trim();
  //
  //   if (name.isNotEmpty) {
  //     // ref.read(authControllerProvider).saveUserDataToFirebase(
  //     //       context,
  //     //       name,
  //     //       image,
  //     //     );
  //
  //     AuthMethods().signUpUser(file: image, bio: bio, username: name);
  //   }
  // }


  void signUpUser() async {
    // set loading to true
    // setState(() {
    //   _isLoading = true;
    // });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
      email:_emailController.text,
      password: _passwordController.text,
        username: nameController.text.toLowerCase(),
        //fullname:_fullnameController.text,
        bio: _bioController.text,
        file: image!);
    // if string returned is sucess, user has been created
    // setState(() {
    //   _isLoading = false;
    // });
    if (res != "success") {
      showSnackBar(context, res);
    }
    else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
          ),
      );

    }
  }

  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  image == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/user_loading.png',
                          ),
                          radius: 64,
                        )
                      : CircleAvatar(
                          backgroundImage: MemoryImage(
                            image!,
                          ),
                          radius: 64,
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: size.width * 0.85,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Username',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // TextField(
                        //   controller: nameController,
                        //   decoration: const InputDecoration(
                        //     hintText: 'Enter your Name',
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 24,
                        // ),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Email',
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your Password',

                          ),
                          obscureText:true,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextField(
                          controller: _bioController,
                          decoration: const InputDecoration(
                            hintText: 'Enter your bio',
                          ),
                        ),

                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: signUpUser,
                    icon: const Icon(
                      Icons.done,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



