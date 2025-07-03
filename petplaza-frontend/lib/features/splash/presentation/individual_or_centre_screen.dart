import 'package:flutter/material.dart';

import '../../register/presentation/createacc.dart';


class IndividualOrCentreScreen extends StatelessWidget {
  const IndividualOrCentreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric( vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   width: double.infinity,
            //   height: 60,
            //   child: ElevatedButton(
            //     onPressed: () {
            //         Navigator.push(context, MaterialPageRoute(builder: (context) => Createacc(isIndividual: true)));
            //     },
            //     child: Text('Individual'),
            //   ),
            // ),
            // SizedBox(
            //   width: double.infinity,
            //   height: 60,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => Createacc(isIndividual: false)));
            //     },
            //     child: Text('Centre'),
            //   ),
            // ),
            Image.asset(
              'lib/core/asset/animation/pets.png', // Replace with your image path
              height: 200, // Adjust the height as needed
              width: double.infinity, // Make it responsive
              fit: BoxFit.cover, // Cover the available space
            ),
            SizedBox(height: 60), // Add some space between the image and the text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'Are you an Individual or a Centre?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            
            SizedBox(height: 20), // Add some space between the text and the buttons
            SizedBox(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Createacc(isIndividual: true)));
                      },
                      child: SizedBox(
                        width: 150, // Set a fixed width for the card
                        height: 150, // Set a fixed height for the card
                        child: Card(
                          color: Colors.deepPurpleAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon( Icons.man, size: 40, color: Colors.white),
                                Text(
                                  'Individuals',
                                  textAlign: TextAlign.center,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Add space between the cards
                     InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Createacc(isIndividual: false)));
                      },
                       child: SizedBox(
                        width: 150, // Set a fixed width for the card
                        height: 150, // Set a fixed height for the card
                         child: Card(
                          color: Colors.deepPurpleAccent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon( Icons.group, size: 40, color: Colors.white),
                                Text(
                                  'Centre',
                                  textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                                           ),
                       ),
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
}
