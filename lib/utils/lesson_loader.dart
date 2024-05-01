import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:markdown/markdown.dart' as md;

class LessonLoader {
  static Future<List<Map<String, String>>> loadLessons() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    final lessonPaths = manifestMap.keys
        .where((path) => path.startsWith('assets/lessons/'))
        .where((path) => path.endsWith('.md'))
        .toList();

    return Future.wait(lessonPaths.map((path) async {
      final markdownData = await rootBundle.loadString(path);
      final lines = markdownData.split('\n');
      final title = _extractTitleFromFirstLine(lines.first);
      // remove header line and blank line after it before assigning to content
      final contentLines = lines.sublist(1).where((line) => line.isNotEmpty);
      final contentMarkdownData = contentLines.join('\n');
      final content = md.markdownToHtml(contentMarkdownData);
      return {'title': title, 'content': content};
    }));
  }

  static String _extractTitleFromFirstLine(String firstLine) {
    if (firstLine.startsWith('# ')) {
      return firstLine.substring(2).trim();
    } else {
      return firstLine.trim();
    }
  }
}
