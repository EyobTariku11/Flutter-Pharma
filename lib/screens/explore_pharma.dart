import 'package:flutter/material.dart';

class PharmaList extends StatefulWidget {
  const PharmaList({super.key});

  @override
  State<PharmaList> createState() => _PharmaListState();
}

class _PharmaListState extends State<PharmaList> {
  int currentPage = 1;
  final int itemsPerPage = 10;

  final List<String> pharmacies = [
    "Bethelmed Pharmacy",
    "Sina Pharmacy",
    "Addis Pharma",
    "Hager Pharmacy",
    "Zenbaba Pharmacy",
    "Glory Pharmacy",
    "St. Paul Pharmacy",
    "Gondar Pharmacy",
    "Tsedey Pharmacy",
    "Meklit Pharmacy",
    "Rosetta Pharmacy",
    "LifeCare Pharmacy",
    "Kidus Pharmacy",
    "Abebech Pharmacy",
    "New Hope Pharmacy",
    "Medical Plus Pharmacy",
    "Ararat Pharmacy",
    "Tana Pharmacy",
  ];

  @override
  Widget build(BuildContext context) {
    final totalPages = (pharmacies.length / itemsPerPage).ceil();
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage < pharmacies.length)
        ? start + itemsPerPage
        : pharmacies.length;

    final currentItems = pharmacies.sublist(start, end);

    return Scaffold(
      backgroundColor: Colors.white,

      // AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false, // REMOVE BACK BUTTON
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 40, // slightly smaller height
        title: const Text(
          "Available Pharmacies",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10), // moved up
              itemCount: currentItems.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showDetails(context, currentItems[index]),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.07),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Color(0xFF1F8C4D),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.local_pharmacy,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentItems[index],
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Addis Ababa, Ethiopia",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.black54,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),

                        const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Modern Pagination
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // PREVIOUS
                ElevatedButton(
                  onPressed: currentPage > 1
                      ? () => setState(() => currentPage--)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F8C4D),
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Previous",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                // PAGE NUMBER
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "$currentPage / $totalPages",
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(width: 15),

                // NEXT
                ElevatedButton(
                  onPressed: currentPage < totalPages
                      ? () => setState(() => currentPage++)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F8C4D),
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // MODERN CENTERED DETAILS POPUP
  void _showDetails(BuildContext context, String name) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) {
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.local_pharmacy,
                  color: Color(0xFF1F8C4D),
                  size: 50,
                ),
                const SizedBox(height: 16),

                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F8C4D),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  "📍 Address: Addis Ababa, Ethiopia",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                ),
                const SizedBox(height: 6),

                const Text(
                  "📞 Phone: +251 911 234 567",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                ),
                const SizedBox(height: 6),

                const Text(
                  "🕒 Working Hours: 8:00 AM – 10:00 PM",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 16),
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
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
