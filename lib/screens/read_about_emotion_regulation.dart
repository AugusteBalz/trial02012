import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ReadAboutEmotionRegulation extends StatefulWidget {
  const ReadAboutEmotionRegulation({Key? key}) : super(key: key);

  @override
  _ReadAboutEmotionRegulationState createState() =>
      _ReadAboutEmotionRegulationState();
}

class _ReadAboutEmotionRegulationState
    extends State<ReadAboutEmotionRegulation> {
  List<Map<String, String>> infoMap = [
    {
      'title': 'Why was this app created?',
      'content': 'Though there is increasing  awareness about the importance of'
          ' mental health, it is still a stigmatized topic. The Covid pandemic '
          'has caused global disruptions with serious psychological impacts, '
          'some of which have manifested in symptoms of mental health challenges for individuals.\u00B9 \n'
          '\nThis is where the idea of this application came around – to help people '
          'learn to recognise and describe their emotions better in order to help'
          ' them know themselves better and increase their mindfulness.'
    },
    {
      'title': 'What is emotion regulation?',
      'content': 'Emotion regulation is the ability to exert control over one’s '
          'own emotional state. It may involve behaviors such as rethinking a challenging '
          'situation to reduce anger or anxiety, hiding visible signs of sadness or fear, or '
          'focusing on reasons to feel happy or calm.\u00B2 '
    },
    {
      'title': 'How much can you really control your emotions?',
      'content': 'While emotions may never be completely subject to conscious '
          'control, it likely depends on which aspect of emotional experience one '
          'tries to control: One may quickly experience an intense initial negative'
          ' feeling but choose to reappraise the cause of the feeling, or accept it '
          'and let it pass, averting further distress and negative behavior.\u00B2'
    },
    {
      'title': 'What does it mean to suppress emotions?',
      'content': 'We all live with emotions that clue us '
          'in as to how we are being affected by our thoughts, memories, or '
          'current circumstances.  While extreme emotions can be overwhelming or painful, '
          'even the most unpleasant feelings serve a psychological purpose. When you '
          'choose to suppress your emotions, however, it means that you avoid allowing '
          'yourself to feel a particular emotion by either pushing it down and ignoring '
          'it, or using unhealthy coping mechanisms to distract yourself.  Unfortunately, '
          'ignoring an emotion forever is impossible, and in attempting to do so you are '
          'likely to create more tension and stress for yourself and the people around you.\u00B3',
    },
    {
      'title': 'Why emotion suppression is bad for you?',
      'content': 'This can have an adverse impact in adulthood if people still do '
          'not know how to describe and identify their emotions, simply because they '
          'were never taught how to do it and how to accept feeling anything besides '
          'pleasant emotions like happiness. Research shows that emotional suppression'
          ' may lead to numerous physical symptoms, diseases (ranging from symptoms as '
          'back pain, itchiness, to diseases like cancer)\u2074 and mental illnesses as well\u2075. ',



    },

    {
      'title': 'If emotions are such a serious thing, why are more people not talking about this?',
      'content': 'It’s probably no big surprise that many people with mental health issues don’t '
          'readily seek treatment for their concerns.\u2076 But why? It happens due to '
          'preconceived notions of seeing '
          'it as a sign of weakness or inability to cope, unwillingness to discuss the problems '
          'with someone else or they lack of background knowledge to identify and address it.\u2077',

    },

    {
      'title': 'How to practice emotional expression on your own?',
      'content': '\u2022 Check in.\n\nAsk yourself how you feel right now. If you have a hard time speaking your emotions at first, trying using words or colors in a journal or piece of art. You can even find a song that matches your mood.\n\n'
    '\u2022 Use “I” statements.\n\nPractice expressing your feelings with phrases like “I feel confused. I feel nervous. I feel terrified.”\n\n'
    '\u2022 Focus on the positive. \n\nIt might seem easier to name and embrace positive emotions at first, and that’s OK. The goal is to get more comfortable with all of your emotions, and small steps help.\n\n'
    '\u2022 Let go of judgement. \n\nNo matter what emotion you’re feeling, avoid judging yourself or telling yourself you shouldn’t feel a certain way. Instead, try finding a reason for the feeling: “I feel nervous because I’m about to have my yearly performance review.”\n\n'
          '\u2022 Make it a habit. \n\nPractice naming and sharing your emotions with the people you feel closest to. Encourage them to share their feelings, too.\n\n',
      //https://www.healthline.com/health/repressed-emotions#releasing-them
    },
    {
      'title': 'Sources',
      'content': ''
          '\u00B9 https://pubmed.ncbi.nlm.nih.gov/33464115/\n'
          '\u00B2 https://www.psychologytoday.com/us/basics/emotion-regulation\n'
          '\u00B3 https://thearbor.com/blog/what-does-it-mean-to-suppress-emotions/\n'

      '\u2074 B. P. Chapman, K. Fiscella, I. Kawachi, P. Duberstein, and P. Muennig, “Emotion suppression and mortality risk over a 12-year follow-up,” doi: 10.1016/j.jpsychores.2013.07.014.\n'
          '\u2075 J. Patel and P. Patel, “Consequences of Repression of Emotion: Physical Health, Mental Health and General Well Being,” doi: 10.14302/issn.2574-612X.ijpr-18-2564.\n'

          '\u2076 http://davidsusman.com/2015/06/11/8-reasons-why-people-dont-get-mental-health-treatment/.\n'
         '\u2077 L. H. Andrade et al., “Barriers to mental health treatment: results from the WHO World Mental Health surveys,” doi: 10.1017/S0033291713001943.\n'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 120,
          ),
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomCenter,
            stops: [
              0.1,
              0.6,
              0.9,
            ],
            colors: [
              Color(0xFF037ffc),
              Colors.indigo,
              Color(0x694c029c),
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  alignment: Alignment.center,
                  child: Text(
                    'Why should I bother to log my emotions at all?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize:25),
                  )),
              Container(
                height: 700,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: infoMap.length,
                  itemBuilder: (context, index) {

                    String? contentTemp = infoMap[index]['content'];
                    String content = (contentTemp != null) ? contentTemp : "Will be updated later...";

                    return GFAccordion(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      textStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      contentBackgroundColor: Colors.white.withOpacity(0.85),
                      expandedTitleBackgroundColor: Colors.white,

                      titlePadding: EdgeInsets.only(top:20, left:20, right: 20, bottom: 15),
                      contentPadding: EdgeInsets.only(top:15, left:20, right: 20, bottom: 25),



                      titleBorderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      contentBorderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                      title: infoMap[index]['title'],

                      contentChild: Text(content, style: TextStyle(
                        fontSize: 16
                      ),



                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
