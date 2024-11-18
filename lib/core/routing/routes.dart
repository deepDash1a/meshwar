class Routes {
  static const String startScreen = '/startScreen';

  // Auth routes
  static const String loginScreen = '/loginScreen';
  static const String askUserRole = '/askUserRole';
  static const String waitingScreen = '/waitingScreen';
  static const String captainRegister = '/captainRegister';
  static const String passengerRegister = '/passengerRegister';

  // passenger home
  static const String passengerHome = '/passengerHome';

  //  passenger home ==> carpool section
  static const String passengerCarpool = '/passengerCarpool';
  static const String passengerBuildNewCarpool = '/passengerBuildNewCarpool';
  static const String passengerBuildMyCarpools = '/passengerBuildMyCarpools';
  static const String passengerBuildMyCurrentCarpools =
      '/passengerBuildMyCurrentCarpools';
  static const String passengerBuildRateCarpool = '/passengerBuildRateCarpool';

  //  passenger home ==> personal page section
  static const String passengerPersonalPage = '/passengerPersonalPage';

  //  passenger home ==> trips page section
  static const String passengerTrips = '/passengerTrips';
  static const String passengerRequestTrips = '/passengerRequestTrips';
  static const String passengerAcceptedTrips = '/passengerAcceptedTrips';
  static const String passengerFinishedTrips = '/passengerFinishedTrips';
}
