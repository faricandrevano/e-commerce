part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String title;
  final String? category;
  SearchProducts({required this.title, this.category});
  @override
  List<Object> get props => [title];
}

class RefreshProduct extends ProductEvent {}
