import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AppInputFormatters {
  static MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
      mask: '+### (##) ###-##-##',
      filter: {'#': RegExp(r'[\+0-9]')},
      type: MaskAutoCompletionType.lazy);
  static final cardNumberFormatter = MaskTextInputFormatter(
      mask: '#### #### #### ####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  static final money = MaskTextInputFormatter(
      mask: '### ### ### ###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  static final cardExpirationDateFormatter = MaskTextInputFormatter(
      mask: '##/##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  static final cardCVCFormatter = MaskTextInputFormatter(
      mask: '###',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
}



class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final length = newText.length;

    if (length <= 2 && length > 0) {
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: length),
      );
    } else if (length == 3 && newText != oldValue.text) {
      return TextEditingValue(
        text: '${newText.substring(0, 2)}/',
        selection: TextSelection.collapsed(offset: 3),
      );
    } else if (length > 3) {
      return TextEditingValue(
        text: newText.substring(0, 4),
        selection: TextSelection.collapsed(offset: 4),
      );
    } else {
      return newValue;
    }
  }
}

// final expiryDateFormatter = ExpiryDateFormatter();
//
// TextFormField(
// keyboardType: TextInputType.number,
// inputFormatters: [expiryDateFormatter],
// decoration: InputDecoration(
// labelText: 'Expiry Date (MM/YY)',
// ),
// // ... other TextFormField properties
// ),
