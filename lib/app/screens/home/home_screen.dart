import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_core/app/screens/home/home_cubit.dart';
import 'package:cubit_core/app/screens/home/home_state.dart';

class HomeScreen extends StatefulWidget {
	const HomeScreen({Key? key}) : super(key: key);
	
	@override
	_HomeScreenState createState() => _HomeScreenState();
}
	
class _HomeScreenState extends State<HomeScreen> {
	final screenCubit = HomeCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<HomeCubit, HomeState>(
				bloc: screenCubit,
				listener: (BuildContext context, HomeState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, HomeState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(HomeState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
