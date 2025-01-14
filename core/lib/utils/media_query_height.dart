

import 'package:flutter/cupertino.dart';

extension Height on BuildContext {

double Heightmedia(coef) => MediaQuery.of(this).size.height * coef ;
double widthmedia(coef) => MediaQuery.of(this).size.width * coef ;




}