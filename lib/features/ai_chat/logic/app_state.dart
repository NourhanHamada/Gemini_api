import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';


@freezed
class AppState<T> with _$AppState<T> {
  const factory AppState.initial() = _Initial;
  const factory AppState.loading() = Loading;
  const factory AppState.success() = Success;
  const factory AppState.fail() = Fail;
}