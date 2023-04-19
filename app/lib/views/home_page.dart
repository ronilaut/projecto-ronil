import 'dart:io';

import 'package:app/model/bps.dart';
import 'package:app/model/som.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:appwrite/appwrite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// ignore: camel_case_types, constant_identifier_names
enum EntradaSaida { Entrada, Saida }

class _HomePageState extends State<HomePage> {
  final TextEditingController _nomeController = TextEditingController();
  List<File> _listaImagens = List.empty(growable: true);
  List<String> _listaStringImagens = List.empty(growable: true);
  final _formKey = GlobalKey<FormState>();
  final List<String> _items = ['SOM', 'BPS'];
  late String _value;
  EntradaSaida? _entradaSaida = EntradaSaida.Entrada;

  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "bd.db");

    var bd = await openDatabase(localBancoDados, version: 1,
        onCreate: (db, dbVersaoRecente) {
      String bps =
          "CREATE TABLE bps (id INTEGER PRIMARY KEY AUTOINCREMENT, bps VARCHAR UNIQUE, images VARCHAR)";
      db.execute(bps);
      String som =
          "CREATE TABLE soms (id INTEGER PRIMARY KEY AUTOINCREMENT, som VARCHAR UNIQUE, images VARCHAR)";
      db.execute(som);
    });
    return bd;
  }

  _salvarSom(Som som) async {
    Database bd = await _recuperarBancoDados();

    int id = await bd.insert(
      "soms",
      {
        'som': som.som,
        'images': som.images.join(','),
      },
    );
  }

  _salvarBps(Bps bps) async {
    Database bd = await _recuperarBancoDados();

    int id = await bd.insert(
      "bps",
      {
        'bps': bps.bps,
        'images': bps.images.join(','),
      },
    );
  }

  _listarBps() async {
    Database db = await _recuperarBancoDados();
    String sql = "SELECT * FROM bps";
    List bpss = await db.rawQuery(sql);
    for (var bps in bpss) {
      print("${bps['id']} \n + ${bps['bps']}");
    }
  }

  _selecionarImagemCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _listaImagens.add(File(image.path));
        _listaStringImagens.add(image.path);
      });
    }
  }

  _selecionarImagem() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();

    if (images.isNotEmpty) {
      setState(() {
        for (var i = 0; i < images.length; i++) {
          _listaImagens.add(File(images[i].path));
          _listaStringImagens.add(images[i].path);
        }
      });
    }
  }

  _limparCampos() {
    setState(() {
      // Reset form validation state
      _formKey.currentState!.reset();
      _entradaSaida = EntradaSaida.Entrada;
      _nomeController.text = "";
      _listaStringImagens = List.empty(growable: true);
      _listaImagens = List.empty(growable: true);
    });
  }

  /*Client client = Client();
client
    .setEndpoint('http://localhost:4466/v1')
    .setProject('643caee32fc7808949fa')
    .setSelfSigned(status: true); */

  @override
  void initState() {
    super.initState();
    _value = _items.first;
  }

  @override
  Widget build(BuildContext context) {
    _recuperarBancoDados();
    print("Lista ${_listaImagens.length}");
    _listarBps();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ronil AppMe"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            //*LogoTipo
            const Center(
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                height: 100,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //!FormField das imagens
                    FormField<List>(
                      initialValue: _listaImagens,
                      validator: (imagens) {
                        if (imagens == null || imagens.isEmpty) {
                          return "Necessário selecionar uma imagem!";
                        }
                        return null;
                      },
                      builder: (state) {
                        return Column(
                          children: [
                            Container(
                              height: 100,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _listaImagens.length + 1,
                                  itemBuilder: (context, indice) {
                                    if (indice == _listaImagens.length) {
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                _selecionarImagemCamera();
                                                //_selecionarImagem();
                                                //requestPermission();
                                                //getImage();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[400],
                                                radius: 50,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.add_a_photo,
                                                      size: 40,
                                                      color: Colors.grey[100],
                                                    ),
                                                    Text(
                                                      "CAMERA",
                                                      style: TextStyle(
                                                        color: Colors.grey[100],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                _selecionarImagem();
                                                //requestPermission();
                                                //getImage();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.grey[400],
                                                radius: 50,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.add_a_photo,
                                                      size: 40,
                                                      color: Colors.grey[100],
                                                    ),
                                                    Text(
                                                      "GALERIA",
                                                      style: TextStyle(
                                                        color: Colors.grey[100],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                    if (_listaImagens.isNotEmpty) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: ((context) => Dialog(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Image.file(
                                                            _listaImagens[
                                                                indice],
                                                          ),
                                                          TextButton(
                                                            child: const Text(
                                                              "Excluir",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            onPressed: () {
                                                              setState(
                                                                () {
                                                                  _listaImagens
                                                                      .removeAt(
                                                                          indice);
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              );
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )));
                                          },
                                          child: CircleAvatar(
                                            backgroundImage: FileImage(
                                                _listaImagens[indice]),
                                            radius: 50,
                                            child: Container(
                                              color: const Color.fromRGBO(
                                                  255, 255, 255, 0.4),
                                              alignment: Alignment.center,
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            ),
                            if (state.hasError)
                              Text(
                                "[${state.errorText}]",
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 14),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        color: const Color.fromARGB(31, 143, 143, 143),
                        child: Row(
                          children: [
                            _buildDropDownButton(),
                            CustomTextField(nomeController: _nomeController),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              tileColor:
                                  const Color.fromARGB(255, 127, 172, 250),
                              activeColor: Colors.white,
                              title: Text(
                                EntradaSaida.Entrada.name,
                                style: const TextStyle(color: Colors.white),
                              ),
                              value: EntradaSaida.Entrada,
                              groupValue: _entradaSaida,
                              onChanged: (EntradaSaida? value) {
                                setState(() {
                                  _entradaSaida = value;
                                });
                              }),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: RadioListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                activeColor: Colors.white,
                                tileColor:
                                    const Color.fromARGB(255, 127, 172, 250),
                                title: Text(
                                  EntradaSaida.Saida.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                value: EntradaSaida.Saida,
                                groupValue: _entradaSaida,
                                onChanged: (EntradaSaida? value) {
                                  setState(() {
                                    _entradaSaida = value;
                                  });
                                })),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState != null) {
                          if (_formKey.currentState!.validate()) {
                            if (_value == 'SOM') {
                              Som som = Som(
                                  som: "$_value-${_nomeController.text}",
                                  images: _listaStringImagens,
                                  entrada: _entradaSaida!.name);
                              _salvarSom(som);
                              _limparCampos();
                              final snackBar = SnackBar(
                                content: const Text('BPS criado com Sucesso!'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                            } else {
                              Bps bps = Bps(
                                  bps: "$_value-${_nomeController.text}",
                                  images: _listaStringImagens,
                                  entrada: _entradaSaida!.name);
                              _salvarBps(bps);
                              _limparCampos();
                              final snackBar = SnackBar(
                                content: const Text('BPS criado com Sucesso!'),
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Some code to undo the change.
                                  },
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropDownButton() {
    return Container(
      color: const Color.fromARGB(255, 22, 180, 253),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconEnabledColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
            dropdownColor: const Color.fromARGB(255, 22, 180, 253),
            value: _value,
            items: ['SOM', 'BPS']
                .map((String value) => DropdownMenuItem(
                      value: value,
                      child: Row(
                        children: <Widget>[
                          Text(value),
                        ],
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _value = value!;
              });

              //currencyCategory = value!;
            },
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController nomeController,
  }) : _nomeController = nomeController;

  final TextEditingController _nomeController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        controller: _nomeController,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelStyle: TextStyle(),
          labelText: "  Digite apenas o número, exemplo: <1234>",
          fillColor: Colors.white,
          border: InputBorder.none,
        ),
        validator: (valor) {
          if (valor == null || valor.isEmpty) {
            return "O Campo é Obrigatório";
          }
          return null;
        },
      ),
    );
  }
}
