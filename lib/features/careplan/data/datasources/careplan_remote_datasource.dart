import 'dart:convert';

import '../../../../core/data/datasources/remote_datasource_base.dart';
import '../../../../core/data/network/network_service.dart';
import '../../../../core/data/network/network_service_response.dart';
import 'endpoint.dart';

abstract class SavogueRemoteDataSource extends RemoteDataSource {
  Future<String> addLongTermGoal({
    required String longTermGoal,
    String? carePlanId,
  });
  Future<String> addStressor({
    bool? work,
    bool? relationship,
    bool? finances,
    bool? physicalHealthOrPain,
    bool? alcoholOrDrugs,
    bool? trauma,
    bool? housing,
    bool? school,
    String? carePlanId,
  });
  Future<String> getSavogueHistory();
  Future<String> getK10History();
  Future<String> getActiveSavogue({required String userId});
  Future<String> getActiveSavogueSummary({required String carePlanId});
  Future<String> getSavogueTeam();
}

class SavogueRemoteDataSourceImpl implements SavogueRemoteDataSource {
  final NetworkService _networkService;
  SavogueRemoteDataSourceImpl(this._networkService);

  @override
  void dispose() {}

  @override
  Future<String> addLongTermGoal({
    required String longTermGoal,
    String? carePlanId,
  }) async {
    NetworkServiceResponse response = await _networkService.patch(
      SavogueEndpoints.addLongTermGoal,
      body: {
        "longTermGoal": longTermGoal,
        "shortTermGoal":
            "(1) Reduce level of depression & anxiety by 50% by 8 weeks after starting treatment as measured by K10. (2) Improve your ability to cope with your stressors by 20% after your third therapy session."
      },
    );
    final data = handleNetworkResponse(response);
    return data["message"] ?? jsonEncode(data);
  }

  @override
  Future<String> addStressor({
    bool? work,
    bool? relationship,
    bool? finances,
    bool? physicalHealthOrPain,
    bool? alcoholOrDrugs,
    bool? trauma,
    bool? housing,
    bool? school,
    String? carePlanId,
  }) async {
    NetworkServiceResponse response = await _networkService.patch(
      SavogueEndpoints.addStressor,
      body: {
        "stressors": {
          "work": work,
          "relationship": relationship,
          "finances": finances,
          "physical health or pain": physicalHealthOrPain,
          "alcohol or drugs": alcoholOrDrugs,
          "trauma": trauma,
          "housing": housing,
          "school": school
        },
        "savogueId": carePlanId
      },
    );
    final data = handleNetworkResponse(response);
    return data["message"] ?? jsonEncode(data);
  }

  @override
  Future<String> getSavogueHistory() async {
    NetworkServiceResponse response = await _networkService.get(SavogueEndpoints.getSavogueHistory);
    final data = handleNetworkResponse(response);
    return jsonEncode(data);
  }

  @override
  Future<String> getK10History() async {
    NetworkServiceResponse response = await _networkService.get(SavogueEndpoints.getK10History);
    final data = handleNetworkResponse(response);
    return jsonEncode(data);
  }

  @override
  Future<String> getActiveSavogue({required String userId}) async {
    NetworkServiceResponse response = await _networkService.get("${SavogueEndpoints.getActiveSavogue}/$userId/recent");
    final data = handleNetworkResponse(response);
    return jsonEncode(data);
  }

  @override
  Future<String> getActiveSavogueSummary({required String carePlanId}) async {
    NetworkServiceResponse response = await _networkService.get("${SavogueEndpoints.getActiveSavogueSummary}/$carePlanId");
    final data = handleNetworkResponse(response);
    return jsonEncode(data);
  }

  @override
  Future<String> getSavogueTeam() async {
    NetworkServiceResponse response = await _networkService.get(SavogueEndpoints.getSavogueTeam);
    final data = handleNetworkResponse(response);
    return jsonEncode(data);
  }
}


