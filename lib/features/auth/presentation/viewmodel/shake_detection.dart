// import 'dart:async';

// import 'package:all_sensors2/all_sensors2.dart';
// import 'package:flaviourfleet/app/navigator/navigator.dart';
// import 'package:flaviourfleet/features/auth/domain/usecases/logout_usecase.dart';
// import 'package:flaviourfleet/features/auth/presentation/view/login_view.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ShakeDetection {
//   static final ShakeDetection _instance = ShakeDetection._internal();

//   factory ShakeDetection() {
//     return _instance;
//   }

//   ShakeDetection._internal();

//   late StreamSubscription<AccelerometerEvent> _accelerometerSubscription;
//   static const double shakeThresholdGravity = 2.7;
//   static const int shakeWaitTimeMS = 500;
//   static const int shakeCountThreshold = 4;
//   late int lastShakeTimestamp;
//   int shakeCount = 0;
//   bool _isInitialized = false;

//   void initialize(ProviderRef ref) {
//     if (_isInitialized) return;
//     _isInitialized = true;
//     lastShakeTimestamp = DateTime.now().millisecondsSinceEpoch;
//     _accelerometerSubscription =
//         accelerometerEvents!.listen((AccelerometerEvent event) {
//       double gX = event.x / 9.81;
//       double gY = event.y / 9.81;
//       double gZ = event.z / 9.81;
//       double gForce = gX * gX + gY * gY + gZ * gZ;
//       if (gForce > shakeThresholdGravity) {
//         final now = DateTime.now().millisecondsSinceEpoch;
//         if (lastShakeTimestamp + shakeWaitTimeMS > now) {
//           return;
//         }
//         lastShakeTimestamp = now;
//         shakeCount++;
//         if (shakeCount >= shakeCountThreshold) {
//           shakeCount = 0; // Reset the shake count
//           _logout(ref);
//         }
//       }
//     });
//   }

//   Future<void> _logout(ProviderRef ref) async {
//     final logoutUseCase = ref.read(logoutUseCaseProvider);
//     final result = await logoutUseCase();
//     result.fold(
//       (failure) {
//         // Handle failure case if needed
//         print('Failed to logout: ${failure.error}');
//       },
//       (success) {
//         // Redirect to login screen after successful logout
//         NavigateRoute.popAndPushRoute(const LoginView());
//       },
//     );
//   }

//   void dispose() {
//     _accelerometerSubscription.cancel();
//   }
// }

// final shakeDetectionServiceProvider = Provider<ShakeDetection>((ref) {
//   final service = ShakeDetection();
//   service.initialize(ref);
//   ref.onDispose(service.dispose);
//   return service;
// });
