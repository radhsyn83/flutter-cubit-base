import 'package:cubit_core/app/cubit/default_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BaseLifecycle {
  void onInit();
  void onClose() {}
}

abstract class BaseScreen<T extends StateStreamable<S>, S extends CubitState>
    extends StatefulWidget {
  const BaseScreen({super.key});

  T get cubit;

  @mustCallSuper
  void onInit() {}

  @mustCallSuper
  void onClose() {}

  AppBar? get appBar => null;

  Widget onLoading(BuildContext context, S state) =>
      const Center(child: CircularProgressIndicator.adaptive());

  Widget body(BuildContext context, S state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Body not set, please call"),
            const SizedBox(height: 10),
            Text(
              "Widget body(BuildContext context, T cubit, S state);",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text("on your View, or you can use custom builder"),
            const SizedBox(height: 10),
            Text(
              "Widget cubitBuilder(BuildContext context, S state);",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text("on your View, or you can use custom builder"),
          ],
        ),
      );

  void listener(BuildContext context, S state) {}

  Widget cubitBuilder(BuildContext context, S state) {
    if (state.isLoading) {
      return onLoading(context, state);
    }
    return body(context, state);
  }

  //Statefull Override method
  @override
  State<BaseScreen<T, S>> createState() => _BaseScreenState<T, S>();
}

class _BaseScreenState<T extends StateStreamable<S>, S extends CubitState>
    extends State<BaseScreen<T, S>> {
  @override
  void initState() {
    super.initState();
    widget.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: BlocConsumer<T, S>(
        bloc: widget.cubit,
        listener: widget.listener,
        builder: widget.cubitBuilder,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.onClose();
  }
}

abstract class BaseViewV2<T extends StateStreamable<S>, S extends CubitState>
    extends StatelessWidget {
  BaseViewV2({super.key}) {
    onInit();
  }

  T get cubit;

  @mustCallSuper
  void onInit() {}

  AppBar? get appBar => null;

  Widget onLoading(BuildContext context, S state) =>
      const Center(child: CircularProgressIndicator.adaptive());

  Widget body(BuildContext context, S state) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Body not set, please call"),
            const SizedBox(height: 10),
            Text(
              "Widget body(BuildContext context, T cubit, S state);",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text("on your View, or you can use custom builder"),
            const SizedBox(height: 10),
            Text(
              "Widget cubitBuilder(BuildContext context, S state);",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.red),
            ),
            const SizedBox(height: 10),
            const Text("on your View, or you can use custom builder"),
          ],
        ),
      );

  void listener(BuildContext context, S state) {}

  Widget cubitBuilder(BuildContext context, S state) {
    if (state.isLoading) {
      return onLoading(context, state);
    }
    return body(context, state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: BlocConsumer<T, S>(
        bloc: cubit,
        listener: listener,
        builder: cubitBuilder,
      ),
    );
  }
}

abstract class BaseScreenLifecycle2<T extends StateStreamable<S>,
    S extends CubitState> extends BaseScreen {
  const BaseScreenLifecycle2({super.key});
}

abstract class BaseScreenLifecycle<T, S> extends BaseScreen
    with WidgetsBindingObserver {
  BaseScreenLifecycle({super.key});

  @override
  @mustCallSuper
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  @override
  @mustCallSuper
  void onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void onResumed() {}
  void onPaused() {}
  void onInactive() {}
  void onDetached() {}
}
