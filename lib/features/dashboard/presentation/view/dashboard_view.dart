import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // For better typography
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:shimmer/shimmer.dart'; // For shimmer effect

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    Future.microtask(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
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
          title: Text(
            'Koselie',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          elevation: 10, // Increased elevation for depth
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8E2DE2), // Purple
                  Color(0xFFEC008C), // Pink
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Confirm Logout"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            context
                                .read<AuthBloc>()
                                .add(AuthLogoutRequested()); // Trigger logout
                          },
                          child: const Text("Logout"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF5F5F5), // Light gray
                Color(0xFFE0E0E0), // Slightly darker gray
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
                // Text(
                //   'Welcome to Koselie!',
                //   style: GoogleFonts.poppins(
                //     fontSize: 26,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
                // const SizedBox(height: 16),

                // 🌟 Categories Title
                Text(
                  'Categories',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // 🌟 Categories Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return AnimatedCategoryCard(
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

// 🌟 Animated Category Card
class AnimatedCategoryCard extends StatefulWidget {
  final String title;
  final String imageUrl;

  const AnimatedCategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  _AnimatedCategoryCardState createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: CategoryCard(
          title: widget.title,
          imageUrl: widget.imageUrl,
        ),
      ),
    );
  }
}

// 🌟 Category Card Design
class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const CategoryCard({super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withOpacity(0.3),
      color: Colors.black, // 🖤 Card Background
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // 🌟 Category Image with Shimmer Effect
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[900]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      color: Colors.grey[900],
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderImage(),
              ),
            ),

            // 🌟 Overlay Gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            // 🌟 Category Title
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                title,
                style: GoogleFonts.poppins(
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
    );
  }

  /// ✅ **Placeholder Image for Broken Links**
  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.white),
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
