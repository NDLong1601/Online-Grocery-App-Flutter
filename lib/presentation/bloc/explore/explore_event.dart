import 'package:equatable/equatable.dart';

/// Base class for all Explore events
///
/// All events in the Explore feature should extend this class.
/// Uses [Equatable] for value equality comparison.
abstract class ExploreEvent extends Equatable {
  const ExploreEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load categories when screen is initialized
///
/// This event is triggered when the Explore screen is first displayed
/// or when the user requests to reload the categories.
class OnLoadCategoriesEvent extends ExploreEvent {
  const OnLoadCategoriesEvent();
}

/// Event to refresh categories
///
/// This event is triggered when the user pulls down to refresh
/// the categories list. Unlike [OnLoadCategoriesEvent], this doesn't
/// show a full-screen loading indicator.
class OnRefreshCategoriesEvent extends ExploreEvent {
  const OnRefreshCategoriesEvent();
}
