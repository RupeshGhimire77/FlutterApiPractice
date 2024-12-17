import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intern_practice/Get/provider/get_api_provider.dart';
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
                        height: 130,
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
                            return Card(
                              elevation:
                                  8, // Increased elevation for a more pronounced shadow
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                width: 100, // Fixed width for uniformity
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.teal.shade200,
                                      Colors.teal.shade100
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (category['image'] != null)
                                      ClipOval(
                                        // Making the image circular
                                        child: Image.network(
                                          category['image'],
                                          height: 75,
                                          width: 75,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0), // Added padding
                                      child: Text(
                                        category['name'] ?? 'Unknown Category',
                                        textAlign:
                                            TextAlign.center, // Centered text
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              14, // Increased font size for better readability
                                          color: Colors
                                              .black87, // Changed text color for better contrast
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.teal.shade200,
                                  Colors.teal.shade100,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                  12), // Match the card's border radius
                            ),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: AutoSlidingCarousel(
                                        images: List<String>.from(
                                            product['images']),
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
                                    ),
                                  ],
                                ),
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

class AutoSlidingCarousel extends StatefulWidget {
  final List<String> images;
  const AutoSlidingCarousel({Key? key, required this.images}) : super(key: key);

  @override
  State<AutoSlidingCarousel> createState() => _AutoSlidingCarouselState();
}

class _AutoSlidingCarouselState extends State<AutoSlidingCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first image
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              widget.images[index],
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
