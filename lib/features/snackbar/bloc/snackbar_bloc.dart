import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dome_care/core/constants/enums.dart';

part 'snackbar_bloc.freezed.dart';

class SnackbarBloc extends Bloc<SnackbarEvent, SnackbarState> {
  SnackbarBloc() : super(SnackbarState()) {
    on<AddSnackbarEvent>(_onAddSnackbarEvent);
    on<RemoveSnackbarEvent>(_onRemoveSnackbarEvent);
  }

  FutureOr _onAddSnackbarEvent(
    AddSnackbarEvent event,
    Emitter<SnackbarState> emit,
  ) async {
    final id = event.id ?? clock.now().millisecondsSinceEpoch.toString();
    if (state.snackbarItems.any((element) => element.id == id)) {
      return;
    }

    emit(state.copyWith(snackbarItems: _addSnackbar(id, event)));

    add(RemoveSnackbarEvent(id));
  }

  FutureOr _onRemoveSnackbarEvent(
    RemoveSnackbarEvent event,
    Emitter<SnackbarState> emit,
  ) async {
    if (event.delay) {
      await Future<dynamic>.delayed(const Duration(seconds: 6));
    }

    emit(
      state.copyWith(
        snackbarItems: state.snackbarItems
            .where((element) => element.id != event.id)
            .toList(),
      ),
    );
  }

  List<SnackbarItem> _addSnackbar(String id, AddSnackbarEvent event) {
    final newSnackbars = [
      ...state.snackbarItems,
      SnackbarItem(
        id: id,
        content: event.message,
        type: event.type,
        key: event.key ?? UniqueKey(),
      ),
    ];

    while (newSnackbars.length > 5) {
      newSnackbars.removeAt(0);
    }

    return newSnackbars;
  }
}

@freezed
abstract class SnackbarItem with _$SnackbarItem {
  factory SnackbarItem({
    @Default('') String id,
    @Default(null) Key? key,
    @Default('') String content,
    @Default(SnackbarType.success) SnackbarType type,
  }) = _SnackbarItem;
}

abstract class SnackbarEvent {}

class AddSnackbarEvent extends SnackbarEvent {
  AddSnackbarEvent({
    required this.message,
    required this.type,
    this.id,
    this.key,
  });

  final String message;
  final SnackbarType type;
  final String? id;
  final Key? key;
}

class RemoveSnackbarEvent extends SnackbarEvent {
  RemoveSnackbarEvent(this.id, {this.delay = true});
  final String id;
  final bool delay;
}

@freezed
abstract class SnackbarState with _$SnackbarState {
  factory SnackbarState({
    @Default(<SnackbarItem>[]) List<SnackbarItem> snackbarItems,
  }) = _SnackbarState;
}
