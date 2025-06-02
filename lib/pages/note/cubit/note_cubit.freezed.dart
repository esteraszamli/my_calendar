// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NoteState {
  NoteModel? get note;
  bool get isLoading;
  String? get errorMessage;
  bool get noteDeleted;
  bool get noteUpdated;
  bool get noteDeletedLocally;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NoteStateCopyWith<NoteState> get copyWith =>
      _$NoteStateCopyWithImpl<NoteState>(this as NoteState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NoteState &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteDeleted, noteDeleted) ||
                other.noteDeleted == noteDeleted) &&
            (identical(other.noteUpdated, noteUpdated) ||
                other.noteUpdated == noteUpdated) &&
            (identical(other.noteDeletedLocally, noteDeletedLocally) ||
                other.noteDeletedLocally == noteDeletedLocally));
  }

  @override
  int get hashCode => Object.hash(runtimeType, note, isLoading, errorMessage,
      noteDeleted, noteUpdated, noteDeletedLocally);

  @override
  String toString() {
    return 'NoteState(note: $note, isLoading: $isLoading, errorMessage: $errorMessage, noteDeleted: $noteDeleted, noteUpdated: $noteUpdated, noteDeletedLocally: $noteDeletedLocally)';
  }
}

/// @nodoc
abstract mixin class $NoteStateCopyWith<$Res> {
  factory $NoteStateCopyWith(NoteState value, $Res Function(NoteState) _then) =
      _$NoteStateCopyWithImpl;
  @useResult
  $Res call(
      {NoteModel? note,
      bool isLoading,
      String? errorMessage,
      bool noteDeleted,
      bool noteUpdated,
      bool noteDeletedLocally});
}

/// @nodoc
class _$NoteStateCopyWithImpl<$Res> implements $NoteStateCopyWith<$Res> {
  _$NoteStateCopyWithImpl(this._self, this._then);

  final NoteState _self;
  final $Res Function(NoteState) _then;

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
    Object? noteDeletedLocally = null,
  }) {
    return _then(_self.copyWith(
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as NoteModel?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteDeleted: null == noteDeleted
          ? _self.noteDeleted
          : noteDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      noteUpdated: null == noteUpdated
          ? _self.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
      noteDeletedLocally: null == noteDeletedLocally
          ? _self.noteDeletedLocally
          : noteDeletedLocally // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _NoteState implements NoteState {
  const _NoteState(
      {this.note,
      this.isLoading = false,
      this.errorMessage,
      this.noteDeleted = false,
      this.noteUpdated = false,
      this.noteDeletedLocally = false});

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
  @JsonKey()
  final bool noteDeletedLocally;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NoteStateCopyWith<_NoteState> get copyWith =>
      __$NoteStateCopyWithImpl<_NoteState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NoteState &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.noteDeleted, noteDeleted) ||
                other.noteDeleted == noteDeleted) &&
            (identical(other.noteUpdated, noteUpdated) ||
                other.noteUpdated == noteUpdated) &&
            (identical(other.noteDeletedLocally, noteDeletedLocally) ||
                other.noteDeletedLocally == noteDeletedLocally));
  }

  @override
  int get hashCode => Object.hash(runtimeType, note, isLoading, errorMessage,
      noteDeleted, noteUpdated, noteDeletedLocally);

  @override
  String toString() {
    return 'NoteState(note: $note, isLoading: $isLoading, errorMessage: $errorMessage, noteDeleted: $noteDeleted, noteUpdated: $noteUpdated, noteDeletedLocally: $noteDeletedLocally)';
  }
}

/// @nodoc
abstract mixin class _$NoteStateCopyWith<$Res>
    implements $NoteStateCopyWith<$Res> {
  factory _$NoteStateCopyWith(
          _NoteState value, $Res Function(_NoteState) _then) =
      __$NoteStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {NoteModel? note,
      bool isLoading,
      String? errorMessage,
      bool noteDeleted,
      bool noteUpdated,
      bool noteDeletedLocally});
}

/// @nodoc
class __$NoteStateCopyWithImpl<$Res> implements _$NoteStateCopyWith<$Res> {
  __$NoteStateCopyWithImpl(this._self, this._then);

  final _NoteState _self;
  final $Res Function(_NoteState) _then;

  /// Create a copy of NoteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? note = freezed,
    Object? isLoading = null,
    Object? errorMessage = freezed,
    Object? noteDeleted = null,
    Object? noteUpdated = null,
    Object? noteDeletedLocally = null,
  }) {
    return _then(_NoteState(
      note: freezed == note
          ? _self.note
          : note // ignore: cast_nullable_to_non_nullable
              as NoteModel?,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      noteDeleted: null == noteDeleted
          ? _self.noteDeleted
          : noteDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      noteUpdated: null == noteUpdated
          ? _self.noteUpdated
          : noteUpdated // ignore: cast_nullable_to_non_nullable
              as bool,
      noteDeletedLocally: null == noteDeletedLocally
          ? _self.noteDeletedLocally
          : noteDeletedLocally // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
