import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BlocStateProviderMixin implements Closable {
  final List<StreamSubscription> _listeners = [];

  void listenBlocState<B extends BlocBase<S>, S>(
    BuildContext context,
    void Function(S state) listener,
  ) {
    final bloc = context.read<B>();
    bloc.stream.listen(listener);
    listener(bloc.state);
  }

  @override
  Future<void> close() async {
    _listeners.map((e) => e.cancel());
  }
}
