// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AddNoteState {
  String get title;
  String get content;
  DateTime get dateTime;
  bool get isLoading;
  String? get errorMessage;
  bool get noteAdded;
  bool get isNetworkError;

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AddNoteStateCopyWith<AddNoteState> get copyWith =>
      _$AddNoteStateCopyWithImpl<AddNoteState>(
          this as AddNoteState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AddNoteState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteAdded, noteAdded) ||
                other.noteAdded == noteAdded) &&
            (identical(other.isNetworkError, isNetworkError) ||
                other.isNetworkError == isNetworkError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content, dateTime,
      isLoading, errorMessage, noteAdded, isNetworkError);

  @override
  String toString() {
    return 'AddNoteState(title: $title, content: $content, dateTime: $dateTime, isLoading: $isLoading, errorMessage: $errorMessage, noteAdded: $noteAdded, isNetworkError: $isNetworkError)';
  }
}

/// @nodoc
abstract mixin class $AddNoteStateCopyWith<$Res> {
  factory $AddNoteStateCopyWith(
          AddNoteState value, $Res Function(AddNoteState) _then) =
      _$AddNoteStateCopyWithImpl;
  @useResult
  $Res call(
      {String title,
      String content,
      DateTime dateTime,
      bool isLoading,
      String? errorMessage,
      bool noteAdded,
      bool isNetworkError});
}

/// @nodoc
class _$AddNoteStateCopyWithImpl<$Res> implements $AddNoteStateCopyWith<$Res> {
  _$AddNoteStateCopyWithImpl(this._self, this._then);

  final AddNoteState _self;
  final $Res Function(AddNoteState) _then;

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
    Object? isNetworkError = null,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _self.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteAdded: null == noteAdded
          ? _self.noteAdded
          : noteAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      isNetworkError: null == isNetworkError
          ? _self.isNetworkError
          : isNetworkError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _AddNoteState implements AddNoteState {
  const _AddNoteState(
      {this.title = '',
      this.content = '',
      required this.dateTime,
      this.isLoading = false,
      this.errorMessage,
      this.noteAdded = false,
      this.isNetworkError = false});

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
  @JsonKey()
  final bool isNetworkError;

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AddNoteStateCopyWith<_AddNoteState> get copyWith =>
      __$AddNoteStateCopyWithImpl<_AddNoteState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AddNoteState &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteAdded, noteAdded) ||
                other.noteAdded == noteAdded) &&
            (identical(other.isNetworkError, isNetworkError) ||
                other.isNetworkError == isNetworkError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, content, dateTime,
      isLoading, errorMessage, noteAdded, isNetworkError);

  @override
  String toString() {
    return 'AddNoteState(title: $title, content: $content, dateTime: $dateTime, isLoading: $isLoading, errorMessage: $errorMessage, noteAdded: $noteAdded, isNetworkError: $isNetworkError)';
  }
}

/// @nodoc
abstract mixin class _$AddNoteStateCopyWith<$Res>
    implements $AddNoteStateCopyWith<$Res> {
  factory _$AddNoteStateCopyWith(
          _AddNoteState value, $Res Function(_AddNoteState) _then) =
      __$AddNoteStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String title,
      String content,
      DateTime dateTime,
      bool isLoading,
      String? errorMessage,
      bool noteAdded,
      bool isNetworkError});
}

/// @nodoc
class __$AddNoteStateCopyWithImpl<$Res>
    implements _$AddNoteStateCopyWith<$Res> {
  __$AddNoteStateCopyWithImpl(this._self, this._then);

  final _AddNoteState _self;
  final $Res Function(_AddNoteState) _then;

  /// Create a copy of AddNoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? dateTime = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteAdded = null,
    Object? isNetworkError = null,
  }) {
    return _then(_AddNoteState(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _self.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteAdded: null == noteAdded
          ? _self.noteAdded
          : noteAdded // ignore: cast_nullable_to_non_nullable
              as bool,
      isNetworkError: null == isNetworkError
          ? _self.isNetworkError
          : isNetworkError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
