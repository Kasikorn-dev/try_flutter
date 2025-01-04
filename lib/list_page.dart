import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              Navigator.pop(context, items[index]); // ส่งข้อมูลกลับ
            },
          );
        },
      ),
    );
  }
}
