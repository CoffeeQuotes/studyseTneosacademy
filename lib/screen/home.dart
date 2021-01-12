import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:share/share.dart';
import 'package:studyse/model/courses.dart';
import 'package:studyse/network_utils/api.dart';
import 'package:studyse/network_utils/courses-api.dart';
import 'package:studyse/network_utils/page-api.dart';
import 'package:studyse/screen/adview.dart';
import 'package:studyse/screen/course-overview.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Tneos/AndroidStudioProjects/studyse/lib/model/pages.dart';
import 'file:///C:/Users/Tneos/AndroidStudioProjects/studyse/lib/model/advertisements.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:getwidget/getwidget.dart';
import 'app_theme.dart';
import 'login.dart';
import 'package:dart_date/dart_date.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  bool multiple = true;
  int userId;
  String name;
  String email;
  String phone;
  void initState() {
    _loadUserData();
    super.initState();
  }

  Future<bool> getTheData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    if (user != null) {
      setState(() {
        name = user['name'];
        userId = user['id'];
        email = user['email'];
        phone = user['phone'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GFDrawer(
        gradient: FlutterGradients.premiumDark(
            type: GradientType.sweep, center: Alignment.bottomCenter),
        // backgroundImage: AssetImage("assets/img/sidebar-bg.png"),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            GFDrawerHeader(
              closeButton: Container(),
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              currentAccountPicture: GFAvatar(
                radius: 80.0,
                backgroundColor: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/logo.png"))),
                ),
                // backgroundImage: AssetImage("assets/img/logo.png"),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name ?? "Hello, User",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    email ?? "Welcome",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Item 1',
                style: TextStyle(color: Colors.white),
              ),
              onTap: null,
            ),
            ListTile(
              title: Text(
                'Item 2',
                style: TextStyle(color: Colors.white),
              ),
              onTap: null,
            ),
          ],
        ),
      ),
      backgroundColor: AppTheme.white,
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: GFShimmer(
                      child: Text(
                        "Tneos Eduloutions",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    background: Image.network(
                      "https://images.pexels.com/photos/207130/pexels-photo-207130.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                      fit: BoxFit.cover,
                    )),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    labelColor: Color(0xffB0BEC5),
                    unselectedLabelColor: Color(0xff37474F),
                    tabs: [
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(top: 1.66, bottom: 1.66),
                          constraints: BoxConstraints.expand(),
                          color: Color(0xff263238),
                          child: Column(
                            children: [
                              Icon(MaterialCommunityIcons.home_outline),
                              Text("Home")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(top: 1.66, bottom: 1.66),
                          color: Color(0xff263238),
                          constraints: BoxConstraints.expand(),
                          child: Column(
                            children: [
                              Icon(MaterialCommunityIcons.video_outline),
                              Text("Live Classes")
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(top: 1.66, bottom: 1.66),
                          color: Color(0xff263238),
                          constraints: BoxConstraints.expand(),
                          child: Column(
                            children: [
                              Icon(MaterialCommunityIcons.comment_outline),
                              Text("Doubts")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Center(
            child: TabBarView(
              children: [
                Container(
                    color: Color(0xff2e2b2b),
                    padding: EdgeInsets.only(top: 0),
                    child: FutureBuilder(
                      future: fetchAdvertisement(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child:  GFLoader(
                               type:GFLoaderType.circle,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error"));
                        } else {
                          if (snapshot.hasData && snapshot.data.isNotEmpty) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                Advertisements list = snapshot.data[index];
                                return VxSwiper(
                                    aspectRatio: 1 / 1,
                                    height:
                                        MediaQuery.of(context).size.height/2 + 260,
                                    viewportFraction: 1.0,
                                    items: [
                                      GFCard(
                                        boxFit: BoxFit.cover,
                                        image: Image(
                                            image: CachedNetworkImageProvider(
                                                'http://10.0.2.2:8000/storage/${list.primaryImage}')),
                                        title: GFListTile(
                                          title: Text("${list.title}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              )),
                                          subtitle: Text(
                                            "${list.body}",
                                            maxLines: 2,
                                          ),
                                        ),
                                        buttonBar: GFButtonBar(
                                            alignment:
                                                WrapAlignment.spaceBetween,
                                            children: [
                                              GFButton(
                                                onPressed: () {
                                                  Share.share(
                                                      "check out new offer http://10.0.2.2:8000/storage/${list.primaryImage}");
                                                },
                                                text: "Share",
                                                color: Color(0xff4E7BB6),
                                                elevation: 10.0,
                                                icon: Icon(
                                                  MaterialCommunityIcons
                                                      .share,
                                                  color: Vx.white,
                                                ),
                                              ),
                                              GFButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => AdView(list.title, list.body, list.primaryImage, list.secondaryImage, list.thirdImage)));
                                                },
                                                color: Color(0xff272B40),
                                                elevation: 10.0,
                                                text: "Open",
                                                icon: Icon(
                                                    MaterialCommunityIcons
                                                        .open_in_app,
                                                    color: Vx.white),
                                              )
                                            ]),
                                        elevation: 10.0,
                                      ),
                                      if (list?.secondaryImage?.isEmpty ?? true)
                                        GFCard(
                                             boxFit: BoxFit.cover,
                                          image: Image.asset(
                                              "assets/img/ads-ui.png"),
                                          title: GFListTile(
                                            title: Text("Tneos Online Learning",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            subtitle: Text(
                                              "Online Courses, Never stop Learning with Tneos Online Learning Classes",
                                              maxLines: 2,
                                            ),
                                          ),
                                          buttonBar: GFButtonBar(
                                            alignment: WrapAlignment
                                                .spaceBetween,
                                            children: [
                                              GFButton(
                                                onPressed: () {
                                                  Share.share(
                                                      "Download Tneos Competitive App  https://tneos.com");
                                                },
                                                color: Color(0xff4E7BB6),
                                                elevation: 10.0,
                                                text: "Share",
                                                icon: Icon(
                                                  MaterialCommunityIcons
                                                      .share,
                                                  color: Vx.white,
                                                ),
                                              ),
                                              GFButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => AdView(list.title, list.body, list.primaryImage, list.secondaryImage, list.thirdImage)));
                                                },
                                                color: Color(0xff272B40),
                                                elevation: 10.0,
                                                text: "Open",
                                                icon: Icon(
                                                  MaterialCommunityIcons
                                                      .open_in_app,
                                                  color: Vx.white,
                                                ),
                                              )
                                            ],
                                          ),
                                          elevation: 10.0,
                                        )
                                      else
                                        GFCard(
                                             boxFit: BoxFit.cover,
                                          image: Image(
                                              image: CachedNetworkImageProvider(
                                                  'http://10.0.2.2:8000/storage/${list.secondaryImage}')),
                                          title: GFListTile(
                                            title: Text("${list.title}",
                                                style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w700,
                                                )),
                                            subtitle: Text(
                                              "${list.body}",
                                              maxLines: 2,
                                            ),
                                          ),
                                          buttonBar: GFButtonBar(
                                              alignment: WrapAlignment
                                                  .spaceBetween,
                                              children: [
                                                GFButton(
                                                  onPressed: () {
                                                    Share.share(
                                                        "check out new offer http://10.0.2.2:8000/storage/${list.secondaryImage}");
                                                  },
                                                  color: Color(0xff4E7BB6),
                                                  elevation: 10.0,
                                                  text: "Share",
                                                  icon: Icon(
                                                    MaterialCommunityIcons
                                                        .share,
                                                    color: Vx.white,
                                                  ),
                                                ),
                                                GFButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => AdView(list.title, list.body, list.primaryImage, list.secondaryImage, list.thirdImage)));
                                                    },
                                                    text: "Open",
                                                    color:
                                                        Color(0xff272B40),
                                                    elevation: 10.0,
                                                    icon: Icon(
                                                        MaterialCommunityIcons
                                                            .open_in_app,
                                                        color: Vx.white))
                                              ]),
                                          elevation: 10.0,
                                        ),
                                      if (list?.thirdImage?.isEmpty ?? true)
                                        GFCard(
                                             boxFit: BoxFit.cover,
                                          image: Image.asset(
                                              "assets/img/ads-ui.png"),
                                          title: GFListTile(
                                            title: Text("Tneos Online Learning",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                )),
                                            subtitle: Text(
                                              "Online Courses, Never stop Learning with Tneos Online Learning Classes",
                                              maxLines: 2,
                                            ),
                                          ),
                                          buttonBar: GFButtonBar(
                                            children: [
                                              GFButton(
                                                onPressed: () {
                                                  Share.share("check out new offer http://10.0.2.2:8000/storage/${list.secondaryImage}");
                                                },
                                                color: Color(0xff4E7BB6),
                                                elevation: 10.0,
                                                text: "Share",
                                                icon: Icon(
                                                  MaterialCommunityIcons
                                                      .share,
                                                  color: Vx.white,
                                                ),
                                              ),
                                              GFButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => AdView(list.title, list.body, list.primaryImage, list.secondaryImage, list.thirdImage)));
                                                },
                                                color: Color(0xff272B40),
                                                elevation: 10.0,
                                                text: "Open",
                                                icon: Icon(
                                                  MaterialCommunityIcons
                                                      .open_in_app,
                                                  color: Vx.white,
                                                ),
                                              )
                                            ],
                                          ),
                                          elevation: 10.0,
                                        )
                                      else
                                        GFCard(
                                             boxFit: BoxFit.cover,
                                          image: Image(
                                              image: CachedNetworkImageProvider(
                                                  'http://10.0.2.2:8000/storage/${list.thirdImage}')),
                                          // title: GFListTile(
                                          //   title: Text("${list.createdAt.toString()}"),
                                          // )
                                          title: GFListTile(
                                            title: Text("${list.title}",
                                                style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.w700,
                                                )),
                                            subtitle: Text(
                                              "${list.body}",
                                              maxLines: 2,
                                            ),
                                          ),
                                          buttonBar: GFButtonBar(
                                              alignment: WrapAlignment
                                                  .spaceBetween,
                                              children: [
                                                GFButton(
                                                  onPressed: () {
                                                    Share.share(
                                                        "check out new offer http://10.0.2.2:8000/storage/${list.thirdImage}");
                                                  },
                                                  color: Color(0xff4E7BB6),
                                                  text: "Share",
                                                  icon: Icon(
                                                    MaterialCommunityIcons
                                                        .share,
                                                    color: Vx.white,
                                                  ),
                                                  elevation: 10.0,
                                                ),
                                                GFButton(
                                                  onPressed: () {
                                                   Navigator.push(context, MaterialPageRoute(
                                                     builder: (context) => AdView(list.title, list.body, list.primaryImage,list.secondaryImage, list.thirdImage)
                                                   ));
                                                  },
                                                  color: Color(0xff272B40),
                                                  text: "Open",
                                                  icon: Icon(
                                                      MaterialCommunityIcons
                                                          .open_in_app,
                                                      color: Vx.white),
                                                  elevation: 10.0,
                                                )
                                              ]),
                                          elevation: 10.0,
                                        ),
                                    ]);

                                //   SingleChildScrollView(
                                //   // This next line does the trick.
                                //   scrollDirection: Axis.horizontal,
                                //   child: Row(
                                //     children: [
                                //      Container(
                                //        width: MediaQuery.of(context).size.width,
                                //        child: GFCard(
                                //             boxFit: BoxFit.contain,
                                //             image: Image(
                                //                 image:CachedNetworkImageProvider('http://10.0.2.2:8000/storage/${list.primaryImage}')
                                //             ),
                                //         ),
                                //      ),
                                //       Container(
                                //         width: MediaQuery.of(context).size.width,
                                //         child: GFCard(
                                //           boxFit: BoxFit.contain,
                                //           image: Image(
                                //               image:CachedNetworkImageProvider('http://10.0.2.2:8000/storage/${list.secondaryImage}')
                                //           ),
                                //         ),
                                //       ),
                                //       Container(
                                //         width: MediaQuery.of(context).size.width,
                                //         child: GFCard(
                                //           boxFit: BoxFit.contain,
                                //           image: Image(
                                //               image:CachedNetworkImageProvider('http://10.0.2.2:8000/storage/${list.thirdImage}')
                                //           ),
                                //         ),
                                //       ),
                                //   ],
                                // ));

                                // CachedNetworkImage(imageUrl: "http://10.0.2.2:8000/storage/${list.image}");
                                //   Container(
                                //   padding: EdgeInsets.only(left: 12.0, right: 12.0),
                                //   child: SingleChildScrollView(
                                //     child: Column(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       children: [
                                //         Padding(
                                //           padding: EdgeInsets.only(left: 8.0),
                                //           child: InkWell(
                                //             onTap: () {
                                //
                                //             },
                                //             child: GFCard(
                                //               boxFit: BoxFit.cover,
                                //               image:  Image(
                                //                 image: CachedNetworkImageProvider("http://10.0.2.2:8000/storage/${list.image}"),
                                //               ),
                                //               //Image.network(),
                                //               title: GFListTile(
                                //                 titleText: list.title,
                                //                 subtitleText: list.createdAt.toString(),
                                //               ),
                                //               content: Text(list.excerpt),
                                //             ),
                                //
                                //           ),
                                //         )
                                //       ],
                                //     ),
                                //   ),
                                // );
                              },
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: Text("Sorry Content Not Available"),
                              ),
                            );
                          }
                        }
                      },
                    )),
                Container(
                    child: FutureBuilder(
                      future: fetchCourses(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            child: Center(
                              child:  GFLoader(
                                type:GFLoaderType.circle,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text("Error"));
                        } else {
                          if (snapshot.hasData && snapshot.data.isNotEmpty) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xff2e2b2b),
                              ),
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    Courses course = snapshot.data[index];
                                    return GFListTile(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) =>  CourseOverview(course.courseTitle, course.courseDesc, course.courseCode, course.courseProvider, course.image, course.courseStatus, course.courseOrganizerName, course.price, course.ratings, course.courseInstance, course.instanceName, course.instanceDesc)
                                        ));
                                      },
                                      description: Text("Course start Date:  ${course.startDate.format('MMMM dd y, h:mm:ss a')}", style: TextStyle(color: Colors.white),),
                                      color: Color(0xff2b2e2e),
                                      padding: EdgeInsets.all(20.0),
                                      avatar: GFAvatar(
                                        backgroundImage: CachedNetworkImageProvider('http://10.0.2.2:8000/storage/${course.image}'),
                                      ),
                                      subtitle: Text(course.courseOrganizerName, style: TextStyle(color: Colors.white70),),
                                      title: Text(course.courseTitle, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "Montserrat"),),
                                      icon: (course.courseStatus == "live") ? GFShimmer( child: Text('LIVE', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, letterSpacing: 2),), showGradient: true, gradient: LinearGradient( colors: [Color(0xfff51019),Color(0xffd34146),Color(0xffd73faa),Color(0xffc939c0)]) ,) : (course.courseStatus == "new") ? GFShimmer(child: Text("New".toUpperCase(), style: TextStyle(fontSize: 24, letterSpacing: 2, fontWeight: FontWeight.w700)), showGradient: true, gradient: LinearGradient( colors: [Color(0xff00987f), Color(0xff8de5b5), Color(0xff8ba582), Color(0xffedfb01)]),) : Icon(MaterialCommunityIcons.video_outline, color: Colors.redAccent, size: 32),
                                    );
                                  }),
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: Text("Sorry Content Not Available"),
                              ),
                            );
                          }
                        }
                      }
                      )),
                Center(child: Text("Page 3")),
              ],
            ),
          ),
        ),

        // children: [
        //   Text('Hello, $name'),
        //   Text('User-id: , $userId'),
        //   Center(
        //     child: RaisedButton(
        //       elevation: 10,
        //       onPressed: () {
        //         logout();
        //       },
        //       color: Vx.teal800,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.all(Radius.circular(10))),
        //       child: Text(
        //         'Logout',
        //         style: TextStyle(color: Vx.white),
        //       ),
        //     ),
        //   ),
        // ],
      ),
    );
  }

  void logout() async {
    var res = await Network().getData('/logout');
    var body = json.decode(res.body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
