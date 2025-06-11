part of 'themes_bloc.dart';

@immutable
abstract class ThemesState {}

class ThemeState {
  final ThemeMode themeMode;
  ThemeState({required this.themeMode});
}
