import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/controller/user_provider.dart';
import 'package:social_media/models/usersmodel.dart';
import 'package:social_media/services/user_services.dart';
import 'package:social_media/view/user_details.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 30,
          titleTextStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          title: const Text('Explore Users'),
        ),
        body: FutureBuilder(
            future: fetchAllUserData(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              } else {
                return provider.users.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: provider.users.length,
                        itemBuilder: (context, index) {
                          final UsersModel data = provider.users[index];
                          final bool isFollowing =
                              provider.isFollowingUser(data.id!);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: SizedBox(
                              height: 80,
                              child: Card(
                                color: Colors.white70,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => UserDetails(
                                          name: data.username.toString(),
                                          email: data.email.toString(),
                                          followers:
                                              data.followers!.length.toString(),
                                          following:
                                              data.following!.length.toString(),
                                        ),
                                      ));
                                    },
                                    leading: const CircleAvatar(
                                      radius: 40,
                                    ),
                                    trailing: ElevatedButton(
                                        style: ButtonStyle(
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(10))),
                                            padding:
                                                const WidgetStatePropertyAll(
                                                    EdgeInsets.symmetric(
                                                        horizontal: 10)),
                                            foregroundColor:
                                                WidgetStatePropertyAll(
                                                    isFollowing
                                                        ? Colors.black
                                                        : Colors.white),
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    isFollowing
                                                        ? Colors.white
                                                        : Colors.blue)),
                                        onPressed: () {
                                          if (isFollowing) {
                                            UserService().unFollowUser(
                                                context, data.id!);
                                            provider.removeFollowing(data.id!);
                                          } else {
                                            UserService()
                                                .followUser(context, data.id!);
                                            provider.addFollowing(data.id!);
                                          }
                                        },
                                        child: Text(
                                            isFollowing ? 'Unfollow' : 'Follow')),
                                    title: Text(
                                      data.username!.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              }
            }));
  }

  Future<void> fetchAllUserData(BuildContext context) async {
    final provider = Provider.of<UserProvider>(context, listen: false);
    await provider.fetchUsers(context);
  }
}
