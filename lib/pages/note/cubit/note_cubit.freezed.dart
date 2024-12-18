// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NoteState {
  NoteModel? get note => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get noteDeleted => throw _privateConstructorUsedError;
  bool get noteUpdated => throw _privateConstructorUsedError;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoteStateCopyWith<NoteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoteStateCopyWith<$Res> {
  factory $NoteStateCopyWith(NoteState value, $Res Function(NoteState) then) =
      _$NoteStateCopyWithImpl<$Res, NoteState>;
  @useResult
  $Res call(
      {NoteModel? note,
      bool isLoading,
      String? errorMessage,
      bool noteDeleted,
      bool noteUpdated});
}

/// @nodoc
class _$NoteStateCopyWithImpl<$Res, $Val extends NoteState>
    implements $NoteStateCopyWith<$Res> {
  _$NoteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? note = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteDeleted = null,
    Object? noteUpdated = null,
  }) {
    return _then(_value.copyWith(
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as NoteModel?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteDeleted: null == noteDeleted
          ? _value.noteDeleted
          : noteDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      noteUpdated: null == noteUpdated
          ? _value.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NoteStateImplCopyWith<$Res>
    implements $NoteStateCopyWith<$Res> {
  factory _$$NoteStateImplCopyWith(
          _$NoteStateImpl value, $Res Function(_$NoteStateImpl) then) =
      __$$NoteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NoteModel? note,
      bool isLoading,
      String? errorMessage,
      bool noteDeleted,
      bool noteUpdated});
}

/// @nodoc
class __$$NoteStateImplCopyWithImpl<$Res>
    extends _$NoteStateCopyWithImpl<$Res, _$NoteStateImpl>
    implements _$$NoteStateImplCopyWith<$Res> {
  __$$NoteStateImplCopyWithImpl(
      _$NoteStateImpl _value, $Res Function(_$NoteStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? note = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteDeleted = null,
    Object? noteUpdated = null,
  }) {
    return _then(_$NoteStateImpl(
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as NoteModel?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteDeleted: null == noteDeleted
          ? _value.noteDeleted
          : noteDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      noteUpdated: null == noteUpdated
          ? _value.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$NoteStateImpl implements _NoteState {
  const _$NoteStateImpl(
      {this.note,
      this.isLoading = false,
      this.errorMessage,
      this.noteDeleted = false,
      this.noteUpdated = false});

  @override
  final NoteModel? note;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool noteDeleted;
  @override
  @JsonKey()
  final bool noteUpdated;

  @override
  String toString() {
    return 'NoteState(note: $note, isLoading: $isLoading, errorMessage: $errorMessage, noteDeleted: $noteDeleted, noteUpdated: $noteUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoteStateImpl &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteDeleted, noteDeleted) ||
                other.noteDeleted == noteDeleted) &&
            (identical(other.noteUpdated, noteUpdated) ||
                other.noteUpdated == noteUpdated));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, note, isLoading, errorMessage, noteDeleted, noteUpdated);

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoteStateImplCopyWith<_$NoteStateImpl> get copyWith =>
      __$$NoteStateImplCopyWithImpl<_$NoteStateImpl>(this, _$identity);
}

abstract class _NoteState implements NoteState {
  const factory _NoteState(
      {final NoteModel? note,
      final bool isLoading,
      final String? errorMessage,
      final bool noteDeleted,
      final bool noteUpdated}) = _$NoteStateImpl;

  @override
  NoteModel? get note;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  bool get noteDeleted;
  @override
  bool get noteUpdated;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoteStateImplCopyWith<_$NoteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
