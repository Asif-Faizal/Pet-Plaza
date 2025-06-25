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
          // 
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.history,color: Colors.white,), label: Text("Order History",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),))
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      height: 50,
                      width: double.infinity,
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
                          label: Text("Logout"))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
