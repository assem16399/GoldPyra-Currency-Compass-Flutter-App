import 'package:get_it/get_it.dart';

import '../features/currency/injection_container.dart' as currency;
import '../features/gold/injection_container.dart' as gold;

final sl = GetIt.instance;

void init() {
  currency.init();
  gold.init();
}
