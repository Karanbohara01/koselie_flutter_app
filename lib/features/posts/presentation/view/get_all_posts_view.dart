// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:koselie/app/constants/api_endpoints.dart';
// // import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// // import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
// // import 'package:koselie/features/posts/presentation/view/update_post_view.dart';
// // import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// // import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// // import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// // class PostView extends StatefulWidget {
// //   const PostView({super.key});

// //   @override
// //   State<PostView> createState() => _PostViewState();
// // }

// // class _PostViewState extends State<PostView> {
// //   String _searchQuery = "";

// //   @override
// //   void initState() {
// //     super.initState();
// //     context.read<PostsBloc>().add(LoadPosts(context: context));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ThemeBloc, ThemeState>(
// //       builder: (context, themeState) {
// //         final isDarkMode = themeState is DarkThemeState;
// //         final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100]!;
// //         final textColor = isDarkMode ? Colors.white : Colors.black;
// //         final cardColor = isDarkMode ? Colors.grey[900]! : Colors.white;
// //         final contrastColor = isDarkMode ? Colors.white : Colors.purple;
// //         final searchFillColor = isDarkMode ? Colors.grey[850]! : Colors.white;

// //         return Scaffold(
// //           backgroundColor: backgroundColor,
// //           appBar: AppBar(
// //             title: Text(
// //               'Marketplace',
// //               style: GoogleFonts.poppins(
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 24,
// //                 color: Colors.white,
// //               ),
// //             ),
// //             centerTitle: true,
// //             elevation: 5,
// //             flexibleSpace: Container(
// //               decoration: const BoxDecoration(
// //                 gradient: LinearGradient(
// //                   colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                 ),
// //               ),
// //             ),
// //           ),
// //           body: Column(
// //             children: [
// //               _buildSearchBar(searchFillColor, textColor),
// //               Expanded(
// //                 child: BlocBuilder<PostsBloc, PostsState>(
// //                   builder: (context, state) {
// //                     final filteredPosts = state.posts
// //                         .where((post) => post.caption
// //                             .toLowerCase()
// //                             .contains(_searchQuery.toLowerCase()))
// //                         .toList();

// //                     if (filteredPosts.isEmpty) {
// //                       return _buildNoPostsScreen(textColor);
// //                     }

