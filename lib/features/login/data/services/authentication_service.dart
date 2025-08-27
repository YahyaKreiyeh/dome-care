import 'package:dio/dio.dart';
import 'package:dome_care/core/networking/api_constants.dart';
import 'package:dome_care/features/login/data/models/login_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'authentication_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class AuthenticationService {
  factory AuthenticationService(Dio dio) = _AuthenticationService;

  @POST(ApiConstants.login)
  Future<LoginResponseDto> login(@Body() LoginRequestDto request);
}
