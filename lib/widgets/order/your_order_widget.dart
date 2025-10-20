import 'package:flutter/material.dart';
import 'order_item_model.dart';
import 'order_items_list_widget.dart';
import 'order_summary_widget.dart';

class YourOrderWidget extends StatelessWidget {
  final List<OrderItem> orderItems;

  const YourOrderWidget({super.key, required this.orderItems});

  double get subtotal {
    try {
      if (orderItems.isNotEmpty) {
        return orderItems.fold(0.0, (sum, item) => sum + item.price);
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  double get tax => subtotal * 0.1; // 10% tax
  double get total => subtotal + tax;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Text(
            'YOUR ORDER',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),

          Expanded(child: OrderItemsListWidget(orderItems: orderItems)),

          const SizedBox(height: 20),
          OrderSummaryWidget(subtotal: subtotal, tax: tax, total: total),
        ],
      ),
    );
  }
}