// //                     return ListView.builder(
// //                       padding: const EdgeInsets.all(8),
// //                       itemCount: filteredPosts.length,
// //                       itemBuilder: (context, index) {
// //                         return PostCard(
// //                           post: filteredPosts[index],
// //                           cardColor: cardColor,
// //                           textColor: textColor,
// //                           contrastColor: contrastColor,
// //                         );
// //                       },
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildSearchBar(Color searchFillColor, Color textColor) {
// //     return Padding(
// //       padding: const EdgeInsets.all(16.0),
// //       child: TextField(
// //         style: GoogleFonts.poppins(color: textColor),
// //         onChanged: (query) {
// //           setState(() {
// //             _searchQuery = query;
// //           });
// //         },
// //         decoration: InputDecoration(
// //           hintText: 'Search for products...',
// //           hintStyle: GoogleFonts.poppins(color: textColor.withOpacity(0.6)),
// //           prefixIcon: const Icon(Icons.search, color: Colors.grey),
// //           filled: true,
// //           fillColor: searchFillColor,
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(15),
// //             borderSide: BorderSide.none,
// //           ),
// //           contentPadding: const EdgeInsets.symmetric(vertical: 12),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildNoPostsScreen(Color textColor) {
// //     return Center(
// //       child: Text(
// //         'No posts found.',
// //         style: GoogleFonts.poppins(
// //           color: textColor.withOpacity(0.6),
// //           fontSize: 16,
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class PostCard extends StatelessWidget {
// //   const PostCard({
// //     super.key,
// //     required this.post,
// //     required this.cardColor,
// //     required this.textColor,
// //     required this.contrastColor,
// //   });

// //   final PostsEntity post;
// //   final Color cardColor;
// //   final Color textColor;
// //   final Color contrastColor;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       elevation: 4,
// //       margin: const EdgeInsets.symmetric(vertical: 8),
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(16),
// //       ),
// //       color: cardColor,
// //       child: InkWell(
// //         borderRadius: BorderRadius.circular(16),
// //         onTap: () {
// //           Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => PostDetailsView(postId: post.postId ?? ""),
// //             ),
// //           );
// //         },
// //         child: Padding(
// //           padding: const EdgeInsets.all(12),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Image.network(
// //                   "${ApiEndpoints.imageUrl}/${post.image!}",
// //                   width: 100,
// //                   height: 100,
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Text(
// //                       post.caption,
// //                       style: GoogleFonts.poppins(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 16,
// //                         color: textColor,
// //                       ),
// //                       maxLines: 2,
// //                       overflow: TextOverflow.ellipsis,
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Text(
// //                       'Rs. ${post.price}',
// //                       style: GoogleFonts.poppins(
// //                         fontWeight: FontWeight.bold,
// //                         fontSize: 18,
// //                         color: contrastColor,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Row(
// //                       children: [
// //                         Icon(Icons.location_on,
// //                             size: 16, color: textColor.withOpacity(0.6)),
// //                         const SizedBox(width: 4),
// //                         Text(post.location,
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 14,
// //                                 color: textColor.withOpacity(0.6))),
// //                         const SizedBox(width: 12),
// //                         Icon(Icons.access_time,
// //                             size: 16, color: textColor.withOpacity(0.6)),
// //                         const SizedBox(width: 4),
// //                         Text('2 hours ago',
// //                             style: GoogleFonts.poppins(
// //                                 fontSize: 14,
// //                                 color: textColor.withOpacity(0.6))),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               IconButton(
// //                 icon: const Icon(Icons.more_vert, color: Colors.grey),
// //                 onPressed: () {
// //                   _showActionSheet(context, post.postId ?? "", post);
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   void _showActionSheet(BuildContext context, String postId, PostsEntity post) {
// //     showModalBottomSheet(
// //       context: context,
// //       builder: (context) => Wrap(
// //         children: [
// //           ListTile(
// //             leading: const Icon(Icons.remove_red_eye),
// //             title: const Text("View Details"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => PostDetailsView(postId: postId),
// //                 ),
// //               );
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.edit, color: Colors.blue),
// //             title: const Text("Edit Post"),
// //             onTap: () {
// //               Navigator.pop(context);
// //               Navigator.push(
// //                 context,
// //                 MaterialPageRoute(
// //                   builder: (context) => PostUpdateView(post: post),
// //                 ),
// //               );
// //             },
// //           ),
// //           ListTile(
// //             leading: const Icon(Icons.delete, color: Colors.red),
// //             title: const Text("Delete Post"),
// //             onTap: () {
// //               context
// //                   .read<PostsBloc>()
// //                   .add(DeletePost(postId: postId, context: context));
// //               Navigator.pop(context);
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
// import 'package:koselie/features/posts/presentation/view/update_post_view.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';
// import 'package:intl/intl.dart';

// class PostView extends StatefulWidget {
//   const PostView({super.key});

//   @override
//   State<PostView> createState() => _PostViewState();
// }

// class _PostViewState extends State<PostView> {
//   String _searchQuery = "";
//   List<String> _categories = ["All", "Electronics", "Furniture", "Clothing", "Books", "Vehicles"];
//   String _selectedCategory = "All";

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
//         final backgroundColor = isDarkMode ? const Color(0xFF18191A) : const Color(0xFFF0F2F5);
//         final textColor = isDarkMode ? Colors.white : Colors.black;
//         final cardColor = isDarkMode ? const Color(0xFF242526) : Colors.white;
//         final primaryColor = const Color(0xFF1877F2); // Facebook blue
//         final searchFillColor = isDarkMode ? const Color(0xFF3A3B3C) : Colors.white;

//         return Scaffold(
//           backgroundColor: backgroundColor,
//           appBar: AppBar(
//             backgroundColor: isDarkMode ? const Color(0xFF242526) : Colors.white,
//             elevation: 0,
//             title: Text(
//               'Marketplace',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//                 color: primaryColor,
//               ),
//             ),
//             actions: [
//               CircleAvatar(
//                 backgroundColor: searchFillColor,
//                 radius: 18,
//                 child: IconButton(
//                   icon: Icon(Icons.notifications_none, size: 20, color: textColor),
//                   onPressed: () {},
//                 ),
//               ),
//               const SizedBox(width: 8),
//               CircleAvatar(
//                 backgroundColor: searchFillColor,
//                 radius: 18,
//                 child: IconButton(
//                   icon: Icon(Icons.message_outlined, size: 20, color: textColor),
//                   onPressed: () {},
//                 ),
//               ),
//               const SizedBox(width: 12),
//             ],
//           ),
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: primaryColor,
//             child: const Icon(Icons.add, color: Colors.white),
//             onPressed: () {
//               // Add new listing functionality
//             },
//           ),
//           body: Column(
//             children: [
//               _buildSearchBar(searchFillColor, textColor, primaryColor),
//               _buildCategoryFilter(textColor, primaryColor),
//               Expanded(
//                 child: BlocBuilder<PostsBloc, PostsState>(
//                   builder: (context, state) {
//                     var filteredPosts = state.posts
//                         .where((post) => post.caption
//                             .toLowerCase()
//                             .contains(_searchQuery.toLowerCase()))
//                         .toList();

//                     // Apply category filter if not "All"
//                     if (_selectedCategory != "All") {
//                       // This is a mock implementation - you would need to add category to your post model
//                       // filteredPosts = filteredPosts.where((post) => post.category == _selectedCategory).toList();
//                     }

//                     if (state.isLoading) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }

//                     if (filteredPosts.isEmpty) {
//                       return _buildNoPostsScreen(textColor);
//                     }

//                     return RefreshIndicator(
//                       onRefresh: () async {
//                         context.read<PostsBloc>().add(LoadPosts(context: context));
//                       },
//                       child: GridView.builder(
//                         padding: const EdgeInsets.all(8),
//                         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio: 0.75,
//                           crossAxisSpacing: 8,
//                           mainAxisSpacing: 8,
//                         ),
//                         itemCount: filteredPosts.length,
//                         itemBuilder: (context, index) {
//                           return PostCard(
//                             post: filteredPosts[index],
//                             cardColor: cardColor,
//                             textColor: textColor,
//                             primaryColor: primaryColor,
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             backgroundColor: isDarkMode ? const Color(0xFF242526) : Colors.white,
//             selectedItemColor: primaryColor,
//             unselectedItemColor: textColor.withOpacity(0.6),
//             type: BottomNavigationBarType.fixed,
//             currentIndex: 2, // Marketplace selected
//             items: const [
//               BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//               BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Groups'),
//               BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Marketplace'),
//               BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//               BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSearchBar(Color searchFillColor, Color textColor, Color primaryColor) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//       child: TextField(
//         style: GoogleFonts.poppins(color: textColor),
//         onChanged: (query) {
//           setState(() {
//             _searchQuery = query;
//           });
//         },
//         decoration: InputDecoration(
//           hintText: 'Search Marketplace',
//           hintStyle: GoogleFonts.poppins(
//             color: textColor.withOpacity(0.6),
//             fontSize: 14,
//           ),
//           prefixIcon: Icon(Icons.search, color: textColor.withOpacity(0.6), size: 20),
//           filled: true,
//           fillColor: searchFillColor,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(vertical: 0),
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryFilter(Color textColor, Color primaryColor) {
//     return Container(
//       height: 50,
//       padding: const EdgeInsets.only(left: 8),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _categories.length,
//         itemBuilder: (context, index) {
//           final category = _categories[index];
//           final isSelected = category == _selectedCategory;

//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             child: FilterChip(
//               label: Text(
//                 category,
//                 style: GoogleFonts.poppins(
//                   fontSize: 13,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   color: isSelected ? Colors.white : textColor,
//                 ),
//               ),
//               selected: isSelected,
//               selectedColor: primaryColor,
//               backgroundColor: textColor.withOpacity(0.1),
//               onSelected: (selected) {
//                 setState(() {
//                   _selectedCategory = category;
//                 });
//               },
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildNoPostsScreen(Color textColor) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.storefront,
//             size: 80,
//             color: textColor.withOpacity(0.3),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'No listings found',
//             style: GoogleFonts.poppins(
//               color: textColor.withOpacity(0.6),
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Try adjusting your search or filters',
//             style: GoogleFonts.poppins(
//               color: textColor.withOpacity(0.6),
//               fontSize: 14,
//             ),
//           ),
//         ],
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
//     required this.primaryColor,
//   });

//   final PostsEntity post;
//   final Color cardColor;
//   final Color textColor;
//   final Color primaryColor;

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 0,
//       margin: EdgeInsets.zero,
//       clipBehavior: Clip.antiAlias,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       color: cardColor,
//       child: InkWell(
//         onTap: () {
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
//             // Image takes up most of the space
//             Stack(
//               children: [
//                 AspectRatio(
//                   aspectRatio: 1.0,
//                   child: Image.network(
//                     "${ApiEndpoints.imageUrl}/${post.image!}",
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) => Container(
//                       color: Colors.grey.shade300,
//                       child: const Center(child: Icon(Icons.image_not_supported, size: 40)),
//                     ),
//                     loadingBuilder: (context, child, loadingProgress) {
//                       if (loadingProgress == null) return child;
//                       return Center(
//                         child: CircularProgressIndicator(
//                           value: loadingProgress.expectedTotalBytes != null
//                               ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
//                               : null,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Positioned(
//                   top: 8,
//                   right: 8,
//                   child: GestureDetector(
//                     onTap: () => _showActionSheet(context, post.postId ?? "", post),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.5),
//                         shape: BoxShape.circle,
//                       ),
//                       padding: const EdgeInsets.all(4),
//                       child: const Icon(
//                         Icons.more_horiz,
//                         color: Colors.white,
//                         size: 18,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Product info
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Rs. ${NumberFormat('#,###').format(post.price)}',
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: textColor,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     post.caption,
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: textColor.withOpacity(0.8),
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 2),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.location_on,
//                         size: 12,
//                         color: textColor.withOpacity(0.6),
//                       ),
//                       const SizedBox(width: 2),
//                       Expanded(
//                         child: Text(
//                           post.location,
//                           style: GoogleFonts.poppins(
//                             fontSize: 11,
//                             color: textColor.withOpacity(0.6),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
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

//   void _showActionSheet(BuildContext context, String postId, PostsEntity post) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final sheetColor = isDarkMode ? const Color(0xFF242526) : Colors.white;
//     final textColor = isDarkMode ? Colors.white : Colors.black;

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: sheetColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (context) => SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 margin: const EdgeInsets.only(bottom: 16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.3),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               _buildActionTile(
//                 context,
//                 Icons.remove_red_eye_outlined,
//                 "View Details",
//                 textColor,
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PostDetailsView(postId: postId),
//                     ),
//                   );
//                 },
//               ),
//               _buildActionTile(
//                 context,
//                 Icons.edit_outlined,
//                 "Edit Post",
//                 textColor,
//                 iconColor: Colors.blue,
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PostUpdateView(post: post),
//                     ),
//                   );
//                 },
//               ),
//               _buildActionTile(
//                 context,
//                 Icons.delete_outline,
//                 "Delete Post",
//                 textColor,
//                 iconColor: Colors.red,
//                 onTap: () {
//                   _showDeleteConfirmation(context, postId);
//                 },
//               ),
//               _buildActionTile(
//                 context,
//                 Icons.share_outlined,
//                 "Share",
//                 textColor,
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Implement share functionality
//                 },
//               ),
//               _buildActionTile(
//                 context,
//                 Icons.save_outlined,
//                 "Save",
//                 textColor,
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Implement save functionality
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActionTile(
//     BuildContext context,
//     IconData icon,
//     String title,
//     Color textColor, {
//     Color? iconColor,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(
//         icon,
//         color: iconColor ?? textColor.withOpacity(0.8),
//       ),
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//           fontSize: 15,
//           color: textColor,
//         ),
//       ),
//       onTap: onTap,
//       dense: true,
//       minLeadingWidth: 20,
//     );
//   }

//   void _showDeleteConfirmation(BuildContext context, String postId) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: isDarkMode ? const Color(0xFF242526) : Colors.white,
//         title: Text(
//           'Delete Post',
//           style: GoogleFonts.poppins(
//             color: isDarkMode ? Colors.white : Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         content: Text(
//           'Are you sure you want to delete this post? This action cannot be undone.',
//           style: GoogleFonts.poppins(
//             color: isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.poppins(
//                 color: isDarkMode ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8),
//               ),
//             ),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close dialog
//               Navigator.pop(context); // Close bottom sheet
//               context.read<PostsBloc>().add(DeletePost(postId: postId, context: context));
//             },
//             child: Text(
//               'Delete',
//               style: GoogleFonts.poppins(
//                 color: Colors.red,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//  ******************************************************************************///

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
// import 'package:koselie/features/posts/presentation/view/post_detail_view.dart';
// import 'package:koselie/features/posts/presentation/view/update_post_view.dart';
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
//   String _selectedCategory = "All"; // Default category
//   List<String> _availableCategories = ["All"]; // Initialize with "All"

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
//         final chipBackgroundColor =
//             isDarkMode ? Colors.grey[900]! : Colors.black;

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
//               _buildCategoryFilter(
//                   chipBackgroundColor, textColor), // Category filter
//               Expanded(
//                 child: BlocBuilder<PostsBloc, PostsState>(
//                   builder: (context, state) {
//                     // Build available categories from posts
//                     if (state.posts.isNotEmpty &&
//                         _availableCategories.length == 1) {
//                       _availableCategories = [
//                         "All",
//                         ...state.posts.map((post) => post.category.name).toSet()
//                       ];
//                     }

//                     List<PostsEntity> filteredPosts = state.posts;

//                     // Category Filtering
//                     if (_selectedCategory != "All") {
//                       filteredPosts = filteredPosts
//                           .where(
//                               (post) => post.category.name == _selectedCategory)
//                           .toList();
//                     }

//                     // Search Query Filtering
//                     filteredPosts = filteredPosts
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
//           prefixIcon: const Icon(Icons.search, color: Colors.white),
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

//   Widget _buildCategoryFilter(Color chipBackgroundColor, Color textColor) {
//     return SizedBox(
//       height: 60, // Adjust the height as needed
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         scrollDirection: Axis.horizontal,
//         itemCount: _availableCategories.length,
//         separatorBuilder: (context, index) => const SizedBox(width: 8),
//         itemBuilder: (context, index) {
//           final category = _availableCategories[index];
//           return ChoiceChip(
//             label: Text(
//               category,
//               style: GoogleFonts.poppins(
//                 color: Colors.white,
//                 fontSize: 14,
//               ),
//             ),
//             selected: _selectedCategory == category,
//             selectedColor: Theme.of(context).primaryColor, // Highlight selected
//             backgroundColor: chipBackgroundColor,
//             onSelected: (selected) {
//               setState(() {
//                 _selectedCategory = selected ? category : "All";
//               });
//             },
//           );
//         },
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
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
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
//                     Text(
//                       'Rs. ${post.price}',
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 18,
//                         color: contrastColor,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on,
//                             size: 16, color: textColor.withOpacity(0.6)),
//                         const SizedBox(width: 4),
//                         Text(post.location,
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 color: textColor.withOpacity(0.6))),
//                         const SizedBox(width: 12),
//                         Icon(Icons.access_time,
//                             size: 16, color: textColor.withOpacity(0.6)),
//                         const SizedBox(width: 4),
//                         Text('2 hours ago',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14,
//                                 color: textColor.withOpacity(0.6))),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.more_vert, color: Colors.grey),
//                 onPressed: () {
//                   _showActionSheet(context, post.postId ?? "", post);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showActionSheet(BuildContext context, String postId, PostsEntity post) {
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
//             leading: const Icon(Icons.edit, color: Colors.blue),
//             title: const Text("Edit Post"),
//             onTap: () {
//               Navigator.pop(context);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => PostUpdateView(post: post),
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
// import 'package:timeago/timeago.dart' as timeago; // Import timeago

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  String _searchQuery = "";
  String _selectedCategory = "All"; // Default category
  List<String> _availableCategories = ["All"]; // Initialize with "All"

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
        final backgroundColor = isDarkMode
            ? Colors.grey[900]!
            : Colors.grey[100]!; // Slightly darker dark mode
        final textColor =
            isDarkMode ? Colors.white : Colors.black87; //More subtle text color
        final cardColor = isDarkMode
            ? Colors.grey[800]!
            : Colors.white; // Darker cards in dark mode
        final contrastColor = isDarkMode
            ? Colors.amberAccent
            : Colors.purple; // More appealing contrast color
        final searchFillColor = isDarkMode
            ? Colors.grey[850]!
            : Colors.grey[200]!; //Subtle Search bar color
        final chipBackgroundColor = isDarkMode
            ? Colors.grey[700]!
            : Colors.grey[300]!; // Muted chip background color
        final iconColor =
            isDarkMode ? Colors.grey[400]! : Colors.grey[600]!; // Icon color
        final dividerColor = isDarkMode ? Colors.grey[700]! : Colors.grey[200]!;
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              'Marketplace',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            elevation: 0, // Removed elevation for a flatter look
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
              _buildCategoryFilter(chipBackgroundColor, textColor,
                  dividerColor), // Category filter
              Expanded(
                child: BlocBuilder<PostsBloc, PostsState>(
                  builder: (context, state) {
                    // Build available categories from posts
                    if (state.posts.isNotEmpty &&
                        _availableCategories.length == 1) {
                      _availableCategories = [
                        "All",
                        ...state.posts.map((post) => post.category.name).toSet()
                      ];
                    }

                    List<PostsEntity> filteredPosts = state.posts;

                    // Category Filtering
                    if (_selectedCategory != "All") {
                      filteredPosts = filteredPosts
                          .where(
                              (post) => post.category.name == _selectedCategory)
                          .toList();
                    }

                    // Search Query Filtering
                    filteredPosts = filteredPosts
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
                          iconColor: iconColor,
                          dividerColor: dividerColor,
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
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 4.0),
          child: Text(
            "Categories",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
        SizedBox(
          height: 50, // Adjusted height
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _availableCategories.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = _availableCategories[index];
              return ChoiceChip(
                label: Text(
                  category,
                  style: GoogleFonts.poppins(
                    color: _selectedCategory == category
                        ? Colors.white
                        : textColor,
                    fontSize: 14,
                  ),
                ),
                selected: _selectedCategory == category,
                selectedColor:
                    Theme.of(context).primaryColor, // Highlight selected
                backgroundColor: chipBackgroundColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)), // Rounded chips
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = selected ? category : "All";
                  });
                },
              );
            },
          ),
        ),
        Divider(
          color: dividerColor,
          height: 1,
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
          padding: const EdgeInsets.all(16), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(12), // More rounded image
                    child: Image.network(
                      "${ApiEndpoints.imageUrl}/${post.image!}",
                      width: 100, // Increased image size
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Container(
                          // Placeholder for broken images
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image_not_supported,
                              color: Colors.grey),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16), // Increased spacing
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.caption,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600, // Bolder caption
                            fontSize: 17, // Increased font size
                            color: textColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6), // Increased spacing
                        Text(
                          'Rs. ${post.price}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, // Even bolder price
                            fontSize: 19, // Further increased size
                            color: contrastColor,
                          ),
                        ),
                        const SizedBox(height: 6), // Increased spacing
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: iconColor),
                            const SizedBox(width: 6),
                            Text(
                              post.location,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color:
                                    textColor.withOpacity(0.8), // Less opaque
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
              const SizedBox(height: 12), // Increased spacing
              Divider(color: dividerColor, height: 1),
              const SizedBox(height: 8), // Increased spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite_border,
                          size: 18, color: iconColor), // Slightly larger icons
                      const SizedBox(width: 4),
                      Text(
                        "6",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: textColor.withOpacity(0.8)),
                      ),
                      const SizedBox(width: 12),
                      Icon(Icons.mode_comment_outlined,
                          size: 18, color: iconColor), // Slightly larger icons
                      const SizedBox(width: 4),
                      Text(
                        "8",
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
