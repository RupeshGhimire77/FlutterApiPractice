import 'package:flutter/material.dart';
import 'package:intern_practice/Get/provider/get_api_provider.dart';
import 'package:intern_practice/Post/provider/product_provider.dart';
import 'package:intern_practice/Get/view/get_api.dart';
import 'package:intern_practice/Post/view/post_api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<GetApiProvider>(
          create: (context) => GetApiProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PostApi(),
      ),
    );
  }
}
