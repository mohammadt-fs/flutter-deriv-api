import '../../basic_api/generated/trading_durations_receive.dart';
import '../../basic_api/generated/trading_durations_send.dart';
import '../../helpers/helpers.dart';
import '../../services/connection/api_manager/base_api.dart';
import '../../services/dependency_injector/injector.dart';
import '../exceptions/exceptions.dart';
import '../models/base_exception_model.dart';

/// Trading durations response model class
abstract class TradingDurationsResponseModel {
  /// Initializes
  TradingDurationsResponseModel({
    this.tradingDurations,
  });

  /// List of underlyings by their display name and symbol followed by their available contract types and trading duration boundaries.
  final List<TradingDurationsItem>? tradingDurations;
}

/// Trading durations response class
class TradingDurationsResponse extends TradingDurationsResponseModel {
  /// Initializes
  TradingDurationsResponse({
    List<TradingDurationsItem>? tradingDurations,
  }) : super(
          tradingDurations: tradingDurations,
        );

  /// Creates an instance from JSON
  factory TradingDurationsResponse.fromJson(
    dynamic tradingDurationsJson,
  ) =>
      TradingDurationsResponse(
        tradingDurations: tradingDurationsJson == null
            ? null
            : List<TradingDurationsItem>.from(
                tradingDurationsJson?.map(
                  (dynamic item) => TradingDurationsItem.fromJson(item),
                ),
              ),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (tradingDurations != null) {
      resultMap['trading_durations'] = tradingDurations!
          .map<dynamic>(
            (TradingDurationsItem item) => item.toJson(),
          )
          .toList();
    }

    return resultMap;
  }

  static final BaseAPI _api = Injector.getInjector().get<BaseAPI>()!;

  /// Retrieves a list of all available underlyings and the corresponding contract types and trading duration boundaries.
  ///
  /// If the user is logged in, only the assets available for that user's landing company will be returned.
  /// For parameters information refer to [TradingDurationsRequest].
  /// Throws a [TradingException] if API response contains an error
  static Future<TradingDurationsResponse> fetchTradingDurations(
    TradingDurationsSend request,
  ) async {
    final TradingDurationsReceive response = await _api.call(request: request);

    checkException(
      response: response,
      exceptionCreator: ({BaseExceptionModel? baseExceptionModel}) =>
          TradingException(baseExceptionModel: baseExceptionModel),
    );

    return TradingDurationsResponse.fromJson(response.tradingDurations);
  }

  /// Creates a copy of instance with given parameters
  TradingDurationsResponse copyWith({
    List<TradingDurationsItem>? tradingDurations,
  }) =>
      TradingDurationsResponse(
        tradingDurations: tradingDurations ?? this.tradingDurations,
      );
}
/// Trading durations item model class
abstract class TradingDurationsItemModel {
  /// Initializes
  TradingDurationsItemModel({
    this.data,
  });

  /// Available contract types and trading duration boundaries
  final List<DataItem>? data;
}

/// Trading durations item class
class TradingDurationsItem extends TradingDurationsItemModel {
  /// Initializes
  TradingDurationsItem({
    List<DataItem>? data,
  }) : super(
          data: data,
        );

