// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

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
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF8E2DE2),
//               Color(0xFFEC008C),
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: BlocBuilder<LoginBloc, LoginState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               );
//             }

//             if (state.user == null) {
//               return const Center(
//                 child: Text("No user information available",
//                     style: TextStyle(color: Colors.white)),
//               );
//             }

//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // ✅ Profile Header
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 80, horizontal: 20),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // ✅ Profile Picture (Now Clickable for Update)
//                         GestureDetector(
//                           onTap: _pickImage, // Open image picker
//                           child: CircleAvatar(
//                             radius: 45,
//                             backgroundImage: (state.user!.image != null &&
//                                     state.user!.image!.isNotEmpty)
//                                 ? NetworkImage(
//                                     "${ApiEndpoints.imageUrl}/${state.user!.image!}")
//                                 : const AssetImage("assets/images/pushpa.jpg")
//                                     as ImageProvider,
//                           ),
//                         ),
//                         const SizedBox(width: 20),
//                         // ✅ User Info Column
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 state.user!.username,
//                                 style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               // Text(
//                               //   state.user!.role ?? "User",
//                               //   style: const TextStyle(
//                               //       fontSize: 16,
//                               //       fontWeight: FontWeight.w500,
//                               //       color: Colors.white70),
//                               //   overflow: TextOverflow.ellipsis,
//                               // ),
//                               Text(
//                                 state.user!.bio ?? "Gunda",
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.white70),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 state.user!.email,
//                                 style: const TextStyle(
//                                     fontSize: 14, color: Colors.white70),
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 10),
//                               // ✅ Star Rating
//                               Row(
//                                 children: List.generate(5, (index) {
//                                   return const Icon(Icons.star,
//                                       color: Colors.amber, size: 20);
//                                 }),
//                               ),
//                               const SizedBox(height: 10),
//                               // ✅ Edit Profile Button
//                               ElevatedButton(
//                                 onPressed: () {
//                                   _showEditProfileDialog(context, state.user!);
//                                 },
//                                 child: const Text(
//                                   "Edit Profile",
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // ✅ Listings & Archived Listings Section
//                   DefaultTabController(
//                     length: 2,
//                     child: Column(
//                       children: [
//                         const TabBar(
//                           indicatorColor: Colors.white,
//                           labelColor: Colors.white,
//                           unselectedLabelColor: Colors.grey,
//                           tabs: [
//                             Tab(icon: Icon(Icons.grid_on)),
//                             Tab(icon: Icon(Icons.archive_outlined)),
//                           ],
//                         ),
//                         ConstrainedBox(
//                           constraints: const BoxConstraints(maxHeight: 400),
//                           child: TabBarView(
//                             children: [
//                               _buildListingsSection(),
//                               _buildArchivedListings(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   /// ✅ **Edit Profile Dialog**
//   void _showEditProfileDialog(BuildContext context, dynamic user) {
//     TextEditingController nameController =
//         TextEditingController(text: user.username);
//     TextEditingController bioController = TextEditingController(text: user.bio);
//     TextEditingController roleController =
//         TextEditingController(text: user.role ?? "User");

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Edit Profile"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: "Username"),
//               ),
//               TextField(
//                 controller: bioController,
//                 decoration: const InputDecoration(labelText: "Bio"),
//               ),
//               TextField(
//                 controller: roleController,
//                 decoration: const InputDecoration(labelText: "Role"),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel"),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 context.read<LoginBloc>().add(UpdateUserProfileEvent(
//                       context: context,
//                       username: nameController.text,
//                       bio: bioController.text,
//                       role: roleController.text,
//                     ));
//                 Navigator.pop(context);
//               },
//               child: const Text("Save"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   /// ✅ **Image Picker for Profile Picture Update**
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

//   // ✅ Your Listings Section
//   Widget _buildListingsSection() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(10),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 4.0,
//         mainAxisSpacing: 4.0,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: 6,
//       itemBuilder: (context, index) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[850],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Icon(Icons.image, color: Colors.white),
//         );
//       },
//     );
//   }

//   // ✅ Archived Listings Section
//   Widget _buildArchivedListings() {
//     return GridView.builder(
//       padding: const EdgeInsets.all(10),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 4.0,
//         mainAxisSpacing: 4.0,
//         childAspectRatio: 0.8,
//       ),
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[900],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: const Icon(Icons.archive, color: Colors.white),
//         );
//       },
//     );
//   }
// }

import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';

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
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8E2DE2),
              Color(0xFFEC008C),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (state.user == null) {
              return const Center(
                child: Text("No user information available",
                    style: TextStyle(color: Colors.white)),
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  // ✅ Profile Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ Profile Picture with Edit Icon
                        badges.Badge(
                          position:
                              badges.BadgePosition.bottomEnd(bottom: 3, end: 3),
                          badgeContent: const Icon(Icons.edit,
                              size: 15, color: Colors.white),
                          badgeStyle: const badges.BadgeStyle(
                              badgeColor: Colors.blueAccent),
                          child: GestureDetector(
                            onTap: _pickImage, // Open image picker
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: (state.user!.image != null &&
                                      state.user!.image!.isNotEmpty)
                                  ? NetworkImage(
                                      "${ApiEndpoints.imageUrl}/${state.user!.image!}")
                                  : const AssetImage("assets/images/pushpa.jpg")
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        // ✅ User Info Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.user!.username,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),
                              // ✅ Bio with Badge Effect
                              Row(
                                children: [
                                  Text(
                                    state.user!.bio ?? "Gunda",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.white70),
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
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white70),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 5),

                              const SizedBox(height: 10),
                              // ✅ Star Rating
                              Row(
                                children: List.generate(5, (index) {
                                  return const Icon(Icons.star,
                                      color: Colors.amber, size: 22);
                                }),
                              ),
                              const SizedBox(height: 10),
                              // ✅ Edit Profile Button
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showEditProfileDialog(context, state.user!);
                                },
                                icon: const Icon(Icons.edit, size: 16),
                                label: const Text(
                                  "Edit Profile",
                                  style: TextStyle(fontSize: 14),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white.withOpacity(0.2),
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

                  // ✅ Listings & Archived Listings Section
                  DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          indicatorColor: Colors.white,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(icon: Icon(Icons.grid_on)),
                            Tab(icon: Icon(Icons.archive_outlined)),
                          ],
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 400),
                          child: TabBarView(
                            children: [
                              _buildListingsSection(),
                              _buildArchivedListings(),
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
  }

  /// ✅ **Edit Profile Dialog**
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
          title: const Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: bioController,
                decoration: const InputDecoration(labelText: "Bio"),
              ),
              TextField(
                controller: roleController,
                decoration: const InputDecoration(labelText: "Role"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
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
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// ✅ **Image Picker for Profile Picture Update**
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

  // ✅ Listings Section
  Widget _buildListingsSection() {
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
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.image, color: Colors.white),
        );
      },
    );
  }

  // ✅ Archived Listings Section
  Widget _buildArchivedListings() {
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
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.archive, color: Colors.white),
        );
      },
    );
  }
}
