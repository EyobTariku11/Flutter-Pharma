import 'package:flutter/material.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen>
    with SingleTickerProviderStateMixin {
  bool sidebarClosed = true;
  String activePage = 'customerlist';
  String userFullName = 'John Doe';

  late final AnimationController _controller;
  late final Animation<double> _sidebarAnimation;

  final double sidebarWidthDesktop = 250;
  final double sidebarWidthMobile = 180;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sidebarAnimation =
        Tween<double>(begin: -sidebarWidthMobile, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void toggleSidebar() {
    setState(() {
      sidebarClosed = !sidebarClosed;
      if (!sidebarClosed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 900;

    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              // Sidebar for desktop
              if (!isMobile)
                Container(
                  width: sidebarWidthDesktop,
                  color: const Color(0xFF1F8C4D),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 180,
                          height: 100,
                        ),
                      ),
                      _sidebarItem(
                        icon: Icons.local_pharmacy,
                        label: "Pharmacies",
                        selected: activePage == 'customerlist',
                        iconSize: 22,
                        fontSize: 14,
                        onTap: () {
                          setState(() {
                            activePage = 'customerlist';
                          });
                        },
                      ),
                      _sidebarItem(
                        icon: Icons.shopping_cart,
                        label: "Explore Medicine",
                        selected: activePage == 'explore-medicine',
                        iconSize: 22,
                        fontSize: 14,
                        onTap: () {
                          setState(() {
                            activePage = 'explore-medicine';
                          });
                        },
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "All rights reserved © Daf Tech 2025",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

              // Main content
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(
                      left: !isMobile
                          ? 0
                          : sidebarClosed
                              ? 0
                              : sidebarWidthMobile),
                  child: Column(
                    children: [
                      // Top bar
                      Container(
                        height: 60,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Hamburger/X menu for mobile
                            if (isMobile)
                              GestureDetector(
                                onTap: toggleSidebar,
                                child: Container(
                                  padding: const EdgeInsets.all(12), // tap area
                                  color: Colors.transparent,
                                  child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, child) {
                                      return SizedBox(
                                        width: 24, // smaller width
                                        height: 20, // smaller height
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Transform.rotate(
                                              angle: _controller.value * 0.7854,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  height: 2, // thinner line
                                                  width: 20, // shorter line
                                                  color: const Color(0xFF1F8C4D),
                                                ),
                                              ),
                                            ),
                                            Opacity(
                                              opacity: 1 - _controller.value,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  height: 2,
                                                  width: 20,
                                                  color: const Color(0xFF1F8C4D),
                                                ),
                                              ),
                                            ),
                                            Transform.rotate(
                                              angle: -_controller.value * 0.7854,
                                              child: Align(
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  height: 2,
                                                  width: 20,
                                                  color: const Color(0xFF1F8C4D),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            const SizedBox(width: 10),
                            // Welcome + logout
                            Row(
                              children: [
                                Text(
                                  "Welcome, $userFullName",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.logout,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Content area
                      Expanded(
                        child: Container(
                          color: const Color(0xFFF5F5F5),
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              activePage == 'customerlist'
                                  ? "Pharmacies Page"
                                  : "Explore Medicine Page",
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Sidebar overlay for mobile
          if (isMobile)
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.translate(
                  offset: Offset(_sidebarAnimation.value, 0),
                  child: child,
                );
              },
              child: SizedBox(
                width: sidebarWidthMobile,
                child: Material(
                  color: const Color(0xFF1F8C4D),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 120,
                            height: 70,
                          ),
                        ),
                        _sidebarItem(
                          icon: Icons.local_pharmacy,
                          label: "Pharmacies",
                          selected: activePage == 'customerlist',
                          iconSize: 20,
                          fontSize: 13,
                          onTap: () {
                            setState(() {
                              activePage = 'customerlist';
                              toggleSidebar();
                            });
                          },
                        ),
                        _sidebarItem(
                          icon: Icons.shopping_cart,
                          label: "Explore Medicine",
                          selected: activePage == 'explore-medicine',
                          iconSize: 20,
                          fontSize: 13,
                          onTap: () {
                            setState(() {
                              activePage = 'explore-medicine';
                              toggleSidebar();
                            });
                          },
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "All rights reserved © Daf Tech 2025",
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _sidebarItem({
    required IconData icon,
    required String label,
    required bool selected,
    double iconSize = 24,
    double fontSize = 16,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: fontSize / 1.5, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: iconSize),
            const SizedBox(width: 12),
            Flexible(
              child: Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: fontSize),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
