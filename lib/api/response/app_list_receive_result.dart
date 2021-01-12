import 'package:meta/meta.dart';

import '../../basic_api/generated/app_list_receive.dart';
import '../../basic_api/generated/app_list_send.dart';
import '../../helpers/helpers.dart';
import '../../services/connection/api_manager/base_api.dart';
import '../../services/dependency_injector/injector.dart';
import '../exceptions/exceptions.dart';
import '../models/base_exception_model.dart';

/// App list response model class
abstract class AppListResponseModel {
  /// Initializes
  AppListResponseModel({
    @required this.appList,
  });

  /// List of created applications for the authorized account.
  final List<AppListItem> appList;
}

/// App list response class
class AppListResponse extends AppListResponseModel {
  /// Initializes
  AppListResponse({
    @required List<AppListItem> appList,
  }) : super(
          appList: appList,
        );

  /// Creates an instance from JSON
  factory AppListResponse.fromJson(
    dynamic appListJson,
  ) =>
      AppListResponse(
        appList: appListJson == null
            ? null
            : List<AppListItem>.from(
                appListJson.map((dynamic item) => AppListItem.fromJson(item))),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (appList != null) {
      resultMap['app_list'] =
          appList.map<dynamic>((AppListItem item) => item.toJson()).toList();
    }

    return resultMap;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>();

  /// Gets all of the account's OAuth applications.
  ///
  /// For parameters information refer to [AppListRequest].
  /// Throws an [AppException] if API response contains an error
  static Future<AppListResponse> fetchApplicationList(
    AppListSend request,
  ) async {
    final AppListReceive response = await _api.call(request: request);

    checkException(
      response: response,
      exceptionCreator: ({BaseExceptionModel baseExceptionModel}) =>
          AppException(baseExceptionModel: baseExceptionModel),
    );

    return AppListResponse.fromJson(response.appList);
  }

  /// Creates a copy of instance with given parameters
  AppListResponse copyWith({
    List<AppListItem> appList,
  }) =>
      AppListResponse(
        appList: appList ?? this.appList,
      );
}
/// App list item model class
abstract class AppListItemModel {
  /// Initializes
  AppListItemModel({
    @required this.appId,
    @required this.appMarkupPercentage,
    this.appstore,
    this.github,
    this.googleplay,
    this.homepage,
    @required this.name,
    @required this.redirectUri,
    this.verificationUri,
  });

  /// Application ID.
  final int appId;

  /// Markup added to contract prices (as a percentage of contract payout).
  final double appMarkupPercentage;

  /// Application's App Store URL.
  final String appstore;

  /// Application's GitHub page. (for open-source projects)
  final String github;

  /// Application's Google Play URL.
  final String googleplay;

  /// Application's homepage URL.
  final String homepage;

  /// Application name.
  final String name;

  /// The URL to redirect to after a successful login.
  final String redirectUri;

  /// Used when `verify_email` called. If available, a URL containing the verification token will send to the client's email, otherwise only the token will be sent.
  final String verificationUri;
}

/// App list item class
class AppListItem extends AppListItemModel {
  /// Initializes
  AppListItem({
    @required int appId,
    @required double appMarkupPercentage,
    String appstore,
    String github,
    String googleplay,
    String homepage,
    @required String name,
    @required String redirectUri,
    String verificationUri,
  }) : super(
          appId: appId,
          appMarkupPercentage: appMarkupPercentage,
          appstore: appstore,
          github: github,
          googleplay: googleplay,
          homepage: homepage,
          name: name,
          redirectUri: redirectUri,
          verificationUri: verificationUri,
        );

  /// Creates an instance from JSON
  factory AppListItem.fromJson(Map<String, dynamic> json) => AppListItem(
        appId: json['app_id'],
        appMarkupPercentage: getDouble(json['app_markup_percentage']),
        appstore: json['appstore'],
        github: json['github'],
        googleplay: json['googleplay'],
        homepage: json['homepage'],
        name: json['name'],
        redirectUri: json['redirect_uri'],
        verificationUri: json['verification_uri'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['app_id'] = appId;
    resultMap['app_markup_percentage'] = appMarkupPercentage;
    resultMap['appstore'] = appstore;
    resultMap['github'] = github;
    resultMap['googleplay'] = googleplay;
    resultMap['homepage'] = homepage;
    resultMap['name'] = name;
    resultMap['redirect_uri'] = redirectUri;
    resultMap['verification_uri'] = verificationUri;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  AppListItem copyWith({
    int appId,
    double appMarkupPercentage,
    String appstore,
    String github,
    String googleplay,
    String homepage,
    String name,
    String redirectUri,
    String verificationUri,
  }) =>
      AppListItem(
        appId: appId ?? this.appId,
        appMarkupPercentage: appMarkupPercentage ?? this.appMarkupPercentage,
        appstore: appstore ?? this.appstore,
        github: github ?? this.github,
        googleplay: googleplay ?? this.googleplay,
        homepage: homepage ?? this.homepage,
        name: name ?? this.name,
        redirectUri: redirectUri ?? this.redirectUri,
        verificationUri: verificationUri ?? this.verificationUri,
      );
}
