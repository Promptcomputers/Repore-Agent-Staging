import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

final getUserDetailsProvider = FutureProvider<UserDetailRes>((ref) async {
  return await ref
      .watch(profileServiceRepoProvider)
      .getUserDetails(PreferenceManager.userId);
});
