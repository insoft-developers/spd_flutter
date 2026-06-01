class Quiz {
  final int id;
  final int no_kuis;
  final String soal_kuis;
  final String jawaban_a;
  final String jawaban_b;
  final String jawaban_c;
  final String jawaban_d;
  final String jawaban_e;
  final String kunci_jawaban;
  final int id_kelas;
  final int tipe_soal;

  Quiz(
      {required this.id,
      required this.no_kuis,
      required this.soal_kuis,
      required this.jawaban_a,
      required this.jawaban_b,
      required this.jawaban_c,
      required this.jawaban_d,
      required this.jawaban_e,
      required this.kunci_jawaban,
      required this.id_kelas,
      required this.tipe_soal});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
        id: json['id'] as int,
        no_kuis: json['no_kuis'] as int,
        soal_kuis: json['soal_kuis'] as String,
        jawaban_a: json['jawaban_a'] as String,
        jawaban_b: json['jawaban_b'] as String,
        jawaban_c: json['jawaban_c'] as String,
        jawaban_d: json['jawaban_d'] as String,
        jawaban_e: json['jawaban_e'] as String,
        kunci_jawaban: json['kunci_jawabaan'] as String,
        id_kelas: json['id_kelas'] as int,
        tipe_soal: json['tipe_soal'] as int);
  }

  @override
  String toString() {
    return 'Quiz{id: $id, no_kuis: $no_kuis, soal_kuis: $soal_kuis, jawaban_a: $jawaban_a, jawaban_b: $jawaban_b, jawaban_c: $jawaban_c, jawaban_d: $jawaban_d, jawaban_e: $jawaban_e}';
  }
}
