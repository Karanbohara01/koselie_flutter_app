// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart'; // Google Fonts
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// import 'package:shimmer/shimmer.dart'; // Shimmer Effect

// class PostView extends StatefulWidget {
//   const PostView({super.key});

//   @override
//   State<PostView> createState() => _PostViewState();
// }

// class _PostViewState extends State<PostView> {
//   String _searchQuery = ""; // 🔍 Search Query State

//   @override
//   void initState() {
//     super.initState();
//     context.read<PostsBloc>().add(LoadPosts(context: context));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: Text(
//           'Marketplace',
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//             color: Colors.white,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 5,
//         backgroundColor: Colors.transparent,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           _buildSearchBar(), // ✅ Search Bar
//           Expanded(
//             child: BlocBuilder<PostsBloc, PostsState>(
//               builder: (context, state) {
//                 if (state.isLoading) {
//                   return _buildShimmerLoading();
//                 } else if (state.error != null) {
//                   return _buildErrorScreen(state.error!);
//                 }

//                 // ✅ Apply search filter
//                 final filteredPosts = state.posts
//                     .where((post) => post.caption
//                         .toLowerCase()
//                         .contains(_searchQuery.toLowerCase()))
//                     .toList();

//                 if (filteredPosts.isEmpty) {
//                   return _buildNoPostsScreen();
//                 }

//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10.0,
//                       mainAxisSpacing: 12.0,
//                       childAspectRatio: 0.8,
//                     ),
//                     itemCount: filteredPosts.length,
//                     itemBuilder: (context, index) {
//                       return PostCard(post: filteredPosts[index]);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔍 **Search Bar Widget**
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         onChanged: (query) {
//           setState(() {
//             _searchQuery = query;
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'Search for products...',
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.white,
//         ),
//       ),
//     );
//   }

//   /// ✨ **Shimmer Loading Effect**
//   Widget _buildShimmerLoading() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 12.0,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: 6, // Number of shimmer placeholders
//         itemBuilder: (context, index) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   /// ⚠️ **Error UI with Retry Button**
//   Widget _buildErrorScreen(String error) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Error loading posts: $error',
//             style: GoogleFonts.poppins(
//               color: Colors.red,
//               fontSize: 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: () {
//               context.read<PostsBloc>().add(LoadPosts(context: context));
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.black,
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }

//   /// ❌ **No Posts Available UI**
//   Widget _buildNoPostsScreen() {
//     return Center(
//       child: Text(
//         'No posts found.',
//         style: GoogleFonts.poppins(
//           color: Colors.black54,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }

// /// **Post Card Widget**
// class PostCard extends StatelessWidget {
//   const PostCard({super.key, required this.post});

//   final PostsEntity post;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 5,
//       borderRadius: BorderRadius.circular(12),
//       color: Colors.white,
//       shadowColor: Colors.black.withOpacity(0.2),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           // ✅ Dispatch `GetPostById` event when tapped
//           context
//               .read<PostsBloc>()
//               .add(GetPostById(postId: post.postId ?? "", context: context));

//           // ✅ Navigate to Post Details Page
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PostDetailsView(postId: post.postId ?? ""),
//             ),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📷 Image Section
//             Expanded(
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   "${ApiEndpoints.imageUrl}/${post.image!}",
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                       _buildPlaceholderImage(),
//                 ),
//               ),
//             ),

//             // 🔥 Post Details Section
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.caption,
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         // overflow: TextOverflow.ellipsis,
//                       )),
//                   const SizedBox(height: 4.0),
//                   Text('Rs. ${post.price}',
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.green,
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// 📷 **Placeholder Image**
//   Widget _buildPlaceholderImage() {
//     return Container(
//       color: Colors.grey[300],
//       child: const Center(
//         child: Icon(Icons.image_outlined, color: Colors.grey),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';
import 'package:shimmer/shimmer.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadPosts(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100]!;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final appBarGradient = isDarkMode
            ? [Colors.black87, Colors.black54]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
        final cardColor = isDarkMode ? Colors.grey[700]! : Colors.white;
        final shimmerBaseColor =
            isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;
        final shimmerHighlightColor =
            isDarkMode ? Colors.grey[500]! : Colors.grey[100]!;
        final searchFillColor = isDarkMode ? Colors.grey[800]! : Colors.white;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              'Marketplace',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 5,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: appBarGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              _buildSearchBar(searchFillColor, textColor),
              Expanded(
                child: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return _buildShimmerLoading(
                          shimmerBaseColor, shimmerHighlightColor);
                    } else if (state.error != null) {
                      return _buildErrorScreen(state.error!, textColor);
                    }

                    final filteredPosts = state.posts
                        .where((post) => post.caption
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                    if (filteredPosts.isEmpty) {
                      return _buildNoPostsScreen(textColor);
                    }

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: filteredPosts.length,
                        itemBuilder: (context, index) {
                          return PostCard(
                            post: filteredPosts[index],
                            cardColor: cardColor,
                            textColor: textColor,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 🔍 Search Bar Widget
  Widget _buildSearchBar(Color searchFillColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(color: textColor),
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search for products...',
          hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: searchFillColor,
        ),
      ),
    );
  }

  /// ✨ Shimmer Loading Effect
  Widget _buildShimmerLoading(Color baseColor, Color highlightColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ⚠️ Error UI with Retry Button
  Widget _buildErrorScreen(String error, Color textColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error loading posts: $error',
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context.read<PostsBloc>().add(LoadPosts(context: context));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// ❌ No Posts Available UI
  Widget _buildNoPostsScreen(Color textColor) {
    return Center(
      child: Text(
        'No posts found.',
        style: GoogleFonts.poppins(
          color: textColor.withOpacity(0.6),
          fontSize: 16,
        ),
      ),
    );
  }
}

/// Post Card Widget
class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.cardColor,
    required this.textColor,
  });

  final PostsEntity post;
  final Color cardColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      color: cardColor,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          context
              .read<PostsBloc>()
              .add(GetPostById(postId: post.postId ?? "", context: context));

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsView(postId: post.postId ?? ""),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  "${ApiEndpoints.imageUrl}/${post.image!}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholderImage(cardColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: textColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Rs. ${post.price}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Placeholder Image
  Widget _buildPlaceholderImage(Color cardColor) {
    return Container(
      color: cardColor,
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.grey),
      ),
    );
  }
}
