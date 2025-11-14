import 'package:flutter/material.dart';

class ExploreMedicine extends StatelessWidget {
  const ExploreMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    // Example dummy data
    final medicines = [
      "Paracetamol",
      "Ibuprofen",
      "Amoxicillin",
      "Vitamin C",
      "Aspirin",
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 3 / 2,
      ),
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: InkWell(
            onTap: () {
              // TODO: Show medicine details
            },
            borderRadius: BorderRadius.circular(12),
            child: Center(
              child: Text(
                medicines[index],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F8C4D),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
