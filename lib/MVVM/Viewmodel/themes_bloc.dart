import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'themes_event.dart';
part 'themes_state.dart';

class ThemeBloc extends Bloc<ThemesEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeMode: ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) {
      final isDark = state.themeMode == ThemeMode.dark;
      emit(ThemeState(themeMode: isDark ? ThemeMode.light : ThemeMode.dark));
    });
  }
}
