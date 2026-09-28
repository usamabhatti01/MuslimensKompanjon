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

/// Set your widget name, define your parameter, and then add the boilerplate
/// code using the `</>` button on the right!
import 'package:google_fonts/google_fonts.dart';
import '/index.dart';

/// Set your widget name, define your parameter, and then add the boilerplate
/// code using the `</>` button on the right!
class NarHjartatMinnsAllahDetailWidget extends StatefulWidget {
  const NarHjartatMinnsAllahDetailWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<NarHjartatMinnsAllahDetailWidget> createState() =>
      _NarHjartatMinnsAllahDetailWidgetState();
}

class _NarHjartatMinnsAllahDetailWidgetState
    extends State<NarHjartatMinnsAllahDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: FlutterFlowTheme.of(context).designToken.spacing.md,
          vertical: FlutterFlowTheme.of(context).designToken.spacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            _buildHeaderSection(context),
            const SizedBox(height: 16.0),

            // Feature List Section
            _buildFeatureListSection(context),
            const SizedBox(height: 16.0),

            // Reward Block
            _buildRewardBlock(context),
            const SizedBox(height: 16.0),

            // Challenge Block
            _buildChallengeBlock(context),
            const SizedBox(height: 16.0),

            // Call to Action (Footer)
            _buildCallToActionFooter(context),
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(
          FlutterFlowTheme.of(context).designToken.radius.md,
        ),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      padding: EdgeInsets.all(
        FlutterFlowTheme.of(context).designToken.spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/love.png',
                  width: 38.0,
                  height: 38.0,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 38.0,
                    height: 38.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .primary
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: const Text('❤️', style: TextStyle(fontSize: 20.0)),
                  ),
                ),
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Text(
                  'När hjärtat minns Allah',
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        font: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            'I en värld full av stress, distraktioner och ständig uppkoppling behöver hjärtat också sin tid med Allah. Här hittar du verktyg som hjälper dig att minnas Allah, stärka din tro och komma närmare Honom – varje dag.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  color: const Color(0xFF000000),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureListSection(BuildContext context) {
    final features = [
      {
        'icon': '🌅',
        'title': 'Börja dagen med Allah',
        'desc':
            'Med Morgon Adhkar börjar du din dag med att minnas Allah och söka Hans beskydd, välsignelser och vägledning.',
        'onTap': () {
          context.pushNamed(
            MorningEveningAdhkarWidget.routeName,
            queryParameters: {
              'adkar': serializeParam('Morgon Adhkar', ParamType.String),
              'adhkar': serializeParam(
                FFAppState().adhkar.where((e) => e.morning == true).toList(),
                ParamType.DataStruct,
                isList: true,
              ),
            }.withoutNulls,
          );
        },
      },
      {
        'icon': '🌙',
        'title': 'Avsluta dagen med Allah',
        'desc':
            'Med Kvälls Adhkar avslutar du dagen med dhikr och åkallan och lämnar dagens bekymmer till Allah.',
        'onTap': () {
          context.pushNamed(
            MorningEveningAdhkarWidget.routeName,
            queryParameters: {
              'adkar': serializeParam('Kvälls Adhkar', ParamType.String),
              'adhkar': serializeParam(
                FFAppState().adhkar.where((e) => e.evening == true).toList(),
                ParamType.DataStruct,
                isList: true,
              ),
            }.withoutNulls,
          );
        },
      },
      {
        'icon': '📿',
        'title': 'Låt din tunga minnas Allah',
        'desc':
            'Med Tasbih kan du enkelt göra dhikr och fylla din dag med att prisa och minnas Allah.',
        'onTap': () {
          context.pushNamed(
            TasbihWidget.routeName,
            queryParameters: {
              'adkar': serializeParam('Tasbih', ParamType.String),
            }.withoutNulls,
          );
        },
      },
      {
        'icon': '✨',
        'title': 'Lär känna Allah genom Hans vackra namn',
        'desc':
            'De 99 Allahs namn hjälper dig att lära känna Allahs namn och egenskaper och fördjupa din relation till Honom.',
        'onTap': () {
          context.pushNamed(
            AllahNamesWidget.routeName,
            queryParameters: {
              'adkar': serializeParam('Allahs  namn', ParamType.String),
            }.withoutNulls,
          );
        },
      },
      {
        'icon': '🤲',
        'title': 'Tala med Allah',
        'desc':
            'I Dua & Åkallan hittar du åkallan för olika stunder och situationer i livet. Be Allah om det du behöver – för duʿa är en del av dyrkan.',
        'onTap': () {
          context.pushNamed(AkallanAndDuaWidget.routeName);
        },
      },
    ];

    return Column(
      children: features.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(
              FlutterFlowTheme.of(context).designToken.radius.md,
            ),
            onTap: item['onTap'] as VoidCallback?,
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(
                  FlutterFlowTheme.of(context).designToken.radius.md,
                ),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).alternate,
                ),
              ),
              padding: EdgeInsets.all(
                FlutterFlowTheme.of(context).designToken.spacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 38.0,
                        height: 38.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .primary
                              .withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          item['icon'] as String,
                          style: const TextStyle(fontSize: 20.0),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Text(
                          item['title'] as String,
                          style: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.bold,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 20.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    item['desc'] as String,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.plusJakartaSans(
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          color: const Color(0xFF000000),
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRewardBlock(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(
          FlutterFlowTheme.of(context).designToken.radius.md,
        ),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.4),
          width: 1.5,
        ),
      ),
      padding: EdgeInsets.all(
        FlutterFlowTheme.of(context).designToken.spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🏆',
                style: TextStyle(fontSize: 26.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Din belöning',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Text(
            'Dhikr är inte bara ord som uttalas med tungan. Det är dyrkan som kan ge en enorm belöning och få hjärtat att finna ro. Profeten ﷺ lärde oss att den som minns Allah får en stor belöning. Även en enkel fras av dhikr kan väga tungt på Vågen.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  color: const Color(0xFF000000),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 16.0),
          _buildQuoteItem(
            context,
            '”Kom ihåg Mig, så ska Jag komma ihåg er.”',
          ),
          const SizedBox(height: 8.0),
          _buildQuoteItem(
            context,
            '”I Allahs åminnelse finner hjärtan ro.”',
          ),
        ],
      ),
    );
  }

  Widget _buildQuoteItem(BuildContext context, String quote) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border(
          left: BorderSide(
            color: FlutterFlowTheme.of(context).primary,
            width: 3.5,
          ),
        ),
      ),
      child: Text(
        quote,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.plusJakartaSans(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
              ),
              color: FlutterFlowTheme.of(context).primaryText,
              letterSpacing: 0.0,
              fontStyle: FontStyle.italic,
            ),
      ),
    );
  }

  Widget _buildChallengeBlock(BuildContext context) {
    final challengeSteps = [
      {'icon': '🌅', 'text': 'Morgon Adhkar'},
      {'icon': '📿', 'text': 'Några minuter Tasbih'},
      {'icon': '🤲', 'text': 'En Dua'},
      {'icon': '🌙', 'text': 'Kvälls Adhkar'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(
          FlutterFlowTheme.of(context).designToken.radius.md,
        ),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      padding: EdgeInsets.all(
        FlutterFlowTheme.of(context).designToken.spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                '🔥',
                style: TextStyle(fontSize: 26.0),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Din utmaning',
                      style: FlutterFlowTheme.of(context).titleMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.bold,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Börja enkelt. 7 dagar. Varje dag.',
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                            ),
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: challengeSteps.map((step) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      step['icon']!,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      step['text']!,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16.0),
          Text(
            'Det handlar inte om att göra allt perfekt. Det handlar om att vara konsekvent. Lite varje dag är bättre än mycket som du snart lämnar.',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                  color: const Color(0xFF000000),
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionFooter(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(
          FlutterFlowTheme.of(context).designToken.radius.md,
        ),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary.withValues(alpha: 0.25),
        ),
      ),
      padding: EdgeInsets.all(
        FlutterFlowTheme.of(context).designToken.spacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Börja idag.',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                  ),
                  color: FlutterFlowTheme.of(context).primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '”Ta några minuter för Allah. Kanske blir de minuterna början på en vana som förändrar ditt liv.”',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.plusJakartaSans(
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                  color: FlutterFlowTheme.of(context).primaryText,
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: FlutterFlowTheme.of(context).white,
              minimumSize: const Size(double.infinity, 48.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  FlutterFlowTheme.of(context).designToken.radius.md,
                ),
              ),
              elevation: 0,
            ),
            child: Text(
              'Kom igång med Adhkar',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                    ),
                    color: FlutterFlowTheme.of(context).white,
                    letterSpacing: 0.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
