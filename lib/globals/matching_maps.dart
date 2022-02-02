library mood_as_classes.globals;

import 'package:flutter/material.dart';
import 'package:trial0201/globals/colors_of_mood.dart';
import 'package:trial0201/globals/constants_of_mood.dart';
import 'package:trial0201/models/blueprint_mood.dart';
import 'package:trial0201/models/moods.dart';



Map<PrimaryMoods, Color> primaryColors = {

  PrimaryMoods.Happy: happyMoodColor,
  PrimaryMoods.Angry: angryMoodColor,
  PrimaryMoods.Scared: scaredMoodColor,
  PrimaryMoods.Surprised: surprisedMoodColor,
  PrimaryMoods.Disgusted: disgustedMoodColor,
  PrimaryMoods.Sad: sadMoodColor,
  PrimaryMoods.Powerful: powerfulMoodColor,
  PrimaryMoods.Peaceful: peacefulMoodColor,
};


Map<PrimaryMoods, String> primaryMoodToString = {

  PrimaryMoods.Happy: "Happy",
  PrimaryMoods.Angry: "Angry",
  PrimaryMoods.Scared: "Scared",
  PrimaryMoods.Surprised: "Surprised",
  PrimaryMoods.Disgusted: "Disgusted",
  PrimaryMoods.Sad: "Sad",
  PrimaryMoods.Powerful: "Powerful",
  PrimaryMoods.Peaceful: "Peaceful",
};


ConstantsOfMood wholeList = ConstantsOfMood();

Map<String, BlueprintMood> nameToBlueprint = {
//HAPPY

  "excited": wholeList.EXCITED,
  "creative": wholeList.CREATIVE,
  "playful": wholeList.PLAYFUL,
  "needed": wholeList.NEEDED,
  "wanted": wholeList.WANTED,
  "loved": wholeList.LOVED,
  "honored": wholeList.HONORED,
  "respected": wholeList.RESPECTED,
  "open": wholeList.OPEN,
  "valued": wholeList.VALUED,
  "optimistic": wholeList.OPTIMISTIC,
  "cheerful": wholeList.CHEERFUL,
  "pleased": wholeList.PLEASED

//ANGRY

  ,
  "offended": wholeList.OFFENDED,
  "let down": wholeList.LETDOWN,
  "betrayed": wholeList.BETRAYED,
  "violated": wholeList.VIOLATED,
  "annoyed": wholeList.ANNOYED,
  "pressured": wholeList.PRESSURED,
  "aggressive": wholeList.AGGRESSIVE,
  "mad": wholeList.MAD,
  "frustrated": wholeList.FRUSTRATED,
  "threatened": wholeList.THREATENED,
  "critical": wholeList.CRITICAL,
  "defensive": wholeList.DEFENSIVE,
  "tense": wholeList.TENSE,
  "jealous": wholeList.JEALOUS,
  "triggered": wholeList.TRIGGERED

//SCARED

  ,
  "inadequate": wholeList.INADEQUATE,
  "stressed": wholeList.STRESSED,
  "powerless": wholeList.POWERLESS,
  "intimidated": wholeList.INTIMIDATED,
  "suspicious": wholeList.SUSPICIOUS,
  "terrified": wholeList.TERRIFIED,
  "anxious": wholeList.ANXIOUS,
  "exposed": wholeList.EXPOSED,
  "insecure": wholeList.INSECURE,
  "out of control": wholeList.OUT_OF_CONTROL,
  "vulnerable": wholeList.VULNERABLE

//SURPRISED

  ,
  "amazed": wholeList.AMAZED,
  "confused": wholeList.CONFUSED,
  "stunned": wholeList.STUNNED,
  "shocked": wholeList.SHOCKED,
  "startled": wholeList.STARTLED,
  "speechless": wholeList.SPEECHLESS,
  "moved": wholeList.MOVED,
  "amused": wholeList.AMUSED

//PEACEFUL

  ,
  "trusted": wholeList.TRUSTED,
  "accepted": wholeList.ACCEPTED,
  "warm": wholeList.WARM,
  "considerate": wholeList.CONSIDERATE,
  "appreciated": wholeList.APPRECIATED,
  "safe": wholeList.SAFE,
  "seen": wholeList.SEEN,
  "present": wholeList.PRESENT,
  "fulfilled": wholeList.FULFILLED,
  "grateful": wholeList.GRATEFUL,
  "calm": wholeList.CALM,
  "loving": wholeList.LOVING,
  "hopeful": wholeList.HOPEFUL

//POWERFUL

  ,
  "fearless": wholeList.FEARLESS,
  "bold": wholeList.BOLD,
  "proud": wholeList.PROUD,
  "inspired": wholeList.INSPIRED,
  "focused": wholeList.FOCUSED,
  "eager": wholeList.EAGER,
  "sure": wholeList.SURE,
  "upbeat": wholeList.UPBEAT,
  "self-assured": wholeList.SELF_ASSURED,
  "passionate": wholeList.PASSIONATE,
  "motivated": wholeList.MOTIVATED

//DISGUSTED

  ,
  "guilty": wholeList.GUILTY,
  "judgemental": wholeList.JUDGEMENTAL,
  "awful": wholeList.AWFUL,
  "nauseated": wholeList.NAUSEATED,
  "repelled": wholeList.REPELLED,
  "ashamed": wholeList.ASHAMED,
  "embarrased": wholeList.EMBARRASED

//SAD

  ,
  "disappointed": wholeList.DISAPPOINTED,
  "empty": wholeList.EMPTY,
  "grief": wholeList.GRIEF,
  "lost": wholeList.LOST,
  "bored": wholeList.BORED,
  "small": wholeList.SMALL,
  "broken": wholeList.BROKEN,
  "worthless": wholeList.WORTHLESS,
  "fragile": wholeList.FRAGILE,
  "abandoned": wholeList.ABANDONED,
  "detached": wholeList.DETACHED,
  "rejected": wholeList.REJECTED,
  "not enough": wholeList.NOT_ENOUGH,
  "distant": wholeList.DISTANT,
  "excluded": wholeList.EXCLUDED,
  "lonely": wholeList.LONELY,
  "hurt": wholeList.HURT,
  "depressed": wholeList.DEPRESSED,
};


