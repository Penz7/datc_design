import 'package:flutter/material.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// A highly customizable, performant list with built-in pull-to-refresh
/// and infinite scrolling (load more) capabilities, relying entirely
/// on the DATC Design Tokens and avoiding heavy external dependencies.
class DCList extends StatefulWidget {
  /// Creates a standard list from a fixed list of widgets.
  /// Ideal for small lists.
  const DCList({
    super.key,
    required List<Widget> children,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.hasMoreData = false,
    this.isLoadingMore = false,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.emptyWidget,
    this.loadingColor,
    this.noMoreDataMessage = 'No more data',
    this.scrollDirection = Axis.vertical,
  }) : _isBuilder = false,
       _isSeparated = false,
       _children = children,
       itemCount = children.length,
       itemBuilder = null,
       separatorBuilder = null;

  /// Creates a list that builds its items on demand.
  /// Ideal for large datasets.
  const DCList.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.hasMoreData = false,
    this.isLoadingMore = false,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.emptyWidget,
    this.loadingColor,
    this.noMoreDataMessage = 'No more data',
    this.scrollDirection = Axis.vertical,
  }) : _isBuilder = true,
       _isSeparated = false,
       _children = null,
       separatorBuilder = null;

  /// Creates a list that builds its items on demand, with separators.
  /// Ideal for large datasets requiring visual dividers.
  const DCList.separated({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.controller,
    this.onRefresh,
    this.onLoadMore,
    this.hasMoreData = false,
    this.isLoadingMore = false,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.emptyWidget,
    this.loadingColor,
    this.noMoreDataMessage = 'No more data',
    this.scrollDirection = Axis.vertical,
  }) : _isBuilder = false,
       _isSeparated = true,
       _children = null;

  /// The total number of items in the list.
  final int itemCount;

  /// The builder function to build each item lazily.
  final Widget Function(BuildContext, int)? itemBuilder;

  /// The builder function to separate items.
  final IndexedWidgetBuilder? separatorBuilder;

  /// The static list of children, used only in the default constructor.
  final List<Widget>? _children;

  /// Optional ScrollController to attach to the list.
  final ScrollController? controller;

  /// Indicates if this list should use builder logic internally.
  final bool _isBuilder;

  /// Indicates if this list should use separated logic internally.
  final bool _isSeparated;

  /// Triggered when the user pulls down to refresh.
  /// Wraps the list in a [RefreshIndicator].
  final Future<void> Function()? onRefresh;

  /// Triggered when the user scrolls near the bottom of the list.
  final Future<void> Function()? onLoadMore;

  /// Should be true if there is more data to load.
  /// Controls the visibility of the bottom loading or 'no more data' indicator.
  final bool hasMoreData;

  /// Indicates if a load more operation is currently in progress.
  /// Used to show the loading spinner at the bottom and prevent duplicate requests.
  final bool isLoadingMore;

  /// Custom padding for the list content. Defaults to `EdgeInsets.all(DCSpacing.md)`.
  final EdgeInsetsGeometry? padding;

  /// Custom scroll physics. Defaults to `AlwaysScrollableScrollPhysics()`.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the scroll direction
  /// should be determined by the contents being viewed.
  final bool shrinkWrap;

  /// Widget to display when the list is completely empty.
  final Widget? emptyWidget;

  /// Color used for the refresh indicator and bottom loading spinner.
  final Color? loadingColor;

  /// Text to display at the bottom when `hasMoreData` is false.
  final String noMoreDataMessage;

  /// The axis along which the scroll view scrolls.
  final Axis scrollDirection;

  @override
  State<DCList> createState() => _DCListState();
}

class _DCListState extends State<DCList> {
  ScrollController? _internalController;

  ScrollController get _scrollController =>
      widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = ScrollController();
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(DCList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onScroll);
      if (widget.controller != null) {
        _internalController?.dispose();
        _internalController = null;
        widget.controller!.addListener(_onScroll);
      } else {
        _internalController = ScrollController();
        _internalController!.addListener(_onScroll);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _internalController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (widget.onLoadMore == null ||
        widget.isLoadingMore ||
        !widget.hasMoreData) {
      return;
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    // Trigger load more when user is 200 pixels from the bottom
    if (maxScroll - currentScroll <= 200) {
      widget.onLoadMore!();
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    if (widget._isBuilder || widget._isSeparated) {
      return widget.itemBuilder!(context, index);
    }
    return widget._children![index];
  }

  Widget _buildList(BuildContext context) {
    if (widget.itemCount == 0 && widget.emptyWidget != null) {
      return Center(child: widget.emptyWidget);
    }

    // Add 1 to itemCount if we have onLoadMore to show loading/end indicator
    final totalCount = widget.itemCount + (widget.onLoadMore != null ? 1 : 0);
    final padding = widget.padding ?? const EdgeInsets.all(DCSpacing.md);
    final physics = widget.physics ?? const AlwaysScrollableScrollPhysics();

    Widget listView;

    if (widget._isSeparated) {
      listView = ListView.separated(
        controller: _scrollController,
        padding: padding,
        physics: physics,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        itemCount: totalCount,
        separatorBuilder: (context, index) {
          if (index == widget.itemCount) return const SizedBox.shrink();
          return widget.separatorBuilder!(context, index);
        },
        itemBuilder: (context, index) {
          if (index == widget.itemCount) {
            return _buildFooter();
          }
          return _buildItem(context, index);
        },
      );
    } else {
      listView = ListView.builder(
        controller: _scrollController,
        padding: padding,
        physics: physics,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        itemCount: totalCount,
        itemBuilder: (context, index) {
          if (index == widget.itemCount) {
            return _buildFooter();
          }
          final child = _buildItem(context, index);
          // Add default spacing for static lists
          if (!widget._isBuilder && !widget._isSeparated) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: DCSpacing.sm),
              child: child,
            );
          }
          return child;
        },
      );
    }

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        color: widget.loadingColor ?? DCColors.primary,
        onRefresh: widget.onRefresh!,
        child: listView,
      );
    }

    return listView;
  }

  Widget _buildFooter() {
    if (widget.isLoadingMore) {
      return Padding(
        padding: const EdgeInsets.all(DCSpacing.lg),
        child: Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.loadingColor ?? DCColors.primary,
              ),
            ),
          ),
        ),
      );
    }

    if (!widget.hasMoreData && widget.itemCount > 0) {
      return Padding(
        padding: const EdgeInsets.all(DCSpacing.lg),
        child: Center(
          child: DCText(
            widget.noMoreDataMessage,
            fontSize: DCFontSize.sm,
            color: DCColors.textSecondary,
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}

/// Simple expandable ListItem widget leveraging DCFontSize
class DCListItem extends StatelessWidget {
  const DCListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(DCSpacing.sm),
        child: Padding(
          padding: const EdgeInsets.all(DCSpacing.md),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: DCSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DCText(title, fontSize: DCFontSize.normal),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      DCText(
                        subtitle!,
                        fontSize: DCFontSize.tiny,
                        color: DCColors.textSecondary,
                      ),
                    ],
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
