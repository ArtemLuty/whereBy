// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:opigno_app/constants/colors.dart';
// import 'package:opigno_app/modules/social_feed/communities/communities_screen.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_cubit.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/post_cubit/post_state.dart';
// import 'package:opigno_app/modules/social_feed/social_feed/social_feed_tab.dart';
// import 'package:opigno_app/widgets/rotating_progress_indicator.dart';

// class SosialScreen extends StatelessWidget {
//   static const path = 'home';

//   const SosialScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//         //  BlocProvider(
//         //   create: (context) => DashbordCubit()..init(),
//         //   child:
//         BlocBuilder<PostCubit, PostState>(
//       builder: (context, state) {
//         if (state.isLoading) {
//           return const Center(
//               child: RotatingProgressIndicator(
//             color: ColorConstants.tapColor,
//             size: 40,
//           ));
//         }

//         return const Scaffold(
//           backgroundColor: Colors.white,
//           body: NestedTabBar(),
//         );
//       },
//       // ),
//     );
//   }
// }

// class NestedTabBar extends StatefulWidget {
//   const NestedTabBar({super.key});

//   @override
//   State<NestedTabBar> createState() => _NestedTabBarState();
// }

// class _NestedTabBarState extends State<NestedTabBar>
//     with TickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: SvgPicture.asset(
//             'assets/svg/logo.svg',
//             color: ColorConstants.tapTextColor,
//             width: 126,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: SvgPicture.asset(
//               'assets/svg/fi-rr-bell.svg',
//               color: ColorConstants.tapTextColor,
//             ),
//             onPressed: () {},
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: IconButton(
//               icon: SvgPicture.asset(
//                 'assets/svg/menu-burger.svg',
//                 color: ColorConstants.tapTextColor,
//               ),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 10),
//             child: SizedBox(
//               height: 35,
//               child: TabBar.secondary(
//                 splashBorderRadius: BorderRadius.circular(40),
//                 splashFactory: NoSplash.splashFactory,
//                 labelColor: ColorConstants.mainText,
//                 labelPadding: const EdgeInsets.all(0),
//                 indicator: BoxDecoration(
//                     color: ColorConstants.tapAditionColor,
//                     borderRadius: BorderRadius.circular(54.0)),
//                 dividerColor: Colors.transparent,
//                 unselectedLabelColor: ColorConstants.mainText,
//                 controller: _tabController,
//                 tabs: const <Widget>[
//                   Tab(
//                     text: 'Social feed',
//                   ),
//                   Tab(text: 'Communities'),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: const <Widget>[
//                 SocialFeedTab(),
//                 CommunitiesScreen(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
