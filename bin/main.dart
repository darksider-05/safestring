import 'dart:io';

void main() {
  var cipher = Cipher();
  var encoder = Encoder();
  bool loop1 = true;
  String? mode;

  stdout.writeln("Choose one:");
  stdout.writeln("1. Encode");
  stdout.writeln("2. Decode");

  while (loop1) {
    stdout.writeln("Please choose '1' or '2':");
    String inp = stdin.readLineSync() ?? "";

    if (inp == "1") {
      mode = "encode";
      loop1 = false;
    } else if (inp == "2") {
      mode = "decode";
      loop1 = false;
    }
  }

  if (mode == "encode") {
    stdout.writeln("Please enter the expression:");
    String exp = stdin.readLineSync() ?? "";
    List<String> lst = exp.split("");
    List<int> vals = [];

    for (int index = 0; index < lst.length; index++) {
      vals.add(cipher.val(lst[index]));
    }
    vals = encoder.encode(vals);
    stdout.writeln("Your encoded expression:");
    stdout.writeln(vals.join("A"));
  } else if (mode == "decode") {
    stdout.writeln("Please enter the sequence:");
    String exp = stdin.readLineSync() ?? "";
    List<String> lst = exp.split("A");

    List<int> vals = lst.map((numStr) => int.tryParse(numStr) ?? 999).toList();
    vals = encoder.decode(vals);

    for (int index = 0; index < lst.length; index++) {
      lst[index] = cipher.char(vals[index]);
    }

    stdout.writeln("Your decoded expression:");
    stdout.writeln(lst.join(""));
  }
}

class Encoder {
  List<int> encode(List<int> preset) {
    for (int index = 0; index < preset.length; index++) {
      preset[index] = enc(preset[index], index);
    }
    return preset;
  }

  List<int> decode(List<int> preset) {
    for (int index = 0; index < preset.length; index++) {
      preset[index] = dec(preset[index], index);
    }
    return preset;
  }

  int enc(int val, int index) {
    switch (index % 4) {
      case 0:
        return val + 1;
      case 1:
        return val + 2;
      case 2:
        return val + 3;
      case 3:
        return val + 4;
      default:
        return 999;
    }
  }

  int dec(int val, int index) {
    switch (index % 4) {
      case 0:
        return val - 1;
      case 1:
        return val - 2;
      case 2:
        return val - 3;
      case 3:
        return val - 4;
      default:
        return 999;
    }
  }
}

class Cipher {
  final baseMap = {
    'a': 0,
    'A': 31,
    'b': 1,
    'B': 32,
    'c': 2,
    'C': 33,
    'd': 3,
    'D': 34,
    'e': 4,
    'E': 35,
    'f': 5,
    'F': 36,
    'g': 6,
    'G': 37,
    'h': 7,
    'H': 38,
    'i': 8,
    'I': 39,
    'j': 9,
    'J': 40,
    'k': 10,
    'K': 41,
    'l': 11,
    'L': 42,
    'm': 12,
    'M': 43,
    'n': 13,
    'N': 44,
    'o': 14,
    'O': 45,
    'p': 15,
    'P': 46,
    'q': 16,
    'Q': 47,
    'r': 17,
    'R': 48,
    's': 18,
    'S': 49,
    't': 19,
    'T': 50,
    'u': 20,
    'U': 51,
    'v': 21,
    'V': 52,
    'w': 22,
    'W': 53,
    'x': 23,
    'X': 54,
    'y': 24,
    'Y': 55,
    'z': 25,
    'Z': 56,
    ' ': 26,
    '"': 27,
    '?': 28,
    '.': 29,
    ',': 30,
  };
  final reverseMap = {
    0: 'a',
    1: 'b',
    2: 'c',
    3: 'd',
    4: 'e',
    5: 'f',
    6: 'g',
    7: 'h',
    8: 'i',
    9: 'j',
    10: 'k',
    11: 'l',
    12: 'm',
    13: 'n',
    14: 'o',
    15: 'p',
    16: 'q',
    17: 'r',
    18: 's',
    19: 't',
    20: 'u',
    21: 'v',
    22: 'w',
    23: 'x',
    24: 'y',
    25: 'z',
    26: ' ',
    27: '"',
    28: '?',
    29: '.',
    30: ',',
    31: 'A',
    32: 'B',
    33: 'C',
    34: 'D',
    35: 'E',
    36: 'F',
    37: 'G',
    38: 'H',
    39: 'I',
    40: 'J',
    41: 'K',
    42: 'L',
    43: 'M',
    44: 'N',
    45: 'O',
    46: 'P',
    47: 'Q',
    48: 'R',
    49: 'S',
    50: 'T',
    51: 'U',
    52: 'V',
    53: 'W',
    54: 'X',
    55: 'Y',
    56: 'Z',
  };

  int val(String char) {
    final base = baseMap[char] ?? 999;
    return base;
  }

  String char(int val) {
    final charac = reverseMap[val] ?? "^";
    return charac;
  }
}
