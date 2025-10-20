import 'package:flutter/material.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double tax;
  final double total;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 1, color: Colors.blueGrey),
        const SizedBox(height: 16),

        // Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Text(
              '\$${subtotal.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Tax
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tax(10%)',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Text(
              '\$${tax.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Due:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
