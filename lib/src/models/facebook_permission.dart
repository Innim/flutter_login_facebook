/// Permissions.
///
/// Represents a Graph API permission.
/// Each permission has its own set of requirements and suggested use cases.
/// See a full list at https://developers.facebook.com/docs/facebook-login/permissions
enum FacebookPermission {
  /// Provides access to a subset of items that are part of a person's public profile.
  publicProfile,

  /// Provides access the list of friends that also use your app.
  userFriends,

  /// Provides access to the person's primary email address.
  email,

  /// Provides access to a person's personal description (the 'About Me' section on their Profile)
  userAboutMe,

  /// Provides access to all common books actions published by any app the person has used.
  /// This includes books they've read, want to read, rated or quoted.
  userActionsBooks,

  /// Provides access to all common Open Graph fitness actions published by any app the person has used.
  /// This includes runs, walks and bikes actions.
  userActionsFitness,

  /// Provides access to all common Open Graph music actions published by any app the person has used.
  /// This includes songs they've listened to, and playlists they've created.
  userActionsMusic,

  /// Provides access to all common Open Graph news actions published by any app the person
  /// has used which publishes these actions.
  /// This includes news articles they've read or news articles they've published.
  userActionsNews,

  /// Provides access to all common Open Graph video actions published by any app the person
  /// has used which publishes these actions.
  userActionsVideo,

  /// Access the date and month of a person's birthday. This may or may not include the person's year of birth,
  /// dependent upon their privacy settings and the access token being used to query this field.
  userBirthday,

  /// Provides access to a person's education history through the education field on the User object.
  userEducationHistory,

  /// Provides read-only access to the Events a person is hosting or has RSVP'd to.
  userEvents,

  /// Provides access to read a person's game activity (scores, achievements) in any game the person has played.
  userGamesActivity,

  /// Provides access to a person's gender.
  userGender,

  /// Provides access to a person's hometown location through the hometown field on the User object.
  userHometown,

  /// Provides access to the list of all Facebook Pages and Open Graph objects that a person has liked.
  userLikes,

  /// Provides access to a person's current city through the location field on the User object.
  userLocation,

  /// Lets your app read the content of groups a person is an admin of through the Groups edge on the User object.
  userManagedGroups,

  /// Provides access to the photos a person has uploaded or been tagged in.
  userPhotos,

  /// Provides access to the posts on a person's Timeline. Includes their own posts, posts they are tagged in,
  /// and posts other people make on their Timeline.
  userPosts,

  /// Provides access to a person's relationship status,
  /// significant other and family members as fields on the User object.
  userRelationships,

  /// Provides access to a person's relationship interests as the interested_in field on the User object.
  userRelationshipDetails,

  /// Provides access to a person's religious and political affiliations.
  userReligionPolitics,

  /// Provides access to the Places a person has been tagged at in photos, videos, statuses and links.
  userTaggedPlaces,

  /// Provides access to the videos a person has uploaded or been tagged in.
  userVideos,

  /// Provides access to the person's personal website URL via the website field on the User object.
  userWebsite,

  /// Provides access to a person's work history and list of employers via the work field on the User object.
  userWorkHistory,

  /// Provides access to the names of custom lists a person has created to organize their friends.
  readCustomFriendlists,

  /// Provides read-only access to the Insights data for Pages, Apps and web domains the person owns.
  readInsights,

  /// Provides read-only access to the Audience Network Insights data for Apps the person owns.
  readAudienceNetworkInsights,

  /// Provides the ability to read from the Page Inboxes of the Pages managed by a person.
  readPageMailboxes,

  /// Provides the access to show the list of the Pages that you manage.
  pagesShowList,

  /// Provides the access to manage call to actions of the Pages that you manage.
  pagesManageCta,

  /// Allows your app to create, edit and delete your Page posts
  pagesManagePosts,

  /// Allows your app to read content (posts, photos, videos, events) posted by the Page
  pagesReadEngagement,

  /// Lets your app manage Instant Articles on behalf of Facebook Pages administered by people using your app.
  pagesManageInstantArticles,

  /// Provides the access to Ads Insights API to pull ads report information for ad accounts you have access to.
  adsRead
}

extension FacebookPermissionExtension on FacebookPermission {
  /// Name of permission.
  String get name => _mapToString[this];
}

final _mapToString = {
  FacebookPermission.publicProfile: "public_profile",
  FacebookPermission.userFriends: "user_friends",
  FacebookPermission.email: "email",
  FacebookPermission.userAboutMe: "user_about_me",
  FacebookPermission.userActionsBooks: "user_actions.books",
  FacebookPermission.userActionsFitness: "user_action.fitness",
  FacebookPermission.userActionsMusic: "user_actions.music",
  FacebookPermission.userActionsNews: "user_actions.news",
  FacebookPermission.userActionsVideo: "user_actions.video",
  FacebookPermission.userBirthday: "user_birthday",
  FacebookPermission.userEducationHistory: "user_education_history",
  FacebookPermission.userEvents: "user_events",
  FacebookPermission.userGamesActivity: "user_games_activity",
  FacebookPermission.userGender: "user_gender",
  FacebookPermission.userHometown: "user_hometown",
  FacebookPermission.userLikes: "user_likes",
  FacebookPermission.userLocation: "user_location",
  FacebookPermission.userManagedGroups: "user_managed_groups",
  FacebookPermission.userPhotos: "user_photos",
  FacebookPermission.userPosts: "user_posts",
  FacebookPermission.userRelationships: "user_relationships",
  FacebookPermission.userRelationshipDetails: "user_relationship_details",
  FacebookPermission.userReligionPolitics: "user_religion_politics",
  FacebookPermission.userTaggedPlaces: "user_tagged_places",
  FacebookPermission.userVideos: "user_videos",
  FacebookPermission.userWebsite: "user_website",
  FacebookPermission.userWorkHistory: "user_work_history",
  FacebookPermission.readCustomFriendlists: "read_custom_friendlists",
  FacebookPermission.readInsights: "read_insights",
  FacebookPermission.readAudienceNetworkInsights:
      "read_audience_network_insights",
  FacebookPermission.readPageMailboxes: "read_page_mailboxes",
  FacebookPermission.pagesShowList: "pages_show_list",
  FacebookPermission.pagesManageCta: "pages_manage_cta",
  FacebookPermission.pagesManagePosts: "pages_manage_posts",
  FacebookPermission.pagesReadEngagement: "pages_read_engagement",
  FacebookPermission.pagesManageInstantArticles:
      "pages_manage_instant_articles",
  FacebookPermission.adsRead: "ads_read",
};
