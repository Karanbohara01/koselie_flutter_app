// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:koselie/features/category/domain/entity/category_entity.dart';
// import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
// import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
// import 'package:permission_handler/permission_handler.dart';

// class CreatePostView extends StatefulWidget {
//   const CreatePostView({super.key});

//   @override
//   State<CreatePostView> createState() => _CreatePostViewState();
// }

// class _CreatePostViewState extends State<CreatePostView> {
//   final _gap = const SizedBox(height: 16);
//   final _key = GlobalKey<FormState>();

//   final _captionController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _priceController = TextEditingController();

//   CategoryEntity? _dropDownValue;
//   File? _img;

//   Future<void> checkCameraPermission() async {
//     if (await Permission.camera.request().isRestricted ||
//         await Permission.camera.request().isDenied) {
//       await Permission.camera.request();
//     }
//   }

//   Future _browseImage(ImageSource imageSource) async {
//     try {
//       final image = await ImagePicker().pickImage(source: imageSource);
//       if (image != null) {
//         setState(() {
//           _img = File(image.path);
//           context.read<PostsBloc>().add(
//                 UploadPostsImage(file: _img!),
//               );
//         });
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Create Listing',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _key,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ✅ Image Upload Section
//                 InkWell(
//                   onTap: () {
//                     showModalBottomSheet(
//                       backgroundColor: Colors.white,
//                       context: context,
//                       isScrollControlled: true,
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(20),
//                         ),
//                       ),
//                       builder: (context) => Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 checkCameraPermission();
//                                 _browseImage(ImageSource.camera);
//                                 Navigator.pop(context);
//                               },
//                               icon:
//                                   const Icon(Icons.camera, color: Colors.white),
//                               label: const Text('Camera',
//                                   style: TextStyle(color: Colors.white)),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.pinkAccent,
//                               ),
//                             ),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 _browseImage(ImageSource.gallery);
//                                 Navigator.pop(context);
//                               },
//                               icon:
//                                   const Icon(Icons.image, color: Colors.white),
//                               label: const Text('Gallery',
//                                   style: TextStyle(color: Colors.white)),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.pinkAccent,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     height: 180,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey[100],
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey[300]!),
//                       image: _img != null
//                           ? DecorationImage(
//                               image: FileImage(_img!),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                     ),
//                     child: _img == null
//                         ? const Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.camera_alt,
//                                   size: 50, color: Colors.grey),
//                               SizedBox(height: 10),
//                               Text("Tap to upload image",
//                                   style: TextStyle(color: Colors.grey)),
//                             ],
//                           )
//                         : null,
//                   ),
//                 ),
//                 _gap,

//                 // ✅ Title Field
//                 TextFormField(
//                   controller: _captionController,
//                   decoration: InputDecoration(
//                     labelText: 'Title',
//                     prefixIcon: const Icon(Icons.title),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a title';
//                     }
//                     return null;
//                   },
//                 ),
//                 _gap,

//                 // ✅ Description Field
//                 TextFormField(
//                   controller: _descriptionController,
//                   decoration: InputDecoration(
//                     labelText: 'Description',
//                     prefixIcon: const Icon(Icons.description),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a description';
//                     }
//                     return null;
//                   },
//                   maxLines: 2,
//                 ),
//                 _gap,

