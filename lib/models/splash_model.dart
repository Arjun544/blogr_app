class SplashModel {
  final String src;
  final String txt;

  SplashModel({this.src, this.txt});
}

List<SplashModel> splashList = [
  SplashModel(
      src: 'assets/view1.json',
      txt: 'Create a unique blog publish your passions.'),
  SplashModel(
      src: 'assets/view2.json',
      txt: 'Find a new source of knowledge for yourself'),
  SplashModel(
      src: 'assets/view3.json',
      txt: 'Analyze your audience. Measure your success.'),
];
