// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';

// class CategoryView extends StatelessWidget {
//   CategoryView({super.key});

//   final categoryNameController = TextEditingController();
//   final _categoryViewFormKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Categories',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xFF8E2DE2), // Purple Shade
//                 Color(0xFFEC008C), // Pink Shade
//               ],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//       ),
//       body: Container(
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
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _categoryViewFormKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // 🌟 Category Input Field
//                 TextFormField(
//                   controller: categoryNameController,
//                   decoration: InputDecoration(
//                     labelText: 'Category Name',
//                     filled: true,
//                     fillColor: Colors.white.withOpacity(0.2),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
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
//                 const SizedBox(height: 16),

//                 // ✅ Add Category Button
//                 ElevatedButton(
//                   onPressed: () {
//                     if (_categoryViewFormKey.currentState!.validate()) {
//                       context.read<CategoryBloc>().add(
//                             AddCategory(categoryNameController.text),
//                           );
//                       categoryNameController.clear(); // Clear input
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white.withOpacity(0.2),
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text('Add Category'),
//                 ),
//                 const SizedBox(height: 16),

//                 // 🔄 Category List
//                 Expanded(
//                   child: BlocBuilder<CategoryBloc, CategoryState>(
//                     builder: (context, state) {
//                       if (state.isLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       } else if (state.error != null) {
//                         return Center(
//                             child: Text('Error: ${state.error!}',
//                                 style: const TextStyle(color: Colors.white)));
//                       } else if (state.categories.isEmpty) {
//                         return const Center(
//                             child: Text('No Categories Added Yet',
//                                 style: TextStyle(color: Colors.white)));
//                       } else {
//                         return ListView.separated(
//                           itemCount: state.categories.length,
//                           separatorBuilder: (context, index) =>
//                               Divider(color: Colors.white.withOpacity(0.3)),
//                           itemBuilder: (BuildContext context, index) {
//                             return ListTile(
//                               leading: const Icon(Icons.category,
//                                   color: Colors.white),
//                               title: Text(state.categories[index].name,
//                                   style: const TextStyle(color: Colors.white)),
//                               trailing: IconButton(
//                                 icon: const Icon(Icons.delete,
//                                     color: Colors.redAccent),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context2) {
//                                       return AlertDialog(
//                                         title: const Text('Delete Category'),
//                                         content: Text(
//                                             'Are you sure you want to delete ${state.categories[index].name}?'),
//                                         actions: [
//                                           TextButton(
//                                             child: const Text('Cancel'),
//                                             onPressed: () {
//                                               Navigator.of(context2).pop();
//                                             },
//                                           ),
//                                           TextButton(
//                                             child: const Text('Delete',
//                                                 style: TextStyle(
//                                                     color: Colors.redAccent)),
//                                             onPressed: () {
//                                               context.read<CategoryBloc>().add(
//                                                     DeleteCategory(
//                                                       state.categories[index]
//                                                           .categoryId!,
//                                                     ),
//                                                   );
//                                               Navigator.of(context2).pop();
//                                             },
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     },
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:koselie/core/common/snackbar/snackbar.dart';
import 'package:koselie/features/category/presentation/view_model/category_bloc.dart';

class CategoryView extends StatelessWidget {
  CategoryView({super.key});

  final categoryNameController = TextEditingController();
  final _categoryViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
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
        ),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _categoryViewFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 🌟 Category Input Field
                TextFormField(
                  controller: categoryNameController,
                  decoration: InputDecoration(
                    labelText: 'Category Name',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(Icons.category, color: Colors.white),
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
                const SizedBox(height: 16),

                // ✅ Add Category Button
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
                      categoryNameController.clear(); // Clear input
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Add Category'),
                ),
                const SizedBox(height: 16),

                // 🔄 Category List
                Expanded(
                  child: BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.error != null) {
                        return Center(
                            child: Text('Error: ${state.error!}',
                                style: const TextStyle(color: Colors.white)));
                      } else if (state.categories.isEmpty) {
                        return const Center(
                            child: Text('No Categories Added Yet',
                                style: TextStyle(color: Colors.white)));
                      } else {
                        return ListView.separated(
                          itemCount: state.categories.length,
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.white.withOpacity(0.3)),
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              leading: const Icon(Icons.category,
                                  color: Colors.white),
                              title: Text(state.categories[index].name,
                                  style: const TextStyle(color: Colors.white)),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context2) {
                                      return AlertDialog(
                                        title: const Text('Delete Category'),
                                        content: Text(
                                            'Are you sure you want to delete ${state.categories[index].name}?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context2).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('Delete',
                                                style: TextStyle(
                                                    color: Colors.redAccent)),
                                            onPressed: () {
                                              context.read<CategoryBloc>().add(
                                                    DeleteCategory(
                                                      state.categories[index]
                                                          .categoryId!,
                                                      onSuccess: (message) =>
                                                          showMySnackBar(
                                                        context: context,
                                                        message: message,
                                                      ),
                                                    ),
                                                  );
                                              Navigator.of(context2).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
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
      ),
    );
  }
}
