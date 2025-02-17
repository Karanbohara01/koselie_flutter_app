// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
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
//       ),
//       body: BlocBuilder<PostsBloc, PostsState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Error loading posts: ${state.error!}'),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<PostsBloc>()
//                           .add(LoadPosts(context: context));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state.posts.isNotEmpty) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: state.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = state.posts[index];
//                   return PostCard(post: post);
//                 },
//               ),
//             );
//           } else {
//             return const Center(child: Text('No posts available.'));
//           }
//         },
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
//       elevation: 2, // Further reduced for a flatter look
//       borderRadius: BorderRadius.circular(8), // More standard radius
//       child: InkWell(
//         borderRadius: BorderRadius.circular(8),
//         onTap: () {
//           // Navigate to details page
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Section
//             Expanded(
//               child: ClipRRect(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(8)),
//                 child: (post.image != null && post.image!.isNotEmpty)
//                     ? Image.network(
//                         "${ApiEndpoints.imageUrl}/${post.image!}",
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Container(
//                             color: Colors.grey[50], // Subtle background color
//                             child: const Center(
//                               child: Icon(
//                                 Icons
//                                     .image_not_supported_outlined, // More appropriate icon
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           );
//                         },
//                       )
//                     : Container(
//                         color: Colors.grey[50], // Subtle background color
//                         child: const Center(
//                           child: Icon(
//                             Icons.image_outlined, // Outline Icon
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//             // Text Section
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Category Badge
//                   // Check if category is null
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 4.0),
//                     decoration: BoxDecoration(
//                       color: Colors.blue[50], // Facebook like color
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       post.category.name, // Handle null category name
//                       style: const TextStyle(
//                         fontSize: 11, // Smaller for subtle
//                         fontWeight: FontWeight.w500, // Readable font
//                         color: Colors.blue, // Blue color
//                       ),
//                     ),
//                   ), // Hide badge if no category
//                   const SizedBox(height: 4.0),

//                   // Caption
//                   Text(
//                     post.caption, // Use Null check here
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w500, // Less Bold, smaller font
//                       fontSize: 14,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     maxLines: 1,
//                   ),
//                   const SizedBox(height: 4.0),
//                   // Description
//                   Text(
//                     post.description, // Use Null check here
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.grey[700],
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     maxLines: 2,
//                   ),
//                   const SizedBox(height: 4.0), // Reduced
//                   // Price
//                   Text(
//                     'Rs. ${post.price}', // Use Null check here
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600, // Adjusted Font Weight
//                       fontSize: 14, // Adjusted Font Size
//                       color: Colors.green,
//                     ),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
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
//       backgroundColor: Colors.grey[100],
//       appBar: AppBar(
//         title: const Text(
//           'Marketplace',
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         elevation: 0,
//       ),
//       body: BlocBuilder<PostsBloc, PostsState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Error loading posts: ${state.error!}',
//                       style: const TextStyle(color: Colors.red)),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<PostsBloc>()
//                           .add(LoadPosts(context: context));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state.posts.isNotEmpty) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8.0,
//                   mainAxisSpacing: 8.0,
//                   childAspectRatio: 0.8,
//                 ),
//                 itemCount: state.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = state.posts[index];
//                   return PostCard(post: post);
//                 },
//               ),
//             );
//           } else {
//             return const Center(child: Text('No posts available.'));
//           }
//         },
//       ),
//     );
//   }
// }

// class PostCard extends StatefulWidget {
//   const PostCard({super.key, required this.post});

//   final PostsEntity post;

//   @override
//   State<PostCard> createState() => _PostCardState();
// }

// class _PostCardState extends State<PostCard> {
//   bool isLiked = false;
//   int likeCount = 0;

