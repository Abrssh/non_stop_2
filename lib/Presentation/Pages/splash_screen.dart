import 'package:flutter/material.dart';
import 'package:non_stop_2/Presentation/Pages/home_pages.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/smiley-friends-posing-together-front-view.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0.0, 0.4, 0.8, 1.0],
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.0),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: "Welcome to \n",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Nonstop Ethiopia.\n",
                        style: TextStyle(
                          color: Colors.orange.shade400,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                          text:
                              "\nExperience the latest Non stop music without worrying about the files even with a limited internet speed.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.9, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    "Start Listening",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
