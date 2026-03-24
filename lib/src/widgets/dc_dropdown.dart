import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// DCDropdown - A highly flexible dropdown component with slide/fade animation.
///
/// The dropdown menu always appears directly attached to the button,
/// automatically choosing to show above or below based on available screen space.
///
/// Usage:
/// ```dart
/// DCDropdown<String>(
///   items: ['Apple', 'Banana', 'Cherry'],
///   onChanged: (value) => print(value),
///   hintText: 'Select a fruit',
/// )
/// ```
class DCDropdown<T> extends StatefulWidget {
  const DCDropdown({
    super.key,
    required this.items,
    this.value,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.errorText,
    this.enabled = true,
    this.prefixIcon,
    this.borderRadius,
    this.fillColor,
    this.itemBuilder,
    this.selectedItemBuilder,
    this.dropdownColor,
    this.icon,
    this.isFullWidth = true,
    this.customHolder,
    this.customMenuBuilder,
    this.animationDuration = const Duration(milliseconds: 250),
    this.menuMaxHeight = 220,
  });

  /// The list of items to display in the dropdown.
  final List<T> items;

  /// The currently selected value.
  final T? value;

  /// Callback triggered when the selection changes.
  final ValueChanged<T?>? onChanged;

  /// Placeholder text when no value is selected.
  final String? hintText;

  /// Label text displayed above the dropdown.
  final String? labelText;

  /// Error message to display under the dropdown.
  final String? errorText;

  /// Whether the dropdown is interactive.
  final bool enabled;

  /// Icon to show at the start of the field.
  final Widget? prefixIcon;

  /// Custom border radius. Defaults to [DCSpacing.sm].
  final double? borderRadius;

  /// Custom background color for the field.
  final Color? fillColor;

  /// Custom background color for the dropdown menu.
  final Color? dropdownColor;

  /// Custom builder for dropdown items.
  final Widget Function(BuildContext context, T item)? itemBuilder;

  /// Custom builder for the selected item display.
  final Widget Function(BuildContext context, T? item)? selectedItemBuilder;

  /// Custom icon for the dropdown arrow.
  final Widget? icon;

  /// Whether the dropdown should take up the full width of its container.
  final bool isFullWidth;

  /// Completely custom holder for the dropdown field (the trigger button).
  final Widget Function(BuildContext context, T? value, bool isOpen)?
      customHolder;

  /// Completely custom builder for the dropdown menu (the overlay that shows up).
  final Widget Function(
          BuildContext context, List<T> items, T? value, Function(T) onSelect)?
      customMenuBuilder;

  /// Duration for the animations.
  final Duration animationDuration;

  /// Maximum height of the dropdown menu.
  final double menuMaxHeight;

  @override
  State<DCDropdown<T>> createState() => _DCDropdownState<T>();
}

