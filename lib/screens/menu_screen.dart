import 'package:flutter/material.dart';
import '../utils/lesson_loader.dart';
import 'lesson_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  late Future<List<Map<String, String>>> lessonsFuture;

  @override
  void initState() {
    super.initState();
    lessonsFuture = LessonLoader.loadLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('HSK 4 Grammar Buddy'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lessons = snapshot.data!;
            return ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                return ListTile(
                  title: Text(lesson['title']!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonScreen(
                          key: ValueKey(lesson['title']),
                          lessonTitle: lesson['title']!,
                          lessonContent: lesson['content']!,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
