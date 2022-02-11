library mood_as_classes.globals;

import 'package:flutter/material.dart';
import 'package:trial0201/globals/mood/colors_of_mood.dart';
import 'package:trial0201/main.dart';
import 'package:trial0201/models/mood/blueprint_mood.dart';
import 'package:trial0201/models/mood/mood_entries.dart';
import 'package:trial0201/models/mood/mood_select.dart';
import 'package:trial0201/models/mood/moods.dart';
import 'package:trial0201/models/mood/one_mood.dart';
import 'package:trial0201/globals/mood/constants_of_mood.dart';
import 'package:trial0201/models/story/story_entry.dart';



//little number for passing the big emotion
int indexOfBigEmotion = 0;

//----
//for bottom navigation bar
int selectedIndex = 2;

List<MoodSelect> WholeMoodSelectionList = [
  happySelection,
  angrySelection,
  sadSelection,
  surpriseSelection,
  scaredSelection,
  powerfulSelection,
  peacefulSelection,
  disgustedSelection,
];

MoodSelect happySelection = MoodSelect(
  moodP: "Happy",
  color: happyMoodColor,
  moodS: [
    "excited",
    "creative",
    "playful",
    "needed",
    "wanted",
    "loved",
    "honored",
    "respected",
    "open",
    "valued",
    "optimistic",
    "cheerful",
    "pleased",
  ],
);

MoodSelect angrySelection = MoodSelect(
  moodP: "Angry",
  color: angryMoodColor,
  moodS: [
    "offended",
    "let down",
    "betrayed",
    "violated",
    "annoyed",
    "pressured",
    "aggressive",
    "mad",
    "frustrated",
    "threatened",
    "critical",
    "defensive",
    "tense",
    "jealous",
    "triggered",
  ],
);

MoodSelect sadSelection = MoodSelect(
  moodP: "Sad",
  color: sadMoodColor,
  moodS: [
    "disappointed",
    "empty",
    "grief",
    "lost",
    "bored",
    "small",
    "broken",
    "worthless",
    "fragile",
    "abandoned",
    "detached",
    "rejected",
    "not enough",
    "distant",
    "excluded",
    "lonely",
    "hurt",
    "depressed",
  ],
);

MoodSelect surpriseSelection = MoodSelect(
  moodP: "Surprised",
  color: surprisedMoodColor,
  moodS: [
    "amazed",
    "confused",
    "stunned",
    "shocked",
    "startled",
    "speechless",
    "moved",
    "amused",
  ],
);

MoodSelect scaredSelection = MoodSelect(
  moodP: "Scared",
  color: scaredMoodColor,
  moodS: [
    "inadequate",
    "stressed",
    "powerless",
    "intimidated",
    "suspicious",
    "terrified",
    "anxious",
    "excluded",
    "exposed",
    "insecure",
    "out of control",
    "vulnerable",
  ],
);

MoodSelect powerfulSelection = MoodSelect(
  moodP: "Powerful",
  color: powerfulMoodColor,
  moodS: [
    "fearless",
    "bold",
    "proud",
    "inspired",
    "focused",
    "eager",
    "sure",
    "upbeat",
    "self-assured",
    "passionate",
    "motivated",
  ],
);

MoodSelect peacefulSelection = MoodSelect(
  moodP: "Peaceful",
  color: peacefulMoodColor,
  moodS: [
    "trusted",
    "accepted",
    "warm",
    "considerate",
    "appreciated",
    "safe",
    "seen",
    "present",
    "fulfilled",
    "grateful",
    "calm",
    "loving",
    "hopeful",
  ],
);

MoodSelect disgustedSelection = MoodSelect(
  moodP: "Disgusted",
  color: disgustedMoodColor,
  moodS: [
    "guilty",
    "judgemental",
    "awful",
    "nauseated",
    "repelled",
    "ashamed",
    "embarrased",
  ],
);



List<String> displayMoods = [
  ...happySelection.moodS,
  ...sadSelection.moodS,
  ...angrySelection.moodS,
  ...surpriseSelection.moodS,
  ...scaredSelection.moodS,
  ...powerfulSelection.moodS,
  ...peacefulSelection.moodS,
  ...disgustedSelection.moodS,
];

