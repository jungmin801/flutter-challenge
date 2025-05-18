import 'package:flutter/material.dart';
import 'package:movieflix/models/detail_movie_model.dart';
import 'package:movieflix/services/api_services.dart';
import 'package:movieflix/widgets/section/detail_body.dart';
import 'package:movieflix/widgets/section/detail_header.dart';

class DetailScreen extends StatefulWidget {
  final String poster, imgUrl;
  final int id;

  const DetailScreen({
    super.key,
    required this.id,
    required this.poster,
    required this.imgUrl,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<DetailMovieModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiServices.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: Text('Back to list'),
        titleSpacing: 0,
        titleTextStyle: TextStyle(fontSize: 16),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 28,
          ), // ← 아이콘 크기 직접 지정
          onPressed: () => Navigator.pop(context),
          constraints: const BoxConstraints(), // ← 버튼 사이즈 작게 만들기 위한 핵심
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('${widget.imgUrl}${widget.poster}'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Color.fromRGBO(0, 0, 0, 0.5), // 이미지 위에 약간의 어두운 필터
              BlendMode.darken,
            ),
          ),
        ),
        child: FutureBuilder(
          future: movie,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 290),
                  DetailHeaderWidget(data: data),
                  SizedBox(height: 50),
                  DetailBodyWidget(data: data),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            8,
                          ), // ✅ 원하는 값으로 조절
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Buy ticket',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
