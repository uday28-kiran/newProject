import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../globalfunction/textwidget.dart';
import '../providers/addproviders.dart';
import 'components/additemscreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        centerTitle: true,
        title: const TextWidget(
          text: 'Item List',
          fontSize: 20, 
          fontWeight: FontWeight.bold,
        ),
      ),
      body: itemProvider.items.isEmpty
          ? const Center(
              child: TextWidget(
                text: 'No items added yet.',
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            )
          : ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              // padding: EdgeInsets.symmetric(horizontal: 0.5.w, vertical: 0.5.h),
              itemCount: itemProvider.items.length,
              itemBuilder: (context, index) {
                final item = itemProvider.items[index];
                return Card(
                  elevation: 1,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 3.w),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListTile(
                      title: TextWidget(
                        text: item['name'] ?? '',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: TextWidget(
                        text: item['description'] ?? '',
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .blue.shade50, 
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddItemScreen(
                                      isEditing: true,
                                      itemIndex: index,
                                      initialData: item,
                                    ),
                                  ),
                                );
                              },
                              iconSize: 24.0,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              splashRadius: 20.0,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Container(
                             width: 40.0,
                            height: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors
                                  .red.shade50, 
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                itemProvider.deleteItem(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Item deleted successfully',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddItemScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
