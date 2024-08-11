//class to keep all the endpoints for our API calls
class Endpoints{
  //endpoint to get all categories
  static const String categories = "/categories.php";
  //to get the list of areas
  static const String regions = "/list.php?a=list";
  //to get meals for category, needs category to be added at the end
  static const String categoryMeals = "/filter.php?c=";
  //to get meals for region, needs region to be added at the end
  static const String regionMeals = "/filter.php?a=";
}