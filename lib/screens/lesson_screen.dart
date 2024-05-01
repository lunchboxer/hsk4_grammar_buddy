import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class LessonScreen extends StatelessWidget {
  final String lessonTitle;
  final String lessonContent;

  const LessonScreen({
    super.key,
    required this.lessonTitle,
    required this.lessonContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(lessonTitle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: HtmlWidget(
              lessonContent,
              textStyle: TextStyle(
                fontSize: 16.0,
                fontFamily: 'CustomFont',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
