import 'package:flutter/material.dart';

/// [Widget] extensions to make it easier to work with [Sliver] widgets.
extension WidgetSliver on Widget {
  Widget get sliver {
    return SliverToBoxAdapter(
      child: this,
    );
  }

  /// Wraps the widget in a [SliverPadding] widget.
  Widget sliverPadding(EdgeInsetsGeometry padding) {
    return SliverPadding(
      padding: padding,
      sliver: this,
    );
  }

  /// Wraps the widget in a [SliverVisibility] widget.
  Widget sliverVisibility(bool isVisible) {
    return isVisible ? this : SliverToBoxAdapter();
  }

  /// Wraps the widget in a [SliverOpacity] widget.
  Widget sliverOpacity(double opacity) {
    return SliverOpacity(
      opacity: opacity,
      sliver: this,
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverFittedBox({BoxFit fit = BoxFit.contain}) {
    return SliverToBoxAdapter(
      child: FittedBox(
        fit: fit,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverExpander() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: this,
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverCenter() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: this),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverAspectRatio(double aspectRatio) {
    return SliverToBoxAdapter(
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverClipRRect(BorderRadius borderRadius) {
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverPhysicalModel({
    required Color color,
    required double elevation,
    BoxShape shape = BoxShape.rectangle,
    Clip clipBehavior = Clip.none,
  }) {
    return SliverToBoxAdapter(
      child: PhysicalModel(
        color: color,
        elevation: elevation,
        shape: shape,
        clipBehavior: clipBehavior,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverFlexibleSpaceBar({String? title, bool centerTitle = true}) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: centerTitle,
        title: title != null ? Text(title) : null,
        background: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverOffstage(bool offstage) {
    return SliverToBoxAdapter(
      child: Offstage(
        offstage: offstage,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverAnimatedSwitcher(
      {Duration duration = const Duration(milliseconds: 250)}) {
    return SliverToBoxAdapter(
      child: AnimatedSwitcher(
        duration: duration,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverFadeTransition({required Animation<double> animation}) {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: animation,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverRotatedBox({int quarterTurns = 1}) {
    return SliverToBoxAdapter(
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverPositionedTransition(
      {required Animation<RelativeRect> animation}) {
    return SliverToBoxAdapter(
      child: PositionedTransition(
        rect: animation,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverScaleTransition({required Animation<double> scale}) {
    return SliverToBoxAdapter(
      child: ScaleTransition(
        scale: scale,
        child: this,
      ),
    );
  }

  /// Wraps the widget in a [SliverAppBar] widget.
  Widget sliverSizeTransition(
      {required Animation<double> sizeFactor, Axis axis = Axis.vertical}) {
    return SliverToBoxAdapter(
      child: SizeTransition(
        sizeFactor: sizeFactor,
        axis: axis,
        child: this,
      ),
    );
  }
}
