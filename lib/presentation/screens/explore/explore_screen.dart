import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_groceries_store_app/core/enums/textfield_style.dart';
import 'package:online_groceries_store_app/di/injector.dart';
import 'package:online_groceries_store_app/domain/usecase/get_categories_usecase.dart';
import 'package:online_groceries_store_app/presentation/bloc/explore/explore_bloc.dart';
import 'package:online_groceries_store_app/presentation/bloc/explore/explore_event.dart';
import 'package:online_groceries_store_app/presentation/bloc/explore/explore_state.dart';
import 'package:online_groceries_store_app/presentation/error/failure_mapper.dart';
import 'package:online_groceries_store_app/presentation/screens/category_detail/category_detail_screen.dart';
import 'package:online_groceries_store_app/presentation/shared/app_textfield.dart';
import 'package:online_groceries_store_app/presentation/theme/app_colors.dart';
import 'package:online_groceries_store_app/presentation/theme/app_padding.dart';
import 'package:online_groceries_store_app/presentation/theme/app_textstyle.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ExploreBloc(getIt<GetCategoriesUsecase>(), FailureMapper(context))
            ..add(const OnLoadCategoriesEvent()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatefulWidget {
  const _ExploreView();

  @override
  State<_ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<_ExploreView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Find Products',
          style: AppTextstyle.tsSemiboldSize18.copyWith(
            color: AppColors.darkText,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ExploreBloc>().add(const OnRefreshCategoriesEvent());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSearchField(),
                SizedBox(height: AppPadding.p24),
                BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.greenAccent,
                        ),
                      );
                    }

                    if (state.errorMessage.isNotEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.errorMessage,
                              style: AppTextstyle.tsRegularSize14.copyWith(
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: AppPadding.p16),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ExploreBloc>().add(
                                  const OnLoadCategoriesEvent(),
                                );
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.categories.isEmpty) {
                      return Center(
                        child: Text(
                          'No categories found',
                          style: AppTextstyle.tsRegularSize14.copyWith(
                            color: AppColors.darkText,
                          ),
                        ),
                      );
                    }

                    return _buildCategoriesGrid(state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return AppTextField(
      variant: AppTextFieldVariant.search,
      hintText: 'Search Store',
      controller: _searchController,
      leading: const Icon(Icons.search, color: AppColors.grayText),
    );
  }

  Widget _buildCategoriesGrid(ExploreState state) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: AppPadding.p12,
        mainAxisSpacing: AppPadding.p12,
        childAspectRatio: 0.85,
      ),
      itemCount: state.categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final category = state.categories[index];
        return _buildCategoryCard(category.name, category.slug);
      },
    );
  }

  Widget _buildCategoryCard(String title, String slug) {
    final borderColor = _getCategoryColor(slug);
    final emoji = _getCategoryEmoji(slug);

    return Container(
      decoration: BoxDecoration(
        color: borderColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 2),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CategoryDetailScreen(
                  categorySlug: slug,
                  categoryName: title,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 48)),
              SizedBox(height: AppPadding.p12),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTextstyle.tsSemiboldSize14.copyWith(
                    color: AppColors.darkText,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to get color based on category slug
  Color _getCategoryColor(String slug) {
    final colors = [
      const Color(0xFF53B175),
      const Color(0xFFF8A44C),
      const Color(0xFFF7A593),
      const Color(0xFFD3B0E0),
      const Color(0xFFFDE598),
      const Color(0xFFB7DFF5),
    ];
    return colors[slug.hashCode.abs() % colors.length];
  }

  // Helper function to get emoji based on category slug
  String _getCategoryEmoji(String slug) {
    final emojiMap = {
      'beauty': '💄',
      'fragrances': '🌸',
      'furniture': '🛋️',
      'groceries': '🥬',
      'home-decoration': '🏠',
      'kitchen-accessories': '🍳',
      'laptops': '💻',
      'mens-shirts': '👔',
      'mens-shoes': '👞',
      'mens-watches': '⌚',
      'mobile-accessories': '📱',
      'motorcycle': '🏍️',
      'skin-care': '🧴',
      'smartphones': '📱',
      'sports-accessories': '⚽',
      'sunglasses': '🕶️',
      'tablets': '📱',
      'tops': '👕',
      'vehicle': '🚗',
      'womens-bags': '👜',
      'womens-dresses': '👗',
      'womens-jewellery': '💍',
      'womens-shoes': '👠',
      'womens-watches': '⌚',
    };
    return emojiMap[slug] ?? '📦';
  }
}
