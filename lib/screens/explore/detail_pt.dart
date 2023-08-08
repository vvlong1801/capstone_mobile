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
    final personalTrainer = ref.watch(detailPersonalTrainerProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Detail Personal Trainer"),
          backgroundColor: Colors.white,
        ),
        body: SafeArea(
            child: personalTrainer.when(data: (pt) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14),
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
                      const SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${pt.user!.name}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          RatingBar.builder(
                            initialRating: pt.rate!.toDouble(),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemSize: 18,
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true,
                            allowHalfRating: true,
                          ),
                          const SizedBox(
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
                              const SizedBox(
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
                  const SizedBox(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                const Text(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                const Text(
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
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                const Text(
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
                  const SizedBox(
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
                                  const Icon(
                                    Icons.agriculture,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.age} years old",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Icon(
                                    Icons.local_activity,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.gender}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.address}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Icon(
                                    Icons.mail_outline_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.user!.email}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Icon(
                                    Icons.work_outline_rounded,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.workType}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Icon(Icons.monetization_on_outlined,
                                      color: Colors.black54),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "${pt.desiredSalary} dollar",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  const Icon(
                                    Icons.gpp_good_outlined,
                                    color: Colors.black54,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    pt.certificateIssuer!.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              Wrap(
                                children: [Text(getTechniques(pt.techniques!))],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${pt.introduce}Xin chào! Tôi là Creator, một personal trainer đầy kinh nghiệm và đam mê về sức khỏe. Tôi tận tâm hỗ trợ khách hàng đạt được mục tiêu thể chất và sức khỏe tối ưu. Với phong cách huấn luyện tùy chỉnh và những kế hoạch hiệu quả, tôi cam kết giúp bạn vượt qua giới hạn và sống một cuộc sống khỏe mạnh, hạnh phúc. Hãy bắt đầu hành trình thay đổi cùng tôi!",
                    ),
                  ),
                  const Divider(),
                  const Text(
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
          );
        }, error: (error, _) {
          return Center(
            child: Text(error.toString()),
          );
        }, loading: () {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        })),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          onPressed: () async {
            await showMessageDialog();
          },
          child: const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          ),
        ));
  }

  String getTechniques(List<Tag> listTechs) {
    final mapped = listTechs.map((e) => e.name).toList();
    return mapped.join(", ");
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
          decoration: const InputDecoration(hintText: "Enter Message"),
          autofocus: true,
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              GoRouter.of(context).pop(messageInputController.text);
              messageInputController.clear();
            },
            child: const Icon(Icons.send)),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    );
  }
}