  /// Creates an instance from JSON
  factory TradingDurationsItem.fromJson(Map<String, dynamic> json) =>
      TradingDurationsItem(
        data: json['data'] == null
            ? null
            : List<DataItem>.from(
                json['data']?.map(
                  (dynamic item) => DataItem.fromJson(item),
                ),
              ),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (data != null) {
      resultMap['data'] = data!
          .map<dynamic>(
            (DataItem item) => item.toJson(),
          )
          .toList();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  TradingDurationsItem copyWith({
    List<DataItem>? data,
  }) =>
      TradingDurationsItem(
        data: data ?? this.data,
      );
}
/// Data item model class
abstract class DataItemModel {
  /// Initializes
  DataItemModel({
    this.market,
    this.submarket,
    this.symbol,
    this.tradeDurations,
  });

  /// The market in which the underlyings listed in `symbol` located.
  final Market? market;

  /// The submarket in which the underlyings listed in `symbol` located.
  final Submarket? submarket;

  /// List of underlying symbols.
  final List<SymbolItem>? symbol;

  /// List of trade durations available for symbols and contract combinations.
  final List<TradeDurationsItem>? tradeDurations;
}

/// Data item class
class DataItem extends DataItemModel {
  /// Initializes
  DataItem({
    Market? market,
    Submarket? submarket,
    List<SymbolItem>? symbol,
    List<TradeDurationsItem>? tradeDurations,
  }) : super(
          market: market,
          submarket: submarket,
          symbol: symbol,
          tradeDurations: tradeDurations,
        );

  /// Creates an instance from JSON
  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        market: json['market'] == null ? null : Market.fromJson(json['market']),
        submarket: json['submarket'] == null
            ? null
            : Submarket.fromJson(json['submarket']),
        symbol: json['symbol'] == null
            ? null
            : List<SymbolItem>.from(
                json['symbol']?.map(
                  (dynamic item) => SymbolItem.fromJson(item),
                ),
              ),
        tradeDurations: json['trade_durations'] == null
            ? null
            : List<TradeDurationsItem>.from(
                json['trade_durations']?.map(
                  (dynamic item) => TradeDurationsItem.fromJson(item),
                ),
              ),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (market != null) {
      resultMap['market'] = market!.toJson();
    }
    if (submarket != null) {
      resultMap['submarket'] = submarket!.toJson();
    }
    if (symbol != null) {
      resultMap['symbol'] = symbol!
          .map<dynamic>(
            (SymbolItem item) => item.toJson(),
          )
          .toList();
    }
    if (tradeDurations != null) {
      resultMap['trade_durations'] = tradeDurations!
          .map<dynamic>(
            (TradeDurationsItem item) => item.toJson(),
          )
          .toList();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  DataItem copyWith({
    Market? market,
    Submarket? submarket,
    List<SymbolItem>? symbol,
    List<TradeDurationsItem>? tradeDurations,
  }) =>
      DataItem(
        market: market ?? this.market,
        submarket: submarket ?? this.submarket,
        symbol: symbol ?? this.symbol,
        tradeDurations: tradeDurations ?? this.tradeDurations,
      );
}
/// Market model class
abstract class MarketModel {
  /// Initializes
  MarketModel({
    this.displayName,
    this.name,
  });

  /// Translated market name.
  final String? displayName;

  /// Market name.
  final String? name;
}

/// Market class
class Market extends MarketModel {
  /// Initializes
  Market({
    String? displayName,
    String? name,
  }) : super(
          displayName: displayName,
          name: name,
        );

  /// Creates an instance from JSON
  factory Market.fromJson(Map<String, dynamic> json) => Market(
        displayName: json['display_name'],
        name: json['name'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['display_name'] = displayName;
    resultMap['name'] = name;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Market copyWith({
    String? displayName,
    String? name,
  }) =>
      Market(
        displayName: displayName ?? this.displayName,
        name: name ?? this.name,
      );
}
/// Submarket model class
abstract class SubmarketModel {
  /// Initializes
  SubmarketModel({
    this.displayName,
    this.name,
  });

  /// Translated submarket name.
  final String? displayName;

  /// Submarket name.
  final String? name;
}

/// Submarket class
class Submarket extends SubmarketModel {
  /// Initializes
  Submarket({
    String? displayName,
    String? name,
  }) : super(
          displayName: displayName,
          name: name,
        );

  /// Creates an instance from JSON
  factory Submarket.fromJson(Map<String, dynamic> json) => Submarket(
        displayName: json['display_name'],
        name: json['name'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['display_name'] = displayName;
    resultMap['name'] = name;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  Submarket copyWith({
    String? displayName,
    String? name,
  }) =>
      Submarket(
        displayName: displayName ?? this.displayName,
        name: name ?? this.name,
      );
}
/// Symbol item model class
abstract class SymbolItemModel {
  /// Initializes
  SymbolItemModel({
    this.displayName,
    this.name,
  });

  /// Translated symbol name.
  final String? displayName;

  /// Symbol name.
  final String? name;
}

/// Symbol item class
class SymbolItem extends SymbolItemModel {
  /// Initializes
  SymbolItem({
    String? displayName,
    String? name,
  }) : super(
          displayName: displayName,
          name: name,
        );

  /// Creates an instance from JSON
  factory SymbolItem.fromJson(Map<String, dynamic> json) => SymbolItem(
        displayName: json['display_name'],
        name: json['name'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['display_name'] = displayName;
    resultMap['name'] = name;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  SymbolItem copyWith({
    String? displayName,
    String? name,
  }) =>
      SymbolItem(
        displayName: displayName ?? this.displayName,
        name: name ?? this.name,
      );
}
/// Trade durations item model class
abstract class TradeDurationsItemModel {
  /// Initializes
  TradeDurationsItemModel({
    this.durations,
    this.tradeType,
  });

  /// List of trade durations available for the symbols.
  final List<DurationsItem>? durations;

  /// List of trade types available for the symbols.
  final TradeType? tradeType;
}

/// Trade durations item class
class TradeDurationsItem extends TradeDurationsItemModel {
  /// Initializes
  TradeDurationsItem({
    List<DurationsItem>? durations,
    TradeType? tradeType,
  }) : super(
          durations: durations,
          tradeType: tradeType,
        );

  /// Creates an instance from JSON
  factory TradeDurationsItem.fromJson(Map<String, dynamic> json) =>
      TradeDurationsItem(
        durations: json['durations'] == null
            ? null
            : List<DurationsItem>.from(
                json['durations']?.map(
                  (dynamic item) => DurationsItem.fromJson(item),
                ),
              ),
        tradeType: json['trade_type'] == null
            ? null
            : TradeType.fromJson(json['trade_type']),
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    if (durations != null) {
      resultMap['durations'] = durations!
          .map<dynamic>(
            (DurationsItem item) => item.toJson(),
          )
          .toList();
    }
    if (tradeType != null) {
      resultMap['trade_type'] = tradeType!.toJson();
    }

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  TradeDurationsItem copyWith({
    List<DurationsItem>? durations,
    TradeType? tradeType,
  }) =>
      TradeDurationsItem(
        durations: durations ?? this.durations,
        tradeType: tradeType ?? this.tradeType,
      );
}
/// Durations item model class
abstract class DurationsItemModel {
  /// Initializes
  DurationsItemModel({
    this.displayName,
    this.max,
    this.min,
    this.name,
  });

  /// Translated duration type name.
  final String? displayName;

  /// Maximum allowed duration for this type.
  final int? max;

  /// Minimum allowed duration for this type.
  final int? min;

  /// Duration type name.
  final String? name;
}

/// Durations item class
class DurationsItem extends DurationsItemModel {
  /// Initializes
  DurationsItem({
    String? displayName,
    int? max,
    int? min,
    String? name,
  }) : super(
          displayName: displayName,
          max: max,
          min: min,
          name: name,
        );

  /// Creates an instance from JSON
  factory DurationsItem.fromJson(Map<String, dynamic> json) => DurationsItem(
        displayName: json['display_name'],
        max: json['max'],
        min: json['min'],
        name: json['name'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['display_name'] = displayName;
    resultMap['max'] = max;
    resultMap['min'] = min;
    resultMap['name'] = name;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  DurationsItem copyWith({
    String? displayName,
    int? max,
    int? min,
    String? name,
  }) =>
      DurationsItem(
        displayName: displayName ?? this.displayName,
        max: max ?? this.max,
        min: min ?? this.min,
        name: name ?? this.name,
      );
}
/// Trade type model class
abstract class TradeTypeModel {
  /// Initializes
  TradeTypeModel({
    this.displayName,
    this.name,
  });

  /// Translated trade type name.
  final String? displayName;

  /// Trade type name.
  final String? name;
}

/// Trade type class
class TradeType extends TradeTypeModel {
  /// Initializes
  TradeType({
    String? displayName,
    String? name,
  }) : super(
          displayName: displayName,
          name: name,
        );

  /// Creates an instance from JSON
  factory TradeType.fromJson(Map<String, dynamic> json) => TradeType(
        displayName: json['display_name'],
        name: json['name'],
      );

  /// Converts an instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> resultMap = <String, dynamic>{};

    resultMap['display_name'] = displayName;
    resultMap['name'] = name;

    return resultMap;
  }

  /// Creates a copy of instance with given parameters
  TradeType copyWith({
    String? displayName,
    String? name,
  }) =>
      TradeType(
        displayName: displayName ?? this.displayName,
        name: name ?? this.name,
      );
}
