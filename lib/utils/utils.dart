import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No Image Selected');
}
pickVideo(ImageSource src) async {
  final video = await ImagePicker().pickVideo(source: src);
  if (video != null) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => ConfirmScreen(
    //       videoFile: File(video.path),
    //       videoPath: video.path,
    //     ),
    //   ),
    // );
    return await video.readAsBytes();
  }
}
// for displaying snackbars
// showSnackBar(BuildContext context, String text) {
//   return ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(text),
//     ),
//   );
// }
showSnackBar(  BuildContext context,String text) {
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
