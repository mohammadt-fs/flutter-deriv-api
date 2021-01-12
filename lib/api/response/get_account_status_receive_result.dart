import 'package:meta/meta.dart';

import '../../basic_api/generated/get_account_status_receive.dart';
import '../../basic_api/generated/get_account_status_send.dart';
import '../../helpers/helpers.dart';
import '../../services/connection/api_manager/base_api.dart';
import '../../services/dependency_injector/injector.dart';
import '../exceptions/exceptions.dart';
import '../models/base_exception_model.dart';

/// Get account status response model class
abstract class GetAccountStatusResponseModel {
  /// Initializes
  GetAccountStatusResponseModel({
    @required this.getAccountStatus,
  });

  /// Account status details
  final GetAccountStatus getAccountStatus;
}

/// Get account status response class
class GetAccountStatusResponse extends GetAccountStatusResponseModel {
  /// Initializes
  GetAccountStatusResponse({
    @required GetAccountStatus getAccountStatus,
  }) : super(
          getAccountStatus: getAccountStatus,
        );

  /// Creates an instance from JSON
  factory GetAccountStatusResponse.fromJson(
    dynamic getAccountStatusJson,
  ) =>
      GetAccountStatusResponse(
        getAccountStatus: getAccountStatusJson == null
            ? null
            : GetAccountStatus.fromJson(getAccountStatusJson),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (getAccountStatus != null) {
      resultMap['get_account_status'] = getAccountStatus.toJson();
    }

    return resultMap;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>();

  /// Gets the account's status
  static Future<GetAccountStatusResponse> fetchAccountStatus() async {
    final GetAccountStatusReceive response = await _api.call(
      request: const GetAccountStatusSend(),
    );

    checkException(
      response: response,
      exceptionCreator: ({BaseExceptionModel baseExceptionModel}) =>
          AccountStatusException(baseExceptionModel: baseExceptionModel),
    );

    return GetAccountStatusResponse.fromJson(response.getAccountStatus);
  }

  /// Creates a copy of instance with given parameters
  GetAccountStatusResponse copyWith({
    GetAccountStatus getAccountStatus,
  }) =>
      GetAccountStatusResponse(
        getAccountStatus: getAccountStatus ?? this.getAccountStatus,
      );
}

final Map<String, StatusEnum> statusEnumMapper = <String, StatusEnum>{
  "none": StatusEnum.none,
  "pending": StatusEnum.pending,
  "rejected": StatusEnum.rejected,
  "verified": StatusEnum.verified,
  "expired": StatusEnum.expired,
  "suspected": StatusEnum.suspected,
};

/// status Enum
enum StatusEnum {
  none,
  pending,
  rejected,
  verified,
  expired,
  suspected,
}
/// Get account status model class
abstract class GetAccountStatusModel {
  /// Initializes
  GetAccountStatusModel({
    @required this.authentication,
    @required this.currencyConfig,
    @required this.promptClientToAuthenticate,
    @required this.riskClassification,
    @required this.status,
  });

  /// This represents the authentication status of the user and it includes what authentication is needed.
  final Authentication authentication;

  /// Provides cashier details for client currency.
  final Map<String, dynamic> currencyConfig;

  /// Indicates whether the client should be prompted to authenticate their account.
  final bool promptClientToAuthenticate;

  /// Client risk classification: `low`, `standard`, `high`.
  final String riskClassification;

