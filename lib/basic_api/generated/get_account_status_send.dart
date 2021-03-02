/// Generated automatically from flutter_deriv_api|lib/basic_api/generated/get_account_status_send.json
// ignore_for_file: avoid_as

import '../request.dart';

/// Get account status send class
class GetAccountStatusSend extends Request {
  /// Initialize GetAccountStatusSend
  const GetAccountStatusSend({
    this.getAccountStatus = true,
    Map<String, dynamic> passthrough,
    int reqId,
  }) : super(
          msgType: 'get_account_status',
          passthrough: passthrough,
          reqId: reqId,
        );

  /// Creates an instance from JSON
  factory GetAccountStatusSend.fromJson(Map<String, dynamic> json) =>
      GetAccountStatusSend(
        getAccountStatus: json['get_account_status'] == null
            ? null
            : json['get_account_status'] == 1,
        passthrough: json['passthrough'] as Map<String, dynamic>,
        reqId: json['req_id'] as int,
      );

  /// Must be `true`
  final bool getAccountStatus;

  /// Converts this instance to JSON
  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'get_account_status': getAccountStatus == null
            ? null
            : getAccountStatus
                ? 1
                : 0,
        'passthrough': passthrough,
        'req_id': reqId,
      };

  /// Creates a copy of instance with given parameters
  @override
  GetAccountStatusSend copyWith({
    bool getAccountStatus,
    Map<String, dynamic> passthrough,
    int reqId,
  }) =>
      GetAccountStatusSend(
        getAccountStatus: getAccountStatus ?? this.getAccountStatus,
        passthrough: passthrough ?? this.passthrough,
        reqId: reqId ?? this.reqId,
      );

  /// Override equatable class
  @override
  List<Object> get props => null;
}
