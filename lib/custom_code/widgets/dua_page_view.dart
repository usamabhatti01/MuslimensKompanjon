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

import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class DuaPageView extends StatefulWidget {
  const DuaPageView({
    super.key,
    this.width,
    this.height,
    this.duaList,
  });

  final double? width;
  final double? height;
  final List<DuaChildStruct>? duaList;

  @override
  State<DuaPageView> createState() => _DuaPageViewState();
}

class _DuaPageViewState extends State<DuaPageView>
    with RouteAware, WidgetsBindingObserver {
  int? _selectedIndex;

  // Keys and ScrollController for auto-scrolling
  final Map<int, GlobalKey> _itemKeys = {};
  late ScrollController _scrollController;

  GlobalKey _getKey(int index) {
    return _itemKeys.putIfAbsent(index, () => GlobalKey());
  }

  Future<void> _triggerHaptic() async {
    if (FFAppState().haptic) {
      try {
        HapticFeedback.lightImpact();
      } catch (_) {}
      try {
        final hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator == true) {
          Vibration.vibrate(duration: 40);
        }
      } catch (_) {}
    }
  }

  Widget _buildArabicRichText({
    required String text,
    required double fontSize,
    required Color textColor,
    double height = 2.0,
    FontWeight fontWeight = FontWeight.bold,
    TextAlign textAlign = TextAlign.right,
  }) {
    final trimmed = text.trim();
    final ayahRegex = RegExp(r'۝([0-9\u0660-\u0669]+)');
    final matches = ayahRegex.allMatches(trimmed);

    if (matches.isEmpty) {
      return Text(
        trimmed,
        textAlign: textAlign,
        textDirection: ui.TextDirection.rtl,
        style: GoogleFonts.scheherazadeNew(
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height,
          color: textColor,
        ),
      );
    }

    final List<InlineSpan> spans = [];
    int lastEnd = 0;

    for (final match in matches) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: trimmed.substring(lastEnd, match.start),
            style: GoogleFonts.scheherazadeNew(
              fontSize: fontSize,
              fontWeight: fontWeight,
              height: height,
              color: textColor,
            ),
          ),
        );
      }

      final digits = match.group(1)!;
      final digitFontSize = digits.length >= 3
          ? fontSize * 0.28
          : (digits.length == 2 ? fontSize * 0.34 : fontSize * 0.40);

      spans.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            width: fontSize * 1.15,
            height: fontSize * 1.15,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  '۝',
                  textDirection: ui.TextDirection.rtl,
                  style: GoogleFonts.scheherazadeNew(
                    fontSize: fontSize * 1.05,
                    height: 1.0,
                    color: textColor,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 1.0),
                    child: Text(
                      digits,
                      textDirection: ui.TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.scheherazadeNew(
                        fontSize: digitFontSize,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < trimmed.length) {
      spans.add(
        TextSpan(
          text: trimmed.substring(lastEnd),
          style: GoogleFonts.scheherazadeNew(
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: height,
            color: textColor,
          ),
        ),
      );
    }

    return Text.rich(
      TextSpan(children: spans),
      textAlign: textAlign,
      textDirection: ui.TextDirection.rtl,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  void _clearSelection() {
    _selectedIndex = null;
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });
    }
  }

  @override
  void didPushNext() {
    _clearSelection();
    super.didPushNext();
  }

  @override
  void didPop() {
    _clearSelection();
    super.didPop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _clearSelection();
    }
  }

  @override
  void deactivate() {
    _clearSelection();
    super.deactivate();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToItem(int index) {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      final key = _itemKeys[index];
      final context = key?.currentContext;
      if (context != null) {
        final RenderBox? box = context.findRenderObject() as RenderBox?;
        final ScrollableState? scrollable = Scrollable.of(context);
        final RenderBox? scrollBox =
            scrollable?.context.findRenderObject() as RenderBox?;
        if (box != null && scrollBox != null) {
          final position = box.localToGlobal(Offset.zero);
          final scrollPosition = scrollBox.localToGlobal(Offset.zero);
          final cardTopInViewport = position.dy - scrollPosition.dy;
          final currentOffset = _scrollController.offset;
          final maxScroll = _scrollController.position.maxScrollExtent;
          final targetOffset =
              (currentOffset + cardTopInViewport).clamp(0.0, maxScroll);

          _scrollController.animateTo(
            targetOffset,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );
          return;
        }
      }

      // Fallback if not rendered yet
      final maxScroll = _scrollController.position.maxScrollExtent;
      final estimatedOffset = (index * 400.0).clamp(0.0, maxScroll);
      _scrollController.animateTo(
        estimatedOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final duaSettings = FFAppState().DuasSetting;
    final list = widget.duaList ?? [];
    final arFont = duaSettings.arFont;
    final swFont = duaSettings.swFont;
    final enFont = duaSettings.enFont;
    final arActive = duaSettings.arActive;
    final swActive = duaSettings.swActive;
    final enActive = duaSettings.enActive;

    if (list.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.menu_book_outlined,
                size: 48.0,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
              const SizedBox(height: 12.0),
              Text(
                'Inga dua tillgängliga ännu',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 16.0,
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: ListView.builder(
        controller: _scrollController,
        cacheExtent: 50000.0,
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          top: 12.0,
          bottom: 24.0,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          final isHighlighted = _selectedIndex == index;
          // Resolve display titles
          final titleSwedish = item.titleSv.trim();
          final titleArabic = item.titleAr.trim();
          final transliteration = item.translitterering.trim();
          final sourceText = item.source.trim();
          final statusText = item.status.trim();

          return InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
            onTap: () {
              _triggerHaptic();
              setState(() {
                if (_selectedIndex == index) {
                  _selectedIndex = null;
                } else {
                  _selectedIndex = index;
                  _scrollToItem(index);
                }
              });
            },
            child: Container(
              key: _getKey(index),
              margin: const EdgeInsets.only(bottom: 16.0),
              decoration: BoxDecoration(
                color: isHighlighted
                    ? FlutterFlowTheme.of(context)
                        .primary
                        .withValues(alpha: 0.05)
                    : FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: isHighlighted
                      ? FlutterFlowTheme.of(context).primary
                      : FlutterFlowTheme.of(context)
                          .alternate
                          .withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isHighlighted
                        ? FlutterFlowTheme.of(context)
                            .primary
                            .withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.04),
                    blurRadius: isHighlighted ? 10.0 : 6.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Arabic Text / Title
                  if (arActive && item.arabic.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 14.0,
                        bottom: 6.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (titleArabic.isNotEmpty &&
                              titleArabic != item.arabic.trim())
                            Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Text(
                                titleArabic,
                                textAlign: TextAlign.right,
                                textDirection: ui.TextDirection.rtl,
                                style: GoogleFonts.scheherazadeNew(
                                  fontSize: (arFont + 4.0).clamp(20.0, 38.0),
                                  fontWeight: FontWeight.w800,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: _buildArabicRichText(
                              text: item.arabic,
                              fontSize: arFont,
                              textColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Dua Title in Swedish (if enabled)
                  if ((swActive || enActive) && titleSwedish.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 8.0,
                        bottom: 4.0,
                      ),
                      child: Text(
                        titleSwedish,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.manrope(
                          fontSize: (swFont + 3.0).clamp(17.0, 28.0),
                          fontWeight: FontWeight.w800,
                          color: FlutterFlowTheme.of(context).primary,
                          height: 1.35,
                        ),
                      ),
                    ),

                  // Transliteration (if English/Transliteration is active)
                  if (enActive && transliteration.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 6.0,
                        bottom: 6.0,
                      ),
                      child: Text(
                        transliteration,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.manrope(
                          fontSize: enFont,
                          color: const Color(0xFF727272),
                          height: 1.5,
                        ),
                      ),
                    ),

                  // Swedish translation text
                  if (swActive && item.swedish.trim().isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 6.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        item.swedish.trim(),
                        textAlign: TextAlign.start,
                        style: GoogleFonts.manrope(
                          fontSize: swFont,
                          color: FlutterFlowTheme.of(context).primaryText,
                          height: 1.5,
                        ),
                      ),
                    ),

                  // Source & Status footer
                  if (sourceText.isNotEmpty || statusText.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 4.0,
                        bottom: 12.0,
                      ),
                      child: Row(
                        children: [
                          if (sourceText.isNotEmpty)
                            Expanded(
                              child: Text(
                                sourceText,
                                style: GoogleFonts.manrope(
                                  fontSize: (swFont - 4.5).clamp(10.5, 18.0),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                              ),
                            ),
                          if (statusText.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                                vertical: 2.0,
                              ),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Text(
                                statusText,
                                style: GoogleFonts.manrope(
                                  fontSize: (swFont - 5.5).clamp(9.5, 16.0),
                                  fontWeight: FontWeight.w600,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    )
                  else
                    const SizedBox(height: 8.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
