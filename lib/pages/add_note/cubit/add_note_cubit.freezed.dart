// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AddNoteState {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get noteAdded => throw _privateConstructorUsedError;

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddNoteStateCopyWith<AddNoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddNoteStateCopyWith<$Res> {
  factory $AddNoteStateCopyWith(
          AddNoteState value, $Res Function(AddNoteState) then) =
      _$AddNoteStateCopyWithImpl<$Res, AddNoteState>;
  @useResult
  $Res call(
      {String title,
      String content,
      DateTime dateTime,
      bool isLoading,
      String? errorMessage,
      bool noteAdded});
}

/// @nodoc
class _$AddNoteStateCopyWithImpl<$Res, $Val extends AddNoteState>
    implements $AddNoteStateCopyWith<$Res> {
  _$AddNoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? dateTime = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteAdded = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteAdded: null == noteAdded
          ? _value.noteAdded
          : noteAdded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddNoteStateImplCopyWith<$Res>
    implements $AddNoteStateCopyWith<$Res> {
  factory _$$AddNoteStateImplCopyWith(
          _$AddNoteStateImpl value, $Res Function(_$AddNoteStateImpl) then) =
      __$$AddNoteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      DateTime dateTime,
      bool isLoading,
      String? errorMessage,
      bool noteAdded});
}

/// @nodoc
class __$$AddNoteStateImplCopyWithImpl<$Res>
    extends _$AddNoteStateCopyWithImpl<$Res, _$AddNoteStateImpl>
    implements _$$AddNoteStateImplCopyWith<$Res> {
  __$$AddNoteStateImplCopyWithImpl(
      _$AddNoteStateImpl _value, $Res Function(_$AddNoteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? dateTime = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteAdded = null,
  }) {
    return _then(_$AddNoteStateImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteAdded: null == noteAdded
          ? _value.noteAdded
          : noteAdded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AddNoteStateImpl implements _AddNoteState {
  const _$AddNoteStateImpl(
      {this.title = '',
      this.content = '',
      required this.dateTime,
      this.isLoading = false,
      this.errorMessage,
      this.noteAdded = false});

  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String content;
  @override
  final DateTime dateTime;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool noteAdded;

  @override
  String toString() {
    return 'AddNoteState(title: $title, content: $content, dateTime: $dateTime, isLoading: $isLoading, errorMessage: $errorMessage, noteAdded: $noteAdded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddNoteStateImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteAdded, noteAdded) ||
                other.noteAdded == noteAdded));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content, dateTime,
      isLoading, errorMessage, noteAdded);

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddNoteStateImplCopyWith<_$AddNoteStateImpl> get copyWith =>
      __$$AddNoteStateImplCopyWithImpl<_$AddNoteStateImpl>(this, _$identity);
}

abstract class _AddNoteState implements AddNoteState {
  const factory _AddNoteState(
      {final String title,
      final String content,
      required final DateTime dateTime,
      final bool isLoading,
      final String? errorMessage,
      final bool noteAdded}) = _$AddNoteStateImpl;

  @override
  String get title;
  @override
  String get content;
  @override
  DateTime get dateTime;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get noteAdded;

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddNoteStateImplCopyWith<_$AddNoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
