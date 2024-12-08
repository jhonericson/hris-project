import 'package:equatable/equatable.dart';
import 'package:healty_apps/constant/asset_const.dart';

List<HomeMenu> homeMenus = [
  const HomeMenu(
      link:
          "https://www.detik.com/bali/berita/d-6387535/10-manfaat-bersepeda-bagi-kesehatan-apa-saja-gowes-yuk",
      descId: 1,
      profitId: 2,
      image: kImgHomeMenu1,
      title: "Bersepeda",
      desc:
          "Bersepeda : Bersepeda adalah sebuah kegiatan rekreasi atau olahraga, serta merupakan salah satu moda transportasi darat yang menggunakan sepeda. Sepeda pertama kali diperkenalkan pada abad ke-19 Masehi. Banyak penggemar bersepeda yang melakukan kegiatan tersebut di berbagai macam medan, misalnya perbukitan, medan yang terjal maupun hanya sekadar dipedesaan dan perkotaan saja.",
      profit:
          "Keuntungan : Selain bermanfaat untuk meningkatkan kekuatan otot, bersepeda secara rutin juga bisa melatih keseimbangan dan koordinasi tubuh. Manfaat lain dari bersepeda yaitu dapat mengontrol berat badan agar tetap ideal. Bersepeda membantu membakar kalori serta meningkatkan metabolisme."),
  const HomeMenu(
      link:
          "https://health.detik.com/kebugaran/d-6500655/ternyata-ini-manfaat-jogging-sore-hari-bagi-kesehatan",
      descId: 1,
      profitId: 2,
      image: kImgHomeMenu2,
      title: "Jogging",
      desc:
          "Jogging : Jogging adalah suatu bentuk berlari dengan kecepatan lambat atau santai. Lari laun bertujuan untuk meningkatkan kebugaran jasmani dengan lebih sedikit tekanan pada tubuh atau mempertahankan kecepatan yang tetap untuk jangka waktu yang lebih lama. Lari laun lebih lambat daripada berlari, tetapi lebih cepat daripada berjalan. Ini adalah suatu bentuk latihan ketahanan aerobik yang dilakukan dalam jarak jauh.",
      profit:
          "Keuntungan : Jogging secara teratur akan membuat tubuh memiliki respons yang lebih baik terhadap penyakit dan gangguan kesehatan. Aktivitas ini juga merangsang produksi sel darah putih yang membantu melawan infeksi bakteri dan virus. Intinya, joging secara konsisten akan membuat tubuh Anda tetap bugar dan tidak mudah sakit"),
  const HomeMenu(
      link:
          "https://health.detik.com/kebugaran/d-6745243/10-manfaat-berenang-bagi-tubuh-bikin-cerdas-sampai-tulang-kuat",
      descId: 1,
      profitId: 2,
      image: kImgHomeMenu3,
      title: "Berenang",
      desc:
          "Berenang : Berenang adalah gerakan sewaktu bergerak di air. Berenang biasanya dilakukan tanpa perlengkapan buatan. Kegiatan ini dapat dimanfaatkan untuk rekreasi dan olahraga. Berenang dipakai sewaktu bergerak dari satu tempat ke tempat lainnya di air, mencari ikan, mandi, atau melakukan olahraga air. Berenang sangat berguna sebagai alat pendidikan, sebagai rekreasi yang sehat, menanamkan keberanian, percaya diri, dan sebagai terapi yang terkadang dianjurkan oleh dokter, serta untuk keselamatan diri atau orang lain. Berenang untuk keperluan rekreasi dan kompetisi dilakukan di kolam renang. Manusia juga berenang di sungai, danau, dan laut sebagai bentuk rekreasi. Olahraga renang membuat tubuh sehat karena hampir semua otot tubuh dipakai sewaktu berenang",
      profit:
          "Keuntungan : Selain meningkatkan metabolisme, renang diketahui dapat membantu memperbaiki masalah postur tubuh sekaligus melatih ketahanan otot. Namun, tidak hanya sampai disitu, manfaat berenang adalah hal yang tak boleh terlewatkan, karena bukan hanya untuk kesehatan tubuh saja, tetapi juga mental."),
];

class HomeMenu extends Equatable {
  final int descId;
  final int profitId;
  final String image;
  final String title;
  final String desc;
  final String profit;
  final String link;

  const HomeMenu({
    required this.descId,
    required this.profitId,
    required this.image,
    required this.title,
    required this.desc,
    required this.profit,
    required this.link,
  });

  @override
  List<Object?> get props => [
        image,
        title,
        desc,
      ];
}

