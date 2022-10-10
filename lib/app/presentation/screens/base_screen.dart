import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseView<T extends StateStreamable<S>, S extends CubitState>
    extends StatefulWidget {
  final Function(BuildContext context, S state)? listener;
  final Function(T cubit)? initState, onViewReady;
  final Widget? onLoading;
  final Widget Function(BuildContext context, S state)? builder;
  final Widget Function(T cubit, S state)? onSuccess;
  final T? cubit;
  final Function()? onResumed, onInactive, onPaused, onDetached;

  const BaseView(
      {Key? key,
      this.listener,
      this.cubit,
      this.initState,
      this.onViewReady,
      this.onLoading,
      this.onSuccess,
      this.onResumed,
      this.onInactive,
      this.onPaused,
      this.onDetached,
      this.builder})
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
    if (widget.builder == null && widget.onSuccess == null) {
      assert(false, "builder or (onSuccess || onLoading) is required");
    }
    if (widget.builder != null && widget.onSuccess != null) {
      assert(false,
          "builder can't combine with onSuccess or onLoading. please choose one.");
    }
    _useLifecycle = widget.onResumed != null ||
        widget.onInactive != null ||
        widget.onPaused != null ||
        widget.onDetached != null;
    if (_useLifecycle) {
      WidgetsBinding.instance.addObserver(this);
    }

    if (widget.initState != null) {
      widget.initState!(widget.cubit!);
    }
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
    if (widget.onViewReady != null) {
      widget.onViewReady!(widget.cubit!);
    }
    return Scaffold(
      body: BlocConsumer<T, S>(
        bloc: widget.cubit,
        listener: widget.listener ?? (BuildContext context, S state) {},
        builder: widget.builder ??
            (BuildContext context, S state) {
              if (state.isLoading && widget.onLoading != null) {
                return widget.onLoading!;
              }
              return widget.onSuccess!(widget.cubit!, state);
            },
      ),
    );
  }
}