  /// Account status. Possible status:
  /// - `address_verified`: client's address is verified by third party services.
  /// - `age_verification`: client is age-verified.
  /// - `authenticated`: client is fully authenticated.
  /// - `cashier_locked`: cashier is locked.
  /// - `closed`: client has closed the account.
  /// - `crs_tin_information`: client has updated tax related information.
  /// - `disabled`: account is disabled.
  /// - `document_expired`: client's submitted proof-of-identity documents have expired.
  /// - `document_expiring_soon`: client's submitted proof-of-identity documents are expiring within a month.
  /// - `duplicate_account`: this client's account has been marked as duplicate.
  /// - `financial_assessment_not_complete`: client has not completed financial assessment.
  /// - `financial_risk_approval`: client has accepted financial risk disclosure.
  /// - `max_turnover_limit_not_set`: client has not set financial limits on their account. Applies to UK and Malta clients.
  /// - `mt5_withdrawal_locked`: MT5 deposits allowed, but withdrawal is not allowed.
  /// - `no_trading`: trading is disabled.
  /// - `no_withdrawal_or_trading`: client cannot trade or withdraw but can deposit.
  /// - `pa_withdrawal_explicitly_allowed`: withdrawal through payment agent is allowed.
  /// - `professional`: this client has opted for a professional account.
  /// - `professional_requested`: this client has requested for a professional account.
  /// - `professional_rejected`: this client's request for a professional account has been rejected.
  /// - `proveid_pending`: this client's identity is being validated. Applies for MX account with GB residence only.
  /// - `proveid_requested`: this client has made a request to have their identity be validated.
  /// - `social_signup`: this client is using social signup.
  /// - `ukgc_funds_protection`: client has acknowledged UKGC funds protection notice.
  /// - `unwelcome`: client cannot deposit or buy contracts, but can withdraw or sell contracts.
  /// - `withdrawal_locked`: deposits allowed but withdrawals are not allowed.
  final List<String> status;
}

/// Get account status class
class GetAccountStatus extends GetAccountStatusModel {
  /// Initializes
  GetAccountStatus({
    @required Authentication authentication,
    @required Map<String, dynamic> currencyConfig,
    @required bool promptClientToAuthenticate,
    @required String riskClassification,
    @required List<String> status,
  }) : super(
          authentication: authentication,
          currencyConfig: currencyConfig,
          promptClientToAuthenticate: promptClientToAuthenticate,
          riskClassification: riskClassification,
          status: status,
        );

