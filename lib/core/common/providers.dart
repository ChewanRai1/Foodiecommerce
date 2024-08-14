// import 'package:flaviourfleet/features/dashboard/data/data_source/remote/dashboard_remote_data_source.dart';
// import 'package:flaviourfleet/features/dashboard/data/repository/dasboard_remote_repository.dart';
// import 'package:flaviourfleet/features/dashboard/domain/repository/dashboard_repository.dart';
// import 'package:flaviourfleet/features/dashboard/domain/usecases/dashboard_usecase.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';

// final dioProvider = Provider<Dio>((ref) {
//   return Dio(); // Initialize Dio or read from an HTTP service provider
// });

// final dashboardRemoteDataSourceProvider =
//     Provider<DashboardRemoteDataSource>((ref) {
//   final dio = ref.read(dioProvider);
//   return DashboardRemoteDataSource(dio);
// });

// final dashboardRepositoryProvider = Provider<IDashboardRepository>((ref) {
//   final remoteDataSource = ref.read(dashboardRemoteDataSourceProvider);
//   return DashboardRemoteRepository(dashboardRemoteDataSource: remoteDataSource);
// });

// final dashboardUsecaseProvider = Provider<DashboardUsecase>((ref) {
//   final repository = ref.read(dashboardRepositoryProvider);
//   return DashboardUsecase(dashboardRepository: repository);
// });
