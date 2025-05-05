import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.name, required this.profilePic});
  final String name;
  final String profilePic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
          SliverAppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            pinned: true,
            expandedHeight: 180,
            backgroundColor: Colors.deepPurpleAccent,
            centerTitle: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                bool isCollapsed = constraints.maxHeight <=
                    kToolbarHeight + MediaQuery.of(context).padding.top;

                return FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    name,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  
                  background: Container(
                    color: Colors.deepPurpleAccent,
                    child: Center(
                      child: isCollapsed
                          ? const SizedBox.shrink()
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(profilePic),
                              
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello, $name!", // Replace with dynamic customer name if needed
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Join Pet Plaza Premium",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Subscribe to unlock the rest of your weeks and reach your full potential.",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.deepPurple,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle Subscribe action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("SUBSCRIBE"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            // Handle Restore action
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.deepPurple, // Text color
                            side: const BorderSide(
                                color: Colors.deepPurple), // Border color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("RESTORE"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Static List
          SliverList(
            delegate: SliverChildListDelegate(
              [
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.notifications,color: Colors.white,),
                  title: Text(
                    'Notifications',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.lock,color: Colors.white,),
                  title: Text(
                    'Privacy',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.pets,color: Colors.white,),
                  title: Text(
                    'My Adoptions',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.favorite,color: Colors.white,),
                  title: Text(
                    'My Donations',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.payments,color: Colors.white,),
                  title: Text(
                    'Payments',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.laptop,color: Colors.white,),
                  title: Text(
                    'Remove Ads',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.brush,color: Colors.white,),
                  title: Text(
                    'Theme',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.help,color: Colors.white,),
                  title: Text(
                    'Help & Support',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {},
                ),SizedBox(height: 20,),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: ElevatedButton.icon(onPressed: (){},
                    icon: Icon(Icons.logout,
                    color: Colors.white,), label: Text("Logout")),
                  )),
                SizedBox(height: 30,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
