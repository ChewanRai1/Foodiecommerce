import 'package:flaviourfleet/features/rateAndReview/data/dto/review_dto.dart';
import 'package:flaviourfleet/features/rateAndReview/domain/entity/review_entity.dart';

class ReviewModel {
  final List<ReviewDTO> reviews;

  ReviewModel({required this.reviews});

  factory ReviewModel.fromJson(List<dynamic> json) {
    return ReviewModel(
      reviews: json.map((e) => ReviewDTO.fromJson(e)).toList(),
    );
  }

  List<ReviewEntity> toEntities() {
    return reviews.map((dto) => dto.toEntity()).toList();
  }
}
