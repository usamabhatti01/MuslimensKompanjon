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

Future fetchYoutubeVideos() async {
  const apiKey = YouTubeConstants.apiKey;
  const defaultUploadsPlaylistId = YouTubeConstants.defaultUploadsPlaylistId;
  const channelId = YouTubeConstants.channelId;

  int parseDurationToSeconds(String duration) {
    final regex = RegExp(r'PT(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)S)?');
    final match = regex.firstMatch(duration);
    if (match == null) return 0;

    final hours = int.tryParse(match.group(1) ?? '') ?? 0;
    final minutes = int.tryParse(match.group(2) ?? '') ?? 0;
    final seconds = int.tryParse(match.group(3) ?? '') ?? 0;

    return (hours * 3600) + (minutes * 60) + seconds;
  }

  String formatDuration(int totalSeconds) {
    if (totalSeconds <= 0) return '0:00';
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    final secondsStr = seconds.toString().padLeft(2, '0');
    if (hours > 0) {
      final minutesStr = minutes.toString().padLeft(2, '0');
      return '$hours:$minutesStr:$secondsStr';
    } else {
      return '$minutes:$secondsStr';
    }
  }

  String formatViews(String? viewCountStr) {
    if (viewCountStr == null || viewCountStr.isEmpty) return '0 visningar';
    final count = int.tryParse(viewCountStr);
    if (count == null) return viewCountStr;

    if (count >= 1000000) {
      final value = count / 1000000;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}M visningar';
    } else if (count >= 1000) {
      final value = count / 1000;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}K visningar';
    } else {
      return '$count visningar';
    }
  }

  String formatLikes(String? likeCountStr) {
    if (likeCountStr == null || likeCountStr.isEmpty) return '0';
    final count = int.tryParse(likeCountStr);
    if (count == null) return likeCountStr;

    if (count >= 1000000) {
      final value = count / 1000000;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}M';
    } else if (count >= 1000) {
      final value = count / 1000;
      return '${value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 1)}K';
    } else {
      return '$count';
    }
  }

  try {
    final List<String> videoIds = [];
    final Map<String, Map<String, String>> videoInfoMap = {};
    String? nextPageToken;

    // 1. Construct Shorts Playlist ID (UC -> UUSH) and fetch all Shorts video IDs
    final Set<String> shortVideoIds = {};
    final shortsPlaylistId = channelId.startsWith('UC')
        ? 'UUSH' + channelId.substring(2)
        : channelId;
    String? shortsPageToken;

    print("Fetching Shorts playlist items...");
    do {
      String playlistUrl = 'https://www.googleapis.com/youtube/v3/playlistItems'
          '?part=snippet'
          '&playlistId=$shortsPlaylistId'
          '&maxResults=50'
          '&key=$apiKey';
      if (shortsPageToken != null) {
        playlistUrl += '&pageToken=$shortsPageToken';
      }

      final playlistResponse = await http.get(Uri.parse(playlistUrl));
      if (playlistResponse.statusCode != 200) {
        print(
            "Failed to load Shorts playlist. Code: ${playlistResponse.statusCode}");
        break;
      }

      final playlistData = json.decode(playlistResponse.body);
      final fetchedItems = playlistData['items'] as List<dynamic>?;
      if (fetchedItems == null || fetchedItems.isEmpty) {
        break;
      }

      for (final item in fetchedItems) {
        final snippet = item['snippet'];
        final videoId = snippet['resourceId']?['videoId'] as String?;
        if (videoId != null && videoId.isNotEmpty) {
          shortVideoIds.add(videoId);
        }
      }

      shortsPageToken = playlistData['nextPageToken'] as String?;
    } while (shortsPageToken != null);

    print("Total Shorts identified: ${shortVideoIds.length}");

    // 2. Fetch uploads playlist items
    print("Fetching uploads playlist items...");
    do {
      String playlistUrl = 'https://www.googleapis.com/youtube/v3/playlistItems'
          '?part=snippet'
          '&playlistId=$defaultUploadsPlaylistId'
          '&maxResults=50'
          '&key=$apiKey';
      if (nextPageToken != null) {
        playlistUrl += '&pageToken=$nextPageToken';
      }

      final playlistResponse = await http.get(Uri.parse(playlistUrl));
      if (playlistResponse.statusCode != 200) {
        print(
            "Failed to load uploads playlist items. Code: ${playlistResponse.statusCode}");
        break;
      }

      final playlistData = json.decode(playlistResponse.body);
      final fetchedItems = playlistData['items'] as List<dynamic>?;
      if (fetchedItems == null || fetchedItems.isEmpty) {
        break;
      }

      for (final item in fetchedItems) {
        final snippet = item['snippet'];
        final videoId = snippet['resourceId']?['videoId'] as String?;
        final title = snippet['title'] as String? ?? '';
        final description = snippet['description'] as String? ?? '';
        final thumbnails = snippet['thumbnails'];
        final thumbnail = thumbnails?['maxres']?['url'] as String? ??
            thumbnails?['high']?['url'] as String? ??
            thumbnails?['medium']?['url'] as String? ??
            thumbnails?['default']?['url'] as String? ??
            '';

        if (videoId != null && videoId.isNotEmpty) {
          videoIds.add(videoId);
          videoInfoMap[videoId] = {
            'title': title,
            'description': description,
            'thumbnail': thumbnail,
            'publishedAt': snippet['publishedAt'] as String? ?? '',
          };
        }
      }

      nextPageToken = playlistData['nextPageToken'] as String?;
    } while (nextPageToken != null);

    print("Total uploads fetched: ${videoIds.length}");

    if (videoIds.isEmpty) return;

    final List<dynamic> allVideoItems = [];
    // 3. Fetch video details in chunks of 50
    for (int i = 0; i < videoIds.length; i += 50) {
      final chunk = videoIds.sublist(
          i, i + 50 > videoIds.length ? videoIds.length : i + 50);
      final idsParameter = chunk.join(',');
      final videosUrl = 'https://www.googleapis.com/youtube/v3/videos'
          '?part=contentDetails,statistics'
          '&id=$idsParameter'
          '&key=$apiKey';

      final videosResponse = await http.get(Uri.parse(videosUrl));
      if (videosResponse.statusCode != 200) {
        print(
            "Failed to fetch video details chunk. Code: ${videosResponse.statusCode}");
        continue;
      }

      final videosData = json.decode(videosResponse.body);
      final videoItems = videosData['items'] as List<dynamic>?;
      if (videoItems != null) {
        allVideoItems.addAll(videoItems);
      }
    }

    final List<YoutubeStruct> youtubeList = [];
    final List<YoutubeStruct> reelsList = [];

    for (final videoItem in allVideoItems) {
      final id = videoItem['id'] as String?;
      final contentDetails = videoItem['contentDetails'];
      final durationStr = contentDetails?['duration'] as String? ?? '';

      final statistics = videoItem['statistics'];
      final viewCountStr = statistics?['viewCount'] as String?;
      final likeCountStr = statistics?['likeCount'] as String?;

      if (id == null || !videoInfoMap.containsKey(id)) continue;

      final totalSeconds = parseDurationToSeconds(durationStr);
      final title = videoInfoMap[id]!['title']!;
      final description = videoInfoMap[id]!['description']!;
      final thumbnail = videoInfoMap[id]!['thumbnail'] ?? '';
      final publishedAtStr = videoInfoMap[id]!['publishedAt'] ?? '';
      final videoUrl = 'https://www.youtube.com/watch?v=$id';

      final youtubeItem = YoutubeStruct(
        video: videoUrl,
        title: title,
        topic: description,
        views: formatViews(viewCountStr),
        likes: formatLikes(likeCountStr),
        duration: formatDuration(totalSeconds),
        thumbnail: thumbnail,
        postDate: publishedAtStr.isNotEmpty
            ? DateTime.tryParse(publishedAtStr)
            : null,
      );

      // Classify as Reel if it belongs to the channel's Shorts playlist (shortVideoIds)
      if (shortVideoIds.contains(id)) {
        reelsList.add(youtubeItem);
      } else {
        youtubeList.add(youtubeItem);
      }
    }

    // 4. Update App State
    FFAppState().update(() {
      FFAppState().youtubeData = youtubeList;
      FFAppState().reelsData = reelsList;
    });

    print(
        "Success: Fetched ${youtubeList.length} videos and ${reelsList.length} Reels from uploads playlist.");
  } catch (e) {
    print("Error in fetchYoutubeVideos: $e");
  }
}
//
