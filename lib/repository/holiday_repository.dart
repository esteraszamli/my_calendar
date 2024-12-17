import 'package:my_calendar/data_source/holiday_remote_data_source.dart';
import 'package:my_calendar/models/holiday_model.dart';

class HolidayRepository {
  final HolidayRemoteDataSource remoteDataSource;

  HolidayRepository(this.remoteDataSource);

  Future<List<HolidayModel>> getHolidays(int year) async {
    return await remoteDataSource.getHolidays(year);
  }
}
