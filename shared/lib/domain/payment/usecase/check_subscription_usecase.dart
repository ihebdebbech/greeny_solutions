import 'package:shared/domain/authentication/authentication_repository.dart';
import 'package:shared/domain/payment/payment_repository.dart';
import 'package:shared/domain/room/room_repository.dart';

class CheckSubscriptionUsecase {
  final PaymentRepository _repository;

  CheckSubscriptionUsecase(this._repository);

  Future<bool> getSubcriptionStatus() async {
    try {
      return await _repository.getSubcriptionStatus();
    } catch (error) {
      throw error;
    }
  }

  Future<String> initpayment() async {
    try {
      return await _repository.initpayment();
    } catch (error) {
      throw error;
    }
  }
}
