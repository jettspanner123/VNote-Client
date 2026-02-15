import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vnote_client/features/home_screen/home.controller.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.event.dart';
import 'package:vnote_client/store/home_scree_controller_bloc/home_screen.value.dart';

class HomeScreenControllerBloc extends Bloc<HomeScreenControllerEvent, HomeScreenControllerState> {
  HomeScreenControllerBloc() : super(HomeScreenControllerState(HomeScreenPageOptions.dashboard)) {
    on<HomeScreenDashboardPressed>((event, emit) {
      emit(HomeScreenControllerState(HomeScreenPageOptions.dashboard));
    });

    on<HomeScreenStatisticsPressed>((event, emit) {
      emit(HomeScreenControllerState(HomeScreenPageOptions.statistics));
    });

    on<HomeScreenScanPressed>((event, emit) {
      emit(HomeScreenControllerState(HomeScreenPageOptions.scan));
    });

    on<HomeScreenCardPressed>((event, emit) {
      emit(HomeScreenControllerState(HomeScreenPageOptions.card));
    });

    on<HomeScreenProfilePressed>((event, emit) {
      emit(HomeScreenControllerState(HomeScreenPageOptions.profile));
    });
  }
}
