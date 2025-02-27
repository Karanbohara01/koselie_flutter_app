// // ----------------------------------------------------------------------//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
// import 'package:koselie/features/chat/presentation/view/chat_view.dart';

// class UserListScreen extends StatefulWidget {
//   const UserListScreen({super.key});

//   @override
//   State<UserListScreen> createState() => _UserListScreenState();
// }

// class _UserListScreenState extends State<UserListScreen> {
//   String _searchQuery = "";
//   bool _isNavigating = false;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AuthBloc>().add(GetAllUsersRequested());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loggedInUserId = context.read<LoginBloc>().state.user?.userId;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Chats",
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 5,
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
//       body: Column(
//         children: [
//           _buildSearchBar(),
//           Expanded(
//             child: BlocBuilder<AuthBloc, AuthState>(
//               builder: (context, state) {
//                 if (state is AuthLoadingUsers) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (state is AuthUsersFailure) {
//                   return Center(
//                       child: Text("Error: ${state.message}",
//                           style: const TextStyle(color: Colors.red)));
//                 } else if (state is AuthUsersLoaded) {
//                   final filteredUsers = state.users
//                       .where((user) =>
//                           user.userId != loggedInUserId &&
//                           user.username
//                               .toLowerCase()
//                               .contains(_searchQuery.toLowerCase()))
//                       .toList();

//                   return ListView.builder(
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: filteredUsers.length,
//                     itemBuilder: (context, index) {
//                       return UserTile(
//                         user: filteredUsers[index],
//                         onTap: () => _navigateToChatScreen(
//                             context, filteredUsers[index]),
//                       );
//                     },
//                   );
//                 }
//                 return const Center(
//                     child: Text("No users found.",
//                         style: TextStyle(color: Colors.black54)));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 Search Bar
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       child: TextField(
//         onChanged: (query) {
//           setState(() {
//             _searchQuery = query;
//           });
//         },
//         style: const TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           hintText: "Search users...",
//           hintStyle: const TextStyle(color: Colors.black54),
//           prefixIcon: const Icon(Icons.search, color: Colors.black87),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: const BorderSide(color: Colors.black26),
//           ),
//         ),
//       ),
//     );
//   }

//   void _navigateToChatScreen(BuildContext context, AuthEntity user) {
//     if (_isNavigating) return;
//     _isNavigating = true;

//     final sender = context.read<LoginBloc>().state.user;

//     if (sender == null) {
//       showMySnackBar(
//         context: context,
//         message: "Error: User not logged in!",
//         color: Colors.red,
//       );
//       _isNavigating = false;
//       return;
//     }

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ChatScreen(
//           senderId: sender.userId!,
//           receiverId: user.userId!,
//           receiverUsername: user.username,
//           receiverImage: user.image ?? '',
//           key: ValueKey(user.userId!),
//         ),
//       ),
//     ).then((_) {
//       _isNavigating = false;
//     });
//   }
// }

// /// 🔹 User Tile Component
// class UserTile extends StatelessWidget {
//   final AuthEntity user;
//   final VoidCallback onTap;

//   const UserTile({super.key, required this.user, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(20),
//           onTap: onTap,
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 _buildAvatar(user),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         user.username,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         user.email,
//                         style: const TextStyle(
//                           color: Colors.black54,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chat_bubble_outline, color: Colors.black87),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   /// 🔹 User Avatar
//   Widget _buildAvatar(AuthEntity user) {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         image: DecorationImage(
//           fit: BoxFit.cover,
//           image: (user.image?.isNotEmpty ?? false)
//               ? NetworkImage("${ApiEndpoints.imageUrl}/${user.image!}")
//               : const AssetImage("assets/images/pushpa.jpg") as ImageProvider,
//         ),
//       ),
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
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/chat/presentation/view/chat_view.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  String _searchQuery = "";
  bool _isNavigating = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(GetAllUsersRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUserId = context.read<LoginBloc>().state.user?.userId;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        final backgroundColor = isDarkMode ? Colors.black : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final appBarGradient = isDarkMode
            ? [Colors.black87, Colors.black54]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
        final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
        final searchFillColor = isDarkMode ? Colors.grey[850]! : Colors.white;
        final hintTextColor = isDarkMode ? Colors.grey[500]! : Colors.black54;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(
              "Chats",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            centerTitle: true,
            elevation: 5,
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
              _buildSearchBar(searchFillColor, hintTextColor, textColor),
              Expanded(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadingUsers) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ));
                    } else if (state is AuthUsersFailure) {
                      return Center(
                          child: Text("Error: ${state.message}",
                              style: const TextStyle(color: Colors.red)));
                    } else if (state is AuthUsersLoaded) {
                      final filteredUsers = state.users
                          .where((user) =>
                              user.userId != loggedInUserId &&
                              user.username
                                  .toLowerCase()
                                  .contains(_searchQuery.toLowerCase()))
                          .toList();

                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          return UserTile(
                            user: filteredUsers[index],
                            cardColor: cardColor,
                            textColor: textColor,
                            onTap: () => _navigateToChatScreen(
                                context, filteredUsers[index]),
                          );
                        },
                      );
                    }
                    return Center(
                        child: Text("No users found.",
                            style: GoogleFonts.poppins(color: Colors.black54)));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Search Bar
  Widget _buildSearchBar(
      Color searchFillColor, Color hintTextColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          hintText: "Search users...",
          hintStyle: TextStyle(color: hintTextColor),
          prefixIcon: const Icon(Icons.search, color: Colors.black87),
          filled: true,
          fillColor: searchFillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black26),
          ),
        ),
      ),
    );
  }

  void _navigateToChatScreen(BuildContext context, AuthEntity user) {
    if (_isNavigating) return;
    _isNavigating = true;

    final sender = context.read<LoginBloc>().state.user;

    if (sender == null) {
      showMySnackBar(
        context: context,
        message: "Error: User not logged in!",
        color: Colors.red,
      );
      _isNavigating = false;
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          senderId: sender.userId!,
          receiverId: user.userId!,
          receiverUsername: user.username,
          receiverImage: user.image ?? '',
          key: ValueKey(user.userId!),
        ),
      ),
    ).then((_) {
      _isNavigating = false;
    });
  }
}

/// User Tile Component
class UserTile extends StatelessWidget {
  final AuthEntity user;
  final VoidCallback onTap;
  final Color cardColor;
  final Color textColor;

  const UserTile({
    super.key,
    required this.user,
    required this.onTap,
    required this.cardColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _buildAvatar(user),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: GoogleFonts.poppins(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: GoogleFonts.poppins(
                          color: textColor.withOpacity(0.6),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chat_bubble_outline, color: Colors.black87),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// User Avatar
  Widget _buildAvatar(AuthEntity user) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: (user.image?.isNotEmpty ?? false)
              ? NetworkImage("${ApiEndpoints.imageUrl}/${user.image!}")
              : const AssetImage("assets/images/pushpa.jpg") as ImageProvider,
        ),
      ),
    );
  }
}
