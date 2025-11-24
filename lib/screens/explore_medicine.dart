import 'package:flutter/material.dart';

class ExploreMedicine extends StatefulWidget {
  const ExploreMedicine({super.key});

  @override
  State<ExploreMedicine> createState() => _ExploreMedicineState();
}

class _ExploreMedicineState extends State<ExploreMedicine> {
  final TextEditingController _searchController = TextEditingController();

  // Example dummy data with medicines and available pharmacies
  final List<Map<String, dynamic>> _allMedicines = [
    {
      "name": "Paracetamol",
      "icon": Icons.local_hospital,
      "pharmacies": ["Bethelmed Pharmacy", "Sina Pharmacy", "Addis Pharma"]
    },
    {
      "name": "Ibuprofen",
      "icon": Icons.medication,
      "pharmacies": ["Hager Pharmacy", "Zenbaba Pharmacy"]
    },
    {
      "name": "Amoxicillin",
      "icon": Icons.healing,
      "pharmacies": ["Glory Pharmacy", "St. Paul Pharmacy", "Gondar Pharmacy"]
    },
    {
      "name": "Vitamin C",
      "icon": Icons.sanitizer,
      "pharmacies": ["Tsedey Pharmacy", "Meklit Pharmacy"]
    },
    {
      "name": "Aspirin",
      "icon": Icons.bloodtype,
      "pharmacies": ["Rosetta Pharmacy", "LifeCare Pharmacy", "Kidus Pharmacy"]
    },
  ];

  List<Map<String, dynamic>> _filteredMedicines = [];

  @override
  void initState() {
    super.initState();
    _filteredMedicines = _allMedicines;
    _searchController.addListener(_filterMedicines);
  }

  void _filterMedicines() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMedicines = _allMedicines
          .where((medicine) =>
              (medicine["name"] as String).toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: "Search medicines...",
              prefixIcon: const Icon(Icons.search, color: Color(0xFF1F8C4D)),
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Medicine Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 2.5,
            ),
            itemCount: _filteredMedicines.length,
            itemBuilder: (context, index) {
              final medicine = _filteredMedicines[index];
              return InkWell(
                onTap: () {
                  _showPharmaciesDialog(
                    context,
                    medicine["name"] as String,
                    medicine["pharmacies"] as List<String>,
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1F8C4D),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          medicine["icon"] as IconData,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        medicine["name"] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F8C4D),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Popup showing pharmacies
  void _showPharmaciesDialog(
      BuildContext context, String medicineName, List<String> pharmacies) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_pharmacy,
                    size: 50,
                    color: Color(0xFF1F8C4D),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    medicineName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F8C4D),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Available at:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: pharmacies
                        .map(
                          (pharmacy) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                    color: Color(0xFF1F8C4D), size: 20),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    pharmacy,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F8C4D),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
