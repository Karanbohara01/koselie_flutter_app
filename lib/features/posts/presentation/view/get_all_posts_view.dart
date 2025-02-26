// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';

// class PostView extends StatefulWidget {
//   const PostView({super.key});

//   @override
//   State<PostView> createState() => _PostViewState();
// }

// class _PostViewState extends State<PostView> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<PostsBloc>().add(LoadPosts(context: context));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Marketplace',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)], // 🌟 Gradient
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF8E2DE2), // Purple Shade
//               Color(0xFFEC008C), // Pink Shade
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: BlocBuilder<PostsBloc, PostsState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state.error != null) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Error loading posts: ${state.error!}',
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         context
//                             .read<PostsBloc>()
//                             .add(LoadPosts(context: context));
//                       },
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             } else if (state.posts.isNotEmpty) {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10.0,
//                     mainAxisSpacing: 12.0,
//                     childAspectRatio: 0.8,
//                   ),
//                   itemCount: state.posts.length,
//                   itemBuilder: (context, index) {
//                     final post = state.posts[index];
//                     return PostCard(post: post);
//                   },
//                 ),
//               );
//             } else {
//               return const Center(
//                 child: Text(
//                   'No posts available.',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class PostCard extends StatelessWidget {
//   const PostCard({super.key, required this.post});

//   final PostsEntity post;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 4,
//       borderRadius: BorderRadius.circular(12),
//       color: Colors.white,
//       shadowColor: Colors.black.withOpacity(0.1),
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
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(12)),
//                     child: (post.image != null && post.image!.isNotEmpty)
//                         ? Image.network(
//                             "${ApiEndpoints.imageUrl}/${post.image!}",
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                           )
//                         : Container(
//                             color: Colors.grey[300],
//                             child: const Center(
//                               child: Icon(Icons.image_outlined,
//                                   color: Colors.grey),
//                             ),
//                           ),
//                   ),
//                   // 📌 Category Tag
//                   Positioned(
//                     top: 8,
//                     left: 8,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         post.category.name,
//                         style:
//                             const TextStyle(color: Colors.white, fontSize: 10),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // 🔥 Post Details Section
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(post.caption,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       maxLines: 1),
//                   const SizedBox(height: 4.0),
//                   Text('Rs. ${post.price}',
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.green,
//                       )),
//                   const SizedBox(height: 6.0),
//                   Row(
//                     children: [
//                       const Icon(Icons.location_on,
//                           size: 14, color: Colors.grey),
//                       const SizedBox(width: 4),
//                       Expanded(
//                         child: Text(
//                           post.location,
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[700],
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           maxLines: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  ******************************************************************** //
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; // Google Fonts
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:shimmer/shimmer.dart'; // Shimmer Effect

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  String _searchQuery = ""; // 🔍 Search Query State

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadPosts(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(), // ✅ Search Bar
          Expanded(
            child: BlocBuilder<PostsBloc, PostsState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return _buildShimmerLoading();
                } else if (state.error != null) {
                  return _buildErrorScreen(state.error!);
                }

                // ✅ Apply search filter
                final filteredPosts = state.posts
                    .where((post) => post.caption
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()))
                    .toList();

                if (filteredPosts.isEmpty) {
                  return _buildNoPostsScreen();
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
                      return PostCard(post: filteredPosts[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔍 **Search Bar Widget**
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search for products...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  /// ✨ **Shimmer Loading Effect**
  Widget _buildShimmerLoading() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.8,
        ),
        itemCount: 6, // Number of shimmer placeholders
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
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

  /// ⚠️ **Error UI with Retry Button**
  Widget _buildErrorScreen(String error) {
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

  /// ❌ **No Posts Available UI**
  Widget _buildNoPostsScreen() {
    return Center(
      child: Text(
        'No posts found.',
        style: GoogleFonts.poppins(
          color: Colors.black54,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// **Post Card Widget**
class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final PostsEntity post;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // ✅ Dispatch `GetPostById` event when tapped
          context
              .read<PostsBloc>()
              .add(GetPostById(postId: post.postId ?? "", context: context));

          // ✅ Navigate to Post Details Page
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
            // 📷 Image Section
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  "${ApiEndpoints.imageUrl}/${post.image!}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      _buildPlaceholderImage(),
                ),
              ),
            ),

            // 🔥 Post Details Section
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.caption,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        // overflow: TextOverflow.ellipsis,
                      )),
                  const SizedBox(height: 4.0),
                  Text('Rs. ${post.price}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.green,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 📷 **Placeholder Image**
  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_outlined, color: Colors.grey),
      ),
    );
  }
}
