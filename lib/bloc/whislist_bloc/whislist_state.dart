part of 'whislist_bloc.dart';

sealed class WhislistState extends Equatable {}

final class WhilistInitial extends WhislistState {
  WhilistInitial();
  @override
  List<Object> get props => [];
}

final class WhislistUpdateData extends WhislistState {
  WhislistUpdateData({required this.data});
  final List<WhislistModel> data;
  @override
  List<Object> get props => [data];
}

final class WhislistSuccess extends WhislistState {
  @override
  List<Object> get props => [];
}

final class WhislistFailed extends WhislistState {
  WhislistFailed(this.error);
  final String error;
  @override
  List<Object> get props => [error];
}