//   void toggleLike() {
//     setState(() {
//       isLiked = !isLiked;
//       likeCount += isLiked ? 1 : -1;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       borderRadius: BorderRadius.circular(12),
//       color: Colors.white,
//       elevation: 3,
//       shadowColor: Colors.black.withOpacity(0.1),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           // Navigate to details page
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image Section
//             Expanded(
//               child: Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(12)),
//                     child: (widget.post.image != null &&
//                             widget.post.image!.isNotEmpty)
//                         ? Image.network(
//                             "${ApiEndpoints.imageUrl}/${widget.post.image!}",
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
//                       child: const Text("For Sale",
//                           style: TextStyle(color: Colors.white, fontSize: 10)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Text Section
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Caption
//                   Text(
//                     widget.post.caption,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14,
//                         overflow: TextOverflow.ellipsis),
//                     maxLines: 1,
//                   ),
//                   const SizedBox(height: 4.0),
//                   // Price
//                   Text(
//                     'Rs. ${widget.post.price}',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.green),
//                   ),
//                   const SizedBox(height: 6.0),
//                   // Like & Comment Buttons
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: Icon(
//                             isLiked ? Icons.favorite : Icons.favorite_border,
//                             color: isLiked ? Colors.red : Colors.grey),
//                         onPressed: toggleLike,
//                       ),
//                       Text('$likeCount likes'),
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

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
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
//       body: BlocBuilder<PostsBloc, PostsState>(
//         builder: (context, state) {
//           if (state.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state.error != null) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Error loading posts: ${state.error!}',
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                   const SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () {
//                       context
//                           .read<PostsBloc>()
//                           .add(LoadPosts(context: context));
//                     },
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             );
//           } else if (state.posts.isNotEmpty) {
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 12.0,
//                   childAspectRatio: 0.75,
//                 ),
//                 itemCount: state.posts.length,
//                 itemBuilder: (context, index) {
//                   final post = state.posts[index];
//                   return PostCard(post: post);
//                 },
//               ),
//             );
//           } else {
//             return const Center(
//               child: Text(
//                 'No posts available.',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           }
//         },
//       ),
//       backgroundColor: const Color(0xFF0F3460), // 🔥 Matching theme
//     );
//   }
// }

// // 🌟 Updated PostCard (More Marketplace-Like)
// class PostCard extends StatelessWidget {
//   const PostCard({super.key, required this.post});

//   final PostsEntity post;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 3,
//       borderRadius: BorderRadius.circular(12),
//       color: Colors.white,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {
//           // Navigate to details page
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // 📷 Image Section with Placeholder
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
//                     top: 10,
//                     left: 10,
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 6, vertical: 3),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.6),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         post.category.name, // Category name
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
//                   // 🏷️ Title
//                   Text(
//                     post.caption,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         overflow: TextOverflow.ellipsis),
//                     maxLines: 1,
//                   ),
//                   const SizedBox(height: 4.0),

//                   // 💰 Price
//                   Text(
//                     'Rs. ${post.price}',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         color: Colors.green),
//                   ),
//                   const SizedBox(height: 6.0),

//                   // 📍 Location
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
//                   const SizedBox(height: 6.0),

//                   // ❤️ Like Button & Count
//                   const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(Icons.favorite_border,
//                               size: 18, color: Colors.grey),
//                           SizedBox(width: 4),
//                           // Text(
//                           //   '${post.likes} Likes',
//                           //   style: TextStyle(
//                           //       fontSize: 12, color: Colors.grey[700]),
//                           // ),
//                         ],
//                       ),
//                       Icon(Icons.more_vert, color: Colors.grey),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(LoadPosts(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Marketplace',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFFEC008C)], // 🌟 Gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
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
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error loading posts: ${state.error!}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<PostsBloc>()
                            .add(LoadPosts(context: context));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state.posts.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostCard(post: post);
                  },
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No posts available.',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

// 🌟 Updated PostCard (More Marketplace-Like)
class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final PostsEntity post;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to post details
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📷 Image Section with Placeholder
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: (post.image != null && post.image!.isNotEmpty)
                        ? Image.network(
                            "${ApiEndpoints.imageUrl}/${post.image!}",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_outlined,
                                  color: Colors.grey),
                            ),
                          ),
                  ),
                  // 📌 Category Tag
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        post.category.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔥 Post Details Section
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🏷️ Title
                  Text(
                    post.caption,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4.0),

                  // 💰 Price
                  Text(
                    'Rs. ${post.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6.0),

                  // 📍 Location
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          post.location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),

                  // ❤️ Like Button & More Options
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.favorite_border,
                              size: 18, color: Colors.grey),
                          SizedBox(width: 4),
                          // Text(
                          //   '${post.likes} Likes',
                          //   style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                          // ),
                        ],
                      ),
                      Icon(Icons.more_vert, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
