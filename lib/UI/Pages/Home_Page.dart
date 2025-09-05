import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raion_battlepass_dummy/Bloc/product/product_bloc.dart';
import 'package:raion_battlepass_dummy/UI/Pages/Detail_Page.dart';
import 'package:raion_battlepass_dummy/models/product.dart';
import 'package:raion_battlepass_dummy/UI/Pages/AddProduct_Page.dart';

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
    final productbloc = context.read<ProductBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          print('Current state: $state');
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductFetchSucceed) {
            final products = state.item;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final title = product.title;
                final id = product.id;

                return InkWell(
                  onTap: () {
                    print("test click");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(id: id, title: title),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              product.images[0],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Product Add");
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddproductPage()));
        },
        child: Icon(Icons.add),
      ),
    );

  }
}
