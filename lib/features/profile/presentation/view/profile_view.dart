import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/core/shared_prefs/user_shared_prefs.dart';
import 'package:flaviourfleet/features/buy/presentation/viewmodel/booking_viewmodel.dart';
import 'package:flaviourfleet/features/profile/presentation/view/edit_profile_view.dart';
import 'package:flaviourfleet/features/profile/presentation/viewmodel/product_viewmodel.dart';
import 'package:flaviourfleet/features/profile/presentation/viewmodel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ConsumerState<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).fetchProfile();
      ref.read(productViewModelProvider.notifier).getPosts();
      ref.read(bookingViewModelProvider.notifier).getBookedProducts();
    });
  }

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final userSharedPrefs = ref.read(userSharedPrefsProvider);
      final result = await userSharedPrefs.deleteUserToken();
      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logout failed: ${failure.error}')),
          );
        },
        (success) {
          Navigator.of(context).pushReplacementNamed('/login');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);
    final productState = ref.watch(productViewModelProvider);
    final bookingState = ref.watch(bookingViewModelProvider);

    if (profileState.isLoading ||
        productState.isLoading ||
        bookingState.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (profileState.error != null) {
      return Center(child: Text('Error: ${profileState.error}'));
    }

    if (productState.error != null) {
      return Center(child: Text('Error: ${productState.error}'));
    }

    if (bookingState.error != null) {
      return Center(child: Text('Error: ${bookingState.error}'));
    }

    final profile = profileState.profile;
    final products = productState.lstPosts;
    final bookings = bookingState.bookings;

    if (profile == null) {
      return const Center(child: Text('No profile data'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: profile.profileImage != null
                                    ? NetworkImage(
                                        '${ApiEndpoints.profileImageUrl}${profile.profileImage}')
                                    : null,
                                radius: 50,
                                child: profile.profileImage == null
                                    ? const Icon(Icons.person, size: 50)
                                    : null,
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfilePage(),
                                    ),
                                  ).then((_) {
                                    ref
                                        .read(profileViewModelProvider.notifier)
                                        .fetchProfile();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.orange, // Button color
                                ),
                                child: const Text('Personal Info'),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profile.fullName,
                                  style: const TextStyle(fontSize: 24)),
                              const SizedBox(height: 8),
                              Text(profile.email,
                                  style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 32),
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(icon: Icon(Icons.post_add), text: 'Posted'),
                        Tab(icon: Icon(Icons.book), text: 'Bought'),
                      ],
                    ),
                    SizedBox(
                      height: 400,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          products.isEmpty
                              ? const Center(child: Text('No posts available'))
                              : ListView.builder(
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    final post = products[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Colors.orange[
                                            50], // Card background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                '${ApiEndpoints.imageUrl}${post.productImage}',
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      post.productTitle,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .black), // Text color
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      post.productDescription,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Rs ${post.productPrice}',
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () async {
                                                      final confirmed =
                                                          await showDialog<
                                                              bool>(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Confirm Delete'),
                                                            content: const Text(
                                                                'Are you sure you want to delete this post?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true);
                                                                },
                                                                child: const Text(
                                                                    'Delete'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );

                                                      if (confirmed == true) {
                                                        await ref
                                                            .read(
                                                                productViewModelProvider
                                                                    .notifier)
                                                            .deletePost(post);
                                                      }
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          bookings.isEmpty
                              ? const Center(
                                  child: Text('No booked products available'))
                              : ListView.builder(
                                  itemCount: bookings.length,
                                  itemBuilder: (context, index) {
                                    final booking = bookings[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        color: Colors.orange[
                                            50], // Card background color
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        elevation: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Image.network(
                                                '${ApiEndpoints.imageUrl}${booking.productId.productImage}', // Directly access product image
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      booking.productId
                                                              .productTitle ??
                                                          'No title', // Directly access product title
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .black), // Text color
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Quantity: ${booking.quantity}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      'Rs ${booking.productId.productPrice}', // Directly access product price
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.orange),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ],
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
