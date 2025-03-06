// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:koselie/features/chat/presentation/view/chat_view.dart';
// import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// class PostDetailsView extends StatefulWidget {
//   final String postId;

//   const PostDetailsView({super.key, required this.postId});

//   @override
//   _PostDetailsViewState createState() => _PostDetailsViewState();
// }

// class _PostDetailsViewState extends State<PostDetailsView> {
//   final TextEditingController _commentController = TextEditingController();
//   bool showAllComments = false;
//   final int initialCommentCount = 3; // Initial number of comments to display
//   bool isExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         context.read<PostsBloc>().add(GetPostById(
//               postId: widget.postId,
//               context: context,
//             ));
//         context.read<PostsBloc>().add(GetComments(
//               postId: widget.postId,
//               context: context,
//             ));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _commentController.dispose();
//     super.dispose();
//   }

//   Widget _buildCommentTile(CommentEntity comment) {
//     final loggedInUser =
//         context.read<LoginBloc>().state.user; // Get logged-in user info

//     // Determine which image to display
//     String authorImage = (comment.authorId == loggedInUser?.userId)
//         ? "${ApiEndpoints.imageUrl}/${loggedInUser!.image}" // Logged-in user's image
//         : "${ApiEndpoints.imageUrl}/${comment.image}"; // Comment author's image

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       elevation: 3,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(authorImage),
//           onBackgroundImageError: (_, __) => const Icon(Icons.person),
//         ),
//         title: Text(
//           comment.authorUsername,
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(comment.text, style: GoogleFonts.poppins(fontSize: 14)),
//       ),
//     );
//   }

//   /// ✅ Display Comments Section
//   Widget _buildCommentsSection() {
//     return BlocBuilder<PostsBloc, PostsState>(
//       builder: (context, state) {
//         final comments = state.postComments[widget.postId] ?? [];
//         final displayedComments = showAllComments
//             ? comments
//             : comments.take(initialCommentCount).toList();

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Comments",
//               style: GoogleFonts.poppins(
//                   fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             if (comments.isEmpty)
//               Center(
//                 child: Text(
//                   "No comments yet.",
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: displayedComments.length,
//                 itemBuilder: (context, index) {
//                   final comment = displayedComments[index];
//                   return _buildCommentTile(comment);
//                 },
//               ),
//             if (comments.length > initialCommentCount)
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     showAllComments = !showAllComments;
//                   });
//                 },
//                 child: Text(
//                   showAllComments ? "See Less" : "See More",
//                   style: GoogleFonts.poppins(
//                       color: Colors.blue, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             const SizedBox(height: 16),
//           ],
//         );
//       },
//     );
//   }

//   /// ✅ Floating Comment Input Bar
//   Widget _buildCommentInput() {
//     return Positioned(
//       bottom: 10,
//       left: 10,
//       right: 10,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)]),
//         child: Row(
//           children: [
//             Expanded(
//                 child: TextField(
//                     controller: _commentController,
//                     decoration: const InputDecoration(
//                         hintText: "Write a comment...",
//                         border: InputBorder.none,
//                         contentPadding: EdgeInsets.all(10)))),
//             IconButton(
//                 icon: const Icon(Icons.send, color: Colors.pink),
//                 onPressed: _addComment),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;

//         final backgroundColor = isDarkMode ? Colors.black : Colors.white;
//         final textColor = isDarkMode ? Colors.white : Colors.black;

//         return Scaffold(
//           backgroundColor: backgroundColor,
//           appBar: AppBar(
//             title: Text(
//               "Product Details",
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//                 color: Colors.white,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.black,
//           ),
//           body: BlocBuilder<PostsBloc, PostsState>(
//             builder: (context, state) {
//               if (state.isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state.error != null) {
//                 return Center(
//                   child: Text(
//                     "Error: ${state.error!}",
//                     style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
//                   ),
//                 );
//               } else if (state.selectedPost == null) {
//                 return Center(
//                   child: Text(
//                     "Post not found",
//                     style: GoogleFonts.poppins(
//                         color: textColor.withOpacity(0.6), fontSize: 16),
//                   ),
//                 );
//               }

