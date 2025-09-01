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
          final item = productFromJson(response.body);
          emit(ProductFetchSucceed(item));
        } else {
          print("Fetch Failed");
        }
      }catch(e){
        print("error $e");
      }
    });



    on<ProductDetail>((event, emit) async {
      emit(ProductLoading());

      try{
        final id = event.id;
          final url = Uri.parse("https://api.escuelajs.co/api/v1/products/$id");
          final response = await http.get(url);
          if(response.statusCode == 200){
            final detail = productFromJson(response.body);
            emit(ProductDetailLoaded(detail));
            print(detail);
          }
      } catch(e){
        print(e);
      }

    });

    //on<ProductEvent>((event, emit) {
    //});
  }
}
