// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:it008_social_media/constants/app_assets.dart';
// import 'package:it008_social_media/constants/app_dimensions.dart';
// import 'package:it008_social_media/screens/verify_story/verify_story.dart';
// import 'package:it008_social_media/widgets/header.dart';

// class AddStoryScreen extends StatefulWidget {
//   const AddStoryScreen({Key? key, required this.camera}) : super(key: key);

//   static const id = 'add_story_screen';
//   // final CameraDescription camera;

//   @override
//   State<AddStoryScreen> createState() => _AddStoryScreenState();
// }

// class _AddStoryScreenState extends State<AddStoryScreen> {
//   // late CameraController _controller;
//   late Future<void> _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.medium,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;

//     return Scaffold(
//         body: SafeArea(
//             child: Stack(
//       children: [
//         SizedBox(
//           height: size.height,
//           width: size.width,
//           child: FutureBuilder<void>(
//             future: _initializeControllerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 // If the Future is complete, display the preview.
//                 return CameraPreview(_controller);
//               } else {
//                 // Otherwise, display a loading indicator.
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//         ),
//         Column(
//           children: [
//             Header(
//               title: '',
//               prefixIcon: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: SvgPicture.asset(AppAssets.icArrowLeft,
//                     width: 18,
//                     height: 18,
//                     fit: BoxFit.contain,
//                     color: Colors.white),
//               ),
//             ),
//             const Spacer(),
//             Column(
//               children: [
//                 SvgPicture.asset(AppAssets.icArrowUp,
//                     width: 37,
//                     height: 13.5,
//                     fit: BoxFit.contain,
//                     color: Colors.white),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: Dimensions.defaultHorizontalMargin),
//                   child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                             onPressed: () {},
//                             icon: SvgPicture.asset(AppAssets.icOutlinedImage,
//                                 width: 25,
//                                 height: 25,
//                                 fit: BoxFit.contain,
//                                 color: Colors.white)),
//                         IconButton(
//                             iconSize: 60,
//                             splashRadius: 30,
//                             onPressed: () async {
//                               // Take the Picture in a try / catch block. If anything goes wrong,
//                               // catch the error.
//                               try {
//                                 // Ensure that the camera is initialized.
//                                 await _initializeControllerFuture;

//                                 // Attempt to take a picture and get the file `image`
//                                 // where it was saved.
//                                 XFile image = await _controller.takePicture();

//                                 if (!mounted) {
//                                   print("Unmounted");
//                                   return;
//                                 }

//                                 // If the picture was taken, display it on a new screen.
//                                 await Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                     builder: (context) => VerifyStoryScreen(
//                                       imagePath: image.path,
//                                     ),
//                                   ),
//                                 );
//                               } catch (e) {
//                                 // If an error occurs, log the error to the console.
//                                 print(e);
//                               }
//                             },
//                             icon: SvgPicture.asset(AppAssets.icCircle,
//                                 width: 60,
//                                 height: 60,
//                                 fit: BoxFit.contain,
//                                 color: Colors.white)),
//                         IconButton(
//                             onPressed: () {},
//                             icon: SvgPicture.asset(AppAssets.icSwitchCamera,
//                                 width: 25,
//                                 height: 25,
//                                 fit: BoxFit.contain,
//                                 color: Colors.white)),
//                       ]),
//                 ),
//                 const SizedBox(height: 10),
//                 Text('Tap for photo',
//                     style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 12,
//                         fontWeight: FontWeight.w400,
//                         color: Colors.white.withOpacity(0.8)))
//               ],
//             ),
//             const SizedBox(height: 10),
//           ],
//         )
//       ],
//     )));
//   }
// }
