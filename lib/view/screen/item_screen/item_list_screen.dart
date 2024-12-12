import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pt_pari_app/view/screen/item_screen/item_detail_screen.dart';
import 'package:test_pt_pari_app/view/screen/item_screen/widgets/add_item_screen.dart';
import 'package:test_pt_pari_app/view_model/item_view_model.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: itemViewModel.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: itemViewModel.items.length,
            itemBuilder: (context, index) {
              final item = itemViewModel.items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.data?.toString() ?? 'No Data'),
                onTap: () => _showItemDetails(context, item.id!),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateItemForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showItemDetails(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ItemDetailsScreen(id: id),
      ),
    );
  }

  void _showCreateItemForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const AddItemScreen(),
      ),
    );
  }
}
