// ignore_for_file: non_constant_identifier_names


import 'package:shared/data/payment/payment_service.dart';
import 'package:shared/domain/payment/payment_repository.dart';


class PaymentDataRepository implements PaymentRepository {
  final PaymentService _service;

  PaymentDataRepository(this._service);

  @override
  Future<bool>getSubcriptionStatus() async {
    final status = await _service.getSubcriptionStatus();
    return status;
  }

  @override
  Future<String> initpayment() async {
    try {
      final status = await _service.initpayment();
      return status;
    } catch (err) {
      print(err);
      return "false";
    }
  }
}
