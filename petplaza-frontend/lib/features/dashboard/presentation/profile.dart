import 'package:flutter/material.dart';
import 'package:petplaza/features/splash/presentation/initial_page.dart';

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
          SliverToBoxAdapter(
            child: SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>InitialPage()), (route) => false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            content: Text("Logged out successfully"),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      label: Text("Logout")),
                )),
          )
        ],
      ),
    );
  }
}
