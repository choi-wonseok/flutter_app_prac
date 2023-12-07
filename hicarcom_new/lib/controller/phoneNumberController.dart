import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('-', '');

    if (text.length >= 3 && text.startsWith('02')) {
      if (text.length == 9) {
        // "02"로 시작하는 9자리 전화번호 형식
        text = _formatAsPhone(text, [2, 3, 4]);
      } else if (text.length == 10) {
        // "02"로 시작하는 10자리 전화번호 형식
        text = _formatAsPhone(text, [2, 4, 4]);
      }
    } else if (text.length == 10) {
      // "03" 이상으로 시작하는 10자리 전화번호 형식
      text = _formatAsPhone(text, [3, 3, 4]);
    } else if (text.length == 11) {
      // 11자리 전화번호 형식
      text = _formatAsPhone(text, [3, 4, 4]);
    }

    return newValue.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length));
  }

  String _formatAsPhone(String text, List<int> pattern) {
    StringBuffer buffer = StringBuffer();
    int patternIndex = 0;
    int segmentSize = pattern[patternIndex];

    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % segmentSize == 0 && i != text.length - 1) {
        buffer.write('-');
        if (patternIndex < pattern.length - 1) {
          patternIndex++;
          segmentSize += pattern[patternIndex];
        }
      }
    }
    return buffer.toString();
  }
}