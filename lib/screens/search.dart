import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:superit/screens/search_screen.dart';
import 'package:superit/screens/searchbypost.dart';
import 'package:superit/screens/searchbyuser.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';

class searchdialogScreen extends StatefulWidget {
  const searchdialogScreen({Key? key}) : super(key: key);

  @override
  State<searchdialogScreen> createState() => _searchdialogScreenState();
}

class _searchdialogScreenState extends State<searchdialogScreen> {
  // _selectsearch(BuildContext context) async {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return SimpleDialog(
  //           title: const Text('Search by user'),
  //           children: [
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text('Take a Photo'),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //                 Uint8List file = await pickImage(
  //                   ImageSource.camera,
  //                 );
  //                 setState(() {
  //                   _file = file;
  //                 });
  //               },
  //             ),
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text('Search by post'),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //                 Navigator.of(context).push(
  //                   MaterialPageRoute(
  //                     builder: (context) => Searchbypost(),
  //                   ),
  //                 );
  //               },
  //             ),
  //             SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text('Cancel'),
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Search for user',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Searchbyuser(),
                ),
              );
            },
          ),
          SimpleDialogOption(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Search for post',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Searchbypost(),
                ),
              );
            },
          ),
        ],
      ),
      // IconButton(
      //   onPressed: () => _selectsearch(context),
      //   icon: const Icon(Icons.upload),
      // ),
    ));
  }
}