//               // final post = state.selectedPost!;
//               // const postAuthor = AuthEntity(
//               //   userId: "67ac643a0cc29040b0e248a6",
//               //   username: 'Rekha',
//               //   email: 'rekha@gmail.com',
//               // );

//               final post = state.selectedPost!;
//               const postAuthor = AuthEntity(
//                 userId: "67ac643a0cc29040b0e248a6",
//                 username: 'Rekha',
//                 email: 'rekha@gmail.com',
//               );

//               return Stack(
//                 children: [
//                   SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // ✅ Post Image
//                         Hero(
//                           tag: 'post-image-${post.postId}',
//                           child: _buildImage(post.image),
//                         ),
//                         const SizedBox(height: 20),

//                         // ✅ Post Caption
//                         Text(
//                           post.caption,
//                           style: GoogleFonts.poppins(
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               color: textColor),
//                         ),
//                         const SizedBox(height: 12),

//                         // ✅ Post Price & Category
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Rs. ${post.price}",
//                               style: GoogleFonts.poppins(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.green),
//                             ),
//                             Chip(
//                               label: Text(
//                                 post.category.name,
//                                 style: GoogleFonts.poppins(
//                                     color: Colors.white, fontSize: 12),
//                               ),
//                               backgroundColor: Colors.black,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         // ✅ Post Description with Expand/Collapse
//                         _buildDescription(post.description, textColor),
//                         const SizedBox(height: 12),
//                         // ✅ Comments Section
//                         _buildCommentsSection(),

//                         const SizedBox(height: 100),
//                       ],
//                     ),
//                   ),

//                   // ✅ Floating Comment Input Bar
//                   _buildCommentInput(),

//                   // ✅ Floating "Message Seller" Button
//                   Positioned(
//                     bottom: 70,
//                     left: 20,
//                     right: 20,
//                     child: _buildActionButton(
//                       "Message Seller",
//                       textColor,
//                       () => _navigateToChatScreen(context, postAuthor),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   /// ✅ Post Description with Expand/Collapse
//   Widget _buildDescription(String description, Color textColor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Description",
//           style: GoogleFonts.poppins(
//               fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
//         ),
//         const SizedBox(height: 8),
//         AnimatedSize(
//           duration: const Duration(milliseconds: 300),
//           child: ConstrainedBox(
//             constraints: isExpanded
//                 ? const BoxConstraints()
//                 : const BoxConstraints(maxHeight: 50),
//             child: Text(
//               description,
//               style: GoogleFonts.poppins(fontSize: 16, color: textColor),
//               softWrap: true,
//               overflow: TextOverflow.fade,
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () => setState(() => isExpanded = !isExpanded),
//           child: Text(
//             isExpanded ? 'Read Less' : 'Read More',
//             style: const TextStyle(color: Colors.pink),
//           ),
//         ),
//       ],
//     );
//   }

//   /// ✅ Navigate to Chat Screen
//   void _navigateToChatScreen(BuildContext context, AuthEntity postAuthor) {
//     final loggedInUser = context.read<LoginBloc>().state.user;

