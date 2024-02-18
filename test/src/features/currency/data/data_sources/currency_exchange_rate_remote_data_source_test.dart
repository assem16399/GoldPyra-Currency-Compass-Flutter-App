import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exchange_rates/src/core/constants/end_points.dart';
import 'package:exchange_rates/src/core/network/web_service.dart';
import 'package:exchange_rates/src/features/currency/data/data_sources/currency_exchange_rate_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'currency_exchange_rate_remote_data_source_test.mocks.dart';

@GenerateMocks([WebService])
void main() {
  late CurrencyExchangeRateRemoteDataSourceImpl remoteDataSource;
  late WebService mockWebService;

  setUp(() {
    mockWebService = MockWebService();
    remoteDataSource =
        CurrencyExchangeRateRemoteDataSourceImpl(webService: mockWebService);
  });

  void setUpMockWebServiceGetRequestSuccess200() {
    when(mockWebService.getRequest(path: kEGPTOUSDExchangeRateEndpoint))
        .thenAnswer((_) async => Response(
                requestOptions:
                    RequestOptions(path: kEGPTOUSDExchangeRateEndpoint),
                statusCode: 200,
                data: jsonDecode(fixture('currency_exchange_rate.json')))
            .data);
  }

  void setUpMockWebServiceGetRequestFailure404() {
    when(mockWebService.getRequest(path: kEGPTOUSDExchangeRateEndpoint))
        .thenAnswer((_) async {
      final response = Response(
          requestOptions: RequestOptions(path: kEGPTOUSDExchangeRateEndpoint),
          statusCode: 404);
      final exception = DioException(
          requestOptions: RequestOptions(path: kEGPTOUSDExchangeRateEndpoint),
          response: response);
      throw exception;
    });
  }

  group('getCurrencyExchangeRateRawData', () {
    final tCurrencyExchangeRateRawData =
        jsonDecode(fixture('currency_exchange_rate.json'));

    test('should perform a GET request on a URL with the endpoint', () async {
      //arrange
      setUpMockWebServiceGetRequestSuccess200();

      //act
      await remoteDataSource.getCurrencyExchangeRateRawData();

      //assert
      verify(mockWebService.getRequest(path: kEGPTOUSDExchangeRateEndpoint));
    });

    test(
        'should return CurrencyExchangeRate Raw data when a GET request on a URL with the endpoint',
        () async {
      //arrange
      setUpMockWebServiceGetRequestSuccess200();

      //act
      final result = await remoteDataSource.getCurrencyExchangeRateRawData();

      //assert
      expect(result, tCurrencyExchangeRateRawData);
    });

    test('should throw a DioException when the status code is not 200',
        () async {
      //arrange
      setUpMockWebServiceGetRequestFailure404();

      //act
      result() => remoteDataSource.getCurrencyExchangeRateRawData();

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });
}
// test('GetCurrencyExchangeRate should return currency exchange rate without any exception', () async {
//   //arrange
//   final currencyExchangeRate = CurrencyExchangeRateModel(
//     baseCurrency: 'USD',
//     date: '2022-01-01',
//     rates: {
//       'IDR': 14000,
//       'EUR': 0.85,
//       'GBP': 0.75,
//     },
//   );
//
//   final currencyExchangeRateMap = currencyExchangeRate.toMap();
//   when(mockNetworkService.get('https://api.exchangerate-api.com/v4/latest/USD'))
//       .thenAnswer(
//     (_) {
//       return Future.value(Response(
//               requestOptions: RequestOptions(
//                 path: 'https://api.exchangerate-api.com/v4/latest/USD',
//               ),
//               data: currencyExchangeRateMap,
//               statusCode: 200)
//           .data);
//     },
//   );
//
//   //act
//   final result = await remoteDataSource.getCurrencyExchangeRate('USD');
//
//   //assert
//   expect(result, currencyExchangeRateMap);
// });
//
// test('GetCurrencyExchangeRate should throw an Exception if the status code is not 200',
//     () async {
//   //arrange
//   final expectedResult = throwsA(isA<DioException>());
//   when(mockNetworkService.get('https://api.exchangerate-api.com/v4/latest/USD'))
//       .thenAnswer(
//     (_) {
//       final requestOptions = RequestOptions(
//         path: 'https://api.exchangerate-api.com/v4/latest/USD',
//         data: null,
//       );
//       final dioException = DioException(
//           requestOptions: requestOptions,
//           response: Response(
//               requestOptions: requestOptions, data: {}, statusCode: 404));
//       print(dioException.response);
//       throw dioException;
//     },
//   );
//
//   //act
//   final result = remoteDataSource.getCurrencyExchangeRate('USD');
//
//   //assert
//   expect(result, expectedResult);
// });
