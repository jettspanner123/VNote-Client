import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/shared/components/page/appbar.dart';
import 'package:vnote_client/shared/components/page/application_bar_back_button.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';
import 'package:vnote_client/utils/ui_helper.dart';

class TransactionSearchScreen extends StatefulWidget {
  const TransactionSearchScreen({super.key});

  @override
  State<TransactionSearchScreen> createState() => _TransactionSearchScreenState();
}

class _TransactionSearchScreenState extends State<TransactionSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final globalColorModeBloc = context.watch<GlobalColorModeControllerBloc>();
    final colorMode = globalColorModeBloc.state.colorMode;
    final textColor = UIHelper.current.getTextColorForColorMode(colorMode);

    return Scaffold(
      backgroundColor: UIHelper.current.getBackgroundColorForColorMode(colorMode),
      body: Stack(
        children: [
          // Blank Body for now (will populate with details later)
          Positioned.fill(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 130, left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(
                    Icons.search_rounded,
                    size: 80,
                    color: textColor.withAlpha(50),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Search Transactions",
                    style: UIHelper.current.funnelTextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textColor.withAlpha(120),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Custom floating AppbarComponent with Back button
          AppbarComponent(
            children: [
              const ApplicationBarBackButtonComponent(),
              Text(
                "Search",
                style: UIHelper.current.funnelTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 50), // Center the header title
            ],
          ),
        ],
      ),
    );
  }
}
