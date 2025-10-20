import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Color? hoverColor;
  final Color? placeholderColor;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final double? enabledBorderWidth;
  final double? focusedBorderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final double? hoverOpacity;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.controller,
    this.hoverColor,
    this.placeholderColor,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.enabledBorderWidth,
    this.focusedBorderWidth,
    this.contentPadding,
    this.hoverOpacity,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHovered = false;
  bool _isFocused = false;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(widget.borderRadius ?? 4);
    final enabledBorderWidth = widget.enabledBorderWidth ?? 0.8;
    final focusedBorderWidth = widget.focusedBorderWidth ?? 2.0;
    final contentPadding =
        widget.contentPadding ??
        const EdgeInsets.symmetric(vertical: 20, horizontal: 12);
    final hoverOpacity = widget.hoverOpacity ?? 0.04;

    // Define hover background
    final Color hoverBg =
        widget.hoverColor ??
        Theme.of(
          context,
        ).colorScheme.shadow.withAlpha((hoverOpacity * 255).round());

    final borderClr =
        widget.borderColor ?? Theme.of(context).colorScheme.inversePrimary;
    final focusedBorderClr =
        widget.focusedBorderColor ??
        Theme.of(context).colorScheme.inversePrimary;
    final placeholderClr = widget.placeholderColor ?? Colors.grey;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color: _isHovered ? hoverBg : Colors.transparent,
          borderRadius: borderRadius,
        ),
        child: TextFormField(
          focusNode: _focusNode,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.label,
            floatingLabelStyle: TextStyle(
              color: _isFocused ? borderClr : Colors.grey,
            ),
            hintText: _isFocused ? null : widget.label,
            hintStyle: TextStyle(color: placeholderClr),
            border: OutlineInputBorder(borderRadius: borderRadius),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: borderClr,
                width: enabledBorderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: focusedBorderClr,
                width: focusedBorderWidth,
              ),
            ),
            contentPadding: contentPadding,
          ),
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          autocorrect: false,
          textCapitalization: TextCapitalization.none,
          validator: widget.validator,
          onSaved: widget.onSaved,
          inputFormatters: widget.inputFormatters,
        ),
      ),
    );
  }
}
