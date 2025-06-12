import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  const AddPetPage({super.key});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController petTypeController = TextEditingController();
  final TextEditingController petAgeController = TextEditingController();
  final TextEditingController petWeightController = TextEditingController();
  final TextEditingController petBreedController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerContactController = TextEditingController();
  final TextEditingController ownerAddressController = TextEditingController();

  String selectedCode = '+91';
  final List<String> countryCodes = ['+91', '+86', '+351', '+971', '+92'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        automaticallyImplyLeading: false,
        leading: SizedBox.shrink(),
        title: Text(
          "Add Pet",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pet Details Section_buildSectionTitle("Owner Details"),
            _buildSectionTitle("Pet Details"),
            const SizedBox(height: 20),
            TextField(
              controller: petNameController,
              decoration: InputDecoration(
                labelText: "Pet Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: petTypeController,
                    decoration: InputDecoration(
                      labelText: "Pet Type",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: petBreedController,
                    decoration: InputDecoration(
                      labelText: "Pet Breed",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: petAgeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Pet Age",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: petWeightController,
                    decoration: InputDecoration(
                      labelText: "Pet Weight",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),
            
            // Owner Details Section
            _buildSectionTitle("Owner Details"),
            const SizedBox(height: 20),
            TextField(
              controller: ownerNameController,
              decoration: InputDecoration(
                labelText: "Owner Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ownerContactController,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration: InputDecoration(
                counterText: '',
                labelText: "Contact Number",
                border: OutlineInputBorder(),
                prefixIcon: PopupMenuButton<String>(
                  onSelected: (value) {
                    setState(() {
                      selectedCode = value;
                    });
                  },
                  itemBuilder: (context) => countryCodes
                      .map((code) => PopupMenuItem(
                            value: code,
                            child: Text(code, style: TextStyle(fontSize: 18)),
                          ))
                      .toList(),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      selectedCode,
                      style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ownerAddressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}