//     if (loggedInUser == null) {
//       showMySnackBar(
//         context: context,
//         message: "Please login  to chat!",
//         color: Colors.green,
//       );
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(
//           senderId: loggedInUser.userId!,
//           receiverId: postAuthor.userId!,
//           receiverUsername: postAuthor.username,
//           receiverImage: postAuthor.image ?? '',
//           key: ValueKey(postAuthor.userId!),
//         ),
//       ),
//     );
//   }

//   /// ✅ Floating "Message Seller" Button
//   Widget _buildActionButton(
//       String text, Color textColor, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   /// ✅ Post Image
//   Widget _buildImage(String? imageUrl) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: imageUrl != null && imageUrl.isNotEmpty
//           ? Image.network(
//               "${ApiEndpoints.imageUrl}/$imageUrl",
//               width: double.infinity,
//               height: 250,
//               fit: BoxFit.cover,
//             )
//           : Container(
//               height: 250,
//               color: Colors.grey[300],
//               child: const Center(
//                   child: Icon(Icons.image_not_supported,
//                       size: 50, color: Colors.grey))),
//     );
//   }

//   void _addComment() {
//     final text = _commentController.text.trim();
//     if (text.isEmpty) return;
//     context.read<PostsBloc>().add(
//         AddComment(postId: widget.postId, commentText: text, context: context));
//     _commentController.clear();
//   }
// }

//  next

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:koselie/features/chat/presentation/view/chat_view.dart';
// import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// class PostDetailsView extends StatefulWidget {
//   final String postId;

//   const PostDetailsView({super.key, required this.postId});

//   @override
//   _PostDetailsViewState createState() => _PostDetailsViewState();
// }

// class _PostDetailsViewState extends State<PostDetailsView>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   final TextEditingController _commentController = TextEditingController();
//   bool showAllComments = false;
//   final int initialCommentCount = 3;
//   bool isExpanded = false;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (mounted) {
//         context.read<PostsBloc>().add(GetPostById(
//               postId: widget.postId,
//               context: context,
//             ));
//         context.read<PostsBloc>().add(GetComments(
//               postId: widget.postId,
//               context: context,
//             ));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _commentController.dispose();
//     super.dispose();
//   }

//   Widget _buildCommentTile(CommentEntity comment) {
//     final loggedInUser =
//         context.read<LoginBloc>().state.user; // Get logged-in user info

//     // Determine which image to display
//     String authorImage = (comment.authorId == loggedInUser?.userId)
//         ? "${ApiEndpoints.imageUrl}/${loggedInUser!.image}" // Logged-in user's image
//         : "${ApiEndpoints.imageUrl}/${comment.image}"; // Comment author's image

//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       elevation: 3,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(authorImage),
//           onBackgroundImageError: (_, __) => const Icon(Icons.person),
//         ),
//         title: Text(
//           comment.authorUsername,
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//         subtitle: Text(comment.text, style: GoogleFonts.poppins(fontSize: 14)),
//       ),
//     );
//   }

//   /// ✅ Display Comments Section
//   Widget _buildCommentsSection() {
//     return BlocBuilder<PostsBloc, PostsState>(
//       builder: (context, state) {
//         final comments = state.postComments[widget.postId] ?? [];
//         final displayedComments = showAllComments
//             ? comments
//             : comments.take(initialCommentCount).toList();

//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Comments",
//               style: GoogleFonts.poppins(
//                   fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             if (comments.isEmpty)
//               Center(
//                 child: Text(
//                   "No comments yet.",
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: displayedComments.length,
//                 itemBuilder: (context, index) {
//                   final comment = displayedComments[index];
//                   return _buildCommentTile(comment);
//                 },
//               ),
//             if (comments.length > initialCommentCount)
//               TextButton(
//                 onPressed: () {
//                   setState(() {
//                     showAllComments = !showAllComments;
//                   });
//                 },
//                 child: Text(
//                   showAllComments ? "See Less" : "See More",
//                   style: GoogleFonts.poppins(
//                       color: Colors.blue, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             const SizedBox(height: 16),

//             // ✅ Floating Comment Input Bar
//             _buildCommentInput(),
//           ],
//         );
//       },
//     );
//   }

//   /// ✅ Floating Comment Input Bar
//   Widget _buildCommentInput() {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)]),
//       child: Row(
//         children: [
//           Expanded(
//               child: TextField(
//                   controller: _commentController,
//                   decoration: const InputDecoration(
//                       hintText: "Write a comment...",
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.all(10)))),
//           IconButton(
//               icon: const Icon(Icons.send, color: Colors.pink),
//               onPressed: _addComment),
//         ],
//       ),
//     );
//   }

