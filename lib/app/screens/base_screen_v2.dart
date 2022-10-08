import 'package:cubit_core/app/screens/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseView<T extends StateStreamable<S>, S extends CubitState>
    extends StatefulWidget {
  final Function(BuildContext context, S state)? listener;
  final Function initState;
  final Widget Function(BuildContext context, S state) builder;
  final T? cubit;

  const BaseView(
      {Key? key,
      this.listener,
      required this.builder,
      this.cubit,
      required this.initState})
      : super(key: key);

  @override
  State<BaseView<T, S>> createState() => _BaseViewState<T, S>();
}

class _BaseViewState<T extends StateStreamable<S>, S extends CubitState>
    extends State<BaseView<T, S>> {
  @override
  void initState() {
    super.initState();
    widget.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<T, S>(
        bloc: widget.cubit,
        listener: widget.listener ?? (BuildContext context, S state) {},
        // builder: widget.builder,
        builder: (BuildContext context, S state) {
          print("object ${state.isLoading}");
          return Container();
        },
      ),
    );
  }
}

// abstract class BaseView<T extends StateStreamable<S>, S>
//     extends StatefulWidget {
//   final PreferredSizeWidget? appBar;

//   const BaseView({Key? key, this.appBar}) : super(key: key);

//   @override
//   State<BaseView<T, S>> createState() => _BaseViewState<T, S>();
// }

// class _BaseViewState<T extends StateStreamable<S>, S>
//     extends State<BaseView<T, S>> {
//   final screenCubit = T;

//   PreferredSizeWidget? appbar;

//   @override
//   void initState() {
//     super.initState();
//     appbar = widget.appBar;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appbar,
//       body: BlocConsumer<T, S>(
//         bloc: screenCubit as T,
//         listener: (BuildContext context, S state) {
//           print("state change");
//         },
//         builder: (BuildContext context, S state) {
//           // if (state.isLoading) {
//           //   return const Center(child: CircularProgressIndicator());
//           // }
//           // return buildBody(state);
//           return Text("data");
//         },
//       ),
//     );
//   }
// }
