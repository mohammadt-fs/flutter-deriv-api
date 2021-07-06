import '../../basic_api/generated/revoke_oauth_app_receive.dart';
import '../../basic_api/generated/revoke_oauth_app_send.dart';
import '../../services/connection/api_manager/base_api.dart';
import '../../services/dependency_injector/injector.dart';
import '../../helpers/helpers.dart';
import '../exceptions/exceptions.dart';
import '../models/base_exception_model.dart';

/// Revoke oauth app response model class
abstract class RevokeOauthAppResponseModel {
  /// Initializes
  RevokeOauthAppResponseModel({
    this.revokeOauthApp,
  });

  /// `1` on success
  final int? revokeOauthApp;
}

/// Revoke oauth app response class
class RevokeOauthAppResponse extends RevokeOauthAppResponseModel {
  /// Initializes
  RevokeOauthAppResponse({
    int? revokeOauthApp,
  }) : super(
          revokeOauthApp: revokeOauthApp,
        );

  /// Creates an instance from JSON
  factory RevokeOauthAppResponse.fromJson(
    dynamic revokeOauthAppJson,
  ) =>
      RevokeOauthAppResponse(
        revokeOauthApp: revokeOauthAppJson,
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['revoke_oauth_app'] = revokeOauthApp;

    return resultMap;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>()!;

  /// Revokes access of a particular app.
  ///
  /// For parameters information refer to [RevokeOauthAppRequest].
  /// Throws an [AppException] if API response contains an error
  static Future<RevokeOauthAppResponse> revokeOauthApplication(
    RevokeOauthAppSend request,
  ) async {
    final RevokeOauthAppReceive response = await _api.call(request: request);

    checkException(
      response: response,
      exceptionCreator: ({BaseExceptionModel? baseExceptionModel}) =>
          AppException(baseExceptionModel: baseExceptionModel),
    );

    return RevokeOauthAppResponse.fromJson(response.revokeOauthApp);
  }

  /// Creates a copy of instance with given parameters
  RevokeOauthAppResponse copyWith({
    int? revokeOauthApp,
  }) =>
      RevokeOauthAppResponse(
        revokeOauthApp: revokeOauthApp ?? this.revokeOauthApp,
      );
}
