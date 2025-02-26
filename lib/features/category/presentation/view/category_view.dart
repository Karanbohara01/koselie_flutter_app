// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';

// class CategoryView extends StatelessWidget {
//   CategoryView({super.key});

//   final categoryNameController = TextEditingController();
//   final _categoryViewFormKey = GlobalKey<FormState>();

//   final Map<String, String> categoryImages = {
//     "Technology": "assets/images/technology.jpg",
//     "Grocery": "assets/images/grocery.jpeg",
//     "Fashion": "assets/images/fashion.jpg",
//     "Books": "assets/images/books.jpg",
//     "Fitness": "assets/images/fitness.jpg",
//     "Foods": "assets/images/foods.jpg",
//     "Vechicles": "assets/images/fashion.jpg",
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         title: const Text(
//           'Categories',
//           style: TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xFF3E1F47), // Deep Purple
//               Color(0xFF9E2A2B), // Reddish tone
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Column(
//             children: [
//               const SizedBox(height: 100), // Space for AppBar transparency
//               Form(
//                 key: _categoryViewFormKey,
//                 child: TextFormField(
//                   controller: categoryNameController,
//                   decoration: InputDecoration(
//                     labelText: 'Category Name',
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.15),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     prefixIcon: const Icon(Icons.category, color: Colors.white),
//                     labelStyle: const TextStyle(color: Colors.white),
//                   ),
//                   style: const TextStyle(color: Colors.white),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter category name';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Add Button with Glassmorphism Effect
//               ElevatedButton(
//                 onPressed: () {
//                   if (_categoryViewFormKey.currentState!.validate()) {
//                     context.read<CategoryBloc>().add(
//                           AddCategory(
//                             categoryNameController.text,
//                             onSuccess: (message) => showMySnackBar(
//                               context: context,
//                               message: message,
//                             ),
//                           ),
//                         );
//                     categoryNameController.clear();
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white.withOpacity(0.15),
//                   foregroundColor: Colors.white,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   'Add Category',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               // Category Grid
//               Expanded(
//                 child: BlocBuilder<CategoryBloc, CategoryState>(
//                   builder: (context, state) {
//                     if (state.isLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state.error != null) {
//                       return Center(
//                           child: Text('Error: ${state.error!}',
//                               style: const TextStyle(color: Colors.white)));
//                     } else if (state.categories.isEmpty) {
//                       return const Center(
//                           child: Text('No Categories Added Yet',
//                               style: TextStyle(color: Colors.white)));
//                     } else {
//                       return GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2, // Two columns
//                           crossAxisSpacing: 15,
//                           mainAxisSpacing: 15,
//                           childAspectRatio: 0.85,
//                         ),
//                         itemCount: state.categories.length,
//                         itemBuilder: (context, index) {
//                           final category = state.categories[index];
//                           String categoryName = category.name;
//                           String categoryImage = categoryImages[categoryName] ??
//                               "assets/images/default.png";

//                           return Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withOpacity(0.2),
//                                   blurRadius: 5,
//                                   offset: const Offset(2, 4),
//                                 ),
//                               ],
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(15),
//                               child: Stack(
//                                 children: [
//                                   Image.asset(
//                                     categoryImage,
//                                     fit: BoxFit.cover,
//                                     width: double.infinity,
//                                     height: double.infinity,
//                                     errorBuilder:
//                                         (context, error, stackTrace) =>
//                                             Container(
//                                       color: Colors.grey.shade300,
//                                       child: const Center(
//                                         child: Icon(Icons.image_not_supported,
//                                             size: 50, color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     bottom: 0,
//                                     left: 0,
//                                     right: 0,
//                                     child: Container(
//                                       padding: const EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                         color: Colors.black.withOpacity(0.6),
//                                         borderRadius: const BorderRadius.only(
//                                           bottomLeft: Radius.circular(15),
//                                           bottomRight: Radius.circular(15),
//                                         ),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             categoryName,
//                                             style: const TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                           IconButton(
//                                             icon: const Icon(Icons.delete,
//                                                 color: Colors.redAccent),
//                                             onPressed: () {
//                                               showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context2) {
//                                                   return AlertDialog(
//                                                     title: const Text(
//                                                         'Delete Category'),
//                                                     content: Text(
//                                                         'Are you sure you want to delete $categoryName?'),
//                                                     actions: [
//                                                       TextButton(
//                                                         child: const Text(
//                                                             'Cancel'),
//                                                         onPressed: () {
//                                                           Navigator.of(context2)
//                                                               .pop();
//                                                         },
//                                                       ),
//                                                       TextButton(
//                                                         child: const Text(
//                                                             'Delete',
//                                                             style: TextStyle(
//                                                                 color: Colors
//                                                                     .redAccent)),
//                                                         onPressed: () {
//                                                           context
//                                                               .read<
//                                                                   CategoryBloc>()
//                                                               .add(
//                                                                 DeleteCategory(
//                                                                   category
//                                                                       .categoryId!,
//                                                                   onSuccess:
//                                                                       (message) =>
//                                                                           showMySnackBar(
//                                                                     context:
//                                                                         context,
//                                                                     message:
//                                                                         message,
//                                                                   ),
//                                                                 ),
//                                                               );
//                                                           Navigator.of(context2)
//                                                               .pop();
//                                                         },
//                                                       ),
//                                                     ],
//                                                   );
//                                                 },
//                                               );
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final categoryNameController = TextEditingController();
  final _categoryViewFormKey = GlobalKey<FormState>();

  final Map<String, String> categoryImages = {
    "Technology": "assets/images/technology.jpg",
    "Grocery": "assets/images/grocery.jpeg",
    "Fashion": "assets/images/fashion.jpg",
    "Books": "assets/images/books.jpg",
    "Fitness": "assets/images/fitness.jpg",
    "Foods": "assets/images/foods.jpg",
    "Vechicles": "assets/images/fashion.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF8E2DE2),
                Color(0xFFEC008C),
              ], // 🌟 Gradient
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            title: const Text(
              'Categories',
              style: TextStyle(
                color: Colors.white, // Ensure text is visible on gradient
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent, // Make AppBar transparent
            elevation: 0, // Remove shadow
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 100), // Space for AppBar transparency
              Form(
                key: _categoryViewFormKey,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 25, 25, 26),
                        Color.fromARGB(255, 17, 17, 17),
                      ], // 🌟 Gradient
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: categoryNameController,
                    decoration: InputDecoration(
                      labelText: 'Category Name',
                      filled: true,
                      fillColor:
                          Colors.transparent, // Make the field transparent
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.category, color: Colors.white),
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter category name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Add Button with Glassmorphism Effect
              ElevatedButton(
                onPressed: () {
                  if (_categoryViewFormKey.currentState!.validate()) {
                    context.read<CategoryBloc>().add(
                          AddCategory(
                            categoryNameController.text,
                            onSuccess: (message) => showMySnackBar(
                              context: context,
                              message: message,
                            ),
                          ),
                        );
                    categoryNameController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Changed button color
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 26),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Category Grid
              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state.error != null) {
                      return Center(
                        child: Text(
                          'Error: ${state.error!}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    } else if (state.categories.isEmpty) {
                      return const Center(
                        child: Text(
                          'No Categories Added Yet',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Two columns
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          String categoryName = category.name;
                          String categoryImage = categoryImages[categoryName] ??
                              "assets/images/default.png";

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1), // Lighter shadow
                                  blurRadius: 5,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Stack(
                                children: [
                                  Image.asset(
                                    categoryImage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      color: Colors.grey.shade300,
                                      child: const Center(
                                        child: Icon(Icons.image_not_supported,
                                            size: 50, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.6),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            categoryName,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete,
                                                color: Colors.redAccent),
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context2) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Delete Category'),
                                                    content: Text(
                                                        'Are you sure you want to delete $categoryName?'),
                                                    actions: [
                                                      TextButton(
                                                        child: const Text(
                                                            'Cancel'),
                                                        onPressed: () {
                                                          Navigator.of(context2)
                                                              .pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent)),
                                                        onPressed: () {
                                                          context
                                                              .read<
                                                                  CategoryBloc>()
                                                              .add(
                                                                DeleteCategory(
                                                                  category
                                                                      .categoryId!,
                                                                  onSuccess:
                                                                      (message) =>
                                                                          showMySnackBar(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        message,
                                                                  ),
                                                                ),
                                                              );
                                                          Navigator.of(context2)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
