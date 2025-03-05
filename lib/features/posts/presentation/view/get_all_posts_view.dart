import 'dart:async';

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
// import 'package:timeago/timeago.dart' as timeago; // Import timeago
import 'package:sensors_plus/sensors_plus.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  String _searchQuery = "";
  String _selectedCategory = "All"; // Default category
  List<String> _availableCategories = ["All"]; // Initialize with "All"
  StreamSubscription? _gyroscopeSubscription;
  DateTime lastRefreshTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadPosts(context: context));
    _startGyroscopeDetection();
  }

  void _startGyroscopeDetection() {
    _gyroscopeSubscription = gyroscopeEvents.listen((event) {
      double tiltThreshold = 0.1;
      DateTime now = DateTime.now();

      // Prevent multiple refreshes within 3 seconds
      if (event.y.abs() > tiltThreshold &&
          now.difference(lastRefreshTime) > const Duration(seconds: 3)) {
        lastRefreshTime = now;

        // Show loading indicator while fetching new posts
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(width: 16),
                Text("Refreshing Marketplace...",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          ),
        );

        // Dispatch event to reload posts from backend
        context.read<PostsBloc>().add(LoadPosts(context: context));
      }
    });
  }

  @override
  void dispose() {
    _gyroscopeSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        final backgroundColor = isDarkMode ? Colors.black : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black87;
        final cardColor = isDarkMode ? Colors.grey[900]! : Colors.white;
        final contrastColor =
            isDarkMode ? Colors.amberAccent : Colors.deepPurple;
        final searchFillColor =
            isDarkMode ? Colors.grey[850]! : Colors.grey[200]!;
        final chipBackgroundColor =
            isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
        final iconColor = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
        final dividerColor = isDarkMode ? Colors.grey[700]! : Colors.grey[200]!;

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
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDarkMode
                      ? [const Color(0xFF1F1C2C), const Color(0xFF928DAB)]
                      : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () {
                  // Add filter functionality
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildSearchBar(searchFillColor, textColor),
              ),

              // Category Filter Chips
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildCategoryFilter(
                    chipBackgroundColor, textColor, dividerColor),
              ),

              // Posts List
              Expanded(
                child: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    if (state.posts.isNotEmpty &&
                        _availableCategories.length == 1) {
                      _availableCategories = [
                        "All",
                        ...state.posts.map((post) => post.category.name).toSet()
                      ];
                    }

                    List<PostsEntity> filteredPosts = state.posts;

                    if (_selectedCategory != "All") {
                      filteredPosts = filteredPosts
                          .where(
                              (post) => post.category.name == _selectedCategory)
                          .toList();
                    }

                    filteredPosts = filteredPosts
                        .where((post) => post.caption
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase()))
                        .toList();

                    if (filteredPosts.isEmpty) {
                      return _buildNoPostsScreen(textColor);
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              // Add navigation to post details
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                color: cardColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: PostCard(
                                post: filteredPosts[index],
                                cardColor: cardColor,
                                textColor: textColor,
                                contrastColor: contrastColor,
                                iconColor: iconColor,
                                dividerColor: dividerColor,
                              ),
                            ),
                          ),
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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8), // Adjusted padding
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
          prefixIcon: Icon(Icons.search,
              color: textColor.withOpacity(0.6)), // Themed search icon
          filled: true,
          fillColor: searchFillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25), // More rounded search bar
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 20), // Adjusted padding
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(
      Color chipBackgroundColor, Color textColor, Color dividerColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Title
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 4.0),
          child: Text(
            "Categories",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600, // Slightly bolder
              color: textColor.withOpacity(0.8), // Subtle text color
            ),
          ),
        ),

        // Category Chips
        SizedBox(
          height: 50,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _availableCategories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = _availableCategories[index];
              final isSelected = _selectedCategory == category;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.3), // Subtle shadow
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: ChoiceChip(
                  label: Text(
                    category,
                    style: GoogleFonts.poppins(
                      color: isSelected ? Colors.white : textColor,
                      fontSize: 14,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor:
                      Theme.of(context).primaryColor, // Highlight selected
                  backgroundColor: chipBackgroundColor,
                  checkmarkColor: Colors.white, // ✅ White checkmark
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategory = selected ? category : "All";
                    });
                  },
                ),
              );
            },
          ),
        ),

        // Divider
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Divider(
            color: dividerColor,
            height: 1,
            thickness: 1,
          ),
        ),
      ],
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

// class PostCard extends StatelessWidget {
//   const PostCard({
//     super.key,
//     required this.post,
//     required this.cardColor,
//     required this.textColor,
//     required this.contrastColor,
//     required this.iconColor,
//     required this.dividerColor,
//   });

