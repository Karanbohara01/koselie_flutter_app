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
//   bool _isNavigating = false; // ✅ Prevent multiple navigation taps

//   @override
//   void initState() {
//     super.initState();

//     // ✅ Use addPostFrameCallback to avoid calling context.read in initState()
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<AuthBloc>().add(GetAllUsersRequested());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final loggedInUserId = context.read<LoginBloc>().state.user?.userId;

//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text(
//           "Chats",
//           style: TextStyle(
//               fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
//         ),
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF833AB4), Color(0xFFFF4081)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         elevation: 5,
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
//                   return Center(child: Text("Error: ${state.message}"));
//                 } else if (state is AuthUsersLoaded) {
//                   final filteredUsers = state.users
//                       .where((user) =>
//                           user.userId != loggedInUserId &&
//                           (user.username
//                               .toLowerCase()
//                               .contains(_searchQuery.toLowerCase())))
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
//                 return const Center(child: Text("No users found."));
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
//         style: const TextStyle(color: Colors.white),
//         decoration: InputDecoration(
//           hintText: "Search users...",
//           hintStyle: const TextStyle(color: Colors.white54),
//           prefixIcon: const Icon(Icons.search, color: Colors.white70),
//           filled: true,
//           fillColor: Colors.white10,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30),
//             borderSide: BorderSide.none,
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
//           receiverUsername: user.username, // Pass receiver's username
//           receiverImage: user.image ??
//               '', // Pass receiver's image (or empty string if null)
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
//           onTap: onTap, // ✅ Uses debounced onTap from `_navigateToChatScreen`
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white10,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.white.withOpacity(0.05),
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
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         user.email,
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.chat_bubble_outline, color: Colors.white70),
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

// ----------------------------------------------------------------------//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/auth/presentation/view_model/signup/auth_bloc.dart';
import 'package:koselie/features/chat/presentation/view/chat_view.dart';

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Chats",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 5,
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
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingUsers) {
                  return const Center(child: CircularProgressIndicator());
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
                        onTap: () => _navigateToChatScreen(
                            context, filteredUsers[index]),
                      );
                    },
                  );
                }
                return const Center(
                    child: Text("No users found.",
                        style: TextStyle(color: Colors.black54)));
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Search Bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: TextField(
        onChanged: (query) {
          setState(() {
            _searchQuery = query;
          });
        },
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: "Search users...",
          hintStyle: const TextStyle(color: Colors.black54),
          prefixIcon: const Icon(Icons.search, color: Colors.black87),
          filled: true,
          fillColor: Colors.white,
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

/// 🔹 User Tile Component
class UserTile extends StatelessWidget {
  final AuthEntity user;
  final VoidCallback onTap;

  const UserTile({super.key, required this.user, required this.onTap});

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
              color: Colors.white,
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.email,
                        style: const TextStyle(
                          color: Colors.black54,
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

  /// 🔹 User Avatar
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
