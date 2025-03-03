import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:koselie/features/category/domain/entity/category_entity.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/posts/domain/entity/posts_entity.dart';
import 'package:koselie/features/posts/presentation/view_model/posts_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';
import 'package:permission_handler/permission_handler.dart';

class PostUpdateView extends StatefulWidget {
  final PostsEntity post;

  const PostUpdateView({super.key, required this.post});

  @override
  State<PostUpdateView> createState() => _PostUpdateViewState();
}

class _PostUpdateViewState extends State<PostUpdateView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _captionController;
  late TextEditingController _locationController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  CategoryEntity? _selectedCategory;
  File? _image;

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController(text: widget.post.caption);
    _locationController = TextEditingController(text: widget.post.location);
    _descriptionController =
        TextEditingController(text: widget.post.description);
    _priceController = TextEditingController(text: widget.post.price);
    _selectedCategory = widget.post.category;
  }

  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image != null) {
        setState(() {
          _image = File(image.path);
          context
              .read<PostsBloc>()
              .add(UploadPostsImage(file: _image!, context: context));
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;
        final backgroundColor = isDarkMode ? Colors.black : Colors.white;
        final textColor = isDarkMode ? Colors.white : Colors.black;
        final textFieldFillColor =
            isDarkMode ? Colors.grey[800]! : Colors.grey[100]!;
        final buttonColor = isDarkMode ? Colors.grey[700]! : Colors.black;
        final iconColor = isDarkMode ? Colors.white : Colors.grey;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: const Text(
              'Update Post',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagePicker(iconColor),
                  const SizedBox(height: 16),
                  _buildTextField(
                    _captionController,
                    'Title',
                    Icons.title,
                    textFieldFillColor,
                    textColor,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    _descriptionController,
                    'Description',
                    Icons.description,
                    textFieldFillColor,
                    textColor,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  _buildPriceField(textFieldFillColor, textColor),
                  const SizedBox(height: 16),
                  _buildCategoryDropdown(textFieldFillColor, textColor),
                  const SizedBox(height: 16),
                  _buildTextField(
                    _locationController,
                    'Location',
                    Icons.location_on,
                    textFieldFillColor,
                    textColor,
                  ),
                  const SizedBox(height: 20),
                  _buildUpdateButton(buttonColor),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// ✅ Image Picker UI
  Widget _buildImagePicker(Color iconColor) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
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
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.camera, color: Colors.white),
                  label: const Text(
                    'Camera',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.image, color: Colors.white),
                  label: const Text(
                    'Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
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
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          image: _image != null
              ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover)
              : widget.post.image != null
                  ? DecorationImage(
                      image: NetworkImage(widget.post.image!),
                      fit: BoxFit.cover,
                    )
                  : null,
        ),
        child: _image == null && widget.post.image == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, size: 50, color: iconColor),
                  const SizedBox(height: 10),
                  Text(
                    "Tap to upload image",
                    style: TextStyle(color: iconColor),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  /// ✅ Text Field Builder
  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon,
    Color fillColor,
    Color textColor, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: textColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: fillColor,
        labelStyle: TextStyle(color: textColor),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter a $label' : null,
      maxLines: maxLines,
    );
  }

  /// ✅ Price Field
  Widget _buildPriceField(Color fillColor, Color textColor) {
    return TextFormField(
      controller: _priceController,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        labelText: 'Price in Rs',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: fillColor,
        labelStyle: TextStyle(color: textColor),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter a price' : null,
      keyboardType: TextInputType.number,
    );
  }

  /// ✅ Category Dropdown
  Widget _buildCategoryDropdown(Color fillColor, Color textColor) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state.categories.isEmpty) {
          return const Text("No categories available.");
        }

        // Ensure selectedCategory is valid and exists in the list
        final validCategory = state.categories
            .where((category) =>
                category.categoryId == _selectedCategory?.categoryId)
            .isNotEmpty;

        return DropdownButtonFormField<CategoryEntity>(
          dropdownColor: fillColor,
          style: TextStyle(color: textColor),
          items: state.categories
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.name, style: TextStyle(color: textColor)),
                  ))
              .toList(),
          onChanged: (value) => setState(() => _selectedCategory = value),
          value: validCategory
              ? _selectedCategory
              : state.categories.first, // ✅ Ensure it's in the list
          decoration: InputDecoration(
            labelText: 'Category',
            prefixIcon: const Icon(Icons.category),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: fillColor,
            labelStyle: TextStyle(color: textColor),
          ),
        );
      },
    );
  }

  /// ✅ Update Button
  Widget _buildUpdateButton(Color buttonColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final updatedImage =
                _image != null ? _image!.path : widget.post.image;

            context.read<PostsBloc>().add(UpdatePost(
                  postId: widget.post.postId!,
                  post: PostsEntity(
                    postId: widget.post.postId!,
                    caption: _captionController.text.trim(),
                    description: _descriptionController.text.trim(),
                    price: _priceController.text.trim(),
                    location: _locationController.text.trim(),
                    category: _selectedCategory ?? widget.post.category,
                    image: updatedImage,
                  ),
                  context: context,
                ));

            // Navigate back after update
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Update Post',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
