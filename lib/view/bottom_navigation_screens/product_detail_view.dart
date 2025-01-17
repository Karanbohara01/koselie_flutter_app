// import 'package:flutter/material.dart';

// class ProductDetailsScreen extends StatelessWidget {
//   const ProductDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Stack(
//               children: [
//                 Image.network(
//                   'https://cdn.britannica.com/16/126516-050-2D2DB8AC/Triumph-Rocket-III-motorcycle-2005.jpg',
//                   width: double.infinity,
//                   height: 300,
//                   fit: BoxFit.contain,
//                 ),
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: IconButton(
//                     icon:
//                         const Icon(Icons.favorite_border, color: Colors.white),
//                     onPressed: () {},
//                   ),
//                 ),
//               ],
//             ),
//             const Padding(
//               padding: EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Title
//                   Text(
//                     'Uk jeep jacket',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   // Price
//                   Text(
//                     'रू7,000',
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.pink,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   // Location
//                   Row(
//                     children: [
//                       Icon(Icons.location_on, color: Colors.red),
//                       SizedBox(width: 8),
//                       Text(
//                         'Nearby',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(thickness: 1),
//             // Send Message Button
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pink,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Send seller a message',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             // Action Buttons
//             Container(
//               color: Colors.pink,
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildActionItem(Icons.notifications_active, 'Alerts'),
//                   _buildActionItem(Icons.local_offer, 'Send offer'),
//                   _buildActionItem(Icons.share, 'Share'),
//                   _buildActionItem(Icons.save, 'Save'),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Description Title
//                   Text(
//                     'Description',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 8),
//                   // Description Content
//                   Text(
//                     'होलसेल ! होलसेल ! होलसेल !\nअब UK jeep jacket होलसेलमुल्यमा\nके तपाई जाडो याम्का लगी एकदम न्यानो र रा... See more',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Action Item Widget
//   Widget _buildActionItem(IconData icon, String label) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           style: const TextStyle(color: Colors.white),
//         ),
//       ],
//     );
//   }
// }
