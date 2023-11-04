import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viajabara/kernel/blocs/gps/gps_bloc.dart';
import 'package:viajabara/kernel/widgets/gps/check_gps_enabled.dart';
import 'package:viajabara/kernel/widgets/gps/check_permission_localization.dart';

class GpsAccessScreen extends StatefulWidget {
  const GpsAccessScreen({super.key});

  @override
  State<GpsAccessScreen> createState() => _GpsAccessScreenState();
}

class _GpsAccessScreenState extends State<GpsAccessScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        print('state $state');

        return !state.isGpsEnabled
            ? const CheckGpsEnabled()
            : !state.isGpsPermissionGranted
                ? const CheckPermissionLocalization()
                : const Card(
                    child: Text("xd"),
                  );
      },
    );
  }
}
