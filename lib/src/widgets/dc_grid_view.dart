import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants/index.dart';
import 'dc_text.dart';

/// A highly customizable, performant grid with built-in pull-to-refresh
/// and infinite scrolling (load more) capabilities, leveraging DATC
/// Design Tokens and the `pull_to_refresh` package.
class DCGridView extends StatefulWidget {
  /// Creates a standard grid from a fixed list of widgets.
  const DCGridView({
    super.key,
    required List<Widget> children,
    required this.gridDelegate,
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
       _children = children,
       itemCount = children.length,
       itemBuilder = null;

  /// Creates a grid that builds its items on demand.
  const DCGridView.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.gridDelegate,
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
       _children = null;

  /// The total number of items in the grid.
  final int itemCount;

  /// The builder function to build each item lazily.
  final Widget Function(BuildContext, int)? itemBuilder;

  /// The static list of children, used only in the default constructor.
  final List<Widget>? _children;

  /// Delegate that controls the layout of the children within the grid.
  final SliverGridDelegate gridDelegate;

  /// Optional ScrollController to attach to the grid.
  final ScrollController? controller;

  /// Optional RefreshController for external control.
  final RefreshController? refreshController;

  /// Indicates if this grid should use builder logic internally.
  final bool _isBuilder;

  /// Triggered when the user pulls down to refresh.
  final Future<void> Function()? onRefresh;

  /// Triggered when the user scrolls near the bottom of the grid.
  final Future<void> Function()? onLoadMore;

  /// Should be true if there is more data to load.
  final bool hasMoreData;

  /// Indicates if a load more operation is currently in progress.
  final bool isLoadingMore;

  /// Custom padding for the grid content.
  final EdgeInsetsGeometry? padding;

  /// Custom scroll physics.
  final ScrollPhysics? physics;

  /// Whether the extent of the scroll view in the scroll direction
  /// should be determined by the contents being viewed.
  final bool shrinkWrap;

  /// Widget to display when the grid is completely empty.
  final Widget? emptyWidget;

  /// Color used for the refresh indicator and bottom loading spinner.
  final Color? loadingColor;

  /// Text to display at the bottom when `hasMoreData` is false.
  final String noMoreDataMessage;

  /// The axis along which the scroll view scrolls.
  final Axis scrollDirection;

  /// Custom header widget for pull-to-refresh.
  final Widget? header;

  /// Custom footer widget for load more.
  final Widget? footer;

  @override
  State<DCGridView> createState() => _DCGridViewState();
}

class _DCGridViewState extends State<DCGridView> {
  late RefreshController _internalRefreshController;

  RefreshController get _refreshController =>
      widget.refreshController ?? _internalRefreshController;

  @override
  void initState() {
    super.initState();
    _internalRefreshController = RefreshController(initialRefresh: false);
  }

  @override
  void didUpdateWidget(DCGridView oldWidget) {
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
    if (widget._isBuilder) {
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

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == 0 && widget.emptyWidget != null) {
      return Center(child: widget.emptyWidget);
    }

    final padding = widget.padding ?? const EdgeInsets.all(DCSpacing.md);
    final physics = widget.physics ?? const AlwaysScrollableScrollPhysics();

    final gridView = GridView.builder(
      controller: widget.controller,
      padding: padding,
      physics: physics,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      gridDelegate: widget.gridDelegate,
      itemCount: widget.itemCount,
      itemBuilder: (context, index) {
        return _buildItem(context, index);
      },
    );

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
      child: gridView,
    );
  }
}
