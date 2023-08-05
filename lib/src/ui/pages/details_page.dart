import 'package:flutter/material.dart';

import 'package:ricks_and_mortys_app/src/model/character_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, this.character});

  final Character? character;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.search),
        onPressed: () {
          Navigator.pushNamed(context, 'searchCharacters');
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: size.width,
                child: Stack(
                  children: [
                    Hero(
                      tag: character!.id!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            character!.image!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      splashRadius: 10,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey[100],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        character!.name!,
                        style: TextStyle(fontSize: size.height * 0.03),
                      ),
                    ),
                    infoItem('Especie', character!.species!, size),
                    infoItem('Genero', character!.gender!, size),
                    infoItem('Origen', character!.origin!.name!, size),
                    infoItem('Localización', character!.location!.name!, size),
                    infoItem('Estatus', character!.status!, size),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  infoItem(String title, String data, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: size.height * 0.02),
          ),
          Text(
            data,
            style: TextStyle(
                fontSize: size.height * 0.02, color: checkAlive(data)),
          ),
        ],
      ),
    );
  }

  Color checkAlive(String text) {
    if (text == 'Alive') {
      return Colors.green;
    } else if (text == 'Dead') {
      return Colors.red;
    }
    return Colors.black;
  }
}