class _DCDropdownState<T> extends State<DCDropdown<T>>
    with SingleTickerProviderStateMixin {
  final GlobalKey _buttonKey = GlobalKey();
  late AnimationController _controller;
  late Animation<double> _iconRotation;
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _iconRotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _removeOverlayImmediate();
    _controller.dispose();
    super.dispose();
  }

  /// Remove overlay without animation (for dispose safety).
  void _removeOverlayImmediate() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _toggleOverlay() {
    if (_isOpen) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  /// Calculate button rect in global coordinates using the GlobalKey.
  Rect? _getButtonRect() {
    final RenderBox? renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return null;
    final Offset topLeft = renderBox.localToGlobal(Offset.zero);
    return topLeft & renderBox.size;
  }

  void _showOverlay() {
    if (!mounted) return;

    final Rect? buttonRect = _getButtonRect();
    if (buttonRect == null) return;

    final Size screenSize = MediaQuery.sizeOf(context);
    final EdgeInsets padding = MediaQuery.paddingOf(context);

    // Usable screen area
    final double safeTop = padding.top;
    final double safeBottom = screenSize.height - padding.bottom;

    // Available space below and above the button
    final double spaceBelow = safeBottom - buttonRect.bottom;
    final double spaceAbove = buttonRect.top - safeTop;

    const double gap = 4.0; // gap between button and menu
    final double menuMaxH = widget.menuMaxHeight;

    // Decide direction
    final bool showAbove = spaceBelow < menuMaxH && spaceAbove > spaceBelow;

    // Constrain menu height to available space
    final double availableH = showAbove ? spaceAbove - gap : spaceBelow - gap;
    final double menuHeight = menuMaxH.clamp(0, availableH);

    // Menu top position
    final double menuTop = showAbove
        ? buttonRect.top - menuHeight - gap
        : buttonRect.bottom + gap;

    _overlayEntry = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            // Barrier – taps outside close the dropdown
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _hideOverlay,
              ),
            ),
            // Menu positioned exactly relative to button
            Positioned(
              left: buttonRect.left,
              top: menuTop,
              width: buttonRect.width,
              child: Material(
                color: Colors.transparent,
                child: FadeTransition(
                  opacity: CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeOut,
                  ),
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, showAbove ? 0.08 : -0.08),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: _buildMenu(
                      menuHeight: menuHeight,
                      showAbove: showAbove,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() => _isOpen = true);
    _controller.forward();
  }

  void _hideOverlay() {
    if (!_isOpen) return;
    _controller.reverse().then((_) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      if (mounted) {
        setState(() => _isOpen = false);
      }
    });
  }

  void _onItemSelected(T item) {
    widget.onChanged?.call(item);
    _hideOverlay();
  }

  Widget _buildMenu({
    required double menuHeight,
    required bool showAbove,
  }) {
    final double radius = widget.borderRadius ?? DCSpacing.sm;

    // If a custom menu builder is provided, use it
    if (widget.customMenuBuilder != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: menuHeight),
        child: widget.customMenuBuilder!(
          context,
          widget.items,
          widget.value,
          _onItemSelected,
        ),
      );
    }

    // Default menu
    return Container(
      constraints: BoxConstraints(maxHeight: menuHeight),
      decoration: BoxDecoration(
        color: widget.dropdownColor ?? DCColors.surface,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: Offset(0, showAbove ? -4 : 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4),
          shrinkWrap: true,
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            final T item = widget.items[index];
            final bool isSelected = widget.value == item;
            return InkWell(
              onTap: () => _onItemSelected(item),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: DCSpacing.md,
                  vertical: DCSpacing.sm,
                ),
                color: isSelected
                    ? DCColors.primary.withValues(alpha: 0.08)
                    : null,
                child: widget.itemBuilder != null
                    ? widget.itemBuilder!(context, item)
                    : DCText(
                        item.toString(),
                        color: isSelected
                            ? DCColors.primary
                            : DCColors.textPrimary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double radius = widget.borderRadius ?? DCSpacing.sm;

    // Build the default field (trigger button)
    final Widget defaultField = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DCSpacing.md,
        vertical: DCSpacing.sm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(
          color: widget.errorText != null
              ? DCColors.error
              : (_isOpen ? DCColors.primary : DCColors.gray300),
          width: _isOpen || widget.errorText != null ? 1.5 : 1.0,
        ),
        color: widget.fillColor ??
            (widget.enabled ? DCColors.surface : DCColors.gray100),
      ),
      child: Row(
        children: [
          if (widget.prefixIcon != null) ...[
            widget.prefixIcon!,
            const SizedBox(width: DCSpacing.sm),
          ],
          Expanded(
            child: widget.selectedItemBuilder != null
                ? widget.selectedItemBuilder!(context, widget.value)
                : DCText(
                    widget.value?.toString() ?? widget.hintText ?? '',
                    color: widget.value == null
                        ? DCColors.textSecondary
                        : DCColors.textPrimary,
                    fontSize: DCFontSize.normal,
                  ),
          ),
          RotationTransition(
            turns: _iconRotation,
            child: widget.icon ??
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: DCColors.gray500,
                ),
          ),
        ],
      ),
    );

    // The button area – we attach GlobalKey here so the overlay
    // is always positioned relative to THIS widget, not the Column.
    final Widget button = GestureDetector(
      key: _buttonKey,
      onTap: widget.enabled ? _toggleOverlay : null,
      child: widget.customHolder != null
          ? widget.customHolder!(context, widget.value, _isOpen)
          : defaultField,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.labelText != null) ...[
          DCText(
            widget.labelText!,
            fontWeight: FontWeight.w500,
            fontSize: DCFontSize.sm,
            color: DCColors.textPrimary,
          ),
          const SizedBox(height: DCSpacing.xs),
        ],
        SizedBox(
          width: widget.isFullWidth ? double.infinity : null,
          child: button,
        ),
        if (widget.errorText != null) ...[
          const SizedBox(height: DCSpacing.xs),
          DCText(
            widget.errorText!,
            color: DCColors.error,
            fontSize: DCFontSize.tiny,
          ),
        ],
      ],
    );
  }
}
