import 'package:hydrated_bloc/hydrated_bloc.dart';

class HydratedUtils {
  static Future<void> clearSubStorages(List<String> blocs) async {
    // ignore: invalid_use_of_visible_for_testing_member
    final box = await HydratedStorage.hive.openBox('hydrated_box');
    if (box.isOpen) {
      box.deleteAll(blocs);
      box.close();
    }
  }
}
