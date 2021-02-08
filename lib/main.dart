import 'package:flutter/material.dart';

import 'package:IMC/fmc_page.dart';

void main() {
  runApp(MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FMC(),
    )
  );
}

