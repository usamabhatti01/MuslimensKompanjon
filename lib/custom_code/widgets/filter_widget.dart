// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class FilterWidget extends StatefulWidget {
  const FilterWidget({
    super.key,
    this.width,
    this.height,
    this.currentValue,
    this.onSelected,
  });

  final double? width;
  final double? height;
  final String? currentValue;
  final Future Function(String selectedValue)? onSelected;

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  late String activeVal;

  @override
  void initState() {
    super.initState();
    activeVal = widget.currentValue ?? 'Latest';
  }

  @override
  void didUpdateWidget(covariant FilterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentValue != oldWidget.currentValue &&
        widget.currentValue != null) {
      setState(() {
        activeVal = widget.currentValue!;
      });
    }
  }

  void _onItemTap(String val) async {
    setState(() {
      activeVal = val;
    });
    if (widget.onSelected != null) {
      await widget.onSelected!(val);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    // Define the options derived from ShortFilter enum
    final options = ShortFilter.values.map((filter) {
      String label;
      switch (filter) {
        case ShortFilter.Latest:
          label = 'Latest';
          break;
        case ShortFilter.Popular:
          label = 'Popular';
          break;
        case ShortFilter.Old:
          label = 'Oldest';
          break;
      }
      return {
        'value': filter.name,
        'label': label,
      };
    }).toList();

    return SizedBox(
      width: widget.width,
      height: widget.height ?? 40.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: options.map((opt) {
          final val = opt['value']!;
          final label = opt['label']!;
          final isActive = activeVal == val;

          Color bg;
          Color txtColor;

          if (isActive) {
            bg = theme.primary;
            txtColor = Colors.white;
          } else {
            // Inactive buttons background is secondaryBackground, text is primaryText
            bg = theme.secondaryBackground;
            txtColor = theme.primaryText;
          }

          return GestureDetector(
            onTap: () => _onItemTap(val),
            child: Container(
              height: widget.height ?? 40.0,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                label,
                style: theme.titleSmall.override(
                  fontFamily: theme.titleSmallFamily,
                  color: txtColor,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: true,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
