class ErrorModel {
  String id;
  String title;
  String? msg;

  ErrorModel({required this.id, required this.title, this.msg});
}

class ErrorType {
  static ErrorModel get noConnection => ErrorModel(
      id: "noConnection",
      title: "Tidak ada Koneksi",
      msg: "Sebelum coba lagi, mohon pastikan WIFI / Mobile data anda aktif");

  static ErrorModel get requestTimeOut => ErrorModel(
      id: "requestTimeOut",
      title: "Waktu permintaan habis",
      msg: "Terjadi gangguan pada jaringan, silahkan coba lagi");

  static ErrorModel get notFound => ErrorModel(
      id: "notFound",
      title: "Tidak ditemukan",
      msg: "Data yang kamu cari tidak ditemukan");

  static ErrorModel get somethingWrong =>
      ErrorModel(id: "somethingWrong", title: "Terjadi Gangguan");
}
