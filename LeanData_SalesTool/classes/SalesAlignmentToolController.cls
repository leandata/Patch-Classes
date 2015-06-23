public with sharing class SalesAlignmentToolController {
  public List<Profile> profiles {get; set;}
  public Map<String, String> profileIdNameMap {get; set;}
  public List<User> users {get; set;}
  public Map<String, Integer> userCountByProfileId {get; set;}

  public SalesAlignmentToolController(){
    profiles = [Select Id, Name From Profile];
    userCountByProfileId = new Map<String, Integer>();
    profileIdNameMap = new Map<String, String>();

    List<SObject> counts = [SELECT COUNT(Id), ProfileId FROM User GROUP BY ProfileId];
    
    for (Profile p : profiles) {
      userCountByProfileId.put(p.Id, 0);
      profileIdNameMap.put(p.Id, p.Name);
    }

    for (SObject count : counts){
      userCountByProfileId.put(String.valueOf(count.get('ProfileId')), (Integer)count.get('expr0'));
    }

    users = [SELECT Id, ProfileId, Name, IsActive FROM User];
  }
}