part of 'setting_cubit.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}

final class SettingLoading extends SettingState {}

final class GetProfileSuccess extends SettingState {}
final class GetProfileError extends SettingState {}

final class ChangeProfileSuccess extends SettingState {}
final class ChangeProfileError extends SettingState {}
