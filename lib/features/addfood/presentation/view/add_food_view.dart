import 'package:flaviourfleet/features/addfood/data/dto/add_food_dto.dart';
import 'package:flaviourfleet/features/addfood/data/model/add_food_model.dart';
import 'package:flaviourfleet/features/addfood/presentation/state/add_food_state.dart';
import 'package:flaviourfleet/features/addfood/presentation/viewmodel/add_food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PostProductView extends ConsumerStatefulWidget {
  const PostProductView({super.key});

  @override
  ConsumerState<PostProductView> createState() => _PostProductViewState();
}

class _PostProductViewState extends ConsumerState<PostProductView> {
  final ValueNotifier<File?> imageNotifier = ValueNotifier<File?>(null);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedCategory;

  Future<void> pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageNotifier.value = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No image selected')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProductViewModel =
        ref.read(postProductViewModelProvider.notifier);
    final postProductState = ref.watch(postProductViewModelProvider);

    ref.listen<PostProductState>(postProductViewModelProvider,
        (previous, next) {
      if (next.isPostSuccess == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Your Food has been added successfully')),
        );
      } else if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add food: ${next.error}')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Own Food'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.zero, // Remove extra padding
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Food Name*',
                        labelStyle: TextStyle(color: Colors.orange),
                        hintText: 'Example: Momo',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.orange[50],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: double.infinity,
                        height: 150.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.orange[50],
                        ),
                        child: ValueListenableBuilder<File?>(
                          valueListenable: imageNotifier,
                          builder: (context, image, child) {
                            return image == null
                                ? const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add,
                                          size: 50.0, color: Colors.orange),
                                      Text('Upload Image',
                                          style:
                                              TextStyle(color: Colors.orange)),
                                    ],
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 150.0,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Cuisine Type*',
                        labelStyle: TextStyle(color: Colors.orange),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.orange[50],
                      ),
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem(
                            value: 'Nepali', child: Text('Nepali')),
                        DropdownMenuItem(
                            value: 'Indian', child: Text('Indian')),
                        DropdownMenuItem(
                            value: 'Chinese', child: Text('Chinese')),
                        DropdownMenuItem(
                            value: 'Korean', child: Text('Korean')),
                      ],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCategory = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                        labelText: 'Price*',
                        labelStyle: TextStyle(color: Colors.orange),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.orange[50],
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        labelText: 'Location Details*',
                        labelStyle: TextStyle(color: Colors.orange),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.orange[50],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Description*',
                        labelStyle: TextStyle(color: Colors.orange),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.orange[50],
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Button color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () async {
                        final title = titleController.text;
                        final price = double.tryParse(priceController.text);
                        final location = locationController.text;
                        final description = descriptionController.text;
                        final image = imageNotifier.value;

                        if (title.isEmpty ||
                            price == null ||
                            selectedCategory == null ||
                            location.isEmpty ||
                            description.isEmpty ||
                            image == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please fill all fields')),
                          );
                          return;
                        }

                        final postDTO = PostProductDTO(
                          product: PostProductModel(
                            productId: '', // will be generated by the backend
                            productTitle: title,
                            productDescription: description,
                            productCategory: selectedCategory!,
                            productPrice: price,
                            productLocation: location,
                            productImage: image
                                .path, // Assuming backend handles image uploads
                            createdBy:
                                '', // This will be updated in the ViewModel
                          ),
                        );

                        await postProductViewModel.postProduct(postDTO, image);
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
