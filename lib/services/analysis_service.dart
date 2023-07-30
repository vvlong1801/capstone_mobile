import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/core/http/base_client.dart';
import 'package:user_side_final_project/models/analysis_data.dart';

final analysisServiceProvider =
    Provider<AnalysisService>((ref) => AnalysisService());

class AnalysisService {
  Future<AnalysisData> fetchAnalysisData() async {
    try {
      var res = await BaseClient().get("/analysis");
      return AnalysisData.fromJson(res["data"]);
    } catch (e) {
      throw Exception(e);
    }
  }
}