//match secondary mood to a string

Map<SecondaryMoods, String> secondaryMoodToString = {



//HAPPY

  SecondaryMoods.happy_excited : "Excited",
  SecondaryMoods.happy_creative : "Creative",
  SecondaryMoods.happy_playful : "Playful",
  SecondaryMoods.happy_needed : "Needed",
  SecondaryMoods.happy_wanted : "Wanted",
  SecondaryMoods.happy_loved : "Loved",
  SecondaryMoods.happy_honored : "Honored",
  SecondaryMoods.happy_respected : "Respected",
  SecondaryMoods.happy_open : "Open",
  SecondaryMoods.happy_valued : "Valued",
  SecondaryMoods.happy_optimistic : "Optimistic",
  SecondaryMoods.happy_cheerful : "Cheerful",
  SecondaryMoods.happy_pleased : "Pleased",

//ANGRY

  SecondaryMoods.angry_offended : "Offended",
  SecondaryMoods.angry_let_down : "Let down",
  SecondaryMoods.angry_betrayed : "Betrayed",
  SecondaryMoods.angry_violated : "Violated",
  SecondaryMoods.angry_annoyed : "Annoyed",
  SecondaryMoods.angry_pressured : "Pressured",
  SecondaryMoods.angry_aggressive : "Aggressive",
  SecondaryMoods.angry_mad : "Mad",
  SecondaryMoods.angry_frustrated : "Frustrated",
  SecondaryMoods.angry_threatened : "Threatened",
  SecondaryMoods.angry_critical : "Critical",
  SecondaryMoods.angry_defensive : "Defensive",
  SecondaryMoods.angry_tense : "Tense",
  SecondaryMoods.angry_jealous : "Jealous",
  SecondaryMoods.angry_triggered : "Triggered",

//SCARED

  SecondaryMoods.scared_inadequate : "Inadequate",
  SecondaryMoods.scared_stressed : "Stressed",
  SecondaryMoods.scared_powerless : "Powerless",
  SecondaryMoods.scared_intimidated : "Intimidated",
  SecondaryMoods.scared_suspicious : "Suspicious",
  SecondaryMoods.scared_terrified : "Terrified",
  SecondaryMoods.scared_anxious : "Anxious",
  SecondaryMoods.scared_exposed : "Exposed",
  SecondaryMoods.scared_insecure : "Insecure",
  SecondaryMoods.scared_out_of_control : "Out of control",
  SecondaryMoods.scared_vulnerable : "Vulnerable",


//SURPRISED

  SecondaryMoods.surprised_amazed : "Amazed",
  SecondaryMoods.surprised_confused : "Confused",
  SecondaryMoods.surprised_stunned : "Stunned",
  SecondaryMoods.surprised_shocked : "Shocked",
  SecondaryMoods.surprised_startled : "Startled",
  SecondaryMoods.surprised_speechless : "Speechless",
  SecondaryMoods.surprised_moved : "Moved",
  SecondaryMoods.surprised_amused : "Amused",



//PEACEFUL

  SecondaryMoods.peaceful_trusted : "Trusted",
  SecondaryMoods.peaceful_accepted : "Accepted",
  SecondaryMoods.peaceful_warm : "Warm",
  SecondaryMoods.peaceful_considerate : "Considerate",
  SecondaryMoods.peaceful_appreciated : "Appreciated",
  SecondaryMoods.peaceful_safe : "Safe",
  SecondaryMoods.peaceful_seen : "Seen",
  SecondaryMoods.peaceful_present : "Present",
  SecondaryMoods.peaceful_fulfilled : "Fulfilled",
  SecondaryMoods.peaceful_grateful : "Grateful",
  SecondaryMoods.peaceful_calm : "Calm",
  SecondaryMoods.peaceful_loving : "Loving",
  SecondaryMoods.peaceful_hopeful : "Hopeful",



//POWERFUL

  SecondaryMoods.powerful_fearless : "Fearless",
  SecondaryMoods.powerful_bold : "Bold",
  SecondaryMoods.powerful_proud : "Proud",
  SecondaryMoods.powerful_inspired : "Inspired",
  SecondaryMoods.powerful_focused : "Focused",
  SecondaryMoods.powerful_eager : "Eager",
  SecondaryMoods.powerful_sure : "Sure",
  SecondaryMoods.powerful_upbeat : "Upbeat",
  SecondaryMoods.powerful_self_assured : "Self-assured",
  SecondaryMoods.powerful_passionate : "Passionate",
  SecondaryMoods.powerful_motivated : "Motivated",


//DISGUSTED

  SecondaryMoods.disgusted_guilty : "Guilty",
  SecondaryMoods.disgusted_judgemental : "Judgemental",
  SecondaryMoods.disgusted_awful : "Awful",
  SecondaryMoods.disgusted_nauseated : "Nauseated",
  SecondaryMoods.disgusted_repelled : "Repelled",
  SecondaryMoods.disgusted_ashamed : "Ashamed",
  SecondaryMoods.disgusted_embarrased : "Embarrased",


//SAD

  SecondaryMoods.sad_disappointed : "Disappointed",
  SecondaryMoods.sad_empty : "Empty",
  SecondaryMoods.sad_grief : "Grief",
  SecondaryMoods.sad_lost : "Lost",
  SecondaryMoods.sad_bored : "Bored",
  SecondaryMoods.sad_small : "Small",
  SecondaryMoods.sad_broken : "Broken",
  SecondaryMoods.sad_worthless : "Worthless",
  SecondaryMoods.sad_fragile : "Fragile",
  SecondaryMoods.sad_abandoned : "Abandoned",
  SecondaryMoods.sad_detached : "Detached",
  SecondaryMoods.sad_rejected : "Rejected",
  SecondaryMoods.sad_not_enough : "Not enough",
  SecondaryMoods.sad_distant : "Distant",
  SecondaryMoods.sad_excluded : "Excluded",
  SecondaryMoods.sad_lonely : "Lonely",
  SecondaryMoods.sad_hurt : "Hurt",
  SecondaryMoods.sad_depressed : "Depressed",
};