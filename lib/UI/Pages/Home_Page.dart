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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state){
        if (state is ProductLoading){
          return const Center(child: CircularProgressIndicator());
        } else if (state == ProductFetchSucceed){
          print("Fetch Succeed and ready to show");
        }

        return Text("Default");
      }),
    );
  }
}
