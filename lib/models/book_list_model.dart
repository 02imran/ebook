
class BookListModel{

  int? bId;
  String? bName;
  String? bPdf;
  String ?bookImage;

  BookListModel(this.bId,{this.bName, this.bPdf,this.bookImage});

}

List<BookListModel> bookListCollection=[
  BookListModel(1,bName:'Communication skills for medical professionals',bPdf: 'assets/file/Communication skills for medical professionals-converted.pdf',bookImage: 'assets/logo.png'),
  BookListModel(2,bName:'How to be a good prescriber',bPdf: 'assets/file/How to be a good prescriber-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(3,bName:'Common side effects of drugs and how to manage those',bPdf: 'assets/file/Common side effects of drugs and how to manage those-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(4,bName:'Common drug interaction',bPdf: 'assets/file/Common drug interaction-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(5,bName:'Use of drugs during pregnancy',bPdf: 'assets/file/Use of drugs during pregnancy-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(6,bName:'Use of drugs during lactation',bPdf: 'assets/file/Use of drugs during lactation-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(7,bName:'Pain management in special situation',bPdf: 'assets/file/Pain management in special situation-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(8,bName:'IV fluids',bPdf: 'assets/file/IV fluids-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(9,bName:'Prescribing in the elderly',bPdf: 'assets/file/Prescribing in the elderly-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(10,bName:'Approaches',bPdf: 'assets/file/Approaches-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(11,bName:'Respiratory system',bPdf: 'assets/file/Respiratory system-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(12,bName:'CVS diseases',bPdf: 'assets/file/CVS diseases-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(13,bName:'GI tract diseases',bPdf: 'assets/file/GI tract diseases-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(14,bName:'Hepatobilliary & pancreatic diseases',bPdf: 'assets/file/Hepatobilliary & pancreatic diseases-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(15,bName:'Endocrine',bPdf: 'assets/file/Endocrine-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(16,bName:'Haematology',bPdf: 'assets/file/Haematology-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(17,bName:'Musculoskeletal system',bPdf: 'assets/file/Musculoskeletal system-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(18,bName:'Renal system',bPdf: 'assets/file/Renal system-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(19,bName:'Infectious disease',bPdf: 'assets/file/Infectious disease-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(20,bName:'Neurology',bPdf: 'assets/file/Neurology-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(21,bName:'Electrolytes imbalance',bPdf: 'assets/file/Electrolytes imbalance-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(22,bName:'Poisoning',bPdf: 'assets/file/Poisoning-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(23,bName:'Gynecology',bPdf: 'assets/file/Gynecology-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(24,bName:'Obstetric',bPdf: 'assets/file/Obstetric-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(25,bName:'Pediatric medicine',bPdf: 'assets/file/Pediatric medicine-converted.pdf',bookImage: 'assets/images/bookimage.jpg'),
  BookListModel(26, bName:'Dermatology',bPdf: 'assets/file/Dermatology.pdf',bookImage: 'assets/images/bookimage.jpg')
];