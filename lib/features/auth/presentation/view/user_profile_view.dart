import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/home/presentation/view/settings_view.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(GetUserInfoEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final appBarGradient = isDarkMode
            ? [Colors.black87, Colors.black54]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
        final cardColor = isDarkMode ? Colors.grey[850]! : Colors.grey[200]!;
        final iconColor = isDarkMode ? Colors.white : Colors.black;
        final iconMenu = isDarkMode ? Icons.menu : Icons.menu; // Icon menu

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: appBarGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: AppBar(
                title: Text(
                  'Profile',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon: Icon(
                        iconMenu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    );
                  },
                ),
              ),
            ),
          ),
          drawer: Drawer(
            backgroundColor: backgroundColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: appBarGradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    'Menu',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: textColor),
                  title: Text(
                    'Settings',
                    style: TextStyle(color: textColor),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Container(
            height: double.infinity,
            color: backgroundColor,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: isDarkMode ? Colors.white : Colors.blue,
                    ),
                  );
                }

                if (state.user == null) {
                  return Center(
                    child: Text(
                      "No user information available",
                      style: TextStyle(color: textColor),
                    ),
                  );
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Header
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 60),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile Picture with Edit Icon
                            badges.Badge(
                              position: badges.BadgePosition.bottomEnd(
                                  bottom: 3, end: 3),
                              badgeContent: const Icon(Icons.edit,
                                  size: 15, color: Colors.white),
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Colors.blueAccent),
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: (state.user!.image != null &&
                                          state.user!.image!.isNotEmpty)
                                      ? NetworkImage(
                                          "${ApiEndpoints.imageUrl}/${state.user!.image!}")
                                      : const AssetImage(
                                              "assets/images/pushpa.jpg")
                                          as ImageProvider,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            // User Info Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.user!.username,
                                    style: GoogleFonts.poppins(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(
                                        "Followers: ${state.user!.followers.length}",
                                        style: TextStyle(color: textColor),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Following: ${state.user!.following.length}",
                                        style: TextStyle(color: textColor),
                                      ),
                                    ],
                                  ),
                                  // Bio with Badge Effect
                                  Row(
                                    children: [
                                      Text(
                                        state.user!.bio ?? "Gunda",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: textColor.withOpacity(0.7),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(width: 8),
                                      const badges.Badge(
                                        badgeStyle: badges.BadgeStyle(
                                            badgeColor: Colors.green),
                                        badgeContent: Icon(Icons.verified,
                                            color: Colors.white, size: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    state.user!.email,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: textColor.withOpacity(0.7),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
                                  const SizedBox(height: 10),
                                  // Star Rating
                                  Row(
                                    children: List.generate(5, (index) {
                                      return const Icon(Icons.star,
                                          color: Colors.amber, size: 22);
                                    }),
                                  ),
                                  const SizedBox(height: 10),
                                  // Edit Profile Button
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _showEditProfileDialog(
                                          context, state.user!);
                                    },
                                    icon: const Icon(Icons.edit, size: 16),
                                    label: const Text(
                                      "Edit Profile",
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueAccent,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Listings & Archived Listings Section
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              indicatorColor: Colors.blueAccent,
                              labelColor: textColor,
                              unselectedLabelColor: Colors.grey,
                              tabs: const [
                                Tab(icon: Icon(Icons.grid_on)),
                                Tab(icon: Icon(Icons.archive_outlined)),
                              ],
                            ),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 400),
                              child: TabBarView(
                                children: [
                                  _buildListingsSection(cardColor, iconColor),
                                  _buildArchivedListings(cardColor, iconColor),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// Edit Profile Dialog
  void _showEditProfileDialog(BuildContext context, dynamic user) {
    TextEditingController nameController =
        TextEditingController(text: user.username);
    TextEditingController bioController = TextEditingController(text: user.bio);
    TextEditingController roleController =
        TextEditingController(text: user.role ?? "User");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Text(
            "Edit Profile",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: bioController,
                decoration: InputDecoration(
                  labelText: "Bio",
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: "Role",
                  labelStyle: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<LoginBloc>().add(UpdateUserProfileEvent(
                      context: context,
                      username: nameController.text,
                      bio: bioController.text,
                      role: roleController.text,
                    ));
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Save",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Image Picker for Profile Picture Update
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      context.read<LoginBloc>().add(UpdateProfilePictureEvent(
            context: context,
            profilePicture: imageFile,
          ));
    }
  }

  // Listings Section
  Widget _buildListingsSection(Color cardColor, Color iconColor) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 0.8,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.image, color: iconColor),
        );
      },
    );
  }

  // Archived Listings Section
  Widget _buildArchivedListings(Color cardColor, Color iconColor) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 3,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.archive, color: iconColor),
        );
      },
    );
  }
}

