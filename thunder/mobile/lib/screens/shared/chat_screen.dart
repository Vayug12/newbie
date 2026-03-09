import "package:flutter/material.dart";

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: const [
              Align(alignment: Alignment.centerLeft, child: Card(child: Padding(padding: EdgeInsets.all(8), child: Text("Vendor: I am on the way")))),
              Align(alignment: Alignment.centerRight, child: Card(child: Padding(padding: EdgeInsets.all(8), child: Text("Customer: Great, thanks"))))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              const Expanded(child: TextField(decoration: InputDecoration(hintText: "Type message"))),
              IconButton(onPressed: () {}, icon: const Icon(Icons.send))
            ],
          ),
        )
      ],
    );
  }
}