//   /// ✅ Post Description with Expand/Collapse
//   Widget _buildDescription(String description, Color textColor) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Description",
//           style: GoogleFonts.poppins(
//               fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
//         ),
//         const SizedBox(height: 8),
//         AnimatedSize(
//           duration: const Duration(milliseconds: 300),
//           child: ConstrainedBox(
//             constraints: isExpanded
//                 ? const BoxConstraints()
//                 : const BoxConstraints(maxHeight: 50),
//             child: Text(
//               description,
//               style: GoogleFonts.poppins(fontSize: 16, color: textColor),
//               softWrap: true,
//               overflow: TextOverflow.fade,
//             ),
//           ),
//         ),
//         InkWell(
//           onTap: () => setState(() => isExpanded = !isExpanded),
//           child: Text(
//             isExpanded ? 'Read Less' : 'Read More',
//             style: const TextStyle(color: Colors.pink),
//           ),
//         ),
//       ],
//     );
//   }

//   /// ✅ Navigate to Chat Screen
//   void _navigateToChatScreen(BuildContext context, AuthEntity postAuthor) {
//     final loggedInUser = context.read<LoginBloc>().state.user;

//     if (loggedInUser == null) {
//       showMySnackBar(
//         context: context,
//         message: "Please login  to chat!",
//         color: Colors.green,
//       );
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(
//           senderId: loggedInUser.userId!,
//           receiverId: postAuthor.userId!,
//           receiverUsername: postAuthor.username,
//           receiverImage: postAuthor.image ?? '',
//           key: ValueKey(postAuthor.userId!),
//         ),
//       ),
//     );
//   }

//   /// ✅ Floating "Message Seller" Button
//   Widget _buildActionButton(
//       String text, Color textColor, VoidCallback onPressed) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.black,
//         foregroundColor: Colors.white,
//         padding: const EdgeInsets.symmetric(vertical: 14),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: Text(
//         text,
//         style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   /// ✅ Post Image
//   Widget _buildImage(String? imageUrl) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(12),
//       child: imageUrl != null && imageUrl.isNotEmpty
//           ? Image.network(
//               "${ApiEndpoints.imageUrl}/$imageUrl",
//               width: double.infinity,
//               height: 250,
//               fit: BoxFit.cover,
//             )
//           : Container(
//               height: 250,
//               color: Colors.grey[300],
//               child: const Center(
//                   child: Icon(Icons.image_not_supported,
//                       size: 50, color: Colors.grey))),
//     );
//   }

//   void _addComment() {
//     final text = _commentController.text.trim();
//     if (text.isEmpty) return;
//     context.read<PostsBloc>().add(
//         AddComment(postId: widget.postId, commentText: text, context: context));
//     _commentController.clear();
//   }

//   Widget _buildDetailsTab(String? imageUrl, String caption, String price,
//       String categoryName, String description, Color textColor) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // ✅ Post Image
//           Hero(
//             tag: 'post-image-${widget.postId}',
//             child: _buildImage(imageUrl),
//           ),
//           const SizedBox(height: 20),

//           // ✅ Post Caption
//           Text(
//             caption,
//             style: GoogleFonts.poppins(
//                 fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
//           ),
//           const SizedBox(height: 12),

//           // ✅ Post Price & Category
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Rs. $price",
//                 style: GoogleFonts.poppins(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green),
//               ),
//               Chip(
//                 label: Text(
//                   categoryName,
//                   style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
//                 ),
//                 backgroundColor: Colors.black,
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           // ✅ Post Description with Expand/Collapse
//           _buildDescription(description, textColor),
//           const SizedBox(height: 12),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;
//         final backgroundColor = isDarkMode ? Colors.black : Colors.white;
//         final textColor = isDarkMode ? Colors.white : Colors.black;

//         return Scaffold(
//           backgroundColor: backgroundColor,
//           appBar: AppBar(
//             title: Text(
//               "Product Details",
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 22,
//                 color: Colors.white,
//               ),
//             ),
//             centerTitle: true,
//             backgroundColor: Colors.blue,
//             bottom: TabBar(
//               controller: _tabController,
//               tabs: const [
//                 Tab(text: "Details"),
//                 Tab(text: "Comments"),
//               ],
//             ),
//           ),
//           body: BlocBuilder<PostsBloc, PostsState>(
//             builder: (context, state) {
//               if (state.isLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state.error != null) {
//                 return Center(
//                   child: Text(
//                     "Error: ${state.error!}",
//                     style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
//                   ),
//                 );
//               } else if (state.selectedPost == null) {
//                 return Center(
//                   child: Text(
//                     "Post not found",
//                     style: GoogleFonts.poppins(
//                         color: textColor.withOpacity(0.6), fontSize: 16),
//                   ),
//                 );
//               }

//               final post = state.selectedPost!;
//               const postAuthor = AuthEntity(
//                 userId: "67ac643a0cc29040b0e248a6",
//                 username: 'Rekha',
//                 email: 'rekha@gmail.com',
//               );

//               return Stack(
//                 children: [
//                   TabBarView(
//                     controller: _tabController,
//                     children: [
//                       _buildDetailsTab(
//                         post.image,
//                         post.caption,
//                         post.price,
//                         post.category.name,
//                         post.description,
//                         textColor,
//                       ),
//                       _buildCommentsSection(),
//                     ],
//                   ),
//                   Positioned(
//                     bottom: 10,
//                     left: 0,
//                     right: 0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: _buildActionButton(
//                         "Message Seller",
//                         textColor,
//                         () => _navigateToChatScreen(context, postAuthor),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/chat/presentation/view/chat_view.dart';
import 'package:koselie/features/comment/presentation/entity/comment_entity.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class PostDetailsView extends StatefulWidget {
  final String postId;

  const PostDetailsView({super.key, required this.postId});

  @override
  _PostDetailsViewState createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _commentController = TextEditingController();
  bool showAllComments = false;
  final int initialCommentCount = 3;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PostsBloc>().add(GetPostById(
              postId: widget.postId,
              context: context,
            ));
        context.read<PostsBloc>().add(GetComments(
              postId: widget.postId,
              context: context,
            ));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Widget _buildCommentTile(CommentEntity comment) {
    final loggedInUser =
        context.read<LoginBloc>().state.user; // Get logged-in user info

    // Determine which image to display
    String authorImage = (comment.authorId == loggedInUser?.userId)
        ? "${ApiEndpoints.imageUrl}/${loggedInUser!.image}" // Logged-in user's image
        : "${ApiEndpoints.imageUrl}/${comment.image}"; // Comment author's image

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(authorImage),
          onBackgroundImageError: (_, __) => const Icon(Icons.person),
        ),
        title: Text(
          comment.authorUsername,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(comment.text, style: GoogleFonts.poppins(fontSize: 14)),
      ),
    );
  }

  /// ✅ Display Comments Section
  Widget _buildCommentsSection() {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        final comments = state.postComments[widget.postId] ?? [];
        final displayedComments = showAllComments
            ? comments
            : comments.take(initialCommentCount).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Comments",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (comments.isEmpty)
              Center(
                child: Text(
                  "No comments yet.",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedComments.length,
                itemBuilder: (context, index) {
                  final comment = displayedComments[index];
                  return _buildCommentTile(comment);
                },
              ),
            if (comments.length > initialCommentCount)
              TextButton(
                onPressed: () {
                  setState(() {
                    showAllComments = !showAllComments;
                  });
                },
                child: Text(
                  showAllComments ? "See Less" : "See More",
                  style: GoogleFonts.poppins(
                      color: Colors.blue, fontWeight: FontWeight.w500),
                ),
              ),
            const SizedBox(height: 16),

            // ✅ Floating Comment Input Bar
            _buildCommentInput(),
          ],
        );
      },
    );
  }

  /// ✅ Floating Comment Input Bar
  Widget _buildCommentInput() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)]),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                      hintText: "Write a comment...",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)))),
          IconButton(
              icon: const Icon(Icons.send, color: Colors.pink),
              onPressed: _addComment),
        ],
      ),
    );
  }

  /// ✅ Post Description with Expand/Collapse
  Widget _buildDescription(String description, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        ),
        const SizedBox(height: 8),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: isExpanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 50),
            child: Text(
              description,
              style: GoogleFonts.poppins(fontSize: 16, color: textColor),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        InkWell(
          onTap: () => setState(() => isExpanded = !isExpanded),
          child: Text(
            isExpanded ? 'Read Less' : 'Read More',
            style: const TextStyle(color: Colors.pink),
          ),
        ),
      ],
    );
  }

  /// ✅ Navigate to Chat Screen
  void _navigateToChatScreen(BuildContext context, AuthEntity postAuthor) {
    final loggedInUser = context.read<LoginBloc>().state.user;

    if (loggedInUser == null) {
      showMySnackBar(
        context: context,
        message: "Please login  to chat!",
        color: Colors.green,
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          senderId: loggedInUser.userId!,
          receiverId: postAuthor.userId!,
          receiverUsername: postAuthor.username,
          receiverImage: postAuthor.image ?? '',
          key: ValueKey(postAuthor.userId!),
        ),
      ),
    );
  }

  /// ✅ Floating "Message Seller" Button
  Widget _buildActionButton(
      String text, Color textColor, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// ✅ Post Image
  Widget _buildImage(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? Image.network(
              "${ApiEndpoints.imageUrl}/$imageUrl",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            )
          : Container(
              height: 250,
              color: Colors.grey[300],
              child: const Center(
                  child: Icon(Icons.image_not_supported,
                      size: 50, color: Colors.grey))),
    );
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;
    context.read<PostsBloc>().add(
        AddComment(postId: widget.postId, commentText: text, context: context));
    _commentController.clear();
  }

  Widget _buildDetailsTab(String? imageUrl, String caption, String price,
      String categoryName, String description, Color textColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Post Image
          Hero(
            tag: 'post-image-${widget.postId}',
            child: _buildImage(imageUrl),
          ),
          const SizedBox(height: 20),

          // ✅ Post Caption
          Text(
            caption,
            style: GoogleFonts.poppins(
                fontSize: 26, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 12),

          // ✅ Post Price & Category
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rs. $price",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Chip(
                label: Text(
                  categoryName,
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
                ),
                backgroundColor: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 12),
          // ✅ Post Description with Expand/Collapse
          _buildDescription(description, textColor),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        final backgroundColor = isDarkMode ? Colors.black : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black87;
        //final cardColor = isDarkMode ? Colors.grey[900]! : Colors.white;
        //final contrastColor =
        //    isDarkMode ? Colors.amberAccent : Colors.deepPurple;
        //final searchFillColor =
        //    isDarkMode ? Colors.grey[850]! : Colors.grey[200]!;
        //final chipBackgroundColor =
        //    isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
        //final iconColor = isDarkMode ? Colors.grey[400]! : Colors.grey[600]!;
        //final dividerColor = isDarkMode ? Colors.grey[700]! : Colors.grey[200]!;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              "Product Details",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
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
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "Details"),
                Tab(text: "Comments"),
              ],
            ),
          ),
          body: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.error != null) {
                return Center(
                  child: Text(
                    "Error: ${state.error!}",
                    style: GoogleFonts.poppins(color: Colors.red, fontSize: 16),
                  ),
                );
              } else if (state.selectedPost == null) {
                return Center(
                  child: Text(
                    "Post not found",
                    style: GoogleFonts.poppins(
                        color: textColor.withOpacity(0.6), fontSize: 16),
                  ),
                );
              }

              final post = state.selectedPost!;
              const postAuthor = AuthEntity(
                userId: "67ac643a0cc29040b0e248a6",
                username: 'Rekha',
                email: 'rekha@gmail.com',
              );

              return Stack(
                children: [
                  TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDetailsTab(
                        post.image,
                        post.caption,
                        post.price,
                        post.category.name,
                        post.description,
                        textColor,
                      ),
                      _buildCommentsSection(),
                    ],
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildActionButton(
                        "Message Seller",
                        textColor,
                        () => _navigateToChatScreen(context, postAuthor),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
