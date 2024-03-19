enum Keys { C, cHash, D, dHash, E, F, fHash, G, gHash, A, aHash, B }

extension Name on Keys {
  String get name {
    switch (this) {
      case Keys.cHash:
        return 'C#';
      case Keys.dHash:
        return 'D#';
      case Keys.fHash:
        return "F#";
      case Keys.gHash:
        return "G#";
      case Keys.aHash:
        return "A#";
      default:
        return toString();
    }
  }
}
