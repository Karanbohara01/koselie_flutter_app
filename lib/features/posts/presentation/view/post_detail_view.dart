import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/chat/presentation/view/chat_view.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class PostDetailsView extends StatefulWidget {
  final String postId;

  const PostDetailsView({super.key, required this.postId});

  @override
  _PostDetailsViewState createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PostsBloc>().add(GetPostById(
              postId: widget.postId,
              context: context,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100]!;
        final textColor = isDarkMode ? Colors.white : Colors.black87;
        final appBarGradient = isDarkMode
            ? [Colors.black87, Colors.black54]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
        final cardColor = isDarkMode ? Colors.grey[700]! : Colors.white;
        final descriptionTextColor =
            isDarkMode ? Colors.grey[400]! : Colors.black87;
        final chipBackgroundColor =
            isDarkMode ? Colors.grey[900]! : Colors.black;
        final placeholderColor =
            isDarkMode ? Colors.grey[700]! : Colors.grey[300]!;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              "Product Details",
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
          body: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return Center(
                    child: CircularProgressIndicator(
                        color: Theme.of(context)
                            .primaryColor)); // Themed indicator
              } else if (state.error != null) {
                return Center(
                  child: Text(
                    "Error: ${state.error!}",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (state.selectedPost == null) {
                return Center(
                  child: Text(
                    "Post not found",
                    style: GoogleFonts.poppins(
                      color: textColor.withOpacity(0.6),
                      fontSize: 16,
                    ),
                  ),
                );
              }

              final post = state.selectedPost!;
              const postAuthor = AuthEntity(
                userId: "67ac643a0cc29040b0e248a6",
                username: 'Rekha',
                email: 'rekha@gmail.com',
              );

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Display
                    Hero(
                      tag: 'post-image-${post.postId}',
                      child: _buildImage(post.image, placeholderColor),
                    ),
                    const SizedBox(height: 20),

                    // Product Title
                    Text(
                      post.caption,
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Price Display & Category
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs. ${post.price}",
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Chip(
                          label: Text(
                            post.category.name,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: chipBackgroundColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 6),
                        Text(
                          post.location,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color:
                                descriptionTextColor, // Adjusted location color
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Description
                    Text(
                      "Description",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      post.description,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color:
                            descriptionTextColor, // Adjusted description color
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Likes & Comments
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconText(Icons.favorite, "6 Likes", Colors.red,
                            descriptionTextColor), // Adjusted icon text color
                        _buildIconText(
                            Icons.comment,
                            "8 Comments",
                            descriptionTextColor,
                            descriptionTextColor), // Adjusted icon text color
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Call to Action (Message Seller)
                    _buildActionButton(
                      "Message Seller",
                      textColor,
                      () => _navigateToChatScreen(context, postAuthor),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  /// Build Image with Placeholder Handling
  Widget _buildImage(String? imageUrl, Color placeholderColor) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? Image.network(
              "${ApiEndpoints.imageUrl}/$imageUrl",
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  _buildPlaceholderImage(placeholderColor),
            )
          : _buildPlaceholderImage(placeholderColor),
    );
  }

  /// Navigate to Chat Screen
  void _navigateToChatScreen(BuildContext context, AuthEntity postAuthor) {
    final loggedInUser = context.read<LoginBloc>().state.user;

    if (loggedInUser == null) {
      showMySnackBar(
        context: context,
        message: "Error: You must be logged in to chat!",
        color: Colors.red,
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

  /// Reusable Method for Like/Comment Display
  Widget _buildIconText(
      IconData icon, String text, Color iconColor, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  /// Reusable Action Button
  Widget _buildActionButton(
      String text, Color textColor, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Keep this fixed
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  /// Placeholder Image
  Widget _buildPlaceholderImage(Color placeholderColor) {
    return Container(
      height: 250,
      color: placeholderColor,
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      ),
    );
  }
}
