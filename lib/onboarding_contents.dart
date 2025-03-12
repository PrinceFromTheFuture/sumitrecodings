class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Track Your meetings and be sure ",
    image: "assets/image1.png",
    desc: "tracking your meetings can help to avoid mistakes ",
  ),
  OnboardingContents(
    title: "Built With Love By PincaColada",
    image: "assets/image2.png",
    desc:
        "we built this app for free for you feel free to ask for improvment! 054-6941-660 ",
  ),
  
];
