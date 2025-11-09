import "dart:ffi";
import "dart:ui";

import "package:client/library/window_helper_functions.dart";
import "package:client/store/theme_provider.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";
import "package:video_player/video_player.dart";

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = VideoPlayerController.asset("assets/gradient.mp4")
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
    currentSelectedOption = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  late VideoPlayerController _controller;
  late int currentSelectedOption;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, value, child) => Scaffold(
        body: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          // color: value.currentTheme.colorScheme.surface,
          // color: Colors.black,
          color: Colors.white,
          child: Row(
            children: [
              // MARK: Graphics Section
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          // MARK: Video Player
                          ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaY: 50,
                              sigmaX: 50,
                            ),
                            child: _controller.value.isInitialized
                                ? Transform.scale(
                                    scale: 1.2,
                                    child: VideoPlayer(_controller),
                                  )
                                : const CircularProgressIndicator(),
                          ),

                          // MARK: Front Black Sheet
                          Container(color: Colors.black.withValues(alpha: 0.5)),

                          // MARK: Graphics Content
                          Padding(
                            padding: const EdgeInsets.fromLTRB(80, 0, 80, 80),
                            child: Column(
                              spacing: 50,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // MARK: Bottom Heading and Description
                                Row(
                                  spacing: 20,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Get Started with US",
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 45,
                                            height: 1.1,
                                          ),
                                        ),
                                      ),
                                    ),

                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Complete these easy steps to register your account",
                                        style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          height: 1.2,
                                          color: Colors.white.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                // MARK: Current Ongoing Steps
                                Row(
                                  spacing: 20,
                                  children: [
                                    CurrentRegistrationStateWidget(
                                      index: 0,
                                      currentSelectedIndex:
                                          currentSelectedOption,
                                    ),
                                    CurrentRegistrationStateWidget(
                                      index: 1,
                                      currentSelectedIndex:
                                          currentSelectedOption,
                                    ),
                                    CurrentRegistrationStateWidget(
                                      index: 2,
                                      currentSelectedIndex:
                                          currentSelectedOption,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // MARK: Content Section
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: WindowHelperFunctions.applyFullScreenWindowOptions,
                  child: Text("Toggle Window"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentRegistrationStateWidget extends StatefulWidget {
  final int index;
  final int currentSelectedIndex;

  const CurrentRegistrationStateWidget({
    super.key,
    required this.index,
    required this.currentSelectedIndex,
  });

  @override
  State<CurrentRegistrationStateWidget> createState() =>
      _CurrentRegistrationStateWidgetState();
}

class _CurrentRegistrationStateWidgetState
    extends State<CurrentRegistrationStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.index == widget.currentSelectedIndex
              ? Colors.white
              : Colors.white.withValues(alpha: 0.15),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: Column(
            spacing: 30,
            children: [
              // MARK: Card Number
              Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 30,
                  width: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                  child: Text(
                    "1",
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              Text(
                "Sign up you account",
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),

      // MARK: Card Description
    );
  }
}
