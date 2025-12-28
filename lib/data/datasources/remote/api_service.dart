import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/models/request/login_request.dart';
import 'package:online_groceries_store_app/data/models/response/login_dto.dart';
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
}
