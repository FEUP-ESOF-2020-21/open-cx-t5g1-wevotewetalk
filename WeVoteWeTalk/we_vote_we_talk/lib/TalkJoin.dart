import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/room_name_constraint.dart';
import 'package:jitsi_meet/room_name_constraint_type.dart';

import 'Database.dart';
import 'Shared/Banned.dart';
import 'Shared/Conference.dart';
import 'Shared/Loading.dart';

class TalkJoin extends StatefulWidget {
  final String talk;
  final user_id;
  final talk_id;
  TalkJoin({this.talk,this.user_id, this.talk_id});
  @override
  _TalkJoinState createState() => _TalkJoinState(user_id: this.user_id, talk_id: this.talk_id);
}

class _TalkJoinState extends State<TalkJoin> {

  final user_id;
  final talk_id;

  _TalkJoinState({this.user_id, this.talk_id});

  final serverText = TextEditingController();
  final roomText = TextEditingController();
  final subjectText = TextEditingController();
  final nameText = TextEditingController();
  final emailText = TextEditingController();
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    roomText.text = widget.talk.replaceAll(new RegExp(r"\s+"), "");
    roomText.text += "_WVWT";
    return StreamBuilder<ConferenceData>(
        stream: DatabaseService(user_id, talk_id).conferenceData,
        builder: (context, snapshot) {
          if(snapshot.hasData)
          {
            ConferenceData conferenceData = snapshot.data;
            if(!conferenceData.isBanned(user_id))
            {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Join A Session"),
                  backgroundColor: Color(0xFF106799),
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Joining " + widget.talk,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25.0, color: Color(0xFF106799)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        TextField(
                          controller: nameText,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Text Chat Username (Optional)",
                          ),
                        ),
                        /*
                  SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                    controller: emailText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                    ),
                  ),
                   */
                        SizedBox(
                          height: 16.0,
                        ),
                        CheckboxListTile(
                          title: Text("Audio Only"),
                          value: isAudioOnly,
                          onChanged: _onAudioOnlyChanged,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        CheckboxListTile(
                          title: Text("Audio Muted"),
                          value: isAudioMuted,
                          onChanged: _onAudioMutedChanged,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        CheckboxListTile(
                          title: Text("Video Muted"),
                          value: isVideoMuted,
                          onChanged: _onVideoMutedChanged,
                        ),
                        Divider(
                          height: 48.0,
                          thickness: 2.0,
                        ),
                        SizedBox(
                          height: 64.0,
                          width: double.maxFinite,
                          child: RaisedButton(
                            onPressed: () {
                              _joinMeeting();
                            },
                            child: Text(
                              "Join Meeting",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Color(0xFF106799),
                          ),
                        ),
                        SizedBox(
                          height: 48.0,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            else
              return Banned();
          }
          else
            return Loading();
      }
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
