import 'package:flutter/material.dart';

import '../../register/presentation/createacc.dart';


class IndividualOrCentreScreen extends StatelessWidget {
  const IndividualOrCentreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Createacc(isIndividual: true)));
              },
              child: Text('Individual'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Createacc(isIndividual: false)));
              },
              child: Text('Centre'),
            ),
          ),
        ],
      ),
    );
  }
}
