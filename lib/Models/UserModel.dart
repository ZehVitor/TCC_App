import 'package:flutter/widgets.dart';
import 'package:tcc_app/DAOs/ClientDAO.dart';
import 'package:tcc_app/DAOs/FuncionarioDAO.dart';
import 'package:tcc_app/DAOs/ProductDAO.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  bool isLoading = false;
  FuncionarioDAO loggedUser;
  PageController pageController;
  ClientDAO pacienteAtual;
  List<ClientDAO> pacientes = List<ClientDAO>();
  List<ProductDAO> implantes = List<ProductDAO>();
  List<ProductDAO> proteses = List<ProductDAO>();

  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context);

  void initProducts(){
    ProductDAO protese = ProductDAO(1, 'Prótese Completa');
    ProductDAO implante = ProductDAO(1, 'Implante Dentário');
    protese.images.add('http://www.dentista-poa.com.br/assets/images/protese-dentaria/protese-dentaria2.jpg');
    protese.tipoProduto = 'Prótese';
    protese.dataFim = '15/15/2015';
    implante.images.add('http://oralunic.com.br/wp-content/uploads/2019/07/implantes-interna.png');
    implante.tipoProduto = 'Implante';
    implante.dataFim = '10/10/2010';

    proteses.add(protese);
    implantes.add(implante);
  }

  void initPacientes(){
    if (this.implantes.isEmpty)
      initProducts();
      
    ProductDAO protese = proteses[0];
    ProductDAO implante = implantes[0];

    ClientDAO maria = ClientDAO(1, 'Maria', '(84)99999-9999', "maria@teste.com");
    maria.cpf = '012.345.678-90';
    maria.endereco = 'Rua de Teste';
    maria.cidade = 'Natal';
    maria.profissao = 'Professor';
    maria.estadoCivil = 'Casado';
    maria.nascimento = '10/10/1910';
    maria.dataCadastro = '10/10/2010';

    maria.produtos.add(implante);
    maria.tipo = implante.tipoProtese[2];
    maria.conector = implante.conectores[1];
    maria.plataforma = implante.plataformas[1];
    maria.fabricante = implante.fabricantes[3];
    maria.regiao = implante.dentes[1];
    maria.torque = implante.torques[1];
    maria.enxerto = implante.enxerto[1];
    maria.oclusao = implante.oclusoes[1];
    maria.ancoragem = implante.ancoragens[2];
    maria.altura = '6';
    maria.historico += '${implante.tipoProduto}:\n';
    maria.historico += '-Plataforma: ${maria.plataforma};\n';
    maria.historico += '-Fabricante: ${maria.fabricante};\n';
    maria.historico += '-Realizado sobre enxerto: ${maria.enxerto};\n';
    maria.historico += '-Data da cirurgia: ${implante.dataFim};\n';
    maria.historico += '-Tipo do implante: ${maria.tipo};\n';
    maria.historico += '\n\n';
    
    ClientDAO jose   = ClientDAO(2, 'José', '(84)88888-8888', "jose@teste.com");
    jose.cpf = '098.765.432-10';
    jose.endereco = 'Rua Outra';
    jose.cidade = 'Natal';
    jose.profissao = 'Estudante';
    jose.estadoCivil = 'Solteiro';
    jose.nascimento = '10/10/2010';
    jose.dataCadastro = '10/10/2010';
    
    ProductDAO produto = ProductDAO(1, 'Não Cadastrado');
    produto.tipoProduto = '-';
    jose.produtos.add(produto);
    jose.produtos.add(protese);
    jose.tipo = protese.tipoProtese[1];
    jose.conector = protese.conectores[2];
    jose.plataforma = protese.plataformas[2];
    jose.fabricante = protese.fabricantes[4];
    jose.regiao = protese.dentes[2];
    jose.torque = protese.torques[1];
    jose.enxerto = protese.enxerto[0];
    jose.oclusao = protese.oclusoes[1];
    jose.ancoragem = protese.ancoragens[1];
    jose.altura = '4';
    jose.historico += '${protese.tipoProduto}:\n';
    jose.historico += '-Data da cirurgia: ${protese.dataFim};\n';
    jose.historico += '-Conector: ${jose.conector};\n';
    jose.historico += '-Tipo da prótese: ${jose.tipo};\n';
    jose.historico += '\n\n';

    this.pacientes.add(maria);
    this.pacientes.add(jose);
  }

  void signIn({@required Map<String, dynamic> user,@required VoidCallback onSuccess,@required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    // final response = await http.get(new Uri.http("10.122.7.235:8080", "/cliente/"+user["login"]));
    // if (response.statusCode == 200){
    if ((user["login"] == "admin" || user["login"] == "gilvani") && user["senha"] == "123"){
      onSuccess();
      loggedUser = FuncionarioDAO.fromJson(user);
      isLoading  = false;
      notifyListeners();
    } 
    else {
      onFail();
      isLoading = false;
      notifyListeners();
    }
  }

  void signOut(VoidCallback logOut){
    logOut();
    loggedUser = null;
  }

  void recoverPass(){

  }

  bool isLoggedIn(){
    return loggedUser != null;
  }
}
