// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CalendarState {
  List<NoteModel> get notes => throw _privateConstructorUsedError;
  List<NoteModel> get allNotes => throw _privateConstructorUsedError;
  List<HolidayModel> get holidays => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalendarStateCopyWith<CalendarState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarStateCopyWith<$Res> {
  factory $CalendarStateCopyWith(
          CalendarState value, $Res Function(CalendarState) then) =
      _$CalendarStateCopyWithImpl<$Res, CalendarState>;
  @useResult
  $Res call(
      {List<NoteModel> notes,
      List<NoteModel> allNotes,
      List<HolidayModel> holidays,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class _$CalendarStateCopyWithImpl<$Res, $Val extends CalendarState>
    implements $CalendarStateCopyWith<$Res> {
  _$CalendarStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
  }) {
    return _then(_value.copyWith(
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      allNotes: null == allNotes
          ? _value.allNotes
          : allNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      holidays: null == holidays
          ? _value.holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<HolidayModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarStateImplCopyWith<$Res>
    implements $CalendarStateCopyWith<$Res> {
  factory _$$CalendarStateImplCopyWith(
          _$CalendarStateImpl value, $Res Function(_$CalendarStateImpl) then) =
      __$$CalendarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NoteModel> notes,
      List<NoteModel> allNotes,
      List<HolidayModel> holidays,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class __$$CalendarStateImplCopyWithImpl<$Res>
    extends _$CalendarStateCopyWithImpl<$Res, _$CalendarStateImpl>
    implements _$$CalendarStateImplCopyWith<$Res> {
  __$$CalendarStateImplCopyWithImpl(
      _$CalendarStateImpl _value, $Res Function(_$CalendarStateImpl) _then)
      : super(_value, _then);

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
  }) {
    return _then(_$CalendarStateImpl(
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      allNotes: null == allNotes
          ? _value._allNotes
          : allNotes // ignore: cast_nullable_to_non_nullable
              as List<NoteModel>,
      holidays: null == holidays
          ? _value._holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<HolidayModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CalendarStateImpl implements _CalendarState {
  const _$CalendarStateImpl(
      {final List<NoteModel> notes = const [],
      final List<NoteModel> allNotes = const [],
      final List<HolidayModel> holidays = const [],
      this.isLoading = false,
      this.errorMessage = ''})
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
  String toString() {
    return 'CalendarState(notes: $notes, allNotes: $allNotes, holidays: $holidays, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarStateImpl &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            const DeepCollectionEquality().equals(other._allNotes, _allNotes) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_notes),
      const DeepCollectionEquality().hash(_allNotes),
      const DeepCollectionEquality().hash(_holidays),
      isLoading,
      errorMessage);

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      __$$CalendarStateImplCopyWithImpl<_$CalendarStateImpl>(this, _$identity);
}

abstract class _CalendarState implements CalendarState {
  const factory _CalendarState(
      {final List<NoteModel> notes,
      final List<NoteModel> allNotes,
      final List<HolidayModel> holidays,
      final bool isLoading,
      final String errorMessage}) = _$CalendarStateImpl;

  @override
  List<NoteModel> get notes;
  @override
  List<NoteModel> get allNotes;
  @override
  List<HolidayModel> get holidays;
  @override
  bool get isLoading;
  @override
  String get errorMessage;

  /// Create a copy of CalendarState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalendarStateImplCopyWith<_$CalendarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
