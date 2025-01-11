import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tasky_app/app/routes/app_routes.dart';
import 'package:tasky_app/shared/theme/app_colors.dart';
import 'package:tasky_app/shared/utils/snack_bars/custom_snack_bar.dart';
import '../../../../app/di/init_dependencies.dart';
import '../../viewmodel/bloc/home_bloc.dart';

class ScanTaskQrCodeScreen extends StatelessWidget {
  const ScanTaskQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: serviceLocator<HomeBloc>(),
      child: const ScanTaskQrCodeBody(),
    );
  }
}

class ScanTaskQrCodeBody extends StatefulWidget {
  const ScanTaskQrCodeBody({super.key});

  @override
  State<ScanTaskQrCodeBody> createState() => _ScanTaskQrCodeBodyState();
}

class _ScanTaskQrCodeBodyState extends State<ScanTaskQrCodeBody>
    with SingleTickerProviderStateMixin {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: false,
  );

  late AnimationController _animationController;
  late Animation<double> _animation;

  bool isProcessing = false;

  @override
  void initState() {
    super.initState();

    /// here we are creating an animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    /// here we are creating an animation that will animate the position of the red line
    /// from top to bottom of the container like a scanner
    _animation = Tween<double>(
      begin: 0.1,
      end: 0.9,
    ).animate(
      _animationController,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<HomeBloc>(context).add(const ResetTaskRequested());
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Task QR Code'),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            showCustomSnackBar(
              context,
              state.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              MobileScanner(
                controller: _scannerController,
                onDetect: (capture) {
                  final qrCodeData = capture.barcodes.first.rawValue;
                  if (qrCodeData != null && qrCodeData.isNotEmpty) {
                    context.read<HomeBloc>().add(GetTaskById(qrCodeData));
                  } else {
                    showCustomSnackBar(
                      context,
                      'Failed to Scan QR, Please try again!',
                      isError: true,
                    );
                  }
                },
              ),
              if (state.status == HomeStatus.loading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Positioned(
                          top: _animation.value * 300,
                          left: 0,
                          right: 0,
                          child: child!,
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 2,
                        color: AppColors.errorRedColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (state.task != null)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pushNamed(
                        AppRoutesPaths.kTaskDetailsScreen,
                        extra: state.task,
                      );
                    },
                    child: const Text('View Task Details'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
