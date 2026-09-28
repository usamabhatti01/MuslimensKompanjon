// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

void _showSafetyAlertDialog() {
  final context = appNavigatorKey.currentContext;
  if (context == null) return;

  String lang = 'sv';
  try {
    lang = FFLocalizations.of(context).languageCode;
  } catch (_) {}

  final isSv = lang.startsWith('sv');
  final title = isSv ? 'Obs!' : 'Notice';
  final message = isSv
      ? 'Minst ett textalternativ måste vara aktiverat.'
      : 'At least one text option must remain enabled.';
  final buttonText = 'OK';

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      final theme = FlutterFlowTheme.of(dialogContext);

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        backgroundColor: theme.secondaryBackground,
        title: Text(
          title,
          style: theme.titleMedium.override(
            fontFamily: theme.titleMediumFamily,
            color: theme.primaryText,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          message,
          style: theme.bodyMedium.override(
            fontFamily: theme.bodyMediumFamily,
            color: theme.secondaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              buttonText,
              style: TextStyle(
                color: theme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      );
    },
  );
}

bool _applySafeToggle(FontSettingStruct s, String value) {
  switch (value) {
    case 'arActive':
      final nextVal = !s.arActive;

      if (!nextVal && !s.swActive && !s.enActive) {
        _showSafetyAlertDialog();
        return false;
      }

      s.arActive = nextVal;
      return true;

    case 'swActive':
      final nextVal = !s.swActive;

      if (!nextVal && !s.arActive && !s.enActive) {
        _showSafetyAlertDialog();
        return false;
      }

      s.swActive = nextVal;
      return true;

    case 'enActive':
      final nextVal = !s.enActive;

      if (!nextVal && !s.arActive && !s.swActive) {
        _showSafetyAlertDialog();
        return false;
      }

      s.enActive = nextVal;
      return true;

    default:
      return false;
  }
}

Future<bool> updateFontApperance(
  String updatedValue,
  String value,
) async {
  bool updated = false;

  switch (updatedValue) {
    case 'quran':
      FFAppState().updateQurantSettingStruct((s) {
        updated = _applySafeToggle(s, value);
      });
      break;

    case 'adhkar':
      FFAppState().updateAdhkarSettingStruct((s) {
        updated = _applySafeToggle(s, value);
      });
      break;

    case 'tasbih':
      FFAppState().updateTasbihSettingStruct((s) {
        updated = _applySafeToggle(s, value);
      });
      break;

    case 'duas':
      FFAppState().updateDuasSettingStruct((s) {
        updated = _applySafeToggle(s, value);
      });
      break;

    default:
      return false;
  }

  return updated;
}
