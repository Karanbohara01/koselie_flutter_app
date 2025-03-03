// //

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/core/common/snackbar/snackbar.dart';
// import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
// import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

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
//     "Vehicles": "assets/images/fashion.jpg", // Corrected typo
//   };

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeBloc, ThemeState>(
//       builder: (context, themeState) {
//         final isDarkMode = themeState is DarkThemeState;

//         // Define colors based on theme
//         final backgroundColor = isDarkMode ? Colors.black87 : Colors.white;
//         final textColor = isDarkMode ? Colors.white : Colors.black;
//         final appBarGradient = isDarkMode
//             ? [Colors.black87, Colors.black54]
//             : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
//         final buttonColor = isDarkMode ? Colors.grey[800]! : Colors.black;
//         const buttonTextColor = Colors.white;
//         final textFieldFillColor = isDarkMode
//             ? Colors.black54
//             : Colors.transparent; // Adjust as needed

//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(kToolbarHeight),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: appBarGradient,
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: AppBar(
//                 title: const Text(
//                   'Categories',
//                   style: TextStyle(
//                     color: Colors.white, // Ensure text is visible on gradient
//                     fontWeight: FontWeight.bold,
//                     fontSize: 22,
//                   ),
//                 ),
//                 centerTitle: true,
//                 backgroundColor: Colors.transparent, // Make AppBar transparent
//                 elevation: 0, // Remove shadow
//               ),
//             ),
//           ),
//           body: Container(
//             color: backgroundColor, // Set background color to theme-based
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Column(
//                 children: [
//                   const SizedBox(height: 100), // Space for AppBar transparency
//                   Form(
//                     key: _categoryViewFormKey,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: isDarkMode
//                               ? [
//                                   Colors.grey[800]!,
//                                   Colors.grey[850]!
//                                 ] //Darkmode textfield gradient
//                               : [
//                                   const Color.fromARGB(255, 25, 25, 26),
//                                   const Color.fromARGB(255, 17, 17, 17),
//                                 ],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: TextFormField(
//                         controller: categoryNameController,
//                         decoration: InputDecoration(
//                           labelText: 'Category Name',
//                           filled: true,
//                           fillColor:
//                               textFieldFillColor, // Make the field transparent
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide.none,
//                           ),
//                           prefixIcon:
//                               const Icon(Icons.category, color: Colors.white),
//                           labelStyle: const TextStyle(color: Colors.white),
//                         ),
//                         style: const TextStyle(color: Colors.white),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter category name';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Add Button with Glassmorphism Effect
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_categoryViewFormKey.currentState!.validate()) {
//                         context.read<CategoryBloc>().add(
//                               AddCategory(
//                                 categoryNameController.text,
//                                 onSuccess: (message) => showMySnackBar(
//                                   context: context,
//                                   message: message,
//                                 ),
//                               ),
//                             );
//                         categoryNameController.clear();
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: buttonColor, // Changed button color
//                       foregroundColor: buttonTextColor,
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 16, horizontal: 26),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: const Text(
//                       'Add Category',
//                       style:
//                           TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Category Grid
//                   Expanded(
//                     child: BlocBuilder<CategoryBloc, CategoryState>(
//                       builder: (context, state) {
//                         if (state.isLoading) {
//                           return const Center(
//                               child: CircularProgressIndicator(
//                             color: buttonTextColor,
//                           ));
//                         } else if (state.error != null) {
//                           return Center(
//                             child: Text(
//                               'Error: ${state.error!}',
//                               style: TextStyle(color: textColor),
//                             ),
//                           );
//                         } else if (state.categories.isEmpty) {
//                           return Center(
//                             child: Text(
//                               'No Categories Added Yet',
//                               style: TextStyle(color: textColor),
//                             ),
//                           );
//                         } else {
//                           return GridView.builder(
//                             gridDelegate:
//                                 const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2, // Two columns
//                               crossAxisSpacing: 15,
//                               mainAxisSpacing: 15,
//                               childAspectRatio: 0.85,
//                             ),
//                             itemCount: state.categories.length,
//                             itemBuilder: (context, index) {
//                               final category = state.categories[index];
//                               String categoryName = category.name;
//                               String categoryImage =
//                                   categoryImages[categoryName] ??
//                                       "assets/images/default.png";

//                               return Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.1),
//                                       blurRadius: 5,
//                                       offset: const Offset(2, 4),
//                                     ),
//                                   ],
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(15),
//                                   child: Stack(
//                                     children: [
//                                       Image.asset(
//                                         categoryImage,
//                                         fit: BoxFit.cover,
//                                         width: double.infinity,
//                                         height: double.infinity,
//                                         errorBuilder:
//                                             (context, error, stackTrace) =>
//                                                 Container(
//                                           color: Colors.grey.shade300,
//                                           child: const Center(
//                                             child: Icon(
//                                                 Icons.image_not_supported,
//                                                 size: 50,
//                                                 color: Colors.grey),
//                                           ),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         bottom: 0,
//                                         left: 0,
//                                         right: 0,
//                                         child: Container(
//                                           padding: const EdgeInsets.all(10),
//                                           decoration: BoxDecoration(
//                                             color:
//                                                 Colors.black.withOpacity(0.6),
//                                             borderRadius:
//                                                 const BorderRadius.only(
//                                               bottomLeft: Radius.circular(15),
//                                               bottomRight: Radius.circular(15),
//                                             ),
//                                           ),
//                                           child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 categoryName,
//                                                 style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                               IconButton(
//                                                 icon: const Icon(Icons.delete,
//                                                     color: Colors.redAccent),
//                                                 onPressed: () {
//                                                   showDialog(
//                                                     context: context,
//                                                     builder: (BuildContext
//                                                         context2) {
//                                                       return AlertDialog(
//                                                         backgroundColor:
//                                                             backgroundColor,
//                                                         title: Text(
//                                                           'Delete Category',
//                                                           style: TextStyle(
//                                                               color: textColor),
//                                                         ),
//                                                         content: Text(
//                                                           'Are you sure you want to delete $categoryName?',
//                                                           style: TextStyle(
//                                                               color: textColor),
//                                                         ),
//                                                         actions: [
//                                                           TextButton(
//                                                             child: const Text(
//                                                               'Cancel',
//                                                               style: TextStyle(
//                                                                   color: Colors
//                                                                       .blueAccent),
//                                                             ),
//                                                             onPressed: () {
//                                                               Navigator.of(
//                                                                       context2)
//                                                                   .pop();
//                                                             },
//                                                           ),
//                                                           TextButton(
//                                                             child: const Text(
//                                                                 'Delete',
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .redAccent)),
//                                                             onPressed: () {
//                                                               context
//                                                                   .read<
//                                                                       CategoryBloc>()
//                                                                   .add(
//                                                                     DeleteCategory(
//                                                                       category
//                                                                           .categoryId!,
//                                                                       onSuccess:
//                                                                           (message) =>
//                                                                               showMySnackBar(
//                                                                         context:
//                                                                             context,
//                                                                         message:
//                                                                             message,
//                                                                       ),
//                                                                     ),
//                                                                   );
//                                                               Navigator.of(
//                                                                       context2)
//                                                                   .pop();
//                                                             },
//                                                           ),
//                                                         ],
//                                                       );
//                                                     },
//                                                   );
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_bloc.dart';
import 'package:koselie/features/theme/presentation/bloc/theme_state.dart';

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
    "Vehicles": "assets/images/fashion.jpg", // Corrected typo
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is DarkThemeState;

        // Define colors based on theme
        final backgroundColor = isDarkMode ? Colors.black : Colors.grey[100]!;
        final textColor = isDarkMode ? Colors.white : Colors.black87;
        final appBarGradient = isDarkMode
            ? [Colors.black, Colors.black]
            : [const Color(0xFF8E2DE2), const Color(0xFFEC008C)];
        final buttonColor = isDarkMode ? Colors.purple[700]! : Colors.black;
        const buttonTextColor = Colors.white;
        final textFieldFillColor = isDarkMode ? Colors.black : Colors.white;
        final hintTextColor =
            isDarkMode ? Colors.grey[600]! : Colors.grey[400]!;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(
              'Categories',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Form(
                      key: _categoryViewFormKey,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: textFieldFillColor
                              .withOpacity(0.5), // Add transparency
                        ),
                        child: TextFormField(
                          controller: categoryNameController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: 'Category Name',
                            hintStyle: TextStyle(color: hintTextColor),
                            // prefixIcon: Icon(Icons.category_outlined, color: iconColor),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 18),
                          ),
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
                        backgroundColor:
                            buttonColor.withOpacity(0.8), // Add transparency
                        foregroundColor: buttonTextColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: Text(
                        'Add Category',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Category Grid
                    Expanded(
                      child: BlocBuilder<CategoryBloc, CategoryState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white));
                          } else if (state.error != null) {
                            return Center(
                              child: Text(
                                'Error: ${state.error!}',
                                style: TextStyle(color: textColor),
                              ),
                            );
                          } else if (state.categories.isEmpty) {
                            return Center(
                              child: Text(
                                'No Categories Added Yet',
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic),
                              ),
                            );
                          } else {
                            return GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // Two columns
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.9, // Adjusted aspect ratio
                              ),
                              padding: EdgeInsets.zero, // Remove grid padding
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                final category = state.categories[index];
                                String categoryName = category.name;
                                String categoryImage =
                                    categoryImages[categoryName] ??
                                        "assets/images/default.png";

                                return _buildCategoryCard(
                                    context,
                                    category,
                                    categoryName,
                                    categoryImage,
                                    backgroundColor,
                                    textColor);
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
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, category, String categoryName,
      String categoryImage, Color backgroundColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.1), // Added Glassmorphism
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
            color: Colors.white.withOpacity(0.1), width: 1.5), // Refined border
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.asset(
              categoryImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) => Container(
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoryName,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.redAccent),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context2) {
                            return AlertDialog(
                              backgroundColor: backgroundColor,
                              title: Text(
                                'Delete Category',
                                style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              content: Text(
                                'Are you sure you want to delete $categoryName?',
                                style: GoogleFonts.poppins(color: textColor),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context2).pop(),
                                  child: Text('Cancel',
                                      style: GoogleFonts.poppins(
                                          color: Colors.blueAccent)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<CategoryBloc>().add(
                                          DeleteCategory(
                                            category.categoryId!,
                                            onSuccess: (message) =>
                                                showMySnackBar(
                                              context: context,
                                              message: message,
                                            ),
                                          ),
                                        );
                                    Navigator.of(context2).pop();
                                  },
                                  child: Text('Delete',
                                      style: GoogleFonts.poppins(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
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
  }
}
