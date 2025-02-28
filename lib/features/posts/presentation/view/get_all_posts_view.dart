// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// class PostView extends StatefulWidget {
//   const PostView({super.key});

//   @override
//   State<PostView> createState() => _PostViewState();
// }

// class _PostViewState extends State<PostView> {
//   String _searchQuery = "";

//   @override
//   void initState() {
//     super.initState();
//     context.read<PostsBloc>().add(LoadPosts(context: context));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;
//         final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100]!;
//         final textColor = isDarkMode ? Colors.white : Colors.black;
//         final cardColor = isDarkMode ? Colors.grey[900]! : Colors.white;
//         final contrastColor = isDarkMode ? Colors.white : Colors.purple;
//         final searchFillColor = isDarkMode ? Colors.grey[850]! : Colors.white;

//         return Scaffold(
//           backgroundColor: backgroundColor,
//           appBar: AppBar(
//             title: Text(
//               'Marketplace',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 24,
//                 color: Colors.white,
//               ),
//             ),
//             centerTitle: true,
//             elevation: 5,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ),
//           body: Column(
//             children: [
//               _buildSearchBar(searchFillColor, textColor),
//               Expanded(
//                 child: BlocBuilder<PostsBloc, PostsState>(
//                   builder: (context, state) {
//                     final filteredPosts = state.posts
//                         .where((post) => post.caption
//                             .toLowerCase()
//                             .contains(_searchQuery.toLowerCase()))
//                         .toList();

//                     if (filteredPosts.isEmpty) {
//                       return _buildNoPostsScreen(textColor);
//                     }

//                     return ListView.builder(
//                       padding: const EdgeInsets.all(8),
//                       itemCount: filteredPosts.length,
//                       itemBuilder: (context, index) {
//                         return PostCard(
//                           post: filteredPosts[index],
//                           cardColor: cardColor,
//                           textColor: textColor,
//                           contrastColor: contrastColor,
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchBar(Color searchFillColor, Color textColor) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextField(
//         style: GoogleFonts.poppins(color: textColor),
//         onChanged: (query) {
//           setState(() {
//             _searchQuery = query;
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'Search for products...',
//           hintStyle: GoogleFonts.poppins(color: textColor.withOpacity(0.6)),
//           prefixIcon: const Icon(Icons.search, color: Colors.grey),
//           filled: true,
//           fillColor: searchFillColor,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 12),
//         ),
//       ),
//     );
//   }

//   Widget _buildNoPostsScreen(Color textColor) {
//     return Center(
//       child: Text(
//         'No posts found.',
//         style: GoogleFonts.poppins(
//           color: textColor.withOpacity(0.6),
//           fontSize: 16,
//         ),
//       ),
//     );
//   }
// }

// class PostCard extends StatelessWidget {
//   const PostCard({
//     super.key,
//     required this.post,
//     required this.cardColor,
//     required this.textColor,
//     required this.contrastColor,
//   });

//   final PostsEntity post;
//   final Color cardColor;
//   final Color textColor;
//   final Color contrastColor;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       color: cardColor,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PostDetailsView(postId: post.postId ?? ""),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Product Image
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   "${ApiEndpoints.imageUrl}/${post.image!}",
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               // Product Details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Product Title
//                     Text(
//                       post.caption,
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: textColor,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 4),
//                     // Price
//                     Text(
//                       'Rs. ${post.price}',
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: contrastColor,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     // Location and Time
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.location_on,
//                           size: 16,
//                           color: textColor.withOpacity(0.6),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           post.location,
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: textColor.withOpacity(0.6),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Icon(
//                           Icons.access_time,
//                           size: 16,
//                           color: textColor.withOpacity(0.6),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '2 hours ago',
//                           style: GoogleFonts.poppins(
//                             fontSize: 14,
//                             color: textColor.withOpacity(0.6),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               // Action Button
//               IconButton(
//                 icon: const Icon(Icons.more_vert, color: Colors.grey),
//                 onPressed: () {
//                   _showActionSheet(context, post.postId ?? "");
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showActionSheet(BuildContext context, String postId) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) => Wrap(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.remove_red_eye),
//             title: const Text("View Details"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PostDetailsView(postId: postId),
//                 ),
//               );
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.delete, color: Colors.red),
//             title: const Text("Delete Post"),
//             onTap: () {
//               context
//                   .read<PostsBloc>()
//                   .add(DeletePost(postId: postId, context: context));
//               Navigator.pop(context);
//             },
//           ),
//         ],
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
import 'package:koselie/features/posts/presentation/view/update_post_view.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

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
        final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100]!;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final cardColor = isDarkMode ? Colors.grey[900]! : Colors.white;
        final contrastColor = isDarkMode ? Colors.white : Colors.purple;
        final searchFillColor = isDarkMode ? Colors.grey[850]! : Colors.white;

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
              _buildSearchBar(searchFillColor, textColor),
              Expanded(
                child: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    final filteredPosts = state.posts
                        .where((post) => post.caption
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                    if (filteredPosts.isEmpty) {
                      return _buildNoPostsScreen(textColor);
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return PostCard(
                          post: filteredPosts[index],
                          cardColor: cardColor,
                          textColor: textColor,
                          contrastColor: contrastColor,
                        );
                      },
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

  Widget _buildSearchBar(Color searchFillColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        style: GoogleFonts.poppins(color: textColor),
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search for products...',
          hintStyle: GoogleFonts.poppins(color: textColor.withOpacity(0.6)),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: searchFillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

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

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.cardColor,
    required this.textColor,
    required this.contrastColor,
  });

  final PostsEntity post;
  final Color cardColor;
  final Color textColor;
  final Color contrastColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsView(postId: post.postId ?? ""),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "${ApiEndpoints.imageUrl}/${post.image!}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.caption,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Rs. ${post.price}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: contrastColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: textColor.withOpacity(0.6)),
                        const SizedBox(width: 4),
                        Text(post.location,
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor.withOpacity(0.6))),
                        const SizedBox(width: 12),
                        Icon(Icons.access_time,
                            size: 16, color: textColor.withOpacity(0.6)),
                        const SizedBox(width: 4),
                        Text('2 hours ago',
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor.withOpacity(0.6))),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () {
                  _showActionSheet(context, post.postId ?? "", post);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionSheet(BuildContext context, String postId, PostsEntity post) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.remove_red_eye),
            title: const Text("View Details"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsView(postId: postId),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit, color: Colors.blue),
            title: const Text("Edit Post"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostUpdateView(post: post),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Delete Post"),
            onTap: () {
              context
                  .read<PostsBloc>()
                  .add(DeletePost(postId: postId, context: context));
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
