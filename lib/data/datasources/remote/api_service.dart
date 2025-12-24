import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:online_groceries_store_app/data/models/request/login_request.dart';
import 'package:online_groceries_store_app/data/models/response/login_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
@lazySingleton
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @POST('/auth/login')
  Future<LoginDto> login(@Body() LoginRequest request);
}
