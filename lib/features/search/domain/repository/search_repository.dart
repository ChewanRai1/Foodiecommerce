import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/search_failure.dart';
import 'package:flaviourfleet/features/search/data/repository/search_repository_impl.dart';
import 'package:flaviourfleet/features/search/domain/entity/search_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider<ISearchRepository>(
  (ref) => ref.read(searchRemoteRepositoryProvider),
);

abstract class ISearchRepository {
  Future<Either<SearchFailure, List<GetSearchEntity>>> searchProducts(String query, int page, int limit);
}
