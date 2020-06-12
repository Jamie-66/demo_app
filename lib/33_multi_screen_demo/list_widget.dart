import 'package:flutter/material.dart';

typedef Null ItemSelectedCallback(int value);

class ListWidget extends StatefulWidget {
  final ItemSelectedCallback onItemSelected;
  ListWidget(this.onItemSelected);

  @override
  State<StatefulWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, position) {
          return ListTile(
            title: Text(position.toString()),
            onTap: () => widget.onItemSelected(position),
          );
        }
    );
  }
}
