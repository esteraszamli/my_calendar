// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CalendarState {
  List<NoteModel> get notes;
  List<NoteModel> get allNotes;
  List<HolidayModel> get holidays;
  bool get isLoading;
  String get errorMessage;
  bool get isNetworkError;
  DateTime? get selectedDay;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      _$CalendarStateCopyWithImpl<CalendarState>(
          this as CalendarState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CalendarState &&
            const DeepCollectionEquality().equals(other.notes, notes) &&
            const DeepCollectionEquality().equals(other.allNotes, allNotes) &&
            const DeepCollectionEquality().equals(other.holidays, holidays) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isNetworkError, isNetworkError) ||
                other.isNetworkError == isNetworkError) &&
            (identical(other.selectedDay, selectedDay) ||
                other.selectedDay == selectedDay));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(notes),
      const DeepCollectionEquality().hash(allNotes),
      const DeepCollectionEquality().hash(holidays),
      isLoading,
      errorMessage,
      isNetworkError,
      selectedDay);

  @override
  String toString() {
    return 'CalendarState(notes: $notes, allNotes: $allNotes, holidays: $holidays, isLoading: $isLoading, errorMessage: $errorMessage, isNetworkError: $isNetworkError, selectedDay: $selectedDay)';
  }
}

/// @nodoc
abstract mixin class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) _then) =
      _$CalendarStateCopyWithImpl;
  @useResult
  $Res call(
      {List<NoteModel> notes,
      List<NoteModel> allNotes,
      List<HolidayModel> holidays,
      bool isLoading,
      String errorMessage,
      bool isNetworkError,
      DateTime? selectedDay});
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._self, this._then);

  final CalendarState _self;
  final $Res Function(CalendarState) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notes = null,
    Object? allNotes = null,
    Object? holidays = null,
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? isNetworkError = null,
    Object? selectedDay = freezed,
  }) {
    return _then(_self.copyWith(
      notes: null == notes
          ? _self.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      allNotes: null == allNotes
          ? _self.allNotes
          : allNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      holidays: null == holidays
          ? _self.holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<HolidayModel>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isNetworkError: null == isNetworkError
          ? _self.isNetworkError
          : isNetworkError // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDay: freezed == selectedDay
          ? _self.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _CalendarState implements CalendarState {
  const _CalendarState(
      {final List<NoteModel> notes = const [],
      final List<NoteModel> allNotes = const [],
      final List<HolidayModel> holidays = const [],
      this.isLoading = false,
      this.errorMessage = '',
      this.isNetworkError = false,
      this.selectedDay})
      : _notes = notes,
        _allNotes = allNotes,
        _holidays = holidays;

  final List<NoteModel> _notes;
  @override
  @JsonKey()
  List<NoteModel> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  final List<NoteModel> _allNotes;
  @override
  @JsonKey()
  List<NoteModel> get allNotes {
    if (_allNotes is EqualUnmodifiableListView) return _allNotes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allNotes);
  }

  final List<HolidayModel> _holidays;
  @override
  @JsonKey()
  List<HolidayModel> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isNetworkError;
  @override
  final DateTime? selectedDay;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalendarStateCopyWith<_CalendarState> get copyWith =>
      __$CalendarStateCopyWithImpl<_CalendarState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CalendarState &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            const DeepCollectionEquality().equals(other._allNotes, _allNotes) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isNetworkError, isNetworkError) ||
                other.isNetworkError == isNetworkError) &&
            (identical(other.selectedDay, selectedDay) ||
                other.selectedDay == selectedDay));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_notes),
      const DeepCollectionEquality().hash(_allNotes),
      const DeepCollectionEquality().hash(_holidays),
      isLoading,
      errorMessage,
      isNetworkError,
      selectedDay);

  @override
  String toString() {
    return 'CalendarState(notes: $notes, allNotes: $allNotes, holidays: $holidays, isLoading: $isLoading, errorMessage: $errorMessage, isNetworkError: $isNetworkError, selectedDay: $selectedDay)';
  }
}

/// @nodoc
abstract mixin class _$CalendarStateCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$CalendarStateCopyWith(
          _CalendarState value, $Res Function(_CalendarState) _then) =
      __$CalendarStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<NoteModel> notes,
      List<NoteModel> allNotes,
      List<HolidayModel> holidays,
      bool isLoading,
      String errorMessage,
      bool isNetworkError,
      DateTime? selectedDay});
}

/// @nodoc
class __$CalendarStateCopyWithImpl<$Res>
    implements _$CalendarStateCopyWith<$Res> {
  __$CalendarStateCopyWithImpl(this._self, this._then);

  final _CalendarState _self;
  final $Res Function(_CalendarState) _then;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? notes = null,
    Object? allNotes = null,
    Object? holidays = null,
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? isNetworkError = null,
    Object? selectedDay = freezed,
  }) {
    return _then(_CalendarState(
      notes: null == notes
          ? _self._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      allNotes: null == allNotes
          ? _self._allNotes
          : allNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      holidays: null == holidays
          ? _self._holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<HolidayModel>,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isNetworkError: null == isNetworkError
          ? _self.isNetworkError
          : isNetworkError // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedDay: freezed == selectedDay
          ? _self.selectedDay
          : selectedDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
