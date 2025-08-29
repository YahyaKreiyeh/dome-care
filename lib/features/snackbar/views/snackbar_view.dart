import 'package:dome_care/core/constants/enums.dart';
import 'package:dome_care/features/snackbar/bloc/snackbar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackbarView extends StatelessWidget {
  const SnackbarView({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: _Snackbars(),
          ),
        ],
      ),
    );
  }
}

class _Snackbars extends StatelessWidget {
  _Snackbars();
  final _listKey = GlobalKey<AnimatedListState>();

  void _onSnackbarAdded(BuildContext context, SnackbarState state) {
    _listKey.currentState?.insertItem(state.snackbarItems.length - 1);
  }

  void _onSnackbarRemoved(BuildContext context, SnackbarState state) {
    _listKey.currentState?.removeItem(0, (context, anim) => Container());
  }

  @override
  Widget build(BuildContext context) {
    final snackbarItems = context.select(
      (SnackbarBloc cubit) => cubit.state.snackbarItems,
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<SnackbarBloc, SnackbarState>(
          listenWhen: (prev, current) =>
              prev.snackbarItems.length < current.snackbarItems.length,
          listener: _onSnackbarAdded,
        ),
        BlocListener<SnackbarBloc, SnackbarState>(
          listenWhen: (prev, current) =>
              prev.snackbarItems.length > current.snackbarItems.length,
          listener: _onSnackbarRemoved,
        ),
      ],
      child: snackbarItems.isNotEmpty
          ? Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: AnimatedList(
                key: _listKey,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                initialItemCount: snackbarItems.length,
                itemBuilder: (context, index, animation) {
                  final e = snackbarItems[index];

                  const begin = Offset(0, 1);
                  const end = Offset.zero;
                  final tween = Tween(begin: begin, end: end);
                  final offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _AnimatedSnackbar(e: e.copyWith()),
                    ),
                  );
                },
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _AnimatedSnackbar extends StatelessWidget {
  const _AnimatedSnackbar({required this.e});
  final SnackbarItem e;

  @override
  Widget build(BuildContext context) {
    MaterialColor backgroundColor;
    IconData snackbarIcon;

    if (e.type == SnackbarType.error) {
      backgroundColor = Colors.red;
      snackbarIcon = Icons.error;
    } else if (e.type == SnackbarType.success) {
      backgroundColor = Colors.green;
      snackbarIcon = Icons.check;
    } else {
      backgroundColor = Colors.orange;
      snackbarIcon = Icons.warning;
    }

    return Center(
      key: e.key,
      child: GestureDetector(
        onTap: () => _removeSnackbar(context, e.id),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 50,
          ),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsetsDirectional.only(
            top: 10,
            bottom: 10,
            start: 15,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(snackbarIcon, color: Colors.white),
              const SizedBox(width: 10),
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(end: 15),
                  child: Text(
                    e.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _removeSnackbar(BuildContext context, String id) {
  context.read<SnackbarBloc>().add(RemoveSnackbarEvent(id, delay: false));
}
