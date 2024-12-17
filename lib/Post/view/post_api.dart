import 'package:flutter/material.dart';
import 'package:intern_practice/Post/core/helper.dart';
import 'package:intern_practice/Post/core/status_util.dart';
import 'package:intern_practice/Post/core/string_const.dart';
import 'package:intern_practice/Post/provider/product_provider.dart';
import 'package:provider/provider.dart';

class PostApi extends StatelessWidget {
  PostApi({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Product"),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: "Category ID"),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      productProvider
                          .setCategoryId(value); // Pass the string directly
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter a Category ID";
                      }
                      if (int.tryParse(value) == null) {
                        return "Please Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: titleStr),
                    onChanged: (value) {
                      productProvider.setTitle(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter a Title";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: priceStr),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      productProvider
                          .setPrice(value); // Pass the string directly
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter a Price";
                      }
                      if (int.tryParse(value) == null) {
                        return "Please Enter a valid number";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: descriptionStr),
                    onChanged: (value) {
                      productProvider.setDescription(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter a Description";
                      }
                      return null;
                    },
                  ),

                  // TextFormField(
                  //   controller: _imageController,
                  //   decoration: InputDecoration(labelText: "Image URL"),
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Please Enter an Image URL";
                  //     }
                  //     return null;
                  //   },
                  // ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Add the image URL to the list
                  //     productProvider.addImage(_imageController.text);
                  //     _imageController.clear(); // Clear the text field
                  //   },
                  //   child: Text("Add Image"),
                  // ),

                  // Inside ListView.builder for displaying images
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: productProvider.images?.length,
                  //   itemBuilder: (context, index) {
                  //     return ListTile(
                  //       title: Text(productProvider.images?[index] ?? "NA"),
                  //       trailing: IconButton(
                  //         icon: Icon(Icons.delete),
                  //         onPressed: () {
                  //           productProvider.removeImage(
                  //               index); // Remove image functionality
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await productProvider.postProductData();
                        if (productProvider.postProductStatus ==
                            StatusUtil.success) {
                          Helper.displaySnackBar(context, "Successfully Saved");
                        } else if (productProvider.postProductStatus ==
                            StatusUtil.error) {
                          Helper.displaySnackBar(
                              context, productProvider.errorMessage!);
                        }
                      }
                    },
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
