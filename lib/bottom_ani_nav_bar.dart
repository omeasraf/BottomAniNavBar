import 'dart:collection' show Queue;
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

enum BottomAniNavBarType {
  fixed,

  shifting,
}

class BottomAniNavBar extends StatefulWidget {
  BottomAniNavBar({
    Key key,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation = 8.0,
    BottomAniNavBarType type,
    Color fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    Color selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    bool showUnselectedLabels,
  })  : assert(items != null),
        assert(items.length >= 2),
        assert(
          items.every((BottomNavigationBarItem item) => item.title != null) ==
              true,
          'Every item must have a non-null title',
        ),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(elevation != null && elevation >= 0.0),
        assert(iconSize != null && iconSize >= 0.0),
        assert(selectedItemColor == null || fixedColor == null,
            'Either selectedItemColor or fixedColor can be specified, but not both'),
        assert(selectedFontSize != null && selectedFontSize >= 0.0),
        assert(unselectedFontSize != null && unselectedFontSize >= 0.0),
        assert(showSelectedLabels != null),
        type = _type(type, items),
        selectedItemColor = selectedItemColor ?? fixedColor,
        showUnselectedLabels =
            showUnselectedLabels ?? _defaultShowUnselected(_type(type, items)),
        super(key: key);

  final List<BottomNavigationBarItem> items;

  final ValueChanged<int> onTap;

  final int currentIndex;

  final double elevation;

  final BottomAniNavBarType type;

  Color get fixedColor => selectedItemColor;

  final Color backgroundColor;

  final double iconSize;

  final Color selectedItemColor;

  final Color unselectedItemColor;

  final IconThemeData selectedIconTheme;

  final IconThemeData unselectedIconTheme;

  final TextStyle selectedLabelStyle;

  final TextStyle unselectedLabelStyle;

  final double selectedFontSize;

  final double unselectedFontSize;

  final bool showUnselectedLabels;

  final bool showSelectedLabels;

  static BottomAniNavBarType _type(
    BottomAniNavBarType type,
    List<BottomNavigationBarItem> items,
  ) {
    if (type != null) {
      return type;
    }
    return items.length <= 3
        ? BottomAniNavBarType.fixed
        : BottomAniNavBarType.shifting;
  }

  static bool _defaultShowUnselected(BottomAniNavBarType type) {
    switch (type) {
      case BottomAniNavBarType.shifting:
        return false;
      case BottomAniNavBarType.fixed:
        return true;
    }
    assert(false);
    return false;
  }

  @override
  _BottomAniNavBarState createState() => _BottomAniNavBarState();
}

