import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.event.dart';
import 'package:vnote_client/store/global_bloc/global_color_mode.value.dart';

import '../../constants/color_factory.dart';

class GlobalColorModeControllerBloc extends Bloc<GlobalColorModeControllerEvent, GlobalColorModeControllerState> {
  GlobalColorModeControllerBloc() : super(GlobalColorModeControllerState(colorMode: AppColorMode.DARK)) {
    on<GlobalColorModeChangedToLight>((event, emit) {
      emit(GlobalColorModeControllerState(colorMode: AppColorMode.LIGHT));
    });

    on<GlobalColorModeChangedToDark>((event, emit) {
      emit(GlobalColorModeControllerState(colorMode: AppColorMode.DARK));
    });
  }
}
