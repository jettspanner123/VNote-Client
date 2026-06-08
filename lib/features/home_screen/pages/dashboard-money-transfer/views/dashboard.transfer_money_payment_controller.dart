import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_button_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_counter_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/components/dashboard.number_preset_controller.dart';
import 'package:vnote_client/features/home_screen/pages/dashboard-money-request/constants/dashboard.money_request_constants.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.bloc.dart';

class DashboardTransferMoneyPaymentController extends StatefulWidget {
  final String initialValue;
  final void Function(String value)? onValueChanged;
  final VoidCallback selectUserButtonAction;

  const DashboardTransferMoneyPaymentController({
    super.key,
    this.initialValue = "0",
    this.onValueChanged,
    required this.selectUserButtonAction,
  });

  @override
  State<DashboardTransferMoneyPaymentController> createState() => DashboardTransferMoneyPaymentControllerState();
}

class DashboardTransferMoneyPaymentControllerState extends State<DashboardTransferMoneyPaymentController> {
  late String _enteredValue;

  @override
  void initState() {
    super.initState();
    _enteredValue = widget.initialValue;
  }

  void _setValue(String value) {
    setState(() => _enteredValue = value);
    widget.onValueChanged?.call(value);
  }

  void _onNumberButtonTap(String value) {
    final backspace = DashboardMoneyRequestConstants.current.NUMBER_BUTTON_BACKSPACE_IDENTIFIER;
    if (value == backspace) {
      _setValue(_enteredValue.length <= 1 ? "0" : _enteredValue.substring(0, _enteredValue.length - 1));
      return;
    }
    if (value == "." && _enteredValue.contains(".")) return;
    if (_enteredValue == "0" && value != ".") {
      _setValue(value);
    } else {
      _setValue(_enteredValue + value);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<GlobalColorModeControllerBloc>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
          child: DashboardNumberCounterController(enteredRequestMoneyValue: _enteredValue),
        ),
        const SizedBox(height: 14),
        DashboardNumberPresetController(currentValue: _enteredValue, onPresetTap: (value) => _setValue(value)),
        const SizedBox(height: 14),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: DashboardNumberButtonController(onButtonTap: _onNumberButtonTap),
          ),
        ),
      ],
    );
  }
}
