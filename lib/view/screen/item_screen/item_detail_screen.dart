import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pt_pari_app/view_model/item_view_model.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String id;
  const ItemDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final itemViewModel = Provider.of<ItemViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Item Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: FutureBuilder(
        future: itemViewModel.fetchItemById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final item = itemViewModel.selectedItem;
          if (item == null) {
            return const Center(child: Text('Barang tidak ditemukan.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${item.name}',
                    style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Data: ${item.data?.toString() ?? 'No Data'}'),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _deleteItem(context, item.id!),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete Item'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _deleteItem(BuildContext context, String id) async {
    final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
    await itemViewModel.deleteItem(id);
    Navigator.pop(context);
  }
}
