import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnote_client/constants/color_factory.dart';

class OtpInputField extends StatefulWidget {
  final Function(String)? onChange;
  final bool autoFocus;
  final TextEditingController textEditingController;
  final bool wantNextFocus;
  const OtpInputField({
    super.key,
    this.onChange,
    this.autoFocus = false,
    required this.textEditingController,
    this.wantNextFocus = true,
  });

  @override
  State<OtpInputField> createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        focusNode: _focusNode,
        onChanged: (value) {
          widget.onChange?.call(value);
          if (value.length == 1 && widget.wantNextFocus) {
            FocusScope.of(context).nextFocus();
          }
        },
        style: Theme.of(context).textTheme.headlineLarge,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          hint: Text(
            "_",
            textAlign: TextAlign.center,
            style: GoogleFonts.funnelSans(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.black.withAlpha(50)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black.withAlpha(90), width: 2),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black.withAlpha(90), width: 0.3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorFactory.accentColor, width: 2),
          ),
        ),
      ),
    );
  }
}
