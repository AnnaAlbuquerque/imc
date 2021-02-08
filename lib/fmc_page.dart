import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FMC extends StatefulWidget {
  FMC({Key key}) : super(key: key);

  @override
  _FMCState createState() => _FMCState();
}

class _FMCState extends State<FMC> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mensagem = "";

  void _calcular(){
    double altura = double.parse(alturaController.text);
    double peso = double.parse(pesoController.text);
    double imc = peso/ (altura * altura);

    setState(() {
      if (imc < 18.6)
        mensagem = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 18.6 && imc < 24.9)
        mensagem = "Peso ideal (${imc.toStringAsPrecision(4)})";
      else if (imc >= 24.9 && imc < 29.9)
        mensagem = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      else if (imc >= 29.9 && imc < 34.9)
        mensagem = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      else if (imc >= 34.9 && imc < 39.9)
        mensagem = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      else if (imc >= 40)
        mensagem = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
    });
  }

  void _refresh(){
    _formKey.currentState.reset();
    alturaController.clear();
    pesoController.clear();
    setState(() {
      mensagem = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calculadora de IMC'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,15,0),
            child: IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _refresh,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.red,
                ),

                TextFormField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  validator: (altura){
                    if (altura.isEmpty || double.parse(altura) ==0) return "Valor da altura necessário";
                  },
                  style: TextStyle(
                    color:Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Altura (m)',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fillColor: Colors.red,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 10
                ),

                TextFormField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  validator: (peso){
                    if (peso.isEmpty || double.parse(peso) == 0) return "Valor do peso necessário";
                  },
                  style: TextStyle(
                    color:Colors.white,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    fillColor: Colors.red,
                    filled: true,
                  ),
                ),
                SizedBox(
                  height: 30
                ),

                ElevatedButton(
                  onPressed: (){
                    if  (_formKey.currentState.validate())  _calcular();  
                  },
                  child: Text('Calcular'),
                ),
                SizedBox(
                  height: 30
                ),

                Text(
                  "$mensagem",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
