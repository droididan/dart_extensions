import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  // Returns the MediaQuery
  MediaQueryData get mq => MediaQuery.of(this);

   /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get sizePx => mq.size;
  
  /// Returns same as MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;
  
  /// Returns same as MediaQuery.of(context).height
  double get heightPx => sizePx.height;

}