//                 // ✅ Price Field
//                 TextFormField(
//                   controller: _priceController,
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(
//                     labelText: 'Price in Rs',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a price';
//                     }
//                     if (double.tryParse(value) == null) {
//                       return 'Please enter a valid number';
//                     }
//                     return null;
//                   },
//                 ),
//                 _gap,

//                 // ✅ Category Dropdown
//                 BlocBuilder<CategoryBloc, CategoryState>(
//                   builder: (context, state) {
//                     if (state.categories.isEmpty) {
//                       return const Text('No categories available.');
//                     }
//                     return DropdownButtonFormField<CategoryEntity>(
//                       items: state.categories
//                           .map((e) => DropdownMenuItem<CategoryEntity>(
//                                 value: e,
//                                 child: Text(e.name),
//                               ))
//                           .toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _dropDownValue = value;
//                         });
//                       },
//                       value: _dropDownValue,
//                       decoration: InputDecoration(
//                         labelText: 'Category',
//                         prefixIcon: const Icon(Icons.category),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null) {
//                           return 'Please select a category';
//                         }
//                         return null;
//                       },
//                     );
//                   },
//                 ),
//                 _gap,

//                 // ✅ Location Field
//                 TextFormField(
//                   controller: _locationController,
//                   decoration: InputDecoration(
//                     labelText: 'Location',
//                     prefixIcon: const Icon(Icons.location_on),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter a location';
//                     }
//                     return null;
//                   },
//                 ),
//                 _gap,

//                 // ✅ List Item Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (_key.currentState!.validate() &&
//                           _dropDownValue != null) {
//                         final registerState = context.read<PostsBloc>().state;
//                         final imageName = registerState.imageName;

//                         context.read<PostsBloc>().add(
//                               CreatePost(
//                                 context: context,
//                                 caption: _captionController.text,
//                                 location: _locationController.text,
//                                 price: _priceController.text,
//                                 category: _dropDownValue!,
//                                 description: _descriptionController.text,
//                                 image: imageName,
//                               ),
//                             );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     child: const Text('List Item'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koselie/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final _gap = const SizedBox(height: 16);
  final _key = GlobalKey<FormState>();

  final _captionController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  CategoryEntity? _dropDownValue;
  File? _img;

  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          context.read<PostsBloc>().add(
                UploadPostsImage(file: _img!),
              );
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.read<LoginBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Listing',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Image Upload Section
                _buildImagePicker(),

                _gap,

                // ✅ Title Field
                _buildTextField(_captionController, 'Title', Icons.title),

                _gap,

                // ✅ Description Field
                _buildTextField(
                    _descriptionController, 'Description', Icons.description,
                    maxLines: 2),

                _gap,

                // ✅ Price Field
                _buildPriceField(),

                _gap,

                // ✅ Category Dropdown
                _buildCategoryDropdown(),

                _gap,

                // ✅ Location Field
                _buildTextField(
                    _locationController, 'Location', Icons.location_on),

                _gap,

                // ✅ Submit Button
                _buildSubmitButton(loggedInUser),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ **Build Image Picker UI**
  Widget _buildImagePicker() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.white,
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    checkCameraPermission();
                    _browseImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.camera, color: Colors.white),
                  label: const Text('Camera',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _browseImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.image, color: Colors.white),
                  label: const Text('Gallery',
                      style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          image: _img != null
              ? DecorationImage(
                  image: FileImage(_img!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: _img == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Tap to upload image",
                      style: TextStyle(color: Colors.grey)),
                ],
              )
            : null,
      ),
    );
  }

  /// ✅ **Build Text Field**
  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter a $label' : null,
      maxLines: maxLines,
    );
  }

  /// ✅ **Build Price Field**
  Widget _buildPriceField() {
    return TextFormField(
      controller: _priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Price in Rs',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Please enter a price';
        if (double.tryParse(value) == null)
          return 'Please enter a valid number';
        return null;
      },
    );
  }

  /// ✅ **Build Category Dropdown**
  Widget _buildCategoryDropdown() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.categories.isEmpty)
          return const Text('No categories available.');
        return DropdownButtonFormField<CategoryEntity>(
          items: state.categories
              .map((e) => DropdownMenuItem<CategoryEntity>(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList(),
          onChanged: (value) => setState(() => _dropDownValue = value),
          value: _dropDownValue,
          decoration: InputDecoration(
            labelText: 'Category',
            prefixIcon: const Icon(Icons.category),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
          validator: (value) =>
              value == null ? 'Please select a category' : null,
        );
      },
    );
  }

  /// ✅ **Build Submit Button**
  Widget _buildSubmitButton(loggedInUser) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_key.currentState!.validate() && _dropDownValue != null) {
            final imageName = context.read<PostsBloc>().state.imageName;

            context.read<PostsBloc>().add(
                  CreatePost(
                    context: context,
                    caption: _captionController.text,
                    location: _locationController.text,
                    price: _priceController.text,
                    category: _dropDownValue!,
                    description: _descriptionController.text,
                    image: imageName,
                  ),
                );
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
        child: const Text('List Item'),
      ),
    );
  }
}
