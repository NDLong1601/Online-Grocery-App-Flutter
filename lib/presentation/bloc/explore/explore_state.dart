import 'package:equatable/equatable.dart';
import 'package:online_groceries_store_app/domain/entities/category_entity.dart';

/// State for Explore screen
///
/// Contains all the data needed to render the Explore screen:
/// - Loading state indicator
/// - Error message (if any)
/// - List of categories to display
///
/// Uses [Equatable] for efficient state comparison in BLoC.
class ExploreState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final List<CategoryEntity> categories;

  const ExploreState({
    this.isLoading = false,
    this.errorMessage = '',
    this.categories = const [],
  });

  /// Creates a copy of this state with the given fields replaced
  /// with new values.
  ///
  /// This is used by the BLoC to create new state instances while
  /// preserving unchanged values.
  ExploreState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<CategoryEntity>? categories,
  }) {
    return ExploreState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, categories];
}
