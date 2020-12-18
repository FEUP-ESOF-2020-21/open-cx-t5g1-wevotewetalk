# openCX-*WeVoteWeTalk* Development Report

Welcome to the documentation pages of the *We Vote We Talk* of **openCX**!

You can find here detailed about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

[Afonso Caiado](https://github.com/afonsocaiado)  
[Diogo Reis Diogo](https://github.com/DiogoReisrr)  
[João Ferreira](https://github.com/joaoferreira987)  
[José Eduardo Henriques](https://github.com/Zeze35H)  
[Ricardo Cardoso](https://github.com/ricardofdc)  

---

## Product Vision

We Vote We Talk - An online event running Open Space Technology, where participants are able to join talks based on their personal interests by voting from a group of talks to then generate a schedule with the top voted topics.

---
## Elevator Pitch

Have you ever been to an online Open Space event, and your concentration and interests level are slowly but surely fading away? What better way to increase your interest in the event than to talk about what you actually want to listen to? 
That's exactly what WeVoteWeTalk does: we want to increase people's interest in an online Open Space event. 
We let people say want they want to talk about, then vote on the ideas that were given and finnaly a moderator generates a schedule that best suits all the attendant's interests so that everyone's experience in the event is surely improved!
After that the talks begin! Any user is free to enter/leave any talk at any moment. Thanks to this there are two roles that a participant can have: bumblebees and buterflies. Bumblebees fly from group to group cross-pollinating the discussions while Butterflies sit around looking relaxed.
Interesting discussions emerge around them as people find them and pause to chat.

---
## Requirements

In this section, you should describe all kinds of requirements for your module: functional and non-functional requirements.

Start by contextualizing your module, describing the main concepts, terms, roles, scope and boundaries of the application domain addressed by the project.

### Use case diagram

![Use-Cases](images/use-cases-diagram.png) 

##### Suggest Themes

* **Actor**: User
* **Description**: This use case's purpose is to allow the user to enter a theme that he would like to talk about.
* **Preconditions**: The user must have previously logged in or registered into his account for the app, and entered a conference. 
* **Postconditions**: After he suggests a theme, the theme will appear in real time in the list of suggested themes.
* **Normal Flow**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The User presses the brainstorm button to start suggesting themes.
  4. The User writes the theme he desires.
  5. The User presses the send button and the theme is suggested.
  6. The theme is added to the list of suggested themes.
* **Alternative Flows and Exceptions**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The User presses the brainstorm button to start suggesting themes.
  4. The User writes a theme that already exists in the themes list.
  5. The App rejects the theme and asks the user to rewrite.
* **Alternative Flows and Exceptions**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The Brainstorm feature was closed by the moderator.
  4. The User has to wait.

##### Vote on Themes

* **Actor**: User
* **Description**: This use case's purpose is to allow the user to vote on themes that have already been suggested by users, and approved by moderators.
* **Preconditions**: The user must have previously logged in or registered into his account for the app, and entered a conference.  
* **Postconditions**: After he votes on a theme, that theme will gain one more vote.
* **Normal Flow**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The User presses the vote button to start voting.
  4. The User likes the themes he desires to.
  5. The voted theme gains a vote.
* **Alternative Flows and Exceptions**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The User presses the vote button to start voting.
  4. The User likes the themes he desires to.
  5. The voted theme gains a vote.
  6. The User removes his like from that same theme.
  7. That theme loses a vote.
* **Alternative Flows and Exceptions**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The Voting feature was closed by the moderator.
  4. The User has to wait.

##### Join Talks

* **Actor**: User
* **Description**: This use case's purpose is to allow the user to join the talk based on the theme he desires to.
* **Preconditions**: The user must have previously logged in or registered into his account for the app, and entered a conference. 
* **Postconditions**: After he joins a talk, he can stay there for as long as it lasts, or leave whenever he wants.
* **Normal Flow**:
  1. The User logs in to his account.
  2. The User enters a conference.
  2. The User presses the Join Talks button.
  3. The User chosees the conference's theme he wants to hear or talk about.
  4. The User can (but is not obliged to) change some settings regarding the conference he is entering.
  5. The User presses the Join Meeting button.
* **Alternative Flows and Exceptions**:
  1. The User logs in to his account.
  2. The User enters a conference.
  3. The Join Talks feature isn't available because the moderator is still to make the schedule.
  4. The User has to wait.

##### Manage

* **Actor**: Moderator
* **Description**: This use case's purpose is to allow the moderator to manage everything he need to for the good functioning of the app.
* **Preconditions**: The moderator must have previously logged in or registered into his account for the app as a moderator. 
* **Postconditions**: He can decide whatever he wants to manage and take care of.
* **Normal Flow**:
  1. The Moderator logs in to his account.
  2. The Moderator creates a conference.
  3. The Moderator presses the manage button.  
      iii.i. The Moderator closes Brainstorm and Manages the suggested ideas for future voting  
      iii.ii. The Moderator closes Voting and Manages the Schedule.  
      iii.iii. The Moderator manages the Users of the app.

### User stories

#### Story 0 - Navigate the App
- **Story:** As a user, I want to login or register when I open the app to then see a Main Page and navigate around the app.
- **User Interface Mockups:**

<img src="images/story1/open_app.png" width="303" height="538"> <img src="images/story1/login.png" width="303" height="538"> <img src="images/story1/main_menu.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: User login fail
    Given I am on the login page
    When I type "valid@test.mail" in the email field
    And I type "wrongpassword" in the password field
    And I press the login button
    Then User is not logged in
```
```
  Scenario: User login
    Given I am on the login page
    When I type "valid@test.mail" in the email field
    And I type "validpassword" in the password field
    And I press the login button
    Then User is logged in
```
```
  Scenario: User register
    Given I am on the register page
    When I type "newemail@test.mail" in the email field
    And I type "newpassword" in the password field
    And I press the register button
    Then User is added to the database
```
- **Value and Effort:**
*Value:* Must have
*Effort:* 5

#### Story 1 - User interaction
- **Story:** As a participant, I want to participate on a talk so that the participants can interact with each other.
- **User Interface Mockups:**

<img src="images/story2/join_talks.png" width="303" height="538"> <img src="images/story2/choose_conf.png" width="303" height="538">
<img src="images/story2/conf_settings.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: User joins talk
    Given I am on the main menu page after entering, joining or creating a conference
    When I press the join talks button
    And I press a theme button
    And I press the join meeting button
    Then User joined a talk on jitsi
```
- **Value and Effort:**
*Value:* Must have
*Effort:* 5

#### Story 2 - Prepare conferences
- **Story:** As a moderator, I want to have access to a control panel so that I can control the flow of the conference.
- **User Interface Mockups:**

<img src="images/story3/moderator_options.png" width="303" height="538"> <img src="images/story3/manage_schedule.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: Moderator manages the schedule
    Given I am on the main menu page after entering, joining or creating a conference
    When I press the moderator options button
    And I press the close voting and manage schedule button
    Then User will be able to generate a schedule of sessions as I wish.
```
- **Value and Effort:**
*Value:* Could have
*Effort:* 10

#### Story 3 - Suggest themes
- **Story:** As a participant, I want to give my idea of a theme so that other users can vote on my idea.
- **User Interface Mockups:**

<img src="images/story4/brainstorm.png" width="303" height="538"> <img src="images/story4/suggest_themes.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: User sends theme idea
    Given I am on the main menu page after entering, joining or creating a conference
    When I press the brainstorm button
    And I type "testtheme" in the text field
    And I press the send button
    Then "testtheme" should be added to the theme list
```
- **Value and Effort:**
*Value:* Must have
*Effort:* 4

#### Story 4 - Voting
- **Story:** As a participant, I want to vote on the ideas I like the most, so that I can learn more about that topic.
- **User Interface Mockups:**

<img src="images/story5/voting.png" width="303" height="538"> <img src="images/story5/vote_on.png" width="303" height="538">
<img src="images/story5/liked.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: User votes on theme
    Given I am on the voting page
    When I press a "theme" button I like
    Then "theme" vote value should be incremented
```
- **Value and Effort:**
*Value:* Must have
*Effort:* 2

#### Story 5 - Enter / Leave Talks
- **Story:** As a participant, I want to be able to leave and enter new talks so that I'm not stuck in a talk I'm no longer interested in.
- **User Interface Mockups:**

<img src="images/story6/leave_meeting.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: User enters or leaves talk
    Given I am in a talk in jitsi
    When I press the hang up button
    Then User left a talk on jitsi
```
- **Value and Effort:**
*Value:* Must have
*Effort:* 2

#### Story 6 - Participate / Create Conferences
- **Story:** As a user, I want to participate / create in different conferences.
- **User Interface Mockups:**

<img src="images/story7/main_page.png" width="303" height="538"> <img src="images/story7/join_conf.png" width="303" height="538"> <img src="images/story7/create_conf.png" width="303" height="538"> <img src="images/story7/enter_conf.png" width="303" height="538">

- **Acceptance tests:**
```
  Scenario: User joins a conference
    Given I have logged in or registered
    When I press the join conference button
    And I insert a conference code in the conference code field
    And the conference code is valid
    And I press the Join Talk button
    Then User has entered an Open Space conference
```
```
  Scenario: Moderator creates a conference
    Given I have logged in or registered
    When I press the create conference button
    And I insert a name conference name field
    And I press the create conference button
    Then Moderator has created an Open Space conference
```
```
  Scenario: User enters a conference
    Given I have logged in or registered
    When I press the enter conference button
    And I press one of the available conference buttons
    Then User has entered that Open Space conference
```
- **Value and Effort:**
*Value:* Must have
*Effort:* 10

### Domain Model

![Domain Model](images/ProblemDomain.png) 

This project is built based on five main classes:

The **User** class represents every person that downloads and uses our application. This person can vote on any theme Idea and participate in any Session of the Conferences he knows about.

The **Moderator** is a special User. This is the person that creates a Conference and each Conference has one and only one Moderator. This person has the power to manage all the Conference related stuff.

The **Conference** is the most imortant class of our project. This makes the connection between the Users, the Ideas, the Votes and the Sessions. One Conference can have multiple Users that can give and vote on theme Ideas for the Sessions and then participate on the most voted Sessions.

The **Idea** is the Session theme. If it has enough votes there will be a Session about it.

The **Session** represents a Jitsi call where all the Users can talk to each other about the Session theme.  

## Architecture and Design

### Logical architecture

![Logical Architecture](images/LogicalArchitecture.png) 

To represent our logical architecture we use a 3-layer representation.

In the first layer we have the Data Tier which represents how information is stored. 

The second layer, the Application Tier, presents what kind of information is processed and it's flow through the application.

Finally, the third layer called Presentation Tier shows everything that the user can see and/or interact with. 

### Physical architecture

![Physical Architecture](images/PhysicalArchitecture.png) 


Our project's physical architecture uses two blocks which communicate through HTTP:
* The client side block where the Flutter app is installed.
* The server side block which contains two Firebase Services, Firebase Cloud Firestore and Firebase Authentication.

We chose Firebase due to it's pre-built authentication capabilities and due to it's real-time synchronization which is necessary for a functioning voting system.  

### Prototype

In the initial phase of our project, we were unsure on what would be our user stories. 
As we brainstormed and started having a more clear vision of what we wanted our app to look like, 
we made up our minds on the main features our app would have:
- The user being able to suggest themes
- The user being able to vote on those themes
- The user being able to enter a talk  

We then started creating user stories, while starting the implementation of the app.

The first minor setup encountered by the group was adapting to the totally new environment in Flutter and Dart
, but has we started to get more used to it, 
we started by taking care of the login and register features in our app using firebase, and then focused on the main features enlisted above.

We were able to integrate jitsi into our app, therefore being able to join existing talks. 
After taking care of the brainstorm and voting features, we started focusing on the connectivity between all these features: 
the number of fotes being visible when deciding which talk to join, being able to vote on recently suggested themes, etc.  

Afterwards, we started turning our attention to the conference side of the app.
We made implementations so that after logging in, you can either join, create (as a moderator), or enter a conference.
Inside that conference you would then find the main features we have already talked about in the beginning of the prototype section.

Finally, we focused on the moderator options in the app, and on the design side of WeVoteWeTalk.  
We created our logo (whitch we are very proud of):

![Logo](images/logo.png)

We were able to give the moderator power to close the brainstorm section, manage the given ideas and close the voting section, generate a schedule.  

We finished off by polishing any possible errors and minor bugs, to give you the best app we can!

---

## Implementation

The main product increments can be found [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t5g1-wevotewetalk/releases).

A more datailed description of the increments in our implementation can be seen in our commit history [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t5g1-wevotewetalk/commits/master).

---

## Test

Currently we have automated tests for the following features:

* User Login
* Brainstorm
* Join Talks
* Voting

All the tests are implemented using a package for flutter named [gherkin_flutter](https://pub.dev/packages/flutter_gherkin) and are completely automated. The automated tests for this features can be seen [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t5g1-wevotewetalk/tree/master/WeVoteWeTalk/we_vote_we_talk/Test).

Example of Login.feature running below.
![Gherkin](images/gherkin.png) 

---

## Configuration and change management

Configuration and change management are key activities to control change to, and maintain the integrity of, a project’s artifacts (code, models, documents).

For the purpose of ESOF, we will use a very simple approach, just to manage feature requests, bug fixes, and improvements, using GitHub issues and following the [GitHub flow](https://guides.github.com/introduction/flow/).

---

## Project management

In this project, to be able to properly manage our project we used Github Projects. 
That way we were able to register the tasks we had done, tasks we were doing and the tasks still to do. 
In addition, we were able to assign group members to each task, as well as being able to add effort estimations to each task.

Our board can be seen [here](https://github.com/FEUP-ESOF-2020-21/open-cx-t5g1-wevotewetalk/projects/1).

---

## Evolution - contributions to open-cx

To be able to add and contribute to openCX, our app provides sessions that are tailor-made for the openCX attendee.  

By brainstorming the topics they most want to talk about, and voting on the available topics, 
every attendee is able to actively participate in the creation of the conference's schedule and main topics.  

That way, the attendee only has to listen and talk about what he wants to, and can leave whenever he wants, 
therefore creating a better openCX experience.

Accordingly, we trully believe WeVoteWeTalk has the potencial to integrate the Open-CX.
