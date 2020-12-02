import 'package:blogr_app/constants/constants.dart';
import 'package:blogr_app/controllers/profile_screen_controller.dart';
import 'package:blogr_app/views/profile_screen/components/articles_tab.dart';
import 'package:blogr_app/views/profile_screen/components/settings_tab.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  static final String routeName = 'profile screen';
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final ProfileScreenController profileScreenController =
      Get.find<ProfileScreenController>();

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: CustomColors.blackColor,
                floating: true,
                snap: true,
                pinned: true,
                stretch: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    profileScreenController.currentUser.displayName,
                    style: TextStyle(fontSize: 18),
                  ),
                  centerTitle: true,
                  background: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          'https://media.istockphoto.com/vectors/abstract-black-background-geometric-texture-vector-id936834172?k=6&m=936834172&s=612x612&w=0&h=oF8_qU5HuultCXfI7KZANZcJBf9VZMuz177kpgEnMcc=',
                          fit: BoxFit.cover,
                        ),
                      ),
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: CachedNetworkImageProvider(
                            profileScreenController.currentUser.photoURL),
                        backgroundColor: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                // TabBar with a ceiling)
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorWeight: 4,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: CustomColors.yellowColor,
                    controller: tabController,
                    tabs: <Widget>[
                      Tab(text: 'Articles'),
                      Tab(text: 'Settings'),
                    ],
                  ),
                ),
              ),
              SliverFillRemaining(
                // TabBarView, the remaining supplement)
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    ArticlesTab(),
                    SettingsTab(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
