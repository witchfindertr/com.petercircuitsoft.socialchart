import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenNotice extends StatelessWidget {
  const ScreenNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notice Screen")),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text("B"),
                ),
                title: Text("Title"),
                subtitle: Text("subtitle"),
                onTap: () => {print("pressed")},
              ),
            );
          },
        ),
      ),
    );
  }
}
