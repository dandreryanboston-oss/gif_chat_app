import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/chat/presentation/pages/chat_page.dart';
import 'features/chat/presentation/providers/chat_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

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

        title: 'GIF Chat',

        themeMode: ThemeMode.dark,

        /// LIGHT THEME
        theme: ThemeData(
          useMaterial3: true,

          brightness: Brightness.light,

          fontFamily:
              GoogleFonts.poppins().fontFamily,

          scaffoldBackgroundColor:
              const Color(0xffECE5DD),

          colorScheme: ColorScheme.fromSeed(
            seedColor:
                const Color(0xff6C3BD0),
          ),

          appBarTheme: AppBarTheme(
            elevation: 0,

            centerTitle: false,

            backgroundColor:
                const Color(0xff6C3BD0),

            foregroundColor: Colors.white,

            titleTextStyle:
                GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          inputDecorationTheme:
              InputDecorationTheme(
            filled: true,

            fillColor: Colors.white,

            hintStyle: TextStyle(
              color:
                  Colors.grey.shade500,
            ),

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              borderSide: BorderSide.none,
            ),

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              borderSide: BorderSide.none,
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              borderSide:
                  const BorderSide(
                color:
                    Color(0xff6C3BD0),
                width: 1.5,
              ),
            ),
          ),
        ),

        /// DARK THEME
        darkTheme: ThemeData(
          useMaterial3: true,

          brightness: Brightness.dark,

          fontFamily:
              GoogleFonts.poppins().fontFamily,

          scaffoldBackgroundColor:
              const Color(0xff0F0F12),

          colorScheme: ColorScheme.dark(
            primary:
                const Color(0xff7C4DFF),

            secondary:
                Colors.deepPurpleAccent,
          ),

          appBarTheme: AppBarTheme(
            elevation: 0,

            backgroundColor:
                const Color(0xff17171C),

            foregroundColor: Colors.white,

            titleTextStyle:
                GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          inputDecorationTheme:
              InputDecorationTheme(
            filled: true,

            fillColor:
                const Color(0xff1D1D25),

            hintStyle: TextStyle(
              color:
                  Colors.grey.shade500,
            ),

            contentPadding:
                const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              borderSide: BorderSide.none,
            ),

            enabledBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              borderSide: BorderSide.none,
            ),

            focusedBorder:
                OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(
                30,
              ),

              borderSide:
                  const BorderSide(
                color:
                    Color(0xff7C4DFF),
                width: 1.5,
              ),
            ),
          ),
        ),

        home: const ChatPage(),
      ),
    );
  }
}