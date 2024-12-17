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
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "Enter the Details For the Product.",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Category ID",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            productProvider.setCategoryId(
                                value); // Pass the string directly
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: titleStr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: priceStr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: descriptionStr,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5))),
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
                        SizedBox(
                          height: 15,
                        ),

                        TextFormField(
                          controller: _imageController,
                          decoration: InputDecoration(
                            labelText: "Image URL",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please Enter an Image URL";
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Add the image URL to the list
                            if (_imageController.text.isNotEmpty) {
                              productProvider.addImage(_imageController.text);
                              _imageController.clear(); // Clear the text field
                            }
                          },
                          child: Text("Add Image"),
                        ),

                        // Display added images
                        SizedBox(height: 10),
                        Text("Added Images:"),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: productProvider.images?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(productProvider.images![index]),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  productProvider.removeImage(index);
                                },
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              backgroundColor: Colors.teal.withOpacity(0.75),
                              foregroundColor: Colors.white),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await productProvider.postProductData();
                              if (productProvider.postProductStatus ==
                                  StatusUtil.success) {
                                Helper.displaySnackBar(
                                    context, "Successfully Saved");
                              } else if (productProvider.postProductStatus ==
                                  StatusUtil.error) {
                                Helper.displaySnackBar(
                                    context, productProvider.errorMessage!);
                              }
                            }
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
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
}
