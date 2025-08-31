import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:raion_battlepass_dummy/models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductFetch>((event, emit) async {
      emit(ProductLoading());

      try{
        final url = Uri.parse("https://api.escuelajs.co/api/v1/products");
        final response = await http.get(url);
        print("Start Fetching");

        if(response.statusCode == 200){
          print("Fect Succeed");
          final product = productFromJson(response.body);
          emit(ProductFetchSucceed());
        }

      }catch(e){
        print("error $e");
      }

    });



    on<ProductEvent>((event, emit) {
    });

    on<ProductEvent>((event, emit) {
    });
  }
}
