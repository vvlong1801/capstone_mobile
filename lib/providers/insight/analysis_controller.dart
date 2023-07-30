import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_side_final_project/services/analysis_service.dart';

final analysisData = FutureProvider((ref) {
  return ref.watch(analysisServiceProvider).fetchAnalysisData();
});
