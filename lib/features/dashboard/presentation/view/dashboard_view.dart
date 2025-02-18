// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/auth/presentation/view/login_view.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   void _navigateToLogin(BuildContext context) {
//     Future.microtask(() {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginView()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<AuthBloc, AuthState>(
//       listener: (context, state) {
//         if (state is AuthUnauthenticated) {
//           _navigateToLogin(context);
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Koselie',
//             style: TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           backgroundColor: Colors.black,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.logout, color: Colors.red),
//               onPressed: () {
//                 context.read<AuthBloc>().add(AuthLogoutRequested());
//               },
//             ),
//           ],
//         ),
//         body: const Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Welcome to Koselie!',
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Categories',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black54,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final String title;
//   final String imageUrl;

//   const CategoryCard({super.key, required this.title, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to category
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: const [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 6,
//               spreadRadius: 2,
//               offset: Offset(2, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.black87,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// final List<Map<String, String>> categories = [
//   {
//     'title': 'Electronics',
//     'imageUrl':
//         'https://m.media-amazon.com/images/I/71Pai0YmEfL._SL1500_.jpg', // Replace with actual URLs
//   },
//   {
//     'title': 'Fashion',
//     'imageUrl':
//         'https://media.glamour.com/photos/66f5c2777e09bc43bcee2067/master/w_2560%2Cc_limit/men%25E2%2580%2599s%2520fashion%2520trends.jpg',
//   },
//   {
//     'title': 'Home & Garden',
//     'imageUrl':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_D6UzlJ_5J0RihunglhixoPywcOur3xMC9A&s',
//   },
//   {
//     'title': 'Beauty',
//     'imageUrl':
//         'https://cdn.pixabay.com/photo/2023/11/14/22/54/beauty-8388807_640.jpg',
//   },
//   {
//     'title': 'Toys',
//     'imageUrl':
//         'https://cdn.firstcry.com/education/2022/11/06094158/Toy-Names-For-Kids.jpg',
//   },
//   {
//     'title': 'Sports',
//     'imageUrl':
//         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9Xv5vxs84doIRq3u1hKcZNzaendHsB3ADiA&s',
//   },
//   {
//     'title': 'Automotive',
//     'imageUrl':
//         'https://cdn.bikedekho.com/processedimages/royal-enfield/classic350/494X300/classic35066d56da536989.jpg',
//   },
//   {
//     'title': 'Books',
//     'imageUrl':
//         'https://junealholder.blog/wp-content/uploads/2019/05/img_20190505_155026_731-1.jpg?w=640',
//   },
// ];

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          _navigateToLogin(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Koselie',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8E2DE2), // Purple Shade
                  Color(0xFFEC008C), // Pink Shade
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8E2DE2),
                Color(0xFFEC008C),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to Koselie!',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),

                // 🌟 Categories Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryCard(
                        title: category['title']!,
                        imageUrl: category['imageUrl']!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// 🌟 Updated CategoryCard Design
class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to category
      },
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // 🌟 Category Image
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),

              // 🌟 Overlay Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),

              // 🌟 Category Title
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 📌 Category List with Images
final List<Map<String, String>> categories = [
  {
    'title': 'Electronics',
    'imageUrl': 'https://m.media-amazon.com/images/I/71Pai0YmEfL._SL1500_.jpg',
  },
  {
    'title': 'Fashion',
    'imageUrl':
        'https://media.glamour.com/photos/66f5c2777e09bc43bcee2067/master/w_2560%2Cc_limit/men%25E2%2580%2599s%2520fashion%2520trends.jpg',
  },
  {
    'title': 'Home & Garden',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_D6UzlJ_5J0RihunglhixoPywcOur3xMC9A&s',
  },
  {
    'title': 'Beauty',
    'imageUrl':
        'https://cdn.pixabay.com/photo/2023/11/14/22/54/beauty-8388807_640.jpg',
  },
  {
    'title': 'Toys',
    'imageUrl':
        'https://cdn.firstcry.com/education/2022/11/06094158/Toy-Names-For-Kids.jpg',
  },
  {
    'title': 'Sports',
    'imageUrl':
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9Xv5vxs84doIRq3u1hKcZNzaendHsB3ADiA&s',
  },
  {
    'title': 'Automotive',
    'imageUrl':
        'https://cdn.bikedekho.com/processedimages/royal-enfield/classic350/494X300/classic35066d56da536989.jpg',
  },
  {
    'title': 'Books',
    'imageUrl':
        'https://junealholder.blog/wp-content/uploads/2019/05/img_20190505_155026_731-1.jpg?w=640',
  },
];
