import 'package:meta/meta.dart';

import '../../basic_api/generated/paymentagent_list_receive.dart';
import '../../basic_api/generated/paymentagent_list_send.dart';
import '../../helpers/helpers.dart';
import '../../services/connection/api_manager/base_api.dart';
import '../../services/dependency_injector/injector.dart';
import '../exceptions/exceptions.dart';
import '../models/base_exception_model.dart';

/// Paymentagent list response model class
abstract class PaymentagentListResponseModel {
  /// Initializes
  PaymentagentListResponseModel({
    @required this.paymentagentList,
  });

  /// Payment Agent List
  final PaymentagentList paymentagentList;
}

/// Paymentagent list response class
class PaymentagentListResponse extends PaymentagentListResponseModel {
  /// Initializes
  PaymentagentListResponse({
    @required PaymentagentList paymentagentList,
  }) : super(
          paymentagentList: paymentagentList,
        );

  /// Creates an instance from JSON
  factory PaymentagentListResponse.fromJson(
    dynamic paymentagentListJson,
  ) =>
      PaymentagentListResponse(
        paymentagentList: paymentagentListJson == null
            ? null
            : PaymentagentList.fromJson(paymentagentListJson),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (paymentagentList != null) {
      resultMap['paymentagent_list'] = paymentagentList.toJson();
    }

    return resultMap;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>();

  /// Returns a list of Payment Agents for a given country for a given currency.
  ///
  /// For parameters information refer to [PaymentagentListRequest].
  /// Throws a [PaymentAgentException] if API response contains an error
  static Future<PaymentagentListResponse> fetch(
    PaymentagentListSend request,
  ) async {
    final PaymentagentListReceive response = await _api.call(request: request);

    checkException(
      response: response,
      exceptionCreator: ({BaseExceptionModel baseExceptionModel}) =>
          PaymentAgentException(baseExceptionModel: baseExceptionModel),
    );

    return PaymentagentListResponse.fromJson(response.paymentagentList);
  }

  /// Creates a copy of instance with given parameters
  PaymentagentListResponse copyWith({
    PaymentagentList paymentagentList,
  }) =>
      PaymentagentListResponse(
        paymentagentList: paymentagentList ?? this.paymentagentList,
      );
}
/// Paymentagent list model class
abstract class PaymentagentListModel {
  /// Initializes
  PaymentagentListModel({
    @required this.availableCountries,
    @required this.list,
  });

  /// The list of countries in which payment agent is available.
  final List<List<String>> availableCountries;

  /// List of payment agents available in the requested country.
  final List<ListItem> list;
}

/// Paymentagent list class
class PaymentagentList extends PaymentagentListModel {
  /// Initializes
  PaymentagentList({
    @required List<List<String>> availableCountries,
    @required List<ListItem> list,
  }) : super(
          availableCountries: availableCountries,
          list: list,
        );

