import 'package:fluttertoast/fluttertoast.dart';

import '../entity.dart';
import '../ids_list/ids_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ids_list_state.dart';

class IDsCheck<T extends Entity> extends StatefulWidget {
  final IDsListCubit<T> cubit;
  final String id;
  final Widget Function(bool isAdded) builder;
  final String Function(bool isAdd) onSuccess;
  const IDsCheck({
    Key key,
    @required this.cubit,
    @required this.id,
    @required this.builder,
    this.onSuccess,
  }) : super(key: key);

  @override
  State<IDsCheck> createState() => _IDsCheckState();
}

class _IDsCheckState<T extends Entity> extends State<IDsCheck<T>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IDsListCubit<T>, IDsListState<T>>(
      key: Key(widget.id),
      bloc: widget.cubit,
      buildWhen: (previous, current) => isAdded(previous) != isAdded(current),
      builder: (context, state) {
        final isAdded = state.ids.contains(widget.id);
        return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () async {
            if (isAdded) {
              final result = await widget.cubit.removeId(id: widget.id);

              if (mounted) {
                showResult(
                  context: context,
                  didSuccess: result,
                  isAdd: !isAdded,
                );
              }
            } else {
              final result = await widget.cubit.addId(id: widget.id);

              if (mounted) {
                showResult(
                  context: context,
                  didSuccess: result,
                  isAdd: !isAdded,
                );
              }
            }
          },
          minSize: 1,
          child: widget.builder(isAdded),
        );
      },
    );
  }

  showResult({
    @required BuildContext context,
    @required bool didSuccess,
    @required bool isAdd,
  }) {
    if (didSuccess) {
      if (widget.onSuccess != null) {
        return Fluttertoast.showToast(msg: widget.onSuccess(isAdd));
      }

      Fluttertoast.showToast(
        msg: isAdd ? 'added successfully' : 'removed successfully',
      );
    } else {
      Fluttertoast.showToast(msg: 'something went worng');
    }
  }

  bool isAdded(IDsListState<T> state) {
    return state.ids.contains(widget.id);
  }
}
