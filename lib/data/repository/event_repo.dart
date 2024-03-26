import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as Http;
import '../../utils/appconstants.dart';
import '../api/apiclient.dart';

class EventRepo {
  late final ApiClient apiClient;
  late final SharedPreferences sharedPreferences;

  EventRepo({required this.sharedPreferences, required this.apiClient});


  /*.................................................Fetch Notification days...................................................*/


  Future<Http.Response> fetchNotificationDays() async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHNOTIFICATIONDAYS),)

        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }





  /*.................................................Update Subscription...................................................*/


  Future<Http.Response> updateSubscription(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.UPDATESUBSCRIPTION), body: map)

        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }



  /*.................................................Fetch Notification...................................................*/


  Future<Http.Response> fetchNotification(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHNOTIFICATION), body: map)

        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }


  /*.................................................Fetch Saved address...................................................*/


  Future<Http.Response> fetchsavedAddress(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHSAVEDADDRESS), body: map)

        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }





  /*.................................................Saved address...................................................*/


  Future<Http.Response> savedAddress(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.SAVEDADDRESS), body: map)

        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }




/*.................................................interest event...................................................*/


  Future<Http.Response> interestEvents(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.INTERESTEVENT), body: map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }

  /*...............................................Saved Events.......................................................*/

  Future<Http.Response> saveEvents(String id) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.SAVEDEVENTS),body: {
      "user_id":id
    })
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }





  /*...............................................unsave and  dislike events...................................................*/

  Future<Http.Response> unsaveEvents(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.UNSAVEEVENT), body: map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }




  /*...............................................save and  like events...................................................*/

  Future<Http.Response> savelikeEvents(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.SAVELIKEEVENT), body: map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }





  /*...............................................fetchEventDetails by event id.......................................................*/

  Future<Http.Response> fetchEventDetails(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.EventDetail), body: map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }





  /*...............................................Category Events.......................................................*/

  Future<Http.Response> categoryEvents(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.CATEGORYWISEEVENTS),body:map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));


  }




  /*...............................................Past Events.......................................................*/

  Future<Http.Response> pastEvents(String id) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.PASTEVENTS),body: {
      "user_id":id
    })
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }


/*...............................................Upcoming Events.......................................................*/

  Future<Http.Response> upcomingEvents(String id) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.UPCOMINGEVENTS),body: {
      "user_id":id
    })
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }



  /*...............................................view Events.......................................................*/

  Future<Http.Response> viewEvents(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.VIEWEVENTS), body: map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }

  /*...............................................fetch subscription.......................................................*/

  Future<Http.Response> fetchSubscription() async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHSUBSCRIPTION), )
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }





/*...............................................fetch card.......................................................*/

  Future<Http.Response> fetchCard(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.FETCHCARD), body:map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }


  /*...............................................add card.......................................................*/

  Future<Http.Response> deleteCard(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.DELETECARD), body:map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }

  /*...............................................add card.......................................................*/

  Future<Http.Response> addCard(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.ADDCARD), body:map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }


  /*...............................................add event.......................................................*/

  Future<Http.Response> addEvent(Map<String,String> map) async {

    return await Http.post(Uri.parse(AppConstants.BASE_URL+AppConstants.ADDEVENT), body:map)
        .timeout(Duration(seconds: AppConstants.timeoutInSeconds));

  }



}