import 'package:customer_display_app/screens/auth/login_by_qr_screen.dart';
import 'package:customer_display_app/screens/auth/login_screen.dart';
import 'package:customer_display_app/screens/auth/selected_device_screen.dart';
import 'package:customer_display_app/screens/home/home_screen.dart';
import 'package:customer_display_app/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.loginPATH,
    debugLogDiagnostics: true,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Route not found: ${state.uri.toString()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteNames.loginPATH),
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    ),
    routes: [
      GoRoute(
        path: RouteNames.homePATH,
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      // GoRoute(
      //   path: RouteNames.LIVE_CART_PATH,
      //   name: RouteNames.LIVE_CART,
      //   builder: (_, __) => const LiveCartScreen(),
      // ),
      GoRoute(
        path: RouteNames.loginPATH,
        name: RouteNames.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.loginQrPATH,
        name: RouteNames.loginQr,
        builder: (_, __) => const LoginByQrScreen(),
      ),
      GoRoute(
        path: RouteNames.selectedDevicePATH,
        name: RouteNames.selectedDevice,
        builder: (context, state) => const SelectedDeviceScreen(),
      ),
      GoRoute(
        path: RouteNames.orderPath,
        name: RouteNames.order,
        builder: (context, state) => const OrderScreen(),
      ),

      // GoRoute(
      //   path: RouteNames.STORE,
      //   name: 'store',
      //   builder: (_, __) => const StorePage(),
      //   routes: [
      //     GoRoute(
      //       path: ':id',
      //       name: 'storeDetail',
      //       builder: (context, state) {
      //         final id = state.params['id']!;
      //         return StoreDetailPage(storeId: id);
      //       },
      //     ),
      //   ],
      // ),
    ],
  );
}
