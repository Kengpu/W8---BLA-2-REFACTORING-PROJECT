import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/ride_preference_state.dart';
import 'view_model/home_model.dart';
import './widgets/home_contect.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(
      ridePreferenceState: context.read<RidePreferenceState>(),
    );
    viewModel.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeContent(viewModel: viewModel);
  }
}