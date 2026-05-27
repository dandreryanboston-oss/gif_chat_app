import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/chat/presentation/pages/chat_page.dart';
import 'features/chat/presentation/providers/chat_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => ChatProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        themeMode: ThemeMode.dark,

        darkTheme: ThemeData.dark().copyWith(

          scaffoldBackgroundColor:
              const Color(0xFF121212),

          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E1E1E),
          ),

          inputDecorationTheme:
              InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade900,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(15),
            ),
          ),
        ),

        home: const ChatPage(),
      ),
    );
  }
}