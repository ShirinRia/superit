// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
//
// import '../models/user.dart';
// import '../providers/user_provider.dart';
// import '../resources/firestore_methods.dart';
// import '../utils/colors.dart';
// import '../utils/utils.dart';
//
// class AddPostScreen extends StatefulWidget {
//   const AddPostScreen({Key? key}) : super(key: key);
//
//   @override
//   State<AddPostScreen> createState() => _AddPostScreenState();
// }
//
// class _AddPostScreenState extends State<AddPostScreen> {
//   Uint8List? _file;
//    String _ftype="";
//   final TextEditingController _descriptionController = TextEditingController();
// bool _isLoading =false;
//   void postImage(
//     String uid,
//     String username,
//     String profImage,
//       String type,
//   ) async {
//     setState(() {
//       _isLoading=true;
//     });
//     try {
//       String res = await FireStoreMethods().uploadPost(
//           _descriptionController.text, _file!, uid, username, profImage,type);
//       if (res == 'success') {
//         setState(() {
//           _isLoading=true;
//         });
//         showSnackBar(context, 'posted!');
//         clearImage();
//       } else {
//         setState(() {
//           _isLoading=false;
//         });
//         showSnackBar(context, res);
//       }
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }
//
//   _selectImage(BuildContext context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             title: const Text('Create a Post'),
//             children: [
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Take a Photo'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(
//                     ImageSource.camera,
//                   );
//                   setState(() {
//                     _file= file;
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose Photo from gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickImage(
//                     ImageSource.gallery,
//                   );
//                   setState(() {
//                     _file = file;
//                     _ftype="image";
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Choose Video from gallery'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                   Uint8List file = await pickVideo(
//                     ImageSource.gallery,
//                   );
//                   setState(() {
//                     _file = file;
//                     _ftype="video";
//                   });
//                 },
//               ),
//               SimpleDialogOption(
//                 padding: const EdgeInsets.all(20),
//                 child: const Text('Cancel'),
//                 onPressed: () async {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         });
//   }
//   void clearImage() {
//     setState(() {
//       _file = null;
//     });
//   }
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _descriptionController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final User? user = Provider.of<UserProvider>(context).getUser;
//     if (user == null) {
//       return const Center(
//           child: CircularProgressIndicator(
//         color: Colors.white,
//       ));
//     }
//     return  _file  == null
//         ? Center(
//             child: Column(mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 IconButton(
//                   onPressed: () => _selectImage(context),
//                   icon: const Icon(
//                       Icons.cloud_upload_sharp,
//                  size: 50.0
//                   ),
//
//                 ),
//                 SizedBox(
//                   height: 40.0,
//                 ),
//                 Text(
//                   ' Tap here to create post',
//                   style: TextStyle(
//                     color: secondaryColor,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 30.0,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         : Scaffold(
//             appBar: AppBar(
//               backgroundColor: mobileBackgroundColor,
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back),
//                 onPressed:clearImage,
//               ),
//               title: const Text('Post to'),
//               centerTitle: false,
//               actions: [
//                 TextButton(
//                     onPressed: () => postImage(
//                           user.uid,
//                           user.username,
//                           user.photoUrl,
//                           _ftype,
//                         ),
//                     child: const Text(
//                       'Post',
//                       style: TextStyle(
//                         color: Colors.blueAccent,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ))
//               ],
//             ),
//             body: Column(
//               children: [
//                 _isLoading
//                     ? const LinearProgressIndicator()
//                     : const Padding(padding: EdgeInsets.only(top: 0.0)),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         user.photoUrl,
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 0.45,
//                       child: TextField(
//                         controller: _descriptionController,
//                         decoration: const InputDecoration(
//                           hintText: 'Write a caption...',
//                           border: InputBorder.none,
//                         ),
//                         maxLines: 8,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 45,
//                       height: 45,
//                       child: AspectRatio(
//                         aspectRatio: 487 / 451,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             image: DecorationImage(
//                               fit: BoxFit.fill,
//                               alignment: FractionalOffset.topCenter,
//                               image: MemoryImage(_file!),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Divider(),
//               ],
//             ),
//           );
//   }
// }

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  late String type;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading =false;
  void postImage(
      String uid,
      String username,
      String profImage,
      String type,
      ) async {
    setState(() {
      _isLoading=true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, username, profImage,type);
      if (res == 'success') {
        setState(() {
          _isLoading=true;
        });
        showSnackBar(context, 'posted!');
        clearImage();
      } else {
        setState(() {
          _isLoading=false;
        });
        showSnackBar(context, res);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose image from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,

                  );
                  setState(() {
                    _file = file;
                    type="image";
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose video from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickVideo(
                    ImageSource.gallery,

                  );
                  setState(() {
                    _file = file;
                    type="video";
                  });
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
  void clearImage() {
    setState(() {
      _file = null;
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    if (user == null) {
      return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ));
    }
    return _file == null
        ? Center(
      child: IconButton(
        onPressed: () => _selectImage(context),
        icon: const Icon(Icons.upload),
      ),
    )
        : Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:clearImage,
        ),
        title: const Text('Post to'),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () => postImage(
                user.uid,
                user.username,
                user.photoUrl,
                type,
              ),
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          _isLoading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0.0)),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CircleAvatar(
                backgroundImage: NetworkImage(
                  user.photoUrl,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Write a caption...',
                    border: InputBorder.none,
                  ),
                  maxLines: 8,
                ),
              ),
              SizedBox(
                width: 45,
                height: 45,
                child: AspectRatio(
                  aspectRatio: 487 / 451,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                        image: MemoryImage(_file!),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
