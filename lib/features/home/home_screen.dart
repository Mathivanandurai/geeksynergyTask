import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/components/constants/text_style.dart';
import 'package:task/components/custom_widgets/custom_image.dart';
import 'package:task/features/home/nav_drwer.dart';
import 'package:task/utils/date_helper.dart';
import '../../controller/home_controller.dart';
import '../../model/movie_list_response.dart';
import '../../utils/enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController(), permanent: true);
  final GlobalKey<ScaffoldState> _key = GlobalKey(); //
  @override
  void initState() {
    controller.callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: const NavDrawer(),
        appBar: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: InkWell(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: const Icon(Icons.menu),
              ),
            )),
        body: GetBuilder<HomeController>(
          builder: (value) {
            if (value.apiCallStatus == ApiCallStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.apiCallStatus == ApiCallStatus.error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value.errorMessage,
                      style: GetTextStyleTask.styleS20w700Grey,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.callApi();
                      },
                      child: Text(
                        "Retry",
                        style: GetTextStyleTask.styleS20w700Black,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async{
                  controller.callApi();
                },
                child: ListView.separated(
                  itemCount: value.movieList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var tempModel = value.movieList[index];
                    return MovieCard(model: tempModel);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 5,
                      child: Divider(
                        height: 0,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.model});

  final MovieResult model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildVotes(),
                const SizedBox(width: 15),
                _buildImage(),
                const SizedBox(width: 15),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
          const SizedBox(height: 15),
          _buildButton()
        ],
      ),
    );
  }

  _buildVotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Transform.scale(
          scale: 1,
          child: InvertChild(
            child: CustomPaint(
              painter: InvertedTrianglePainter(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            "${model.voted.length}",
            style: GetTextStyleTask.styleS20w700Grey.copyWith(
              color: Colors.black,
            ),
          ),
        ),
        Transform.scale(
          scale: 1,
          child: SizedBox(
            width: 20,
            height: 50,
            child: CustomPaint(
              painter: InvertedTrianglePainter(),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "Votes",
          style: GetTextStyleTask.styleS20w700Grey.copyWith(
            color: Colors.black,
          ),
        )
      ],
    );
  }

  _buildImage() {
    return CustomNetworkImage(
      image: model.poster,
      radius: 15,
      width: 120,

    );
  }

  _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          style: GetTextStyleTask.styleS20w700Black
              .copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        titleSubtitleText("Genre", model.genre.capitalizeFirst ?? ""),
        const SizedBox(height: 5),
        titleSubtitleText("Director", model.director.join(",")),
        const SizedBox(height: 5),
        titleSubtitleText("Starring", model.stars.join(", ")),
        const SizedBox(height: 5),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          children: [
            Text("${model.runTime ?? 0} Mins",
                style: GetTextStyleTask.styleS16w500Black),
            Container(
              height: 18,
              width: 2,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            Text(model.language, style: GetTextStyleTask.styleS16w500Black),
            Container(
              height: 18,
              width: 2,
              decoration: const BoxDecoration(color: Colors.black),
            ),
            Text(DateHelper.dateOnly(model.releasedDate),
                style: GetTextStyleTask.styleS16w500Black)
          ],
        ),
        const SizedBox(height: 10),
        IntrinsicHeight(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              Text(
                "${model.pageViews} views",
                style: GetTextStyleTask.styleS20w700Blue,
              ),
              Container(
                width: 2,
                height: 20,
                decoration: const BoxDecoration(color: Colors.blueAccent),
              ),
              Text(
                "Voted by ${model.voted.length} People",
                style: GetTextStyleTask.styleS20w700Blue,
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(
          "Watch Trailer",
          style:
              GetTextStyleTask.styleS20w700Black.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget titleSubtitleText(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: GetTextStyleTask.styleS20w700Grey.copyWith(fontSize: 16),
        ),
        Flexible(
            child: Text(subtitle,
                style: GetTextStyleTask.styleS20w700Grey.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 16))),
      ],
    );
  }
}

class InvertedTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;

    final double bluntHeight =
        height * 0.19; // Adjust the blunt height as per your requirement
    final double bluntOffset =
        width * 0.022; // Adjust the blunt offset as per your requirement

    final path = Path();
    path.moveTo(0, 0); // Top left corner

    path.lineTo(width, 0); // Top right corner
    path.lineTo(width / 2 + bluntOffset, bluntHeight); // Top blunt corner
    path.quadraticBezierTo(
      width / 2,
      bluntHeight * 1.06,
      width / 2 - bluntOffset,
      bluntHeight,
    ); // Curve the tip of the triangle
    path.lineTo(0, 0); // Top left corner
    path.close();

    final paint = Paint()..color = Colors.black;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class InvertChild extends StatelessWidget {
  const InvertChild({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..scale(1.0, -1.0, 1.0), // Flip vertically
      child: SizedBox(
        width: 20,
        height: 50,
        child: child,
      ), // Replace with your child widget
    );
  }
}
