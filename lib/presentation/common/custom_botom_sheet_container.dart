import 'package:employee_attendance/core/config/employee_attendance_screen.dart';
import 'package:employee_attendance/core/static/ui_const.dart';
import 'package:flutter/material.dart';

class CustomBottomSheetContainer extends StatelessWidget {
  const CustomBottomSheetContainer({
    super.key,
    required this.children,
    this.bottomSheetTitle,
    this.showPadding = true,
    this.constraints,
    required this.theme,
  });

  final List<Widget> children;
  final String? bottomSheetTitle;
  final bool showPadding;
  final BoxConstraints? constraints;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: constraints,
      padding: showPadding
          ? EdgeInsets.only(
              top: twentyPx,
              bottom: twentyPx,
              left: twentyPx,
              right: twentyPx,
            )
          : EdgeInsets.zero,
      decoration: decorateBottomSheet(context),
      child: Wrap(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showPadding ? const SizedBox.shrink() : gapH10,
              if (bottomSheetTitle != null) ...[
                gapH8,
                Text(
                  bottomSheetTitle!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: eighteenPx,
                    color: theme.colorScheme.scrim,
                  ),
                ),
                gapH20,
              ],
              ...children,
            ],
          )
        ],
      ),
    );
  }
}

BoxDecoration decorateBottomSheet(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(twentyPx),
      topRight: Radius.circular(twentyPx),
    ),
  );
}
