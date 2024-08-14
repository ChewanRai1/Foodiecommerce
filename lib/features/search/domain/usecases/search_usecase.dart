import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/search_failure.dart';
import 'package:flaviourfleet/features/search/domain/entity/search_entity.dart';
import 'package:flaviourfleet/features/search/domain/repository/search_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchUsecaseProvider = Provider<SearchUsecase>((ref) => SearchUsecase(
      searchRepository: ref.read(searchRepositoryProvider),
    ));

class SearchUsecase {
  final ISearchRepository searchRepository;

  SearchUsecase({required this.searchRepository});

  Future<Either<SearchFailure, List<GetSearchEntity>>> searchProducts(String query, int page, int limit) {
    return searchRepository.searchProducts(query, page, limit);
  }
}