class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.type,
    this.item,
    this.animation,
    this.iconSize, {
    this.onTap,
    this.colorTween,
    this.flex,
    this.selected = false,
    @required this.selectedLabelStyle,
    @required this.unselectedLabelStyle,
    @required this.selectedIconTheme,
    @required this.unselectedIconTheme,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.indexLabel,
  })  : assert(type != null),
        assert(item != null),
        assert(animation != null),
        assert(selected != null),
        assert(selectedLabelStyle != null),
        assert(unselectedLabelStyle != null);

  final BottomAniNavBarType type;
  final BottomNavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback onTap;
  final ColorTween colorTween;
  final double flex;
  final bool selected;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final String indexLabel;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    int size;

    switch (type) {
      case BottomAniNavBarType.fixed:
        size = 1;
        break;
      case BottomAniNavBarType.shifting:
        size = (flex * 1000.0).round();
        break;
    }

    return Expanded(
      flex: size,
      child: Semantics(
        container: true,
        selected: selected,
        child: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Stack(
            overflow: Overflow.clip,
            children: <Widget>[
              InkResponse(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AnimatedContainer(
                        width: selected ? 130 : 50,
                        height: 40,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.ease,
                        decoration: BoxDecoration(
                          color: selected
                              ? Colors.blueAccent.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          child: Container(
                            width: selected ? 130 : 50,
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconTheme(
                                  data: IconThemeData(
                                    size: iconSize,
                                    color: selected
                                        ? Colors.blueAccent
                                        : colorTween.evaluate(animation),
                                  ),
                                  child: selected ? item.activeIcon : item.icon,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                if (selected)
                                  Expanded(
                                    child: Container(
                                      width: 5,
                                      child: DefaultTextStyle.merge(
                                        style: TextStyle(
                                          color: colorTween.evaluate(animation),
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Rubik",
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        child: item.title,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Semantics(
                label: indexLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomAniNavBarState extends State<BottomAniNavBar>
    with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  List<CurvedAnimation> _animations;

  final Queue<_Circle> _circles = Queue<_Circle>();

  Color _backgroundColor;

  static final Animatable<double> _flexTween =
      Tween<double>(begin: 1.0, end: 1.5);

  void _resetState() {
    for (AnimationController controller in _controllers) controller.dispose();
    for (_Circle circle in _circles) circle.dispose();
    _circles.clear();

    _controllers =
        List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations =
        List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {});
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) controller.dispose();
    for (_Circle circle in _circles) circle.dispose();
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) =>
      _flexTween.evaluate(animation);

  void _pushCircle(int index) {
    if (widget.items[index].backgroundColor != null) {}
  }

  @override
  void didUpdateWidget(BottomAniNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      switch (widget.type) {
        case BottomAniNavBarType.fixed:
          break;
        case BottomAniNavBarType.shifting:
          _pushCircle(widget.currentIndex);
          break;
      }
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor != widget.items[widget.currentIndex].backgroundColor)
        _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
    }
  }

  static TextStyle _effectiveTextStyle(TextStyle textStyle, double fontSize) {
    textStyle ??= const TextStyle();

    return textStyle.fontSize == null
        ? textStyle.copyWith(fontSize: fontSize)
        : textStyle;
  }

  List<Widget> _createTiles() {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    assert(localizations != null);

    final ThemeData themeData = Theme.of(context);

    final TextStyle effectiveSelectedLabelStyle =
        _effectiveTextStyle(widget.selectedLabelStyle, widget.selectedFontSize);
    final TextStyle effectiveUnselectedLabelStyle = _effectiveTextStyle(
        widget.unselectedLabelStyle, widget.unselectedFontSize);

    Color themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.primaryColor;
        break;
      case Brightness.dark:
        themeColor = themeData.accentColor;
        break;
    }

    ColorTween colorTween;
    switch (widget.type) {
      case BottomAniNavBarType.fixed:
        colorTween = ColorTween(
          begin:
              widget.unselectedItemColor ?? themeData.textTheme.caption.color,
          end: widget.selectedItemColor ?? widget.fixedColor ?? themeColor,
        );
        break;
      case BottomAniNavBarType.shifting:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ?? Colors.white,
          end: widget.selectedItemColor ?? Colors.white,
        );
        break;
    }

    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      tiles.add(_BottomNavigationTile(
        widget.type,
        widget.items[i],
        _animations[i],
        widget.iconSize,
        selectedIconTheme: widget.selectedIconTheme,
        unselectedIconTheme: widget.unselectedIconTheme,
        selectedLabelStyle: effectiveSelectedLabelStyle,
        unselectedLabelStyle: effectiveUnselectedLabelStyle,
        onTap: () {
          if (widget.onTap != null) widget.onTap(i);
        },
        colorTween: colorTween,
        flex: _evaluateFlex(_animations[i]) - 0.49,
        selected: i == widget.currentIndex,
        showSelectedLabels: widget.showSelectedLabels,
        showUnselectedLabels: widget.showUnselectedLabels,
        indexLabel: localizations.tabLabel(
            tabIndex: i + 1, tabCount: widget.items.length),
      ));
    }
    return tiles;
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasMediaQuery(context));

    final double additionalBottomPadding = math.max(
        MediaQuery.of(context).padding.bottom - widget.selectedFontSize / 2.0,
        0.0);
    Color backgroundColor;
    switch (widget.type) {
      case BottomAniNavBarType.fixed:
        backgroundColor = widget.backgroundColor;
        break;
      case BottomAniNavBarType.shifting:
        backgroundColor = _backgroundColor;
        break;
    }
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        elevation: widget.elevation,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: kBottomNavigationBarHeight + additionalBottomPadding),
          child: CustomPaint(
            child: Material(
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(bottom: additionalBottomPadding),
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: _createContainer(_createTiles()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Circle {
  _Circle({
    @required this.state,
    @required this.index,
    @required this.color,
    @required TickerProvider vsync,
  })  : assert(state != null),
        assert(index != null),
        assert(color != null) {
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
  }

  final _BottomAniNavBarState state;
  final int index;
  final Color color;
  AnimationController controller;
  CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      return animations
          .map<double>(state._evaluateFlex)
          .fold<double>(0.0, (double sum, double value) => sum + value);
    }

    final double allWeights = weightSum(state._animations);

    final double leadingWeights =
        weightSum(state._animations.sublist(0, index));

    return (leadingWeights +
            state._evaluateFlex(state._animations[index]) / 2.0) /
        allWeights;
  }

  void dispose() {
    controller.dispose();
  }
}
