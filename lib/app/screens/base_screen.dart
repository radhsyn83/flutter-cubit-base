import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseView<T extends StateStreamable<S>, S extends CubitState>
    extends StatefulWidget {
  final Function(BuildContext context, S state)? listener;
  final Function(T cubit) initState;
  final Widget? onLoading;
  final Widget Function(T cubit, S state) onSuccess;
  final T? cubit;
  final Function()? onResumed, onInactive, onPaused, onDetached;

  const BaseView(
      {Key? key,
      this.listener,
      this.cubit,
      required this.initState,
      this.onLoading,
      required this.onSuccess,
      this.onResumed,
      this.onInactive,
      this.onPaused,
      this.onDetached})
      : super(key: key);

  @override
  State<BaseView<T, S>> createState() => BaseViewState<T, S>();
}

class BaseViewState<T extends StateStreamable<S>, S extends CubitState>
    extends State<BaseView<T, S>> with WidgetsBindingObserver {
  bool _useLifecycle = false;

  @override
  void initState() {
    super.initState();
    _useLifecycle = widget.onResumed != null ||
        widget.onInactive != null ||
        widget.onPaused != null ||
        widget.onDetached != null;
    if (_useLifecycle) {
      WidgetsBinding.instance.addObserver(this);
    }
    widget.initState(widget.cubit!);
  }

  @override
  void dispose() {
    if (_useLifecycle) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (widget.onResumed != null) widget.onResumed!();
        break;
      case AppLifecycleState.inactive:
        if (widget.onInactive != null) widget.onInactive!();
        break;
      case AppLifecycleState.paused:
        if (widget.onPaused != null) widget.onPaused!();
        break;
      case AppLifecycleState.detached:
        if (widget.onDetached != null) widget.onDetached!();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<T, S>(
        bloc: widget.cubit,
        listener: widget.listener ?? (BuildContext context, S state) {},
        // builder: widget.builder,
        builder: (BuildContext context, S state) {
          if (state.isLoading && widget.onLoading != null) {
            return widget.onLoading!;
          }
          return widget.onSuccess(widget.cubit!, state);
        },
      ),
    );
  }
}
