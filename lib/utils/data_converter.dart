class BLEDataConverter {
  static Map<String, dynamic>? convertShortToLongFormat(
      Map<String, dynamic> rawData) {
    // データがdata.dの階層構造になっている場合の処理
    final shortData = rawData['data']?['d'] ?? rawData['d'];
    if (shortData == null) return null;

    return {
      'digital_outputs': _expandPinData(shortData['do']),
      'digital_inputs': _expandPinData(shortData['di']),
      'analog_inputs': _expandPinData(shortData['ai']),
    };
  }

  static Map<String, dynamic> _expandPinData(Map<String, dynamic>? shortData) {
    if (shortData == null) return {};

    final result = <String, dynamic>{};
    shortData.forEach((key, value) {
      result[key] = {
        'value': value['v'],
        'gp': value['g'],
      };
    });
    return result;
  }

  static Map<String, dynamic> createCommand(String cmd,
      {String? category, String? pin, dynamic val}) {
    // 短縮フォーマットでコマンドを生成
    if (cmd == 'set') {
      return {
        'c': 's',
        't': _getCategoryShortName(category),
        'p': pin,
        'v': val,
      };
    }
    if (cmd == 'read') {
      return {'c': 'r'};
    }

    // その他のコマンドは既存フォーマットを使用
    final Map<String, dynamic> command = {'cmd': cmd};
    if (category != null) command['category'] = category;
    if (pin != null) command['pin'] = pin;
    if (val != null) command['val'] = val;
    return command;
  }

  static String? _getCategoryShortName(String? category) {
    if (category == 'digital_outputs') return 'do';
    if (category == 'digital_inputs') return 'di';
    if (category == 'analog_inputs') return 'ai';
    return category;
  }
}
