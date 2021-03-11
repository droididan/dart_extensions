
import 'package:flutter/material.dart';

/// convert Sizedbox height/width to percents.
extension SizedBoxExt on SizedBox {
  SizedBox toPercents(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (this.width != null) return SizedBox(width: (this.width ?? 0  / size.width) * 1000);
    if (this.height != null) return SizedBox(height: (this.height ?? 0 / size.height) * 1000);
    return SizedBox.shrink();
  }
}