import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intern_practice/Get/get_api_provider.dart';
import 'package:intern_practice/Post/core/status_util.dart';
import 'package:provider/provider.dart';

class GetApi extends StatefulWidget {
  const GetApi({super.key});

  @override
  State<GetApi> createState() => _GetApiState();
}

class _GetApiState extends State<GetApi> {
  @override
  void initState() {
    super.initState();
    // _getApi();

    var provider = Provider.of<GetApiProvider>(context, listen: false);
    provider.getApiData();
  }

  // Dio dio = Dio();
  // Response? value;
  // bool isLoading = true;

  final TextStyle titleStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final TextStyle subTitleStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  final TextStyle descStyle = TextStyle(fontSize: 14, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GetApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.teal,
      ),
      body: provider.getApiStatus == StatusUtil.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.getApiStatus == StatusUtil.error
              ? Center(
                  child: Text(provider.errorMessage ?? 'Something went wrong'),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category Section
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Text("Category", style: titleStyle),
                      ),
                      Container(
                        height: 100,
                        padding: const EdgeInsets.only(right: 20),
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 20),
                          itemCount: provider.data.isNotEmpty
                              ? provider.data.length
                              : 0,
                          itemBuilder: (context, index) {
                            final category = provider.data[index]['category'];
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (category['image'] != null)
                                    Image.network(
                                      category['image'],
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    category['name'] ?? 'Unknown Category',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Product Section
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 20),
                        child: Text("Products", style: titleStyle),
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemCount:
                            provider.data.isNotEmpty ? provider.data.length : 0,
                        itemBuilder: (context, index) {
                          final product = provider.data[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage(product['images'][0]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['title'],
                                          style: titleStyle,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "\$${product['price']}",
                                          style: subTitleStyle,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          product['description'],
                                          style: descStyle,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
    );
  }

  // _getApi() async {
  //   try {
  //     Response response = await dio
  //         .get("https://api.escuelajs.co/api/v1/products?limit=10&offset=0");

  //     print(response);
  //     setState(() {
  //       value = response;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print(e);
  //       isLoading = false;
  //     });
  //   }
  // }
}