  /// Creates an instance from JSON
  factory GetAccountStatus.fromJson(Map<String, dynamic> json) =>
      GetAccountStatus(
        authentication: json['authentication'] == null
            ? null
            : Authentication.fromJson(json['authentication']),
        currencyConfig: json['currency_config'],
        promptClientToAuthenticate:
            getBool(json['prompt_client_to_authenticate']),
        riskClassification: json['risk_classification'],
        status: json['status'] == null
            ? null
            : List<String>.from(json['status'].map((dynamic item) => item)),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (authentication != null) {
      resultMap['authentication'] = authentication.toJson();
    }
    resultMap['currency_config'] = currencyConfig;
    resultMap['prompt_client_to_authenticate'] = promptClientToAuthenticate;
    resultMap['risk_classification'] = riskClassification;
    if (status != null) {
      resultMap['status'] = status.map<dynamic>((String item) => item).toList();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  GetAccountStatus copyWith({
    Authentication authentication,
    Map<String, dynamic> currencyConfig,
    bool promptClientToAuthenticate,
    String riskClassification,
    List<String> status,
  }) =>
      GetAccountStatus(
        authentication: authentication ?? this.authentication,
        currencyConfig: currencyConfig ?? this.currencyConfig,
        promptClientToAuthenticate:
            promptClientToAuthenticate ?? this.promptClientToAuthenticate,
        riskClassification: riskClassification ?? this.riskClassification,
        status: status ?? this.status,
      );
}
/// Authentication model class
abstract class AuthenticationModel {
  /// Initializes
  AuthenticationModel({
    @required this.document,
    @required this.identity,
    @required this.needsVerification,
  });

  /// The authentication status for document.
  final Document document;

  /// The authentication status for identity.
  final Identity identity;

  /// An array containing the list of required authentication.
  final List<String> needsVerification;
}

/// Authentication class
class Authentication extends AuthenticationModel {
  /// Initializes
  Authentication({
    @required Document document,
    @required Identity identity,
    @required List<String> needsVerification,
  }) : super(
          document: document,
          identity: identity,
          needsVerification: needsVerification,
        );

  /// Creates an instance from JSON
  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
        document: json['document'] == null
            ? null
            : Document.fromJson(json['document']),
        identity: json['identity'] == null
            ? null
            : Identity.fromJson(json['identity']),
        needsVerification: json['needs_verification'] == null
            ? null
            : List<String>.from(
                json['needs_verification'].map((dynamic item) => item)),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (document != null) {
      resultMap['document'] = document.toJson();
    }
    if (identity != null) {
      resultMap['identity'] = identity.toJson();
    }
    if (needsVerification != null) {
      resultMap['needs_verification'] =
          needsVerification.map<dynamic>((String item) => item).toList();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Authentication copyWith({
    Document document,
    Identity identity,
    List<String> needsVerification,
  }) =>
      Authentication(
        document: document ?? this.document,
        identity: identity ?? this.identity,
        needsVerification: needsVerification ?? this.needsVerification,
      );
}
/// Document model class
abstract class DocumentModel {
  /// Initializes
  DocumentModel({
    @required this.expiryDate,
    @required this.status,
  });

  /// This is the epoch of the document expiry date.
  final DateTime expiryDate;

  /// This represents the current status of the proof of address document submitted for authentication.
  final StatusEnum status;
}

/// Document class
class Document extends DocumentModel {
  /// Initializes
  Document({
    @required DateTime expiryDate,
    @required StatusEnum status,
  }) : super(
          expiryDate: expiryDate,
          status: status,
        );

  /// Creates an instance from JSON
  factory Document.fromJson(Map<String, dynamic> json) => Document(
        expiryDate: getDateTime(json['expiry_date']),
        status: statusEnumMapper[json['status']],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['expiry_date'] = getSecondsSinceEpochDateTime(expiryDate);
    resultMap['status'] = statusEnumMapper.entries
        .firstWhere((entry) => entry.value == status, orElse: () => null)
        ?.key;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Document copyWith({
    DateTime expiryDate,
    StatusEnum status,
  }) =>
      Document(
        expiryDate: expiryDate ?? this.expiryDate,
        status: status ?? this.status,
      );
}
/// Identity model class
abstract class IdentityModel {
  /// Initializes
  IdentityModel({
    @required this.expiryDate,
    @required this.services,
    @required this.status,
  });

  /// This is the epoch of the document expiry date.
  final DateTime expiryDate;

  /// This shows the information about the authentication services implemented
  final Services services;

  /// This represent the current status for proof of identity document submitted for authentication.
  final StatusEnum status;
}

/// Identity class
class Identity extends IdentityModel {
  /// Initializes
  Identity({
    @required DateTime expiryDate,
    @required Services services,
    @required StatusEnum status,
  }) : super(
          expiryDate: expiryDate,
          services: services,
          status: status,
        );

  /// Creates an instance from JSON
  factory Identity.fromJson(Map<String, dynamic> json) => Identity(
        expiryDate: getDateTime(json['expiry_date']),
        services: json['services'] == null
            ? null
            : Services.fromJson(json['services']),
        status: statusEnumMapper[json['status']],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['expiry_date'] = getSecondsSinceEpochDateTime(expiryDate);
    if (services != null) {
      resultMap['services'] = services.toJson();
    }
    resultMap['status'] = statusEnumMapper.entries
        .firstWhere((entry) => entry.value == status, orElse: () => null)
        ?.key;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Identity copyWith({
    DateTime expiryDate,
    Services services,
    StatusEnum status,
  }) =>
      Identity(
        expiryDate: expiryDate ?? this.expiryDate,
        services: services ?? this.services,
        status: status ?? this.status,
      );
}
/// Services model class
abstract class ServicesModel {
  /// Initializes
  ServicesModel({
    @required this.onfido,
  });

  /// This shows the information related to Onfido supported services
  final Onfido onfido;
}

/// Services class
class Services extends ServicesModel {
  /// Initializes
  Services({
    @required Onfido onfido,
  }) : super(
          onfido: onfido,
        );

  /// Creates an instance from JSON
  factory Services.fromJson(Map<String, dynamic> json) => Services(
        onfido: json['onfido'] == null ? null : Onfido.fromJson(json['onfido']),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (onfido != null) {
      resultMap['onfido'] = onfido.toJson();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Services copyWith({
    Onfido onfido,
  }) =>
      Services(
        onfido: onfido ?? this.onfido,
      );
}
/// Onfido model class
abstract class OnfidoModel {
  /// Initializes
  OnfidoModel({
    @required this.documents,
    @required this.isCountrySupported,
  });

  /// This shows the list of documents types supported by Onfido
  final List<String> documents;

  /// This shows the information if the country is supported by Onfido
  final bool isCountrySupported;
}

/// Onfido class
class Onfido extends OnfidoModel {
  /// Initializes
  Onfido({
    @required List<String> documents,
    @required bool isCountrySupported,
  }) : super(
          documents: documents,
          isCountrySupported: isCountrySupported,
        );

  /// Creates an instance from JSON
  factory Onfido.fromJson(Map<String, dynamic> json) => Onfido(
        documents: json['documents'] == null
            ? null
            : List<String>.from(json['documents'].map((dynamic item) => item)),
        isCountrySupported: getBool(json['is_country_supported']),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (documents != null) {
      resultMap['documents'] =
          documents.map<dynamic>((String item) => item).toList();
    }
    resultMap['is_country_supported'] = isCountrySupported;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Onfido copyWith({
    List<String> documents,
    bool isCountrySupported,
  }) =>
      Onfido(
        documents: documents ?? this.documents,
        isCountrySupported: isCountrySupported ?? this.isCountrySupported,
      );
}
