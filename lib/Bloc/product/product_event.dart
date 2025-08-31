part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductFetch extends ProductEvent{}

class ProductClick extends ProductEvent{
  final String id;
  ProductClick(this.id);
}

class ProductUpdate extends ProductEvent{}
class ProductAdd extends ProductEvent{}
class ProductDelete extends ProductEvent{}

