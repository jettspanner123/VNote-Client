import "dart:ui";

import "package:client/components/shared/custom_hover_effect.dart";
import "package:client/models/sign_up_section_onboarding_progress_options.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:google_fonts/google_fonts.dart";
import "package:video_player/video_player.dart";
import "package:window_manager/window_manager.dart";

import "current_registration_state_widget.dart";

class RegistrationScreenGraphicSection extends StatefulWidget {
  final SignUpSectionOnboardingOptions currentSelectedOnboarding;

  const RegistrationScreenGraphicSection({
    super.key,
    required this.currentSelectedOnboarding,
  });

  @override
  State<RegistrationScreenGraphicSection> createState() =>
      _RegistrationScreenGraphicSectionState();
}

class _RegistrationScreenGraphicSectionState
    extends State<RegistrationScreenGraphicSection> {
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _controller.dispose();
  }

  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                // MARK: Video Player
                ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 50, sigmaX: 50),
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
                  padding: const EdgeInsets.fromLTRB(80, 80, 80, 80),
                  child: Column(
                    spacing: 50,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // MARK: Exit Button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    await windowManager.close();
                                  },
                                  child: CustomHoverEffect(
                                    cursorType: SystemMouseCursors.click,
                                    builder: (isHovering) {
                                      return AnimatedContainer(
                                        duration: Duration(milliseconds: 150),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          color: isHovering
                                              ? Colors.transparent
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 16,
                                          ),
                                          child: Row(
                                            spacing: 10,
                                            children: [
                                              Icon(
                                                FontAwesomeIcons
                                                    .rightFromBracket,
                                                color: isHovering
                                                    ? Colors.white
                                                    : Colors.black,
                                              ),
                                              Text(
                                                "Exit",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  color: isHovering
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            // MARK: Change Theme Button
                            CustomHoverEffect(
                              cursorType: SystemMouseCursors.click,
                              builder: (isHovering) {
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 150),
                                  decoration: BoxDecoration(
                                    color: isHovering
                                        ? Colors.transparent
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Icon(
                                      FontAwesomeIcons.moon,
                                      color: isHovering
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      Spacer(),
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
                                color: Colors.white.withValues(alpha: 0.5),
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
                            indexT: 0,
                            index: SignUpSectionOnboardingOptions
                                .personAccountSetup,
                            currentSelectedIndex:
                                widget.currentSelectedOnboarding,
                            description: "Sign up your account",
                          ),
                          CurrentRegistrationStateWidget(
                            indexT: 1,
                            index:
                                SignUpSectionOnboardingOptions.workspaceSetup,
                            currentSelectedIndex:
                                widget.currentSelectedOnboarding,
                            description: "Set up your workspace",
                          ),
                          CurrentRegistrationStateWidget(
                            indexT: 2,
                            index: SignUpSectionOnboardingOptions.profileSetup,
                            currentSelectedIndex:
                                widget.currentSelectedOnboarding,
                            description: "Set up your profile",
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
    );
  }
}
