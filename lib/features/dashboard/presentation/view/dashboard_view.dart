import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/features/auth/presentation/view/login_view.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';
import 'package:shimmer/shimmer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Theme.of(context).dialogBackgroundColor, // Themed background
          title: Text("Confirm Logout",
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color)), // Themed text
          content: Text("Are you sure you want to log out?",
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color)),
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          _navigateToLogin(context); // Navigate to LoginView on logout
        }
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          final isDarkMode = themeState is DarkThemeState;

          // Define colors based on theme
          final backgroundColorStart =
              isDarkMode ? Colors.black87 : const Color(0xFFF5F5F5);
          final backgroundColorEnd =
              isDarkMode ? Colors.black54 : const Color(0xFFE0E0E0);
          final textColor = isDarkMode ? Colors.white : Colors.black;
          final shimmerBaseColor =
              isDarkMode ? Colors.grey[900]! : Colors.grey[300]!;
          final shimmerHighlightColor =
              isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;
          final appBarGradient = isDarkMode
              ? [Colors.black87, Colors.black54]
              : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];

          return Scaffold(
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
              elevation: 10,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: appBarGradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () => _showLogoutConfirmationDialog(context),
                ),
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [backgroundColorStart, backgroundColorEnd],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                            shimmerBaseColor: shimmerBaseColor,
                            shimmerHighlightColor: shimmerHighlightColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedCategoryCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const AnimatedCategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
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
          shimmerBaseColor: widget.shimmerBaseColor,
          shimmerHighlightColor: widget.shimmerHighlightColor,
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color shimmerBaseColor;
  final Color shimmerHighlightColor;

  const CategoryCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.shimmerBaseColor,
    required this.shimmerHighlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.black.withOpacity(0.3),
      color: Colors.black,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return Shimmer.fromColors(
                    baseColor: shimmerBaseColor,
                    highlightColor: shimmerHighlightColor,
                    child: Container(
                      color: Colors.grey[900],
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholderImage(),
              ),
            ),
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

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[900],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.white),
      ),
    );
  }
}

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
