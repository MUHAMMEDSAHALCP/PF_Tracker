import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget buildPage(
        {required image, required title, required subtiltle, height}) =>
    Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Image(
            height: height,
            image: AssetImage(image),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AutoSizeText(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "CrimsonText"),
              ),
            ),
            subtitle: AutoSizeText(
              subtiltle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cinzel"),
            ),
          ),
        ],
      ),
    );
