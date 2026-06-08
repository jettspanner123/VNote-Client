import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/constants/color_factory.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_field.dart';
import 'package:vnote_client/shared/components/inputs/standard_input_label.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class DashboardTransferMoneyCreateUserController extends StatefulWidget {
  final void Function({required String fullName, required String phoneNumber, String? email})? onSubmit;

  const DashboardTransferMoneyCreateUserController({super.key, this.onSubmit});

  @override
  State<DashboardTransferMoneyCreateUserController> createState() => DashboardTransferMoneyCreateUserControllerState();
}

class DashboardTransferMoneyCreateUserControllerState extends State<DashboardTransferMoneyCreateUserController> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit?.call(
      fullName: _fullNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      email: _emailController.text.trim().isEmpty ? null : _emailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: UIHelper.current.getValueAccordingToColorMode(
                colorMode: colorMode,
                darkValue: ColorFactory.darkForegroundColor,
                lightValue: Colors.white,
              ),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StandardInputLabelComponent(text: "Full Name", secondaryText: "Required"),
                    StandardInputField(
                      textController: _fullNameController,
                      placeholder: "e.g. Aarav Sharma",
                      icon: const Icon(Icons.person_outline_rounded, size: 20),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Full name is required";
                        if (value.trim().length < 2) return "Name must be at least 2 characters";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    StandardInputLabelComponent(text: "Phone Number", secondaryText: "Required"),
                    StandardInputField(
                      textController: _phoneController,
                      placeholder: "e.g. +91 98765 43210",
                      icon: const Icon(Icons.phone_outlined, size: 20),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s\-()]'))],
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return "Phone number is required";
                        final digits = value.replaceAll(RegExp(r'\D'), '');
                        if (digits.length < 7) return "Enter a valid phone number";
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    StandardInputLabelComponent(text: "Email", secondaryText: "Optional"),
                    StandardInputField(
                      textController: _emailController,
                      placeholder: "e.g. aarav@gmail.com",
                      icon: const Icon(Icons.mail_outline_rounded, size: 20),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) return null;
                        final emailRegex = RegExp(r'^[\w\.\+\-]+@[\w\-]+\.[a-zA-Z]{2,}$');
                        if (!emailRegex.hasMatch(value.trim())) return "Enter a valid email address";
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