List<NewsMenu> newsMenus = [
  const NewsMenu(
    image: kImgNew1,
    title: "Studi Menunjukkan Manfaat Olahraga Rutin",
    desc:
        "Sebuah studi terbaru yang diterbitkan dalam Jurnal Ilmu Kesehatan menunjukkan bahwa olahraga rutin dapat secara signifikan mengurangi risiko penyakit jantung dan meningkatkan kesehatan secara keseluruhan.",
    source: "Kesehatan Hari Ini",
    date: "2024-03-28",
  ),
  const NewsMenu(
    image: kImgNew2,
    title: "Vaksin Baru untuk Penyakit Flu Biasa",
    desc:
        "Para peneliti telah mengumumkan pengembangan vaksin baru yang menunjukkan harapan dalam mencegah flu biasa. Uji klinis telah menunjukkan hasil positif dengan efek samping minimal.",
    source: "Berita Kedokteran",
    date: "2024-03-27",
  ),
  const NewsMenu(
    image: kImgNew3,
    title: "Tips untuk Menjaga Pola Makan Sehat",
    desc:
        "Nutrisionis merekomendasikan untuk memasukkan lebih banyak buah, sayuran, dan biji-bijian utuh ke dalam pola makan Anda untuk menjaga kesehatan secara keseluruhan. Menghindari makanan olahan dan minuman manis juga dapat membantu mencegah penyakit kronis.",
    source: "Majalah Hidup Sehat",
    date: "2024-03-26",
  ),
  const NewsMenu(
    image: kImgNew4,
    title: "Manfaat Buah Pisang",
    desc:
        "Manaker menjelaskan bahwa setiap orang boleh mengonsumsi pisang setiap hari. Bahkan, bisa menjadi kebiasaan yang baik dilakukan. Namun, ada sebagian orang yang tak bisa bebas mengonsumsi pisang. Terutama mereka yang sedang mengikuti diet rendah kalium atau yang memiliki peningkatan gula darah setelah mengonsumsinya",
    source: "Majalah Hidup Sehat",
    date: "2024-03-26",
  ),
  const NewsMenu(
    image: kImgNew5,
    title: "Tips Yoga dirumah",
    desc:
        "Perserikatan Bangsa-Bangsa (PBB) menetapkan setiap tanggal 21 Juni sebagai Hari Yoga Internasional. Pada tahun ini, di tengah pandemi Covid-19, PBB mengambil tema Yoga for Health - Yoga at Home, yang berarti Yoga untuk Kesehatan - Yoga di Rumah. Langkah-langkah untuk memulai yoga di rumah pun dapat dilakukan dengan mudah.",
    source: "Majalah Hidup Sehat",
    date: "2024-03-26",
  ),
];

class NewsMenu extends Equatable {
  final String image;
  final String title;
  final String desc;
  final String source;
  final String date;

  const NewsMenu({
    required this.image,
    required this.title,
    required this.desc,
    required this.source,
    required this.date,
  });

  @override
  List<Object?> get props => [
        image,
        title,
        desc,
        source,
        date,
      ];
}

List<FoodMenu> foodMenus = [
  FoodMenu(
    favorite: false,
    image: kImgFood1,
    name: "Telur Rebus",
    desc:
        "Mendukung Diet Penurunan Berat Badan: Telur rendah kalori tetapi tinggi protein dan nutrisi, sehingga dapat menjadi bagian penting dari diet penurunan berat badan. Konsumsi telur rebus sebagai bagian dari sarapan atau camilan sehat dapat membantu Anda merasa kenyang lebih lama dan mengurangi keinginan untuk ngemil makanan yang tidak sehat.",
  ),
  FoodMenu(
    favorite: true,
    image: kImgFood2,
    name: "Roti Gandum",
    desc:
        "Membantu Menjaga Berat Badan yang Sehat: Roti gandum memiliki indeks glikemik yang lebih rendah daripada roti putih, yang berarti tidak menyebabkan lonjakan gula darah yang tajam setelah dikonsumsi. Ini membantu menjaga tingkat gula darah stabil dan mengurangi keinginan untuk makan makanan tidak sehat.",
  ),
  FoodMenu(
    favorite: true,
    image: kImgFood3,
    name: "Sayuran Hijau",
    desc:
        "Meningkatkan Kesehatan Jantung: Konsumsi sayuran hijau terkait dengan penurunan risiko penyakit jantung. Kandungan serat, kalium, dan antioksidan dalam sayuran hijau dapat membantu menurunkan tekanan darah, kolesterol LDL (kolesterol jahat), dan peradangan, yang semua merupakan faktor risiko penyakit jantung.",
  ),
  FoodMenu(
    favorite: true,
    image: kImgFood4,
    name: "Dada Ayam",
    desc:
        "Meskipun dada ayam memiliki banyak manfaat kesehatan, penting untuk memasukkan dada ayam sebagai bagian dari pola makan yang seimbang dan beragam. Hindari mengonsumsi dada ayam yang digoreng atau dipanggang dengan kulit yang banyak berlemak, dan pastikan untuk memasak dada ayam dengan cara yang sehat, seperti dipanggang atau direbus, untuk mendapatkan manfaat kesehatan yang optimal.",
  ),
  FoodMenu(
    favorite: true,
    image: kImgFood5,
    name: "Ubi Jalar",
    desc:
        "Mengonsumsi ubi jalar secara teratur sebagai bagian dari pola makan yang seimbang dan beragam dapat memberikan banyak manfaat kesehatan. Ubi jalar dapat dimasak dengan berbagai cara, termasuk direbus, dipanggang, direbus, atau diolah menjadi berbagai hidangan dan makanan penutup yang lezat.",
  ),
  FoodMenu(
    favorite: false,
    image: kImgFood6,
    name: "Daging",
    desc:
        "Meskipun daging memiliki manfaat kesehatan, penting untuk mengonsumsinya dengan bijak sebagai bagian dari pola makan yang seimbang dan beragam. Pilih potongan daging yang rendah lemak dan hindari mengonsumsi daging yang diproses secara berlebihan atau digoreng dalam minyak yang banyak berlemak. Kombinasikan dengan sayuran, buah-buahan, dan sumber karbohidrat yang sehat untuk mendapatkan nutrisi yang optimal.",
  ),
];

// ignore: must_be_immutable
class FoodMenu extends Equatable {
  final String image;
  final String name;
  final String desc;
  bool favorite;

  FoodMenu({
    required this.image,
    required this.name,
    required this.desc,
    required this.favorite,
  });

  @override
  List<Object?> get props => [
        image,
        name,
        desc,
        favorite,
      ];
}
