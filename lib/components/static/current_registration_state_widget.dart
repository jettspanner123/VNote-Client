import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class CurrentRegistrationStateWidget extends StatefulWidget {
  final int index;
  final int currentSelectedIndex;
  final String description;

  const CurrentRegistrationStateWidget({
    super.key,
    required this.index,
    required this.currentSelectedIndex,
    required this.description,
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
            spacing: 20,
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
                    color: widget.index == widget.currentSelectedIndex
                        ? Colors.black
                        : Colors.white.withValues(alpha: 0.25),
                  ),
                  child: Text(
                    (widget.index + 1).toString(),
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // MARK: Card Description
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.description,
                  style: GoogleFonts.roboto(
                    fontSize: 17,
                    color: widget.index == widget.currentSelectedIndex
                        ? Colors.black
                        : Colors.white.withValues(alpha: 0.6),
                    fontWeight: widget.index == widget.currentSelectedIndex
                        ? FontWeight.w500
                        : FontWeight.w400,
                  ),
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
