import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raion_battlepass_dummy/Bloc/product/product_bloc.dart';
import 'package:raion_battlepass_dummy/models/product.dart';

class DetailPage extends StatefulWidget {
  final int id;
  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            print("Loading Fetch Single Product");
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetailLoaded) {
            final product = state.product;
            print(state);
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product.images[0], fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.title,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text("Price: \$${product.price}"),
                        const SizedBox(height: 8),
                        Text(product.description),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text(widget.id.toString()),
          );
        },
      ),
    );
  }
}
