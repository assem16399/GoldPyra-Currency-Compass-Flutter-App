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
        .thenThrow(DioException(
            requestOptions: RequestOptions(path: kEGPTOUSDExchangeRateEndpoint),
            response: Response(
                requestOptions:
                    RequestOptions(path: kEGPTOUSDExchangeRateEndpoint),
                statusCode: 404)));
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
      final result = remoteDataSource.getCurrencyExchangeRateRawData();

      //assert
      expect(result, throwsA(isA<DioException>()));
    });
  });
}
