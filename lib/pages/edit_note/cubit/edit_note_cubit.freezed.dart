// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditNoteState {
  String get id;
  String get title;
  String get content;
  DateTime get dateTime;
  String get userID;
  bool get isLoading;
  String? get errorMessage;
  bool get noteUpdated;

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditNoteStateCopyWith<EditNoteState> get copyWith =>
      _$EditNoteStateCopyWithImpl<EditNoteState>(
          this as EditNoteState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditNoteState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteUpdated, noteUpdated) ||
                other.noteUpdated == noteUpdated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, dateTime,
      userID, isLoading, errorMessage, noteUpdated);

  @override
  String toString() {
    return 'EditNoteState(id: $id, title: $title, content: $content, dateTime: $dateTime, userID: $userID, isLoading: $isLoading, errorMessage: $errorMessage, noteUpdated: $noteUpdated)';
  }
}

/// @nodoc
abstract mixin class $EditNoteStateCopyWith<$Res> {
  factory $EditNoteStateCopyWith(
          EditNoteState value, $Res Function(EditNoteState) _then) =
      _$EditNoteStateCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      DateTime dateTime,
      String userID,
      bool isLoading,
      String? errorMessage,
      bool noteUpdated});
}

/// @nodoc
class _$EditNoteStateCopyWithImpl<$Res>
    implements $EditNoteStateCopyWith<$Res> {
  _$EditNoteStateCopyWithImpl(this._self, this._then);

  final EditNoteState _self;
  final $Res Function(EditNoteState) _then;

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? dateTime = null,
    Object? userID = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteUpdated = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteUpdated: null == noteUpdated
          ? _self.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _EditNoteState implements EditNoteState {
  const _EditNoteState(
      {required this.id,
      this.title = '',
      this.content = '',
      required this.dateTime,
      required this.userID,
      this.isLoading = false,
      this.errorMessage,
      this.noteUpdated = false});

  @override
  final String id;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String content;
  @override
  final DateTime dateTime;
  @override
  final String userID;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool noteUpdated;

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditNoteStateCopyWith<_EditNoteState> get copyWith =>
      __$EditNoteStateCopyWithImpl<_EditNoteState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditNoteState &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteUpdated, noteUpdated) ||
                other.noteUpdated == noteUpdated));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, content, dateTime,
      userID, isLoading, errorMessage, noteUpdated);

  @override
  String toString() {
    return 'EditNoteState(id: $id, title: $title, content: $content, dateTime: $dateTime, userID: $userID, isLoading: $isLoading, errorMessage: $errorMessage, noteUpdated: $noteUpdated)';
  }
}

/// @nodoc
abstract mixin class _$EditNoteStateCopyWith<$Res>
    implements $EditNoteStateCopyWith<$Res> {
  factory _$EditNoteStateCopyWith(
          _EditNoteState value, $Res Function(_EditNoteState) _then) =
      __$EditNoteStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String content,
      DateTime dateTime,
      String userID,
      bool isLoading,
      String? errorMessage,
      bool noteUpdated});
}

/// @nodoc
class __$EditNoteStateCopyWithImpl<$Res>
    implements _$EditNoteStateCopyWith<$Res> {
  __$EditNoteStateCopyWithImpl(this._self, this._then);

  final _EditNoteState _self;
  final $Res Function(_EditNoteState) _then;

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? dateTime = null,
    Object? userID = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteUpdated = null,
  }) {
    return _then(_EditNoteState(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      userID: null == userID
          ? _self.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteUpdated: null == noteUpdated
          ? _self.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
