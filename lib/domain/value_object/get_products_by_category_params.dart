import 'package:equatable/equatable.dart';

/// Parameters for GetProductsByCategoryUsecase
class GetProductsByCategoryParams extends Equatable {
  final String categorySlug;

  const GetProductsByCategoryParams({required this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}
