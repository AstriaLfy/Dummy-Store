part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState{}
final class ProductLoading extends ProductState{}


final class ProductFetchSucceed extends ProductState{
  final List<Product> item;
  ProductFetchSucceed(this.item);
}

final class ProductDetailLoaded extends ProductState{
  final Product product;
  ProductDetailLoaded(this.product);
}
