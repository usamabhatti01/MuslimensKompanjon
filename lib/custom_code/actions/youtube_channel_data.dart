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

import 'dart:convert';
import 'package:http/http.dart' as http;
import '/app_state.dart';
import '/custom_code/actions/constants.dart';

Future youtubeChannelData() async {
  const apiKey = YouTubeConstants.apiKey;
  const channelId = YouTubeConstants.channelId;

  try {
    final channelUrl = 'https://www.googleapis.com/youtube/v3/channels'
        '?part=snippet,statistics'
        '&id=$channelId'
        '&key=$apiKey';

    print("Fetching channel details from YouTube...");
    final channelResponse = await http.get(Uri.parse(channelUrl));
    if (channelResponse.statusCode == 200) {
      final channelDataMap = json.decode(channelResponse.body);
      final channelItems = channelDataMap['items'] as List<dynamic>?;
      if (channelItems != null && channelItems.isNotEmpty) {
        final channelItem = channelItems[0];
        final snippet = channelItem['snippet'];
        final statistics = channelItem['statistics'];

        final channelName = snippet['title'] as String? ?? '';
        final channelDesc = snippet['description'] as String? ?? '';
        final channelImage =
            snippet['thumbnails']?['medium']?['url'] as String? ??
                snippet['thumbnails']?['default']?['url'] as String? ??
                '';

        final subCountStr = statistics?['subscriberCount'] as String?;
        String formatSubscribers(String? countStr) {
          if (countStr == null || countStr.isEmpty) return '0 prenumeranter';
          final count = int.tryParse(countStr);
          if (count == null) return '$countStr prenumeranter';

          if (count >= 1000000) {
            final value = count / 1000000;
            return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}M prenumeranter';
          } else if (count >= 1000) {
            final value = count / 1000;
            return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}K prenumeranter';
          } else {
            return '$count prenumeranter';
          }
        }

        final channelFollowers = formatSubscribers(subCountStr);

        final channelStruct = ChannelStruct(
          name: channelName,
          description: channelDesc,
          image: channelImage,
          followers: channelFollowers,
        );

        FFAppState().update(() {
          FFAppState().channelData = channelStruct;
        });

        print("Success: Updated channel data.");
      }
    }
  } catch (e) {
    print("Error fetching channel details: $e");
  }
}
