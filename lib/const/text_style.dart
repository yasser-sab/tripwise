import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



TextStyle kStyle = GoogleFonts.aBeeZee();
TextStyle kStyleBolded = GoogleFonts.aBeeZee(fontWeight: FontWeight.bold);

TextStyle kmStyle(double fontSize){
  return GoogleFonts.aBeeZee(fontSize: fontSize);
}
TextStyle kmStyleBolded(double fontSize){
  return GoogleFonts.aBeeZee(fontWeight: FontWeight.bold, fontSize: fontSize);
}