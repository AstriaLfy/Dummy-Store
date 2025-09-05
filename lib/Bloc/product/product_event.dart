part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductFetch extends ProductEvent{}
class SingleFetch extends ProductEvent{}

class ProductDetail extends ProductEvent{
  final int id;
  ProductDetail(this.id);
}

class ProductUpdate extends ProductEvent{}
class ProductAdd extends ProductEvent{}
class ProductDelete extends ProductEvent{}
class StateReset extends ProductEvent{}
