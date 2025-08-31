import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:raion_battlepass_dummy/Bloc/product/product_bloc.dart';
import 'package:raion_battlepass_dummy/models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(ProductFetch());
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state){
        if (state is ProductLoading){
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProductFetchSucceed){
          final products = state.item;
          return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1,
          ),itemCount: products.length,
            itemBuilder: (context, index){
            final product = products[index];
            final title = product.title;
            final desc = product.description;

            return Card(
              child: Text(title),
            );
            },
          );
        }

        return Text("Default");
      }),
    );
  }
}
