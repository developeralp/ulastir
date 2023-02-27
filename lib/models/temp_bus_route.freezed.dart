// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'temp_bus_route.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TempBusRoute {
  BusLine get line => throw _privateConstructorUsedError;
  BusDirection get direction => throw _privateConstructorUsedError;
  List<BusDirection> get directions => throw _privateConstructorUsedError;
  BusStation get station => throw _privateConstructorUsedError;
  List<BusStation> get stations => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TempBusRouteCopyWith<TempBusRoute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TempBusRouteCopyWith<$Res> {
  factory $TempBusRouteCopyWith(
          TempBusRoute value, $Res Function(TempBusRoute) then) =
      _$TempBusRouteCopyWithImpl<$Res, TempBusRoute>;
  @useResult
  $Res call(
      {BusLine line,
      BusDirection direction,
      List<BusDirection> directions,
      BusStation station,
      List<BusStation> stations});
}

/// @nodoc
class _$TempBusRouteCopyWithImpl<$Res, $Val extends TempBusRoute>
    implements $TempBusRouteCopyWith<$Res> {
  _$TempBusRouteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line = null,
    Object? direction = null,
    Object? directions = null,
    Object? station = null,
    Object? stations = null,
  }) {
    return _then(_value.copyWith(
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as BusLine,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as BusDirection,
      directions: null == directions
          ? _value.directions
          : directions // ignore: cast_nullable_to_non_nullable
              as List<BusDirection>,
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as BusStation,
      stations: null == stations
          ? _value.stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<BusStation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TempBusRouteCopyWith<$Res>
    implements $TempBusRouteCopyWith<$Res> {
  factory _$$_TempBusRouteCopyWith(
          _$_TempBusRoute value, $Res Function(_$_TempBusRoute) then) =
      __$$_TempBusRouteCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BusLine line,
      BusDirection direction,
      List<BusDirection> directions,
      BusStation station,
      List<BusStation> stations});
}

/// @nodoc
class __$$_TempBusRouteCopyWithImpl<$Res>
    extends _$TempBusRouteCopyWithImpl<$Res, _$_TempBusRoute>
    implements _$$_TempBusRouteCopyWith<$Res> {
  __$$_TempBusRouteCopyWithImpl(
      _$_TempBusRoute _value, $Res Function(_$_TempBusRoute) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? line = null,
    Object? direction = null,
    Object? directions = null,
    Object? station = null,
    Object? stations = null,
  }) {
    return _then(_$_TempBusRoute(
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as BusLine,
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as BusDirection,
      directions: null == directions
          ? _value._directions
          : directions // ignore: cast_nullable_to_non_nullable
              as List<BusDirection>,
      station: null == station
          ? _value.station
          : station // ignore: cast_nullable_to_non_nullable
              as BusStation,
      stations: null == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<BusStation>,
    ));
  }
}

/// @nodoc

class _$_TempBusRoute implements _TempBusRoute {
  const _$_TempBusRoute(
      {required this.line,
      required this.direction,
      required final List<BusDirection> directions,
      required this.station,
      required final List<BusStation> stations})
      : _directions = directions,
        _stations = stations;

  @override
  final BusLine line;
  @override
  final BusDirection direction;
  final List<BusDirection> _directions;
  @override
  List<BusDirection> get directions {
    if (_directions is EqualUnmodifiableListView) return _directions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directions);
  }

  @override
  final BusStation station;
  final List<BusStation> _stations;
  @override
  List<BusStation> get stations {
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stations);
  }

  @override
  String toString() {
    return 'TempBusRoute(line: $line, direction: $direction, directions: $directions, station: $station, stations: $stations)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TempBusRoute &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            const DeepCollectionEquality()
                .equals(other._directions, _directions) &&
            (identical(other.station, station) || other.station == station) &&
            const DeepCollectionEquality().equals(other._stations, _stations));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      line,
      direction,
      const DeepCollectionEquality().hash(_directions),
      station,
      const DeepCollectionEquality().hash(_stations));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TempBusRouteCopyWith<_$_TempBusRoute> get copyWith =>
      __$$_TempBusRouteCopyWithImpl<_$_TempBusRoute>(this, _$identity);
}

abstract class _TempBusRoute implements TempBusRoute {
  const factory _TempBusRoute(
      {required final BusLine line,
      required final BusDirection direction,
      required final List<BusDirection> directions,
      required final BusStation station,
      required final List<BusStation> stations}) = _$_TempBusRoute;

  @override
  BusLine get line;
  @override
  BusDirection get direction;
  @override
  List<BusDirection> get directions;
  @override
  BusStation get station;
  @override
  List<BusStation> get stations;
  @override
  @JsonKey(ignore: true)
  _$$_TempBusRouteCopyWith<_$_TempBusRoute> get copyWith =>
      throw _privateConstructorUsedError;
}
