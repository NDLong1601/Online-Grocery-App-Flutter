import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/models/request/add_to_cart_request.dart';
import 'package:online_groceries_store_app/data/models/request/create_cart_request.dart';
import 'package:online_groceries_store_app/data/models/request/login_request.dart';
import 'package:online_groceries_store_app/data/models/response/carts_by_user_response_dto.dart';
import 'package:online_groceries_store_app/data/models/response/category_dto.dart';
import 'package:online_groceries_store_app/data/models/response/login_dto.dart';
import 'package:online_groceries_store_app/data/models/response/product_dto.dart';
import 'package:online_groceries_store_app/data/models/response/products_by_category_response_dto.dart';
import 'package:online_groceries_store_app/data/models/response/single_cart_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

/// Remote API service for handling network requests to the backend server.
///
/// This service provides methods for authentication and other API operations.
/// Uses Dio for HTTP client functionality and is configured as a lazy singleton
/// to ensure a single instance throughout the app lifecycle.
///
/// The service is automatically generated using the retrofit package annotations.
@RestApi()
@lazySingleton
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginRequest request);

  @GET('/carts/user/{userId}')
  Future<CartsByUserResponseDto> getCartsByUser(@Path('userId') int userId);

  @GET('/carts/{id}')
  Future<SingleCartResponseDto> getSingleCart(@Path('id') int cartId);

  @GET('/products/categories')
  Future<List<CategoryDto>> getCategories();

  @GET('/products/category/{categorySlug}')
  Future<ProductsByCategoryResponseDto> getProductsByCategory(
    @Path('categorySlug') String categorySlug,
  );

  @GET('/products/{id}')
  Future<ProductDto> getProductById(@Path('id') int id);

  @PUT('/carts/{cartId}')
  Future<SingleCartResponseDto> updateCart(
    @Path('cartId') int cartId,
    @Body() AddToCartRequest request,
  );

  @POST('/carts/add')
  Future<SingleCartResponseDto> createCart(@Body() CreateCartRequest request);
}
