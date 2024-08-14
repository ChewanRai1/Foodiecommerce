import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/search_failure.dart';
import 'package:flaviourfleet/features/search/data/data_source/remote/search_remote_data_source.dart';
import 'package:flaviourfleet/features/search/domain/entity/search_entity.dart';
import 'package:flaviourfleet/features/search/domain/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRemoteRepositoryProvider = Provider<ISearchRepository>(
  (ref) => SearchRemoteRepository(
    searchRemoteDataSource: ref.read(searchRemoteDataSourceProvider),
  ),
);

class SearchRemoteRepository implements ISearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRemoteRepository({required this.searchRemoteDataSource});

  @override
  Future<Either<SearchFailure, List<GetSearchEntity>>> searchProducts(String query, int page, int limit) {
    return searchRemoteDataSource.searchProducts(query, page, limit);
  }
}