List<String> displayMoods2 = [
  "jealous",
  "hurt",
  "furious",
  "mad",
  "triggered",

  //-------

  "scared",
  "insecure",
  "helpless",
  "anxious",

  //-------

  "romantic",
  "sentimental",
  "appreciative",

  //-------

  //JOY

  "proud",
  "cheerful",
  "peaceful",
  "pleased",

  //SURPRISE
  "amazed",
  "confused",
  "stunned",
  "shocked",

  //SAD

  "lonely",
  "disappointed",
  "miserable",
  "guilty",
  "depressed",

  //OTHER

  "empty",
  "shameful",
];

List<String> selectedDisplayMoods = [];


List<String> selectedChoicesAll = [];
List<String> moodSelection = [];

Map< DateTime,List<OneMood>> mapOfMonths = {};

final List<MoodEntry> moodEntryList2 = [];

final List<MoodEntry> moodEntryList = [
  MoodEntry(
    id: 'e1',
    dateTime: DateTime.utc(2022, 2, 05, 18, 25),
    eachMood: [
      OneMood(
        moodPrimary: PrimaryMoods.Happy,
        moodSecondary: SecondaryMoods.happy_cheerful,
        strength: 9,
        color: happyMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Peaceful,
        moodSecondary: SecondaryMoods.peaceful_calm,
        strength: 6,
        color: peacefulMoodColor,
      ),
    ],
  ),
  MoodEntry(
    id: 'e2',
    dateTime: DateTime.utc(2022, 1, 25, 16, 3),
    eachMood: [
      OneMood(
        moodPrimary: PrimaryMoods.Powerful,
        moodSecondary: SecondaryMoods.powerful_fearless,
        strength: 9,
        color: powerfulMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Surprised,
        moodSecondary: SecondaryMoods.surprised_amazed,
        strength: 8,
        color: surprisedMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Happy,
        moodSecondary: SecondaryMoods.happy_open,
        strength: 6,
        color: happyMoodColor,
      ),
    ],
  ),
  MoodEntry(
    id: 'e3',
    dateTime: DateTime.utc(2022, 1, 24, 14, 44),
    eachMood: [
      OneMood(
        moodPrimary: PrimaryMoods.Angry,
        moodSecondary: SecondaryMoods.angry_annoyed,
        strength: 3,
        color: angryMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Sad,
        moodSecondary: SecondaryMoods.sad_broken,
        strength: 2,
        color: sadMoodColor,
      ),
    ],
  ),
  MoodEntry(
    id: 'e4',
    dateTime: DateTime.utc(2022, 1, 23, 15, 3),
    eachMood: [
      OneMood(
        moodPrimary: PrimaryMoods.Peaceful,
        moodSecondary: SecondaryMoods.peaceful_grateful,
        strength: 9,
        color: peacefulMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Surprised,
        moodSecondary: SecondaryMoods.surprised_moved,
        strength: 8,
        color: surprisedMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Happy,
        moodSecondary: SecondaryMoods.happy_wanted,
        strength: 6,
        color: happyMoodColor,
      ),
    ],
  ),
  MoodEntry(
    id: 'e5',
    dateTime: DateTime.utc(2022, 1, 22, 12, 33),
    eachMood: [
      OneMood(
        moodPrimary: PrimaryMoods.Disgusted,
        moodSecondary: SecondaryMoods.disgusted_embarrased,
        strength: 9,
        color: disgustedMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Scared,
        moodSecondary: SecondaryMoods.scared_anxious,
        strength: 8,
        color: scaredMoodColor,
      ),
      OneMood(
        moodPrimary: PrimaryMoods.Angry,
        moodSecondary: SecondaryMoods.angry_let_down,
        strength: 6,
        color: angryMoodColor,
      ),
    ],
  ),
];

OneMood oneSubEmotion = OneMood(
    moodPrimary: PrimaryMoods.Happy,
    moodSecondary: SecondaryMoods.happy_cheerful,
    strength: 0,
    color: Colors.grey);

MoodEntry oneEntry = MoodEntry(id: "a1", dateTime: DateTime.now(), eachMood: []);
StoryEntry oneStoryEntry = StoryEntry(id: "a1", dateTime: DateTime.now(), eachMood: [], tags: [], title: 'New Story', story: '...');