//   final PostsEntity post;
//   final Color cardColor;
//   final Color textColor;
//   final Color contrastColor;
//   final Color iconColor;
//   final Color dividerColor;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       color: cardColor,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(15),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => PostDetailsView(postId: post.postId ?? ""),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16), // Increased padding
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         BorderRadius.circular(12), // More rounded image
//                     child: Image.network(
//                       "${ApiEndpoints.imageUrl}/${post.image!}",
//                       width: 100, // Increased image size
//                       height: 100,
//                       fit: BoxFit.cover,
//                       errorBuilder: (BuildContext context, Object exception,
//                           StackTrace? stackTrace) {
//                         return Container(
//                           // Placeholder for broken images
//                           width: 100,
//                           height: 100,
//                           color: Colors.grey.shade300,
//                           child: const Icon(Icons.image_not_supported,
//                               color: Colors.grey),
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 16), // Increased spacing
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           post.caption,
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w600, // Bolder caption
//                             fontSize: 17, // Increased font size
//                             color: textColor,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 6), // Increased spacing
//                         Text(
//                           'Rs. ${post.price}',
//                           style: GoogleFonts.poppins(
//                             fontWeight: FontWeight.w700, // Even bolder price
//                             fontSize: 19, // Further increased size
//                             color: contrastColor,
//                           ),
//                         ),
//                         const SizedBox(height: 6), // Increased spacing
//                         Row(
//                           children: [
//                             Icon(Icons.location_on, size: 16, color: iconColor),
//                             const SizedBox(width: 6),
//                             Text(
//                               post.location,
//                               style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 color:
//                                     textColor.withOpacity(0.8), // Less opaque
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   PopupMenuButton<String>(
//                     icon: Icon(Icons.more_vert, color: iconColor),
//                     itemBuilder: (BuildContext context) {
//                       return [
//                         const PopupMenuItem<String>(
//                           value: "View Details",
//                           child: Text("View Details"),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Edit Post",
//                           child: Text("Edit Post"),
//                         ),
//                         const PopupMenuItem<String>(
//                           value: "Delete Post",
//                           child: Text("Delete Post"),
//                         ),
//                       ];
//                     },
//                     onSelected: (String choice) {
//                       _showActionSheet(
//                           context, post.postId ?? "", post, choice);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12), // Increased spacing
//               Divider(color: dividerColor, height: 1),
//               const SizedBox(height: 8), // Increased spacing
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Icon(Icons.favorite_border,
//                           size: 18, color: iconColor), // Slightly larger icons
//                       const SizedBox(width: 4),
//                       Text(
//                         "6",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, color: textColor.withOpacity(0.8)),
//                       ),
//                       const SizedBox(width: 12),
//                       Icon(Icons.mode_comment_outlined,
//                           size: 18, color: iconColor), // Slightly larger icons
//                       const SizedBox(width: 4),
//                       Text(
//                         "8",
//                         style: GoogleFonts.poppins(
//                             fontSize: 14, color: textColor.withOpacity(0.8)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showActionSheet(
//       BuildContext context, String postId, PostsEntity post, String choice) {
//     switch (choice) {
//       case "View Details":
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PostDetailsView(postId: postId),
//           ),
//         );
//         break;
//       case "Edit Post":
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => PostUpdateView(post: post),
//           ),
//         );
//         break;
//       case "Delete Post":
//         context
//             .read<PostsBloc>()
//             .add(DeletePost(postId: postId, context: context));
//         break;
//     }
//   }
// }

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.cardColor,
    required this.textColor,
    required this.contrastColor,
    required this.iconColor,
    required this.dividerColor,
  });

  final PostsEntity post;
  final Color cardColor;
  final Color textColor;
  final Color contrastColor;
  final Color iconColor;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: cardColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailsView(postId: post.postId ?? ""),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "${ApiEndpoints.imageUrl}/${post.image!}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.caption,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: textColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Rs. ${post.price}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 19,
                            color: contrastColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: iconColor),
                            const SizedBox(width: 6),
                            Text(
                              post.location,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: textColor.withOpacity(0.8),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: iconColor),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: "View Details",
                          child: Text("View Details"),
                        ),
                        const PopupMenuItem<String>(
                          value: "Edit Post",
                          child: Text("Edit Post"),
                        ),
                        const PopupMenuItem<String>(
                          value: "Delete Post",
                          child: Text("Delete Post"),
                        ),
                      ];
                    },
                    onSelected: (String choice) {
                      _showActionSheet(
                          context, post.postId ?? "", post, choice);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Divider(color: dividerColor, height: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border, size: 18, color: iconColor),
                      const SizedBox(width: 4),
                      Text(
                        "${post.likes?.length ?? 2}", // ✅ Display actual likes count
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: textColor.withOpacity(0.8)),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.mode_comment_outlined,
                          size: 18, color: iconColor),
                      const SizedBox(width: 4),
                      Text(
                        "${post.comments?.length ?? 0}", // ✅ Display actual comments count
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: textColor.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showActionSheet(
      BuildContext context, String postId, PostsEntity post, String choice) {
    switch (choice) {
      case "View Details":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostDetailsView(postId: postId),
          ),
        );
        break;
      case "Edit Post":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostUpdateView(post: post),
          ),
        );
        break;
      case "Delete Post":
        context
            .read<PostsBloc>()
            .add(DeletePost(postId: postId, context: context));
        break;
    }
  }
}
