// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EditNoteState {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get noteUpdated => throw _privateConstructorUsedError;

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditNoteStateCopyWith<EditNoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditNoteStateCopyWith<$Res> {
  factory $EditNoteStateCopyWith(
          EditNoteState value, $Res Function(EditNoteState) then) =
      _$EditNoteStateCopyWithImpl<$Res, EditNoteState>;
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
class _$EditNoteStateCopyWithImpl<$Res, $Val extends EditNoteState>
    implements $EditNoteStateCopyWith<$Res> {
  _$EditNoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteUpdated: null == noteUpdated
          ? _value.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EditNoteStateImplCopyWith<$Res>
    implements $EditNoteStateCopyWith<$Res> {
  factory _$$EditNoteStateImplCopyWith(
          _$EditNoteStateImpl value, $Res Function(_$EditNoteStateImpl) then) =
      __$$EditNoteStateImplCopyWithImpl<$Res>;
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
class __$$EditNoteStateImplCopyWithImpl<$Res>
    extends _$EditNoteStateCopyWithImpl<$Res, _$EditNoteStateImpl>
    implements _$$EditNoteStateImplCopyWith<$Res> {
  __$$EditNoteStateImplCopyWithImpl(
      _$EditNoteStateImpl _value, $Res Function(_$EditNoteStateImpl) _then)
      : super(_value, _then);

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
    return _then(_$EditNoteStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteUpdated: null == noteUpdated
          ? _value.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EditNoteStateImpl implements _EditNoteState {
  const _$EditNoteStateImpl(
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

  @override
  String toString() {
    return 'EditNoteState(id: $id, title: $title, content: $content, dateTime: $dateTime, userID: $userID, isLoading: $isLoading, errorMessage: $errorMessage, noteUpdated: $noteUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditNoteStateImpl &&
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

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditNoteStateImplCopyWith<_$EditNoteStateImpl> get copyWith =>
      __$$EditNoteStateImplCopyWithImpl<_$EditNoteStateImpl>(this, _$identity);
}

abstract class _EditNoteState implements EditNoteState {
  const factory _EditNoteState(
      {required final String id,
      final String title,
      final String content,
      required final DateTime dateTime,
      required final String userID,
      final bool isLoading,
      final String? errorMessage,
      final bool noteUpdated}) = _$EditNoteStateImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  DateTime get dateTime;
  @override
  String get userID;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get noteUpdated;

  /// Create a copy of EditNoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditNoteStateImplCopyWith<_$EditNoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
