import 'package:bloc_quiz/presentation/main/result_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultItem extends StatelessWidget {
  const ResultItem(this.index, this.doc);

  final int index;
  final dynamic doc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultDetailScreen(
                  score: double.parse(doc['score']),
                  categoryIndex: doc['categoryIndex'],
                  attempts: doc['attempts'],
                  wrongAttempts: doc['wrongAttempts'],
                  correctAttempts: doc['correctAttempts'],
                  difficultyLevel: doc['difficultyLevel'],
                  isSaved: true,
                )),
          );
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    doc['score'],
                    style: TextStyle(
                      fontSize: 23,
                      color: (double.parse(doc['score']) > 0.0 ? Colors.black : Colors.redAccent),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM y, h:mm a').format((doc['time'] as Timestamp).toDate()),
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
