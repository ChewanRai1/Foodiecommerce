import 'package:flaviourfleet/app/constants/api_endpoint.dart';
import 'package:flaviourfleet/features/cart/presentation/view/cart_view.dart';
import 'package:flaviourfleet/features/home/presentation/state/post_state.dart';
import 'package:flaviourfleet/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:flaviourfleet/features/search/presentation/state/search_state.dart';
import 'package:flaviourfleet/features/search/presentation/viewmodel/search_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = false;
  int currentPage = 1;
  bool hasMore = true;
  String selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500 && !isLoading && hasMore) {
      if (selectedCategory.isNotEmpty) {
        _loadMoreProductsByCategory();
      } else {
        _loadMorePosts();
      }
    }
  }

  Future<void> _refreshPosts() async {
    setState(() {
      currentPage = 1;
      hasMore = true;
      selectedCategory = ''; // Reset selected category
    });
    await ref.read(homeViewModelProvider.notifier).refreshPosts();
  }

  Future<void> _refreshProductsByCategory() async {
    setState(() {
      currentPage = 1;
      hasMore = true;
    });
    await ref
        .read(homeViewModelProvider.notifier)
        .refreshProductsByCategory(selectedCategory);
  }

  void _loadMorePosts() async {
    setState(() {
      isLoading = true;
    });
    int nextPage = currentPage + 1;
    final result =
        await ref.read(homeViewModelProvider.notifier).getPosts(page: nextPage);
    if (result) {
      setState(() {
        isLoading = false;
        currentPage = nextPage;
      });
    } else {
      setState(() {
        isLoading = false;
        hasMore = false;
      });
    }
  }

  void _loadMoreProductsByCategory() async {
    setState(() {
      isLoading = true;
    });
    int nextPage = currentPage + 1;
    final result = await ref
        .read(homeViewModelProvider.notifier)
        .getProductsByCategory(selectedCategory, page: nextPage);
    if (result) {
      setState(() {
        isLoading = false;
        currentPage = nextPage;
      });
    } else {
      setState(() {
        isLoading = false;
        hasMore = false;
      });
    }
  }

  void _searchProducts(String query) {
    ref.read(searchViewModelProvider.notifier).searchProducts(query, 1, 20);
  }

  void _clearSearch() {
    ref.read(searchViewModelProvider.notifier).clearSearch();
  }

  void _fetchProductsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      currentPage = 1;
      hasMore = true;
    });
    ref
        .read(homeViewModelProvider.notifier)
        .refreshProductsByCategory(category);
  }

  final List<String> images = [
    'assets/images/burger.png',
    'assets/images/pizza.png',
  ];
  int currentSlide = 1;

  @override
  Widget build(BuildContext context) {
    Size mediaSize = MediaQuery.of(context).size;
    final state = ref.watch(homeViewModelProvider);
    final searchState = ref.watch(searchViewModelProvider);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.orange[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _refreshPosts,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topBar(),
                    const SizedBox(height: 8),
                    _commonWidthContainer(
                      child: Column(
                        children: [
                          _searchBar(),
                          const SizedBox(height: 8),
                          _homeSlider(mediaSize),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _categoriesSection(),
                    const SizedBox(height: 10),
                    const Text(
                      'All Dishes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color from login page
                      ),
                    ),
                    const SizedBox(height: 10),
                    _recentPostsSection(mediaSize, state, searchState),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange, // Loading indicator color
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _commonWidthContainer({required Widget child}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          child: child,
        );
      },
    );
  }

  Widget _topBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Container()),
        const Text(
          'FlavourFleet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color matching the login view
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 52,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.orange), // Border color
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Flexible(
            child: TextFormField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search for Food',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _searchProducts(value);
                } else {
                  _clearSearch();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeSlider(Size mediaSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double sliderHeight = constraints.maxHeight * 0.2;
        if (sliderHeight > 150) sliderHeight = 150;
        return Stack(
          children: [
            SizedBox(
              height: sliderHeight,
              width: constraints.maxWidth,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentSlide = value;
                  });
                },
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Special Offers',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Get 25% Off upto 200',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange, // Button color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Shop Now'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: currentSlide == index ? 15 : 8,
                      height: 8,
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            currentSlide == index ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _categoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cuisines',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Text color
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _categoryItem(
                title: 'Nepali',
                categoryId: 'Nepali Cuisine',
                icon: Icons.rice_bowl,
              ),
              _categoryItem(
                title: 'Indian',
                categoryId: 'Indian Cuisine',
                icon: Icons.local_dining,
              ),
              _categoryItem(
                title: 'Chinese',
                categoryId: 'Chinese Cuisine',
                icon: Icons.ramen_dining,
              ),
              _categoryItem(
                title: 'Korean',
                categoryId: 'Korean Cuisine',
                icon: Icons.kitchen,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _categoryItem({
    required String title,
    required String categoryId,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () => _fetchProductsByCategory(categoryId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: selectedCategory == categoryId
                    ? Colors.orange // Active category color
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                icon,
                size: 30,
                color: selectedCategory == categoryId
                    ? Colors.white // Icon color for active category
                    : Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black, // Text color
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentPostsSection(
      Size mediaSize, PostState state, SearchState searchState) {
    final List posts =
        searchState.products.isNotEmpty ? searchState.products : state.lstposts;
    if (posts.isEmpty) {
      return Center(
        child: Text(
          'No products found for the selected category.',
          style: TextStyle(color: Colors.black), // Text color
        ),
      );
    }

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            _scrollController.position.extentAfter == 0) {
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            if (selectedCategory.isNotEmpty) {
              _loadMoreProductsByCategory();
            } else {
              _loadMorePosts();
            }
          }
        }
        return true;
      },
      child: SizedBox(
        height: mediaSize.height * 0.6,
        child: GridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return GestureDetector(
              onTap: () {
                ref
                    .read(homeViewModelProvider.notifier)
                    .openPostPage(post.productId);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.orange[50],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: mediaSize.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${ApiEndpoints.imageUrl}${post.productImage}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        post.productTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Text color
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Rs ${post.productPrice}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
