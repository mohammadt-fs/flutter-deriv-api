import 'package:meta/meta.dart';

import '../../basic_api/generated/portfolio_receive.dart';
import '../../basic_api/generated/portfolio_send.dart';
import '../../helpers/helpers.dart';
import '../../services/connection/api_manager/base_api.dart';
import '../../services/dependency_injector/injector.dart';
import '../exceptions/exceptions.dart';
import '../models/base_exception_model.dart';

/// Portfolio response model class
abstract class PortfolioResponseModel {
  /// Initializes
  PortfolioResponseModel({
    @required this.portfolio,
  });

  /// Current account's open positions.
  final Portfolio portfolio;
}

/// Portfolio response class
class PortfolioResponse extends PortfolioResponseModel {
  /// Initializes
  PortfolioResponse({
    @required Portfolio portfolio,
  }) : super(
          portfolio: portfolio,
        );

  /// Creates an instance from JSON
  factory PortfolioResponse.fromJson(
    dynamic portfolioJson,
  ) =>
      PortfolioResponse(
        portfolio:
            portfolioJson == null ? null : Portfolio.fromJson(portfolioJson),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (portfolio != null) {
      resultMap['portfolio'] = portfolio.toJson();
    }

    return resultMap;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>();

  /// Gets the portfolio fo logged-in account
  ///
  /// Throws a [PortfolioException] if API response contains an error
  static Future<PortfolioResponse> fetchPortfolio(PortfolioSend request) async {
    final PortfolioReceive response = await _api.call(request: request);

    checkException(
      response: response,
      exceptionCreator: ({BaseExceptionModel baseExceptionModel}) =>
          PortfolioException(baseExceptionModel: baseExceptionModel),
    );

    return PortfolioResponse.fromJson(response.portfolio);
  }

  /// Creates a copy of instance with given parameters
  PortfolioResponse copyWith({
    Portfolio portfolio,
  }) =>
      PortfolioResponse(
        portfolio: portfolio ?? this.portfolio,
      );
}
/// Portfolio model class
abstract class PortfolioModel {
  /// Initializes
  PortfolioModel({
    @required this.contracts,
  });

  /// List of open positions.
  final List<ContractsItem> contracts;
}

/// Portfolio class
class Portfolio extends PortfolioModel {
  /// Initializes
  Portfolio({
    @required List<ContractsItem> contracts,
  }) : super(
          contracts: contracts,
        );

  /// Creates an instance from JSON
  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        contracts: json['contracts'] == null
            ? null
            : List<ContractsItem>.from(json['contracts']
                .map((dynamic item) => ContractsItem.fromJson(item))),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (contracts != null) {
      resultMap['contracts'] = contracts
          .map<dynamic>((ContractsItem item) => item.toJson())
          .toList();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Portfolio copyWith({
    List<ContractsItem> contracts,
  }) =>
      Portfolio(
        contracts: contracts ?? this.contracts,
      );
}
/// Contracts item model class
abstract class ContractsItemModel {
  /// Initializes
  ContractsItemModel({
    @required this.transactionId,
    @required this.symbol,
    @required this.purchaseTime,
    @required this.payout,
    @required this.longcode,
    @required this.expiryTime,
    @required this.dateStart,
    @required this.currency,
    @required this.contractType,
    @required this.contractId,
    @required this.buyPrice,
    this.appId,
  });

  /// It is the transaction ID. Every contract (buy or sell) and every payment has a unique ID.
  final int transactionId;

  /// Symbol code
  final String symbol;

  /// Epoch of purchase time
  final DateTime purchaseTime;

  /// Payout price
  final double payout;

  /// Contract description
  final String longcode;

  /// Epoch of expiry time
  final DateTime expiryTime;

  /// Epoch of start date
  final DateTime dateStart;

  /// Contract currency
  final String currency;

  /// Contract type
  final String contractType;

  /// Internal contract identifier number (to be used in a `proposal_open_contract` API call).
  final int contractId;

  /// Buy price
  final double buyPrice;

  /// ID of the application where this contract was purchased.
  final int appId;
}

/// Contracts item class
class ContractsItem extends ContractsItemModel {
  /// Initializes
  ContractsItem({
    @required double buyPrice,
    @required int contractId,
    @required String contractType,
    @required String currency,
    @required DateTime dateStart,
    @required DateTime expiryTime,
    @required String longcode,
    @required double payout,
    @required DateTime purchaseTime,
    @required String symbol,
    @required int transactionId,
    int appId,
  }) : super(
          buyPrice: buyPrice,
          contractId: contractId,
          contractType: contractType,
          currency: currency,
          dateStart: dateStart,
          expiryTime: expiryTime,
          longcode: longcode,
          payout: payout,
          purchaseTime: purchaseTime,
          symbol: symbol,
          transactionId: transactionId,
          appId: appId,
        );

  /// Creates an instance from JSON
  factory ContractsItem.fromJson(Map<String, dynamic> json) => ContractsItem(
        buyPrice: getDouble(json['buy_price']),
        contractId: json['contract_id'],
        contractType: json['contract_type'],
        currency: json['currency'],
        dateStart: getDateTime(json['date_start']),
        expiryTime: getDateTime(json['expiry_time']),
        longcode: json['longcode'],
        payout: getDouble(json['payout']),
        purchaseTime: getDateTime(json['purchase_time']),
        symbol: json['symbol'],
        transactionId: json['transaction_id'],
        appId: json['app_id'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['buy_price'] = buyPrice;
    resultMap['contract_id'] = contractId;
    resultMap['contract_type'] = contractType;
    resultMap['currency'] = currency;
    resultMap['date_start'] = getSecondsSinceEpochDateTime(dateStart);
    resultMap['expiry_time'] = getSecondsSinceEpochDateTime(expiryTime);
    resultMap['longcode'] = longcode;
    resultMap['payout'] = payout;
    resultMap['purchase_time'] = getSecondsSinceEpochDateTime(purchaseTime);
    resultMap['symbol'] = symbol;
    resultMap['transaction_id'] = transactionId;
    resultMap['app_id'] = appId;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  ContractsItem copyWith({
    double buyPrice,
    int contractId,
    String contractType,
    String currency,
    DateTime dateStart,
    DateTime expiryTime,
    String longcode,
    double payout,
    DateTime purchaseTime,
    String symbol,
    int transactionId,
    int appId,
  }) =>
      ContractsItem(
        buyPrice: buyPrice ?? this.buyPrice,
        contractId: contractId ?? this.contractId,
        contractType: contractType ?? this.contractType,
        currency: currency ?? this.currency,
        dateStart: dateStart ?? this.dateStart,
        expiryTime: expiryTime ?? this.expiryTime,
        longcode: longcode ?? this.longcode,
        payout: payout ?? this.payout,
        purchaseTime: purchaseTime ?? this.purchaseTime,
        symbol: symbol ?? this.symbol,
        transactionId: transactionId ?? this.transactionId,
        appId: appId ?? this.appId,
      );
}
