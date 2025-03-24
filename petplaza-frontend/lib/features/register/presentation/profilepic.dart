import 'package:flutter/material.dart';

class Profilepic extends StatefulWidget {
  const Profilepic({super.key});

  @override
  State<Profilepic> createState() => _ProfilepicState();
}

class _ProfilepicState extends State<Profilepic> {
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: SizedBox.shrink(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 40),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width/4,
                    child: Icon(Icons.person,size: MediaQuery.of(context).size.width/5,),
                  ),
                  Positioned(
                    bottom: 10,right: 10,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.add)))
                ],
              ),
              SizedBox(height: 20,),

              Text("Please Upload profile picture to continue! ",style: theme.textTheme.bodyMedium,),
              SizedBox(height: 100,),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(onPressed: (){}, child: Text("Upload",))),
                SizedBox(height: 30,),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: OutlinedButton(onPressed: (){}, child: Text("Take Photo"))),
            ],
          ),
        ),
      ),
    );
  }
}