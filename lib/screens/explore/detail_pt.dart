import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';
import 'package:user_side_final_project/models/tag.dart';
import 'package:user_side_final_project/providers/explore/controllers/personal_trainer_controller.dart';

class DetailPersonalTrainerPage extends ConsumerStatefulWidget {
  int id;
  DetailPersonalTrainerPage({super.key, required this.id});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailPersonalTrainerPageState();
}

class _DetailPersonalTrainerPageState
    extends ConsumerState<DetailPersonalTrainerPage> {
  TextEditingController messageInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pt = ref.watch(detailPersonalTrainerProvider(widget.id));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(pt!.user!.name!),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              pt.user!.avatar!.url,
                              fit: BoxFit.cover,
                              width: 1000,
                            ),
                          )),
                      SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${pt.user!.name}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          RatingBar.builder(
                            initialRating: pt.rate!.toDouble() ?? 0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 18,
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true,
                            allowHalfRating: true,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Link(
                                  uri: Uri.parse(pt.facebook!),
                                  builder: (BuildContext context, followLink) {
                                    return GestureDetector(
                                      onTap: followLink,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/facebook.png",
                                          width: 32,
                                          height: 32,
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                width: 8,
                              ),
                              Link(
                                  uri: Uri.parse(pt.youtube!),
                                  builder: (BuildContext context, followLink) {
                                    return GestureDetector(
                                      onTap: followLink,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          "assets/images/youtube.jpg",
                                          width: 32,
                                          height: 32,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadowColor: Colors.black87,
                    elevation: 1,
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            color: Colors.white,
                            width: (MediaQuery.of(context).size.width - 36) / 3,
                            height: 80,
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  "${pt.members}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Member",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: (MediaQuery.of(context).size.width - 36) / 3,
                            height: 80,
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  "${pt.challenges}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Challenge",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: (MediaQuery.of(context).size.width - 36) / 3,
                            height: 80,
                            child: Flex(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              direction: Axis.vertical,
                              children: [
                                Text(
                                  "${pt.numRate}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  "Rating",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Card(
                    color: Colors.white,
                    elevation: 1,
                    shadowColor: Colors.black87,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.agriculture,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.age} years old",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.local_activity,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.gender}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.address}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.mail_outline_rounded,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.user!.email}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.work_outline_rounded,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.workType}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(Icons.monetization_on_outlined,
                                      color: Colors.black54),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.desiredSalary} dollar",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.gpp_good_outlined,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.certificateIssuer!.name}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Icon(
                                    Icons.label_outlined,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  ...getTechniques(pt.techniques!),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${pt.introduce}Xin chào! Tôi là Creator, một personal trainer đầy kinh nghiệm và đam mê về sức khỏe. Tôi tận tâm hỗ trợ khách hàng đạt được mục tiêu thể chất và sức khỏe tối ưu. Với phong cách huấn luyện tùy chỉnh và những kế hoạch hiệu quả, tôi cam kết giúp bạn vượt qua giới hạn và sống một cuộc sống khỏe mạnh, hạnh phúc. Hãy bắt đầu hành trình thay đổi cùng tôi!",
                    ),
                  ),
                  Divider(),
                  Text(
                    "Training Activities",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                  GalleryImage(
                      titleGallery: "Training Activities",
                      numOfShowImages: pt.workoutTrainingMedia!.length,
                      imageUrls:
                          pt.workoutTrainingMedia!.map((e) => e.url).toList())
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () async {
            await showMessageDialog();
          },
          child: Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ));
  }

  List<Widget> getTechniques(List<Tag> listTechs) {
    return listTechs
        .map((e) => Text(
              "${e.name}, ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ))
        .toList();
  }

  Future<String?> showMessageDialog() => showDialog(
      context: context,
      builder: (context) {
        return messageModalWidget(context);
      });

  Widget messageModalWidget(context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      content: Container(
        color: Colors.white,
        width: 400,
        child: TextField(
          maxLines: 8,
          controller: messageInputController,
          decoration: InputDecoration(hintText: "Enter Message"),
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              GoRouter.of(context).pop(messageInputController.text);
              messageInputController.clear();
            },
            child: Icon(Icons.send)),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}
