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
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _categoryViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: categoryNameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_categoryViewFormKey.currentState!.validate()) {
                    context.read<CategoryBloc>().add(
                          AddCategory(categoryNameController.text),
                        );
                  }
                },
                child: const Text('Add Category'),
              ),
              const SizedBox(height: 10),
              BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                if (state.categories.isEmpty) {
                  return const Center(child: Text('No Categories Added Yet'));
                } else if (state.isLoading) {
                  return const CircularProgressIndicator();
                } else if (state.error != null) {
                  return showMySnackBar(
                    context: context,
                    message: state.error!,
                    color: Colors.red,
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.categories.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Text(state.categories[index].name),
                          subtitle: Text(state.categories[index].categoryId!),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context2) {
                                  return AlertDialog(
                                    title: const Text('Delete Category'),
                                    content: Text(
                                        'Are you sure you want to delete ${state.categories[index].name} category?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          context.read<CategoryBloc>().add(
                                                DeleteCategory(
                                                  state.categories[index]
                                                      .categoryId!,
                                                ),
                                              );

                                          Navigator.of(context).pop();
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
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
