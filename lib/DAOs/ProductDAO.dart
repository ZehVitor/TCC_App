

class ProductDAO {
  final int id;
  final String descricao;
  // Protese
  List<String> conectores = ['UCLA','Cilindro CM','Mini-Pilar','Pilar GT','Munhão Universal','Outros'];
  List<String> tipoProtese = ['Protocolo','Unitária','Conjugada','Outros'];
  List<String> parafuso = ['Hexagonal','Quadrado','Fenda','Outros'];
  List<String> oclusoes = ['Dente','Prótese','Implante','Outros'];
  String dataFim;

  //Implante
  List<String> plataformas = ['Gran Morse', 'Cone Morse', 'HE', 'HI','Outros'];
  List<String> tpPlataformas = ['3.5X9mm', '3.5X10mm', '3.75X9mm', '3.75X10mm', '4.3X9mm', '4.3X10mm','Outros'];
  List<String> fabricantes = ['NeoDente', 'Strauman', 'DentoFlex', 'SIN', 'Singular', 'FGM','Conexão','Outros'];
  List<String> dentes = ['18','17','16','15','14','13','12','11','21','22','23','24','25','26','27','28'];
  List<String> dentes2 = ['48','47','46','45','44','43','42','41','31','32','33','34','35','36','37','38'];
  List<String> torques = ['10n','20n','32n','45n','60n','80n','Outros'];
  List<String> ancoragens = ['Boa','Ótima','Deficiente','Outros'];
  List<String> enxerto = ['Autógeno','Sintético','Xenógeno','Outros'];
  List<String> caracteristicas = ['DriveCM','HelixGM','TitaMaxGM','HelixHE','TitaMaxTI EX','TitaMaxCM EX','Outros'];
  List<String> coberturas = ['Cicatrizador','COVER','Outros'];
  List<String> cargas = ['Implante Imediata','Carga Imediata','Outros'];
  List<String> superficie = ['Acqua','NeoPoros','Outros'];
  String tipoProduto; //Protese ou Implante
  double precoAtual = 0;
  List<String> images = new List<String>();

  ProductDAO(this.id, this.descricao);

  factory ProductDAO.fromJson(Map<String, dynamic> json) {
    return ProductDAO(
      json['id'],
      json['descricao'],
    );
  }
}
