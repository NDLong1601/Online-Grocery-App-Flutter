import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/domain/core/usecase.dart';
import 'package:online_groceries_store_app/domain/usecase/get_categories_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/explore/explore_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/explore/explore_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';

/// BLoC for managing Explore screen state
///
/// This BLoC handles:
/// - Loading categories from the API
/// - Refreshing categories
/// - Managing loading and error states
/// - Converting failures to user-friendly error messages
///
/// Events:
/// - [OnLoadCategoriesEvent]: Loads categories with loading indicator
/// - [OnRefreshCategoriesEvent]: Refreshes categories without full loading state
class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  final GetCategoriesUsecase _getCategoriesUsecase;
  final FailureMapper _failureMapper;

  ExploreBloc(this._getCategoriesUsecase, this._failureMapper)
    : super(const ExploreState()) {
    on<OnLoadCategoriesEvent>(_onLoadCategories);
    on<OnRefreshCategoriesEvent>(_onRefreshCategories);
  }

  /// Handles loading categories event
  ///
  /// Shows loading indicator while fetching categories from the API.
  /// On success, updates state with categories.
  /// On failure, updates state with error message.
  Future<void> _onLoadCategories(
    OnLoadCategoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: ''));

      final result = await _getCategoriesUsecase.call(NoParams());

      result.fold(
        (failure) => emit(
          state.copyWith(
            isLoading: false,
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (categories) => emit(
          state.copyWith(
            isLoading: false,
            categories: categories,
            errorMessage: '',
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  /// Handles refresh categories event
  ///
  /// Fetches categories without showing full-screen loading indicator.
  /// Used for pull-to-refresh functionality.
  Future<void> _onRefreshCategories(
    OnRefreshCategoriesEvent event,
    Emitter<ExploreState> emit,
  ) async {
    try {
      final result = await _getCategoriesUsecase.call(NoParams());

      result.fold(
        (failure) => emit(
          state.copyWith(
            errorMessage: _failureMapper.mapFailureToMessage(failure),
          ),
        ),
        (categories) =>
            emit(state.copyWith(categories: categories, errorMessage: '')),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
