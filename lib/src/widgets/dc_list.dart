import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// A highly customizable, performant list with built-in pull-to-refresh
/// and infinite scrolling (load more) capabilities, relying entirely
/// on the DATC Design Tokens and using the `pull_to_refresh` package.
class DCList extends StatefulWidget {
  /// Creates a standard list from a fixed list of widgets.
  /// Ideal for small lists.
  const DCList({
    super.key,
    required List<Widget> children,
    this.controller,
    this.refreshController,
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
    this.header,
    this.footer,
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
    this.refreshController,
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
    this.header,
    this.footer,
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
    this.refreshController,
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
    this.header,
    this.footer,
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

  /// Optional RefreshController for external control.
  final RefreshController? refreshController;

  /// Indicates if this list should use builder logic internally.
  final bool _isBuilder;

  /// Indicates if this list should use separated logic internally.
  final bool _isSeparated;

  /// Triggered when the user pulls down to refresh.
  final Future<void> Function()? onRefresh;

  /// Triggered when the user scrolls near the bottom of the list.
  final Future<void> Function()? onLoadMore;

  /// Should be true if there is more data to load.
  final bool hasMoreData;

  /// Indicates if a load more operation is currently in progress.
  /// Note: Managed seamlessly by SmartRefresher natively, but kept for compatibility.
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

  /// Custom header widget for pull-to-refresh (e.g., WaterDropHeader, ClassicHeader).
  final Widget? header;

  /// Custom footer widget for load more (e.g., ClassicFooter, CustomFooter).
  final Widget? footer;

  @override
  State<DCList> createState() => _DCListState();
}

class _DCListState extends State<DCList> {
  late RefreshController _internalRefreshController;

  RefreshController get _refreshController =>
      widget.refreshController ?? _internalRefreshController;

  @override
  void initState() {
    super.initState();
    _internalRefreshController = RefreshController(initialRefresh: false);
  }

  @override
  void didUpdateWidget(DCList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.hasMoreData && widget.hasMoreData) {
      _refreshController.resetNoData();
    } else if (oldWidget.hasMoreData && !widget.hasMoreData) {
      _refreshController.loadNoData();
    }
  }

  @override
  void dispose() {
    _internalRefreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
    if (mounted) {
      _refreshController.refreshCompleted();
      if (widget.hasMoreData) {
        _refreshController.resetNoData();
      } else {
        _refreshController.loadNoData();
      }
    }
  }

  Future<void> _onLoading() async {
    if (widget.onLoadMore != null) {
      await widget.onLoadMore!();
    }
    if (mounted) {
      if (widget.hasMoreData) {
        _refreshController.loadComplete();
      } else {
        _refreshController.loadNoData();
      }
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    if (widget._isBuilder || widget._isSeparated) {
      return widget.itemBuilder!(context, index);
    }
    return widget._children![index];
  }

  Widget _buildDefaultFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus? mode) {
        return SizedBox(
          height: 60,
          child: Center(child: _buildFooterContent(mode)),
        );
      },
    );
  }

  Widget _buildFooterContent(LoadStatus? mode) {
    if (mode == LoadStatus.loading) {
      return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            widget.loadingColor ?? DCColors.primary,
          ),
        ),
      );
    } else if (mode == LoadStatus.noMore ||
        (!widget.hasMoreData && widget.itemCount > 0)) {
      return DCText(
        widget.noMoreDataMessage,
        fontSize: DCFontSize.sm,
        color: DCColors.textSecondary,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildList(BuildContext context) {
    if (widget.itemCount == 0 && widget.emptyWidget != null) {
      return Center(child: widget.emptyWidget);
    }

    final padding = widget.padding ?? const EdgeInsets.all(DCSpacing.md);
    final physics = widget.physics ?? const AlwaysScrollableScrollPhysics();

    Widget listView;

    if (widget._isSeparated) {
      listView = ListView.separated(
        controller: widget.controller,
        padding: padding,
        physics: physics,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        itemCount: widget.itemCount,
        separatorBuilder: widget.separatorBuilder!,
        itemBuilder: (context, index) {
          return _buildItem(context, index);
        },
      );
    } else {
      listView = ListView.builder(
        controller: widget.controller,
        padding: padding,
        physics: physics,
        shrinkWrap: widget.shrinkWrap,
        scrollDirection: widget.scrollDirection,
        itemCount: widget.itemCount,
        itemBuilder: (context, index) {
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

    return SmartRefresher(
      enablePullDown: widget.onRefresh != null,
      enablePullUp: widget.onLoadMore != null,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header:
          widget.header ??
          MaterialClassicHeader(color: widget.loadingColor ?? DCColors.primary),
      footer: widget.footer ?? _buildDefaultFooter(),
      child: listView,
    );
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
