import 'package:dio/dio.dart';
import 'package:my_calendar/models/holiday_model.dart';

class HolidayRemoteDataSource {
  final Dio dio;

  HolidayRemoteDataSource(this.dio);

  Future<List<HolidayModel>> getHolidays(int year) async {
    try {
      final response = await dio.get(
        'https://date.nager.at/api/v3/publicholidays/$year/PL',
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((json) => HolidayModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Nie udało się pobrać danych o dniach wolnych');
      }
    } on DioException catch (e) {
      throw Exception('Błąd połączenia: ${e.message}');
    }
  }
}