// // ************************************************************************//
// import 'dart:io';

// import 'package:badges/badges.dart' as badges;
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

// class UserProfileScreen extends StatefulWidget {
//   const UserProfileScreen({super.key});

//   @override
//   State<UserProfileScreen> createState() => _UserProfileViewState();
// }

// class _UserProfileViewState extends State<UserProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<LoginBloc>().add(GetUserInfoEvent(context: context));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;
//         final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
//         final textColor = isDarkMode ? Colors.white : Colors.black;
//         final appBarGradient = isDarkMode
//             ? [Colors.black87, Colors.black54]
//             : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];

//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Profile',
//                 style: GoogleFonts.poppins(
//                     color: Colors.white, fontWeight: FontWeight.bold)),
//             centerTitle: true,
//             flexibleSpace: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: appBarGradient,
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//             ),
//           ),
//           body: BlocBuilder<LoginBloc, LoginState>(
//             builder: (context, state) {
//               if (state.isLoading) {
//                 return Center(
//                     child: CircularProgressIndicator(
//                         color: isDarkMode ? Colors.white : Colors.blue));
//               }

//               if (state.user == null) {
//                 return Center(
//                     child: Text("No user information available",
//                         style: TextStyle(color: textColor)));
//               }

//               final user = state.user!;
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildProfileHeader(user, textColor),
//                     _buildTabs(user, textColor, isDarkMode),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProfileHeader(user, Color textColor) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Row(
//         children: [
//           badges.Badge(
//             position: badges.BadgePosition.bottomEnd(bottom: 3, end: 3),
//             badgeContent: const Icon(Icons.edit, size: 15, color: Colors.white),
//             badgeStyle: const badges.BadgeStyle(badgeColor: Colors.blueAccent),
//             child: GestureDetector(
//               onTap: _pickImage,
//               child: CircleAvatar(
//                 radius: 50,
//                 backgroundImage: user.profilePicture != null
//                     ? NetworkImage(user.profilePicture!)
//                     : const AssetImage("assets/images/default_avatar.png")
//                         as ImageProvider,
//               ),
//             ),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(user.username,
//                     style: GoogleFonts.poppins(
//                         fontSize: 22,
//                         fontWeight: FontWeight.bold,
//                         color: textColor)),
//                 Text(user.email,
//                     style: GoogleFonts.poppins(fontSize: 16, color: textColor)),
//                 Text(user.bio ?? "No bio available",
//                     style: GoogleFonts.poppins(
//                         fontSize: 14, color: textColor.withOpacity(0.7))),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTabs(user, Color textColor, bool isDarkMode) {
//     return DefaultTabController(
//       length: 2,
//       child: Column(
//         children: [
//           TabBar(
//             indicatorColor: Colors.blueAccent,
//             labelColor: textColor,
//             unselectedLabelColor: Colors.grey,
//             tabs: const [Tab(text: "Posts"), Tab(text: "Bookmarks")],
//           ),
//           SizedBox(
//             height: 400,
//             child: TabBarView(
//               children: [
//                 _buildGridView(user.posts, isDarkMode),
//                 _buildGridView(user.bookmarks, isDarkMode),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildGridView(List<dynamic> items, bool isDarkMode) {
//     return items.isEmpty
//         ? const Center(child: Text("No items available"))
//         : GridView.builder(
//             padding: const EdgeInsets.all(10),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 4.0,
//               mainAxisSpacing: 4.0,
//             ),
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               if (item is! Map<String, dynamic>) {
//                 return Container(
//                   color: Colors.red,
//                   alignment: Alignment.center,
//                   child: const Text("Invalid data",
//                       style: TextStyle(color: Colors.white)),
//                 );
//               }

//               return ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: item['image'] != null
//                     ? Image.network(
//                         "${ApiEndpoints.imageUrl}/${item['image']}",
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return const Icon(Icons.broken_image,
//                               size: 50, color: Colors.grey);
//                         },
//                       )
//                     : Container(
//                         color: Colors.grey,
//                         alignment: Alignment.center,
//                         child: Text(item['caption'] ?? "No Caption",
//                             style: const TextStyle(color: Colors.white)),
//                       ),
//               );
//             },
//           );
//   }

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       File imageFile = File(pickedFile.path);
//       context.read<LoginBloc>().add(UpdateProfilePictureEvent(
//             context: context,
//             profilePicture: imageFile,
//           ));
//     }
//   }
// }
