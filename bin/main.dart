import 'dart:io';
import 'dart:math';

void main() {
  var cipher = Cipher();
  var encoder = Encoder();
  bool loop1 = true;
  String? mode;

  stdout.writeln("Choose an option:");
  stdout.writeln();
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
    List tricks = [];

    for (int index = 0; index < lst.length; index++) {
      vals.add(cipher.val(lst[index]));
    }
    vals = encoder.encode(vals);

    for (int index = 0; index < vals.length; index++) {
      int a = Random().nextInt(10);
      if (a > 5) {
        tricks.add(index);
      }
    }

    for (var item in tricks) {
      vals.insert(item, [89, 78, 93, 69, 91, 94, 70, 87][Random().nextInt(8)]);
    }

    stdout.writeln("Your encoded expression:");
    stdout.writeln(vals.join("A"));
  } else if (mode == "decode") {
    stdout.writeln("Please enter the sequence:");
    String exp = stdin.readLineSync() ?? "";
    List<String> lst = exp.split("A");

    lst.removeWhere(
      (item) => ["89", "78", "93", "69", "91", "94", "70", "87"].contains(item),
    );

    List<int> vals = lst.map((numStr) => int.tryParse(numStr) ?? 999).toList();
    vals = encoder.decode(vals);

    for (int index = 0; index < lst.length; index++) {
      lst[index] = cipher.char(vals[index]);
    }

    stdout.writeln("Your decoded expression:");
    stdout.writeln();
    stdout.writeln(lst.join(""));
  }
  stdin.readLineSync();
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
    switch (index % 13) {
      case 0:
        return val + 7;
      case 1:
        return val + 9;
      case 2:
        return val + 8;
      case 3:
        return val + 4;
      case 4:
        return val + 5;
      case 5:
        return val + 11;
      case 6:
        return val + 2;
      case 7:
        return val + 2;
      case 8:
        return val + 1;
      case 9:
        return val + 6;
      case 10:
        return val + 3;
      case 11:
        return val + 10;
      case 12:
        return val + 12;
      default:
        return 999;
    }
  }

  int dec(int val, int index) {
    switch (index % 13) {
      case 0:
        return val - 7;
      case 1:
        return val - 9;
      case 2:
        return val - 8;
      case 3:
        return val - 4;
      case 4:
        return val - 5;
      case 5:
        return val - 11;
      case 6:
        return val - 2;
      case 7:
        return val - 2;
      case 8:
        return val - 1;
      case 9:
        return val - 6;
      case 10:
        return val - 3;
      case 11:
        return val - 10;
      case 12:
        return val - 12;
      default:
        return 999;
    }
  }
}

class Cipher {
  final Map<String, int> baseMap;
  final Map<int, String> reverseMap;

  Cipher()
    : this.baseMap = {
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
      },
      this.reverseMap = {} {
    for (var entry in baseMap.entries) {
      reverseMap[entry.value] = entry.key;
    }
  }

  int val(String char) => baseMap[char] ?? 999;

  String char(int val) => reverseMap[val] ?? "^";
}
