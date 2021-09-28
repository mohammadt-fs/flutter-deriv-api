import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_deriv_api/api/exceptions/exceptions.dart';
import 'package:flutter_deriv_api/api/response/contracts_for_response_result.dart';
import 'package:flutter_deriv_api/api/response/forget_all_response_result.dart';
import 'package:flutter_deriv_api/api/response/proposal_response_result.dart';
import 'package:flutter_deriv_api/basic_api/generated/api.dart';
import 'package:rxdart/rxdart.dart';

import '../available_contracts/available_contracts_bloc.dart';

part 'price_proposal_event.dart';
part 'price_proposal_state.dart';

/// PriceProposalBloc
class PriceProposalBloc extends Bloc<PriceProposalEvent, PriceProposalState> {
  ///Initializes
  PriceProposalBloc(AvailableContractsBloc availableContractsBloc)
      : super(PriceProposalLoading()) {
    availableContractsBloc.stream.listen((AvailableContractsState state) {
      if (state is AvailableContractsLoaded) {
        add(SubscribeProposal(state.selectedContract));
      }
    });
  }

  @override
  Stream<PriceProposalState> mapEventToState(
    PriceProposalEvent event,
  ) async* {
    if (event is SubscribeProposal) {
      yield PriceProposalLoading();

      await _unsubscribeProposal();

      _subscribeProposal(event)
          .handleError((dynamic error) => error is ContractOperationException
              ? add(YieldError(error.message))
              : add(YieldError(error.toString())))
          .listen((ProposalResponse? proposal) =>
              add(YieldProposalLoaded(proposal!)));
    } else if (event is YieldProposalLoaded) {
      yield PriceProposalLoaded(event.proposal.proposal);
    } else if (event is YieldError) {
      yield PriceProposalError(event.message);
    }
  }

  Stream<ProposalResponse?> _subscribeProposal(SubscribeProposal event) =>
      ProposalResponse.subscribePriceForContract(
        // ignore: missing_required_param
        ProposalRequest(
          amount: event.amount,
          durationUnit: event.durationUnit,
          duration: event.duration,
          basis: event.basis,
          currency: 'USD',
          contractType: event.contract?.contractType,
          symbol: event.contract?.underlyingSymbol,
          limitOrder: null,
          cancellation: null,
        ),
      );

  Future<ForgetAllResponse> _unsubscribeProposal() =>
      ProposalResponse.unsubscribeAllProposal();

  @override
  Future<void> close() async {
    await _unsubscribeProposal();

    await super.close();
  }
}
