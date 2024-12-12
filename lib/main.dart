import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pt_pari_app/view/screen/item_screen/item_list_screen.dart';
import 'package:test_pt_pari_app/view_model/item_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter CRUD PT PARI',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ItemListScreen(),
      ),
    );
  }
}
