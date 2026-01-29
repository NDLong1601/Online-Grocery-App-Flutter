import 'package:equatable/equatable.dart';

/// Domain entity representing a product category
///
/// This entity contains information about a product category including
/// its unique identifier (slug), display name, and the URL to fetch
/// products belonging to this category.
///
/// Properties:
/// - [slug]: Unique identifier for the category (e.g., "beauty", "groceries")
/// - [name]: Human-readable display name (e.g., "Beauty", "Groceries")
/// - [url]: API endpoint URL to fetch products in this category
class CategoryEntity extends Equatable {
  final String slug;
  final String name;
  final String url;

  const CategoryEntity({
    required this.slug,
    required this.name,
    required this.url,
  });

  @override
  List<Object?> get props => [slug, name, url];
}
