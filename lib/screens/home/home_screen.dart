import 'package:customer_display_app/screens/routes/route_names.dart';
import 'package:customer_display_app/widgets/card/home_card_menu_widget.dart';
import 'package:customer_display_app/widgets/text/title_lg_semibold_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(1200, 56),
        child: Align(
          alignment: Alignment.center, // center the AppBar if screen is wider
          child: SizedBox(
            width: 1200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: bgColor, width: 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.stop_outlined,
                            color: bgColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Center(
            child: Container(
              width: 1200,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                // color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  TitleLgSemiboldWidget(text: 'CUSTOMER DISPLAY'),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeCardMenuWidget(
                        icon: Icons.shopping_cart_outlined,
                        title: 'LIVE CART',
                        iconColor: Theme.of(
                          context,
                        ).colorScheme.inversePrimary, // Green accent
                        actionText: 'View Order',
                        actionDesc: 'View your real-time cart',
                        onTap: () {
                          GoRouter.of(context).go(RouteNames.orderPath);
                        },
                      ),
                      const SizedBox(width: 30),

                      // 2. DISCOUNT Menu Card
                      HomeCardMenuWidget(
                        icon: Icons.local_offer_outlined,
                        title: 'DISCOUNT',
                        iconColor: const Color(0xFFFF9800), // Orange accent
                        actionText: 'See Deals',
                        actionDesc: 'Teg for daily specials',
                        onTap: () {
                          // Navigate to Discount Slideshow screen
                        },
                      ),
                      const SizedBox(width: 30),

                      // 3. NEW ITEMS / SLIDESHOW Menu Card
                      HomeCardMenuWidget(
                        icon: Icons.new_releases_outlined,
                        title: 'NEW ARRIVALS',
                        iconColor: const Color(0xFF2196F3),
                        actionDesc: 'Explore the latest products',
                        actionText: 'Browse Now',
                        onTap: () {
                          // Navigate to New Items Slideshow screen
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
