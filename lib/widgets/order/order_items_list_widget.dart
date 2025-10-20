import 'package:flutter/material.dart';
import 'order_item_model.dart';
import 'order_item_widget.dart';

class OrderItemsListWidget extends StatelessWidget {
  final List<OrderItem> orderItems;

  const OrderItemsListWidget({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    try {
      if (orderItems.isEmpty) {
        return const Center(
          child: Text(
            'No items in your order',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.separated(
        itemCount: orderItems.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          try {
            if (index >= orderItems.length) {
              return const SizedBox.shrink();
            }
            final item = orderItems[index];
            return OrderItemWidget(item: item);
          } catch (e) {
            return const SizedBox.shrink();
          }
        },
      );
    } catch (e) {
      return const Center(
        child: Text(
          'Error loading order items',
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
      );
    }
  }
}