  /// Creates an instance from JSON
  factory PaymentagentList.fromJson(Map<String, dynamic> json) =>
      PaymentagentList(
        availableCountries: json['available_countries'] == null
            ? null
            : List<List<String>>.from(json['available_countries'].map(
                (dynamic item) =>
                    List<String>.from(item.map((dynamic item) => item)))),
        list: json['list'] == null
            ? null
            : List<ListItem>.from(
                json['list'].map((dynamic item) => ListItem.fromJson(item))),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (availableCountries != null) {
      resultMap['available_countries'] = availableCountries
          .map<dynamic>(
              (List<String> item) => item.map((item) => item).toList())
          .toList();
    }
    if (list != null) {
      resultMap['list'] =
          list.map<dynamic>((ListItem item) => item.toJson()).toList();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  PaymentagentList copyWith({
    List<List<String>> availableCountries,
    List<ListItem> list,
  }) =>
      PaymentagentList(
        availableCountries: availableCountries ?? this.availableCountries,
        list: list ?? this.list,
      );
}
/// List item model class
abstract class ListItemModel {
  /// Initializes
  ListItemModel({
    @required this.currencies,
    @required this.depositCommission,
    @required this.email,
    @required this.furtherInformation,
    this.maxWithdrawal,
    this.minWithdrawal,
    @required this.name,
    @required this.paymentagentLoginid,
    @required this.summary,
    this.supportedBanks,
    @required this.telephone,
    @required this.url,
    @required this.withdrawalCommission,
  });

  /// Currencies that are accepted by this payment agent.
  final String currencies;

  /// Commission amount applied on deposits made through this payment agent.
  final String depositCommission;

  /// Payment agent's email address.
  final String email;

  /// More descriptions about this payment agent.
  final String furtherInformation;

  /// Maximum withdrawal allowed for transactions through this payment agent.
  final String maxWithdrawal;

  /// Minimum withdrawal allowed for transactions through this payment agent.
  final String minWithdrawal;

  /// Payment agent's name.
  final String name;

  /// Payment agent's loginid.
  final String paymentagentLoginid;

  /// A summary about payment agent.
  final String summary;

  /// Comma separated list of supported banks.
  final String supportedBanks;

  /// Payment agent's phone number.
  final String telephone;

  /// Payment agent's website URL.
  final String url;

  /// Commission amount applied on withdrawals made through this payment agent.
  final String withdrawalCommission;
}

/// List item class
class ListItem extends ListItemModel {
  /// Initializes
  ListItem({
    @required String currencies,
    @required String depositCommission,
    @required String email,
    @required String furtherInformation,
    String maxWithdrawal,
    String minWithdrawal,
    @required String name,
    @required String paymentagentLoginid,
    @required String summary,
    String supportedBanks,
    @required String telephone,
    @required String url,
    @required String withdrawalCommission,
  }) : super(
          currencies: currencies,
          depositCommission: depositCommission,
          email: email,
          furtherInformation: furtherInformation,
          maxWithdrawal: maxWithdrawal,
          minWithdrawal: minWithdrawal,
          name: name,
          paymentagentLoginid: paymentagentLoginid,
          summary: summary,
          supportedBanks: supportedBanks,
          telephone: telephone,
          url: url,
          withdrawalCommission: withdrawalCommission,
        );

  /// Creates an instance from JSON
  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        currencies: json['currencies'],
        depositCommission: json['deposit_commission'],
        email: json['email'],
        furtherInformation: json['further_information'],
        maxWithdrawal: json['max_withdrawal'],
        minWithdrawal: json['min_withdrawal'],
        name: json['name'],
        paymentagentLoginid: json['paymentagent_loginid'],
        summary: json['summary'],
        supportedBanks: json['supported_banks'],
        telephone: json['telephone'],
        url: json['url'],
        withdrawalCommission: json['withdrawal_commission'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['currencies'] = currencies;
    resultMap['deposit_commission'] = depositCommission;
    resultMap['email'] = email;
    resultMap['further_information'] = furtherInformation;
    resultMap['max_withdrawal'] = maxWithdrawal;
    resultMap['min_withdrawal'] = minWithdrawal;
    resultMap['name'] = name;
    resultMap['paymentagent_loginid'] = paymentagentLoginid;
    resultMap['summary'] = summary;
    resultMap['supported_banks'] = supportedBanks;
    resultMap['telephone'] = telephone;
    resultMap['url'] = url;
    resultMap['withdrawal_commission'] = withdrawalCommission;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  ListItem copyWith({
    String currencies,
    String depositCommission,
    String email,
    String furtherInformation,
    String maxWithdrawal,
    String minWithdrawal,
    String name,
    String paymentagentLoginid,
    String summary,
    String supportedBanks,
    String telephone,
    String url,
    String withdrawalCommission,
  }) =>
      ListItem(
        currencies: currencies ?? this.currencies,
        depositCommission: depositCommission ?? this.depositCommission,
        email: email ?? this.email,
        furtherInformation: furtherInformation ?? this.furtherInformation,
        maxWithdrawal: maxWithdrawal ?? this.maxWithdrawal,
        minWithdrawal: minWithdrawal ?? this.minWithdrawal,
        name: name ?? this.name,
        paymentagentLoginid: paymentagentLoginid ?? this.paymentagentLoginid,
        summary: summary ?? this.summary,
        supportedBanks: supportedBanks ?? this.supportedBanks,
        telephone: telephone ?? this.telephone,
        url: url ?? this.url,
        withdrawalCommission: withdrawalCommission ?? this.withdrawalCommission,
      );
}
