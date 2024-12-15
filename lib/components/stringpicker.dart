// Taken from https://pub.dev/packages/numberpicker

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_listview/infinite_listview.dart';

typedef TextMapper = String Function(String numberText);

// TODO: Replace the magic number 0 scattered around the code with a PROPERLY NAMED VARIABLE
class StringPicker extends StatefulWidget {
  /// List of strings user can pick
  final List<String> items;

  /// Currently selected value
  final String currentSelection;

  /// Called when selected value changes
  final ValueChanged<int> onChanged;

  /// Specifies how many items should be shown - defaults to 3
  final int itemCount;

  /// Step between elements. Only for integer datePicker
  /// Examples:
  /// if step is 100 the following elements may be 100, 200, 300...
  /// if min=0, max=6, step=3, then items will be 0, 3 and 6
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// height of single item in pixels
  final double itemHeight;

  /// width of single item in pixels
  final double itemWidth;

  /// Direction of scrolling
  final Axis axis;

  /// Style of non-selected numbers. If null, it uses Theme's bodyText2
  final TextStyle? textStyle;

  /// Style of non-selected numbers. If null, it uses Theme's headline5 with accentColor
  final TextStyle? selectedTextStyle;

  /// Whether to trigger haptic pulses or not
  final bool haptics;

  /// Build the text of each item on the picker
  final TextMapper? textMapper;

  /// Pads displayed integer values up to the length of maxValue
  final bool zeroPad;

  /// Decoration to apply to central box where the selected value is placed
  final Decoration? decoration;

  final bool infiniteLoop;

  const StringPicker({
    Key? key,
    required this.items,
    required this.currentSelection,
    required this.onChanged,
    this.itemCount = 3,
    this.step = 1,
    this.itemHeight = 50,
    this.itemWidth = 150,
    this.axis = Axis.vertical,
    this.textStyle,
    this.selectedTextStyle,
    this.haptics = false,
    this.decoration,
    this.zeroPad = false,
    this.textMapper,
    this.infiniteLoop = false,
  })  : super(key: key);

  @override
  _StringPickerState createState() => _StringPickerState();
}

class _StringPickerState extends State<StringPicker> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final initialOffset =
        // (widget.value - widget.minValue) ~/ widget.step * itemExtent;
        0 ~/ widget.step * itemExtent;
    if (widget.infiniteLoop) {
      _scrollController =
          InfiniteScrollController(initialScrollOffset: initialOffset);
    } else {
      _scrollController = ScrollController(initialScrollOffset: initialOffset);
    }
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    var indexOfMiddleElement = (_scrollController.offset / itemExtent).round();
    if (widget.infiniteLoop) {
      indexOfMiddleElement %= itemCount;
    } else {
      indexOfMiddleElement = indexOfMiddleElement.clamp(0, itemCount - 1);
    }
    
    final stringInTheMiddle =
        _stringFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);

    if (widget.currentSelection != stringInTheMiddle) {
      widget.onChanged(stringInTheMiddle);
      if (widget.haptics) {
        HapticFeedback.selectionClick();
      }
    }
    
    Future.delayed(
      Duration(milliseconds: 100),
      () => _maybeCenterValue(),
    );
  }

  @override
  void didUpdateWidget(StringPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentSelection != widget.currentSelection) {
      _maybeCenterValue();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get isScrolling => _scrollController.position.isScrollingNotifier.value;

  double get itemExtent =>
      widget.axis == Axis.vertical ? widget.itemHeight : widget.itemWidth;

  int get itemCount => widget.items.length;

  int get listItemsCount => itemCount + 2 * additionalItemsOnEachSide;

  int get additionalItemsOnEachSide => (widget.itemCount - 1) ~/ 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.axis == Axis.vertical
          ? widget.itemWidth
          : widget.itemCount * widget.itemWidth,
      height: widget.axis == Axis.vertical
          ? widget.itemCount * widget.itemHeight
          : widget.itemHeight,
      child: NotificationListener<ScrollEndNotification>(
        onNotification: (not) {
          if (not.dragDetails?.primaryVelocity == 0) {
            Future.microtask(() => _maybeCenterValue());
          }
          return true;
        },
        child: Stack(
          children: [
            if (widget.infiniteLoop)
              InfiniteListView.builder(
                scrollDirection: widget.axis,
                controller: _scrollController as InfiniteScrollController,
                itemExtent: itemExtent,
                itemBuilder: _stringBuilder,
                padding: EdgeInsets.zero,
                // padding: const EdgeInsets.only(left: 20.0),
              )
            else
              ListView.builder(
                itemCount: listItemsCount,
                scrollDirection: widget.axis,
                controller: _scrollController,
                itemExtent: itemExtent,
                itemBuilder: _stringBuilder,
                padding: EdgeInsets.zero,
                // padding: const EdgeInsets.only(left: 20.0),
              ),
            _StringPickerSelectedItemDecoration(
              axis: widget.axis,
              itemExtent: itemExtent,
              decoration: widget.decoration,
            ),
          ],
        ),
      ),
    );
  }

  Widget _stringBuilder(BuildContext context, int index) {
    final themeData = Theme.of(context);
    final defaultStyle = widget.textStyle ?? themeData.textTheme.bodyMedium;
    final selectedStyle = widget.selectedTextStyle ??
        themeData.textTheme.headlineSmall
            ?.copyWith(color: themeData.colorScheme.secondary);

    final str = _stringFromIndex(index % itemCount);
    final isExtra = !widget.infiniteLoop &&
        (index < additionalItemsOnEachSide ||
            index >= listItemsCount - additionalItemsOnEachSide);
    final itemStyle = str == widget.currentSelection ? selectedStyle : defaultStyle;

    final child = isExtra
        ? SizedBox.shrink()
        : Text(
            _getDisplayedString(str),
            style: itemStyle,
          );

    return Container(
      width: widget.itemWidth,
      height: widget.itemHeight,
      alignment: Alignment.center,
      child: child,
    );
  }

  String _getDisplayedString(int strIndex) {
    final availableStrings = widget.items;
    final longestStringInAvailableStrings = availableStrings[0];
    final text = widget.zeroPad
        ? availableStrings[strIndex].padLeft(longestStringInAvailableStrings.length, '0')
        : availableStrings[strIndex];
    if (widget.textMapper != null) {
      return widget.textMapper!(text);
    } else {
      return text;
    }
  }

  int _stringFromIndex(int index) {
    index -= additionalItemsOnEachSide;
    index %= itemCount;
    return 0 + index * widget.step;
  }

  void _maybeCenterValue() {
    if (_scrollController.hasClients && !isScrolling) {
      int diff = widget.items.indexOf(widget.currentSelection) - 0;
      int index = diff ~/ widget.step;
      if (widget.infiniteLoop) {
        final offset = _scrollController.offset + 0.5 * itemExtent;
        final cycles = (offset / (itemCount * itemExtent)).floor();
        index += cycles * itemCount;
      }
      _scrollController.animateTo(
        index * itemExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }
}

class _StringPickerSelectedItemDecoration extends StatelessWidget {
  final Axis axis;
  final double itemExtent;
  final Decoration? decoration;

  const _StringPickerSelectedItemDecoration({
    Key? key,
    required this.axis,
    required this.itemExtent,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: Container(
          width: isVertical ? double.infinity : itemExtent,
          height: isVertical ? itemExtent : double.infinity,
          decoration: decoration,
        ),
      ),
    );
  }

  bool get isVertical => axis == Axis.vertical;
}
