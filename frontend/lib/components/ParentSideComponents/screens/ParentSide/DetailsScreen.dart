// // ignore: file_names
// import 'package:flutter/material.dart';
// import 'package:frontend/main.dart';

// class DetailsScreen extends StatelessWidget {
//   const DetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue,
//       body: Column(
//         children: [
//           const SizedBox(height: 30),
//           Expanded(
//             child: PageView(
//               scrollDirection: Axis.horizontal,
//               children: [
//                 _buildPage(
//                   title: "Welcome To Edu Fun",
//                   subtitle: "Thank you for downloading the EDUFUN app",
//                   description: "With this application, you can...",
//                 ),
//                 _buildPage(
//                   title: "Take Control!!",
//                   subtitle:
//                       "Manage your child's phone activity while ensuring a fun and safe digital experience!",
//                 ),
//                 _buildPage(
//                   title: "Learn and Play!",
//                   subtitle:
//                       "Access educational content and fun activities designed for kids of all ages!",
//                 ),
//                 _buildPage(
//                   title: "Monitor Usage",
//                   subtitle:
//                       "Track screen time, set daily limits, and keep an eye on app usage.",
//                 ),
//                 _buildPage(
//                   title: "Parental Guidance",
//                   subtitle:
//                       "Get insights on your child's activity and guide them with educational content.",
//                 ),
//                 _buildLastPage(
//                   context,
//                   title: "Safe & Fun Learning",
//                   subtitle:
//                       "Ensure your child has a safe and enjoyable learning experience with EduFun!",
//                   buttonText: "Get Started",
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildPage({
//   required String title,
//   required String subtitle,
//   String? description,
// }) {
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 31,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontFamily: 'Poppins', // ✅ Apply Poppins font
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         Text(
//           subtitle,
//           style: const TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//             fontFamily: 'Poppins', // ✅ Apply Poppins font
//           ),
//           textAlign: TextAlign.center,
//         ),
//         if (description != null) ...[
//           const SizedBox(height: 18),
//           Text(
//             description,
//             style: const TextStyle(color: Colors.white, fontFamily: 'Poppins'),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ],
//     ),
//   );
// }

// Widget _buildLastPage(
//   BuildContext context, {
//   required String title,
//   required String subtitle,
//   required String buttonText,
// }) {
//   return Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 31,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//             fontFamily: 'Poppins', // ✅ Apply Poppins font
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         Text(
//           subtitle,
//           style: const TextStyle(
//             fontSize: 20,
//             color: Colors.white,
//             fontFamily: 'Poppins', // ✅ Apply Poppins font
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 40),
//         SizedBox(
//           width: 320,
//           height: 40,
//           child: ElevatedButton(
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) =>  MyApp()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: Text(
//               buttonText,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 16,
//                 fontFamily: 'Poppins', // ✅ Apply Poppins font
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
