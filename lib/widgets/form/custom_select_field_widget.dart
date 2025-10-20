import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'dart:async';

class CustomSelectFieldWidget<T> extends StatefulWidget {
  final String label;
  final List<T> items;
  final T? selectedItem;
  final String Function(T)? itemAsString;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Icon? icon;

  const CustomSelectFieldWidget({
    super.key,
    required this.label,
    required this.items,
    this.icon,
    this.selectedItem,
    this.itemAsString,
    this.onChanged,
    this.validator,
  });

  @override
  State<CustomSelectFieldWidget<T>> createState() =>
      _CustomSelectFieldWidgetState<T>();
}

class _CustomSelectFieldWidgetState<T>
    extends State<CustomSelectFieldWidget<T>> {
  final TextEditingController _searchController = TextEditingController();
  List<T> _filteredItems = [];
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    // Cancel previous timer if it exists
    _debounceTimer?.cancel();

    // Create new timer with 300ms delay
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final searchText = _searchController.text.toLowerCase();

      if (mounted) {
        setState(() {
          if (searchText.isEmpty) {
            _filteredItems = widget.items;
          } else {
            _filteredItems = widget.items
                .where(
                  (item) => (widget.itemAsString?.call(item) ?? item.toString())
                      .toLowerCase()
                      .contains(searchText),
                )
                .toList();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(4);
    final borderColor = Theme.of(context).colorScheme.inversePrimary;
    final bgColor = Theme.of(context).colorScheme.primaryContainer;

    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<T>(
        value: widget.selectedItem,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: widget.icon ?? const Icon(Icons.store_outlined, size: 25),
          border: OutlineInputBorder(borderRadius: borderRadius),
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: borderColor, width: 0.8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 0,
          ),
          filled: true,
          fillColor: bgColor,
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 350, // Reasonable maximum height
          width: 600,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius,
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(4),
            thickness: WidgetStateProperty.all(4),
            thumbVisibility: WidgetStateProperty.all(true),
            trackVisibility: WidgetStateProperty.all(false),
            thumbColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.outline.withValues(alpha: 0.5),
            ),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 48, // Fixed height for regular items
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: _searchController,
          searchInnerWidgetHeight: 80, // Compact search area
          searchInnerWidget: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select ${widget.label}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _searchController,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    isDense: true,
                    prefixIcon: const Icon(Icons.search, size: 25),
                    hintText: 'Search...',
                    border: OutlineInputBorder(borderRadius: borderRadius),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: borderColor, width: 0.8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: borderRadius,
                      borderSide: BorderSide(color: borderColor, width: 1.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          searchMatchFn: (item, searchValue) {
            final itemLabel =
                widget.itemAsString?.call(item.value as T) ??
                item.value.toString();
            return itemLabel.toLowerCase().contains(searchValue.toLowerCase());
          },
        ),

        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            _searchController.clear();
            setState(() {
              _filteredItems = widget.items;
            });
          }
        },
        items: _filteredItems.isEmpty && _searchController.text.isNotEmpty
            ? [
                DropdownMenuItem<T>(
                  enabled: false,
                  value: null,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Data not found',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Try adjusting your search terms',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]
            : _filteredItems.map<DropdownMenuItem<T>>((T item) {
                final itemLabel =
                    widget.itemAsString?.call(item) ?? item.toString();
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(itemLabel, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
      ),
    );
  }
}
