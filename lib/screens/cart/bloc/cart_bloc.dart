import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch_store/data/model/cart.dart';
import 'package:watch_store/data/model/user_address.dart';
import 'package:watch_store/data/repo/cart_repo.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository _cartRepository;
  CartBloc(this._cartRepository) : super(CartInitialState()) {
    on<CartEvent>((event, emit) async {
      try {
        if (event is CartInitEvent) {
          // CartInitEvent
          emit(CartLoadingState());
          final userCart = await _cartRepository.getUserCart();
          emit(CartLoadedState(userCart));
        } else if (event is RemoveFromCartEvent) {
          // RemoveFromCartEvent
          final response = await _cartRepository.removeFromCart(
            productId: event.productId,
          );
          emit(CartItemRemovedState(response));
        } else if (event is DeleteFromCartEvent) {
          // DeleteFromCartEvent
          final response = await _cartRepository.deleteFromCart(
            productId: event.productId,
          );
          emit(CartItemDeletedState(response));
        } else if (event is AddToCartEvent) {
          // AddToCartEvent
          final response = await _cartRepository.addToCart(
            productId: event.productId,
          );
          emit(CartItemAddedState(response));
        } else if (event is AddToCartSingleEvent) {
          // AddToCartSingleEvent
          emit(CartLoadingSingleState());
          final response = await _cartRepository.addToCart(
            productId: event.productId,
          );
          emit(CartItemAddedState(response));
        } else if (event is CartItemCountEvent) {
          // CartItemCountEvent
          await _cartRepository.countCartItems();
          emit(CartCountState());
        } else if (event is PayEvent) {
          // PayEvent
          final response = await _cartRepository.payCart();
          emit(RecivedPayLinkState(url: response));
        } else if (event is GetUserAddressEvent) {
          // GetUserAddressEvent
          emit(UserAddressLoadingState());
          try {
            final response = await _cartRepository.getUserAddresses();
            emit(GetUserAddressesLoadedState(userAddress: response));
          } catch (_) {
            emit(UserAddressErrorState());
          }
        }
      } catch (e) {
        emit(CartErrorState());
      }
    });
  }
}
