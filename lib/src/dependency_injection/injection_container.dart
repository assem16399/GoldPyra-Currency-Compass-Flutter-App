import 'package:get_it/get_it.dart';

import '../features/currency/injection_container.dart' as currency;
import '../features/currency_convertor/injection_container.dart'
    as currency_convertor;
import '../features/currency_exchange_rate_details/injection_container.dart'
    as currency_details;
import '../features/gold/injection_container.dart' as gold;

final sl = GetIt.instance;

void init() {
  currency.init();
  currency_convertor.init();
  currency_details.init();

  gold.init();
}
