import 'package:flutter/material.dart';

class PharmaList extends StatelessWidget {
  const PharmaList({super.key});

  @override
  Widget build(BuildContext context) {
    // Example dummy data
    final pharmacies = [
      "Pharmacy A",
      "Pharmacy B",
      "Pharmacy C",
      "Pharmacy D",
    ];

    return ListView.builder(
      itemCount: pharmacies.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.local_pharmacy, color: Color(0xFF1F8C4D)),
            title: Text(pharmacies[index]),
            subtitle: const Text("Address: Addis Ababa, Ethiopia"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // TODO: Navigate to pharmacy details
            },
          ),
        );
      },
    );
  }
}
