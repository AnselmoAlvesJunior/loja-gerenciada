import 'dart:async';

class LoginValidators{

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains("@")){
        sink.add(email);
      } else{
        sink.addError("Insira um e-mail válido");
      }
    }
  );

  final validadePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password,sink){
      if(password.length > 6){
        sink.add(password);
      } else{
        sink.addError("Insira uma senha válida");
      }
    }
  );
}