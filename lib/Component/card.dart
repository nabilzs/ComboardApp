import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:intl/intl.dart';

class ComboardCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String loginto; // "Internal" | "Student" | "Teacher" | "Parent"

  const ComboardCard({
    super.key,
    required this.item,
    required this.loginto,
  });

  String formatDateRange(dynamic start, dynamic end) {
    if (start == null || end == null) {
      return "";
    }
    try {
      final DateTime date1 = DateTime.parse(start.toString());
      final DateTime date2 = DateTime.parse(end.toString());
      final DateFormat formatter = DateFormat('dd MMM yyyy');

      if (date1.isAtSameMomentAs(date2)) {
        return formatter.format(date1);
      }
      return "${formatter.format(date1)} - ${formatter.format(date2)}";
    } catch (e) {
      return "-";
    }
  }

  String? extractYouTubeId(String? url) {
    if (url == null || url.isEmpty) return null;
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    } else if (uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.last;
    }
    return null;
  }

  bool _canShow() {
    if (loginto == "Internal") return true; // admin lihat semua

    if (loginto == "Student") {
      return item["to_student"] == true;
    } else if (loginto == "Teacher") {
      return item["to_teacher"] == true;
    } else if (loginto == "Parent") {
      return item["to_parent"] == true;
    }

    return false; // default jangan tampil
  }

  @override
  Widget build(BuildContext context) {
    if (!_canShow()) {
      return const SizedBox.shrink(); // kalau gak boleh tampil, return kosong
    }

    // ambil gambar base64
    String? base64Image;
    if (item['file_img'] != null && item['file_img'].isNotEmpty) {
      base64Image = item['file_img'][0].split(',').last.trim();
    }

    // ambil link youtube
    String? youtubeId = extractYouTubeId(item['link_url']);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  IconButton(
                    icon: const Icon(
                      Icons.library_books,
                      color: Color.fromRGBO(21, 39, 81, 1),
                    ),
                    onPressed: () {},
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 60,
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(
                    width: 360,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'] ?? 'No title',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromRGBO(21, 39, 81, 1),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              item['creator'] ?? "",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              formatDateRange(
                                  item['datetime_1'], item['datetime_2']),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ]),
                    ),
                  ),
                  if (loginto == "Internal")
                    Container(
                      height: 70,
                      child: const Icon(
                        Icons.more_vert,
                        color: Color.fromRGBO(21, 39, 81, 1),
                      ),
                    )
                ]),
                const Divider(height: 1),

                Html(
                  data: item['info'] ?? 'No info',
                  style: {
                    "p": Style(
                      fontSize: FontSize(14),
                      color: Colors.black87,
                    ),
                  },
                ),

                const Divider(height: 1),

                if (base64Image != null)
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        base64Decode(base64Image),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                if (youtubeId != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12),
                    child: YoutubePlayer(
                      controller: YoutubePlayerController.fromVideoId(
                        videoId: youtubeId,
                        autoPlay: false,
                        params: const YoutubePlayerParams(
                          showFullscreenButton: true,
                          showControls: true,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
