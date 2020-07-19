# flutter-sheets
flutter application to read and write google sheets [catsheets](https://docs.google.com/spreadsheets/d/1jyKoInSV74FM7iSPGm5Pl8q-y4SwAM5uMHNkcMP2sMg/edit#gid=0)

## [Add photo sharing](https://codelabs.developers.google.com/codelabs/google-photos-sharing/#0)
Adding photo share and link into [catsheets](https://docs.google.com/spreadsheets/d/1jyKoInSV74FM7iSPGm5Pl8q-y4SwAM5uMHNkcMP2sMg/edit#gid=0)

## [Add QR Codes](https://medium.com/flutter-community/working-with-barcodes-and-qr-codes-in-flutter-fbb3a2d4ede7)
Adding QR Code for storage box scan.

## [Add Geolocation](https://pub.dev/packages/geolocator) git commit "geo working"
Adding geolocation to row data column 'where' on save

1. Add dependency in pubspec.yaml
```
dependencies:
  flutter:
    sdk: flutter
  http:
  geolocator: ^5.3.2+2
```
2. Add Import to main.dart
```
import 'package:geolocator/geolocator.dart';
```
3. Add position call which requires async to _submitForm()_ this might be wrong but it seemed to work
```
  Future<void> _submitForm() async {
    if (_formKey.currentState.validate()) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
```
## [Add Dropdown List](https://www.youtube.com/watch?v=yV5Ev_hI4Qo) based on [dropdown-list-in-flutter](http://www.coderzheaven.com/2019/04/16/dropdown-list-in-flutter/)

1. Create DropdownButton and DropdownMenuItem in UI
```
body: Center(
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0),
              child: DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    value: "Mom",
                    child: Center(
                      child: Text("Mom"),
                    ),
                  ),
```
2. onChanged sets the controller text
```
  onChanged: (_value) => {
    print(_value.toString()),
    setState(() {
      whoController.text = _value;
    }),
  },
```

## Debug catsheets
- [Google SpreadsheetApp Reference](https://developers.google.com/apps-script/reference/spreadsheet/spreadsheet-app#openById(String))
- Google foo-bars openByID - [Fix using SpreadsheetApp.open(DriveApp.getFileById(ID))](https://stackoverflow.com/questions/32077888/spreadsheetapp-openbyurl-and-openbyid-give-errors)

## [DevTools for Flutter](https://flutter.dev/docs/development/tools/devtools/overview)
1. Install via [cli](https://flutter.dev/docs/development/tools/devtools/cli)
```
flutter pub global activate devtools
```
2. Start Server
```
flutter pub global run devtools   # If you have `flutter` on your path.
```
3. Run App
```
chris@catSurface MINGW64 ~/code
$ cd catsheets/

chris@catSurface MINGW64 ~/code/catsheets
$ flutter run
Launching lib\main.dart on PH 1 in debug mode...
Running Gradle task 'assembleDebug'...                             54.0s
√ Built build\app\outputs\flutter-apk\app-debug.apk.
Installing build\app\outputs\flutter-apk\app.apk...                 5.3s
Waiting for PH 1 to report its views...                              8ms
Syncing files to device PH 1...                                    255ms

Flutter run key commands.
r Hot reload.
R Hot restart.
h Repeat this help message.
d Detach (terminate "flutter run" but leave application running).
c Clear the screen
q Quit (terminate the application on the device).
An Observatory debugger and profiler on PH 1 is available at: http://127.0.0.1:59138/pQbZfBZrqjY=/

```
4. Connect to [http://localhost:9100](http://localhost:9100) and follow instructions to connect

## catsheets based off of [Flutter App to Google Sheets](https://www.westernhomecommunities.org/)
1. Create a new blank google sheet [TC 1:28](https://youtu.be/x2CoecrzBCA?t=88)
  - [catsheets](https://docs.google.com/spreadsheets/d/1jyKoInSV74FM7iSPGm5Pl8q-y4SwAM5uMHNkcMP2sMg/edit#gid=0)
  - Put names in first row Name, Email, Phone and Feedback
2. Add script access [TC 2:14](https://youtu.be/x2CoecrzBCA?t=134)
  - Tools -> Script Editor
  - Add the following
  ```
  function doGet(request){
    var sheet = SpreadsheetApp.openById("putgooglesheetidhere");
    var result = {"status":"SUCCESS"};
    try{
      var name = request.parameter.name;
      var email = request.parameter.email;
      var phone = request.parameter.phone;
      var feedback = request.parameter.feedback;
      var rowData = sheet.appendRow([name,email,phone,feedback]);
    }catch(exe){
      result = {"status":"FAILED","message":exe};
    }
    return ContentService
      .createTextOutput(JSON.stringify(result))
      .setMimeType(ContentService.MimeType.JSON);
  }
  ```
3. Publish -> Deploy as web app [TC 10:28](https://youtu.be/x2CoecrzBCA?t=628)
  - Publish -> Deploy as web app
  - Name: catsheetsdata
  - Project Version: 
    - New "Initial catsheets web app"
    - Execute the app as: Me
    - Who has access: Anyone, even anonymous
  - Deploy
  - Use your google account
  - Advanced:
    - Go to catsheet (unsafe)
    - Allow
  - Copy web app URL string and save somewhere safe
4. Edit pubspec.yaml in catsheet project [TC 11:57](https://youtu.be/x2CoecrzBCA?t=717)
  - Add http: under dependencies
  - Click Packages get (or reload packages)
5. Create StatefulWidget (after cleanup) [TC 12:20](https://youtu.be/x2CoecrzBCA?t=740)
6. Create a Model [TC 14:28](https://youtu.be/x2CoecrzBCA?t=868)
  - in lib (right click) New -> Package -> models
  - in models (right click) New -> Dart File -> feedback_form
  - Code for feedback_form [form.dart](https://github.com/theindianappguy/flutter_google_sheets/blob/master/lib/model/form.dart)
  ```
  class FeedbackForm{
    String _name;
    String _email;
    String _phone;
    String _feedback;
    FeedbackForm(this._name,this._email,this._phone,this._feedback);
    String toParams() => "?name=$_name&email=$_email&phone=$_phone&feedback=$_feedback";
  }
  ```
7. Create a Controller [TC 19:52](https://youtu.be/x2CoecrzBCA?t=1192)
  - in lib (right click) New -> Dart File -> controller
  - Code for [controller.dart](https://github.com/theindianappguy/flutter_google_sheets/blob/master/lib/controller.dart))
  ```
  ```
8. Create a UI code [TC 33:40](https://youtu.be/x2CoecrzBCA?t=2020)
  - 
  - Code for [main.dart](https://github.com/theindianappguy/flutter_google_sheets/blob/master/lib/main.dart)
  ```
  ```


## [Flutter Test Drive](https://flutter.dev/docs/get-started/test-drive?tab=terminal)
1. Create flutter project
  ```
  chris@catSurface MINGW64 ~/code
  $ flutter create catsheets
  Creating project catsheets...
    catsheets\.gitignore (created)
    xxxx stuff deleted xxxx
  Running "flutter pub get" in catsheets...                           2.4s
  Wrote 71 files.

  All done!
  [√] Flutter: is fully installed. (Channel flutter-1.20-candidate.8, 1.20.0-8.0.pre.22, on Microsoft Windows [Version 10.0.18362.900], locale en-US)
  [√] Android toolchain - develop for Android devices: is fully installed. (Android SDK version 30.0.1)
  [√] Android Studio: is fully installed. (version 4.0)
  [√] VS Code, 32-bit edition: is fully installed. (version 1.47.0)
  [√] Connected device: is fully installed. (1 available)

  In order to run your application, type:

    $ cd catsheets
    $ flutter run

  Your application code is in catsheets\lib\main.dart.


  chris@catSurface MINGW64 ~/code
  $ ls
  catsheets/

  chris@catSurface MINGW64 ~/code
  $
  ```
  2. Run the app
    - NOTE - You will have to accept some firewall rules
  ```
  chris@catSurface MINGW64 ~/code/catsheets
  $ flutter devices
  1 connected device:

  PH 1 (mobile) • PM1LHMA7B1300416 • android-arm64 • Android 10 (API 29)

  chris@catSurface MINGW64 ~/code/catsheets
  $ flutter run
  Launching lib\main.dart on PH 1 in debug mode...

  ```
  3. View app on device, try hot reload.
    1. Edit lib/main.dart change string 'You have pushed' to 'Dude touched'
    2. Save changes
    3. Type r in terminal
    4. Verify change in app
    5. Type s for screenshot
    6. Type CNTL-C to terminate (app will still run)

## [Flutter Install Windows](https://flutter.dev/docs/get-started/install/windows)
1. Windows 10 Pro, i5, 4GB on catSurface
2. [Git for Windows](https://git-scm.com/download/win)
3. Set path to c:\src\flutter\bin
    - Search 'env' Edit environment variables for your account
    - User varibles add c:\src\flutter\bin
4. Pull down flutter
  ```cmd
  C:\src>git clone https://github.com/flutter/flutter.git -b flutter-1.20-candidate.8 
  ```
5. Run Flutter Doctor
  ```cmd
  C:\src>flutter doctor
  Checking Dart SDK version...
  Downloading Dart SDK from Flutter engine 0ec6f6c3f2551db94dd6e39124de502ae9da1418...
  Unzipping Dart SDK...
  Building flutter tool...
  Running pub upgrade...
  Downloading Material fonts...                                       0.5s
  Downloading Gradle Wrapper...                                       0.1s
  Downloading package sky_engine...                                   0.5s
  Downloading flutter_patched_sdk tools...                            1.3s
  Downloading flutter_patched_sdk_product tools...                    1.3s
  Downloading windows-x64 tools...                                    2.7s
  Downloading windows-x64/font-subset tools...                        0.5s
  Downloading android-arm-profile/windows-x64 tools...                0.4s
  Downloading android-arm-release/windows-x64 tools...                0.4s
  Downloading android-arm64-profile/windows-x64 tools...              0.4s
  Downloading android-arm64-release/windows-x64 tools...              0.4s
  Downloading android-x64-profile/windows-x64 tools...                0.5s
  Downloading android-x64-release/windows-x64 tools...                0.4s
  Doctor summary (to see all details, run flutter doctor -v):
  [√] Flutter (Channel flutter-1.20-candidate.8, 1.20.0-8.0.pre.22, on Microsoft Windows [Version 10.0.18362.900], locale
      en-US)
  [X] Android toolchain - develop for Android devices
      X Unable to locate Android SDK.
        Install Android Studio from: https://developer.android.com/studio/index.html
        On first launch it will assist you in installing the Android SDK components.
        (or visit https://flutter.dev/docs/get-started/install/windows#android-setup for detailed instructions).
        If the Android SDK has been installed to a custom location, set ANDROID_SDK_ROOT to that location.
        You may also want to add it to your PATH environment variable.

  [!] Android Studio (not installed)
  [!] VS Code, 32-bit edition (version 1.12.1)
      X Flutter extension not installed; install from
        https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
  [!] Connected device
      ! No devices available

  ! Doctor found issues in 4 categories.

  C:\src>
```
6. [Install Visual Studio Flutter Dart Code](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
7. [Install Android Studio](https://developer.android.com/studio/index.html)
  - Had issue with HAXM
  ```
    Running Intel® HAXM installer
    Failed to install Intel HAXM. For details, please check the installation log: "C:\Users\chris\AppData\Local\Temp\haxm_log.txt"
    Intel® HAXM installation failed. To install Intel® HAXM follow the instructions found at: https://software.intel.com/android/articles/installation-instructions-for-intel-hardware-accelerated-execution-manager-windows
    Installer log is located at C:\Users\chris\AppData\Local\Temp\haxm_log.txt
    Installer log contents:
    === Logging started: 7/10/2020  10:19:42 ===
    This computer does not support Intel Virtualization Technology (VT-x) or it is being exclusively used by Hyper-V. HAXM cannot be installed. 
    Please ensure Hyper-V is disabled in Windows Features, or refer to the Intel HAXM documentation for more information.

    === Logging stopped: 7/10/2020  10:19:42 ===
  ```
8. Rerun flutter doctor
  ```
  C:\src>flutter doctor
  Doctor summary (to see all details, run flutter doctor -v):
  [√] Flutter (Channel flutter-1.20-candidate.8, 1.20.0-8.0.pre.22, on Microsoft Windows [Version 10.0.18362.900], locale
      en-US)

  [!] Android toolchain - develop for Android devices (Android SDK version 30.0.1)
      X Android licenses not accepted.  To resolve this, run: flutter doctor --android-licenses
  [!] Android Studio (version 4.0)
      X Flutter plugin not installed; this adds Flutter specific functionality.
      X Dart plugin not installed; this adds Dart specific functionality.
  [√] VS Code, 32-bit edition (version 1.47.0)
  [!] Connected device
      ! No devices available

  ! Doctor found issues in 3 categories.

  C:\src>flutter doctor --android-licenses
  Warning: File C:\Users\chris\.android\repositories.cfg could not be loaded.
  7 of 7 SDK package licenses not accepted. 100% Computing updates...
  Review licenses that have not been accepted (y/N)? y
  Accept? (y/N): y
  All SDK package licenses accepted
  ```
9. Install Flutter and Dart plugin on Android Studio
10. Plugin a USB Android phone WITH Debugging turned on
11. Rerun flutter doctor
  ```
  C:\src>flutter doctor
  Doctor summary (to see all details, run flutter doctor -v):
  [√] Flutter (Channel flutter-1.20-candidate.8, 1.20.0-8.0.pre.22, on Microsoft Windows [Version 10.0.18362.900], locale
      en-US)

  [√] Android toolchain - develop for Android devices (Android SDK version 30.0.1)
  [√] Android Studio (version 4.0)
  [√] VS Code, 32-bit edition (version 1.47.0)
  [√] Connected device (1 available)

  • No issues found!

  C:\src>
  ```

### Disable Hyper-V and install Android
1. To [disable Hyper-V](https://support.microsoft.com/en-us/help/3204980/virtualization-applications-do-not-work-together-with-hyper-v-device-g) in Control Panel, follow these steps:
  - In Control Panel, select Programs and Features.
  - Select Turn Windows features on or off.
  - Expand Hyper-V, expand Hyper-V Platform, and then clear the Hyper-V Hypervisor check box. 
2. Enable [Android virtual device](https://developer.android.com/studio/run/emulator)

## [Install Flutter on MAC OS](https://flutter.dev/docs/get-started/install/macos)
NOTE: Apple foo-bar on XCode requires 10.15.6 Catalina which cannot be installed on older macs without metal.  A non-offical bios hack exist from [http://dosdude1.com](http://dosdude1.com) the [video tutorial](https://www.youtube.com/watch?v=mytdmyZNgsM) I used.  See 

1. Install [flutter from github](https://github.com/flutter/flutter)
```
catmini:~ cat$ mkdir code
catmini:~ cat$ cd code/
catmini:code cat$ git clone https://github.com/flutter/flutter.git
Cloning into 'flutter'...
remote: Enumerating objects: 15, done.
remote: Counting objects: 100% (15/15), done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 249493 (delta 2), reused 4 (delta 0), pack-reused 249478
Receiving objects: 100% (249493/249493), 106.11 MiB | 1.34 MiB/s, done.
Resolving deltas: 100% (191632/191632), done.
```
2. Add Flutter path to bashrc and bash_profile
``` 
catmini:code cat$ vi ~/.bash_
.bash_history   .bash_profile   .bash_sessions/ 
catmini:code cat$ vi ~/.bashrc 
catmini:code cat$ cat ~/.bashrc 
export PATH=$PATH:$HOME/Library/Python/2.7/bin
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/code/flutter/bin"
catmini:code cat$ 
catmini:code cat$ source /Users/cat/.bashrc 
catmini:~ cat$ cat ~/.bash_profile 

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/mysql/bin:/Users/cat/code/flutter/bin

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
catmini:~ cat$ soruce ~/.bash_profile
catmini:code cat$ which flutter
/Users/cat/code/flutter/bin/flutter
catmini:code cat$ which flutter dart
/Users/cat/code/flutter/bin/flutter
/Users/cat/code/flutter/bin/dart
```
3. Pre-download development binaries
```
catmini:code cat$ flutter precache
```
4. Run flutter doctor
```
catmini:code cat$ flutter doctor
```
  - Keep running flutter doctor and fix issue

## Mac flutter prep
1. Bios hack  [http://dosdude1.com/catalina/](http://dosdude1.com/catalina/) via  [video tutorial](https://www.youtube.com/watch?v=mytdmyZNgsM)
  - Download http://dosdude1.com/catalina/ [TC 4:07](https://youtu.be/mytdmyZNgsM?t=247)
  - Start Catalina Patcher [TC 5:39](https://youtu.be/mytdmyZNgsM?t=339)
  - Allow Patcher to run via Preferences Security [TC 6:13](https://youtu.be/mytdmyZNgsM?t=373)
  - Patcher will download a version of OS [TC 7:38](https://youtu.be/mytdmyZNgsM?t=458)
  - Patcher will build a bootable installer UIEF USB 32GB [TC 8:14](https://youtu.be/mytdmyZNgsM?t=494)
  - Once complete shutdown mac [TC 9:32](https://youtu.be/mytdmyZNgsM?t=572)
  - Reboot mac from USB stick hold option key to force USB boot [TC 9:45](https://youtu.be/mytdmyZNgsM?t=585)
  - In Recovery mode goto Disk Utility and format drive as APFS if you are running High Serria [TC 11:55](https://youtu.be/mytdmyZNgsM?t=715)
  - Reinstall MAC OSX on the targe hard drive [TC 12:33](https://youtu.be/mytdmyZNgsM?t=753)
  = Let patcher install and reboot by itself [TC 13:16](https://youtu.be/mytdmyZNgsM?t=796)
  - On the 2nd reboot hold down option to get back into Patch Recover Utilities [TC 13:35](https://youtu.be/mytdmyZNgsM?t=815) see at [TC 14:25](https://youtu.be/mytdmyZNgsM?t=865)
  - Run the MacOS Post Install in Utilites [TC 14:52](https://youtu.be/mytdmyZNgsM?t=892)
  - This should apply patches for you mac verify it detects the correct mac [TC 15:09](https://youtu.be/mytdmyZNgsM?t=909)
  - Should Reboot and run Catalina [TC 16:12](https://youtu.be/mytdmyZNgsM?t=972)
  - Might install video drivers durning first boot
  - Run the patcher updater to finish updates [TC 20:23](https://youtu.be/mytdmyZNgsM?t=1223)
  - Should be good to go now frikn Apple sucks
2. Install XCode via the AppStore
  - should be a normal install via AppStore takes a LONG TIME
  - Fire up XCode and accept stuff
  - Quit XCode
3. Install [Android Studio](https://developer.android.com/studio/) on Mac
  - Download android-studio-ide.dmg
  - Install Android Studio
  - Fire up XCode and accept stuff

## [Flutter - ios](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices) device setup
1. Install CocoaPods
```
cat@cats-Mac-mini catsheets % sudo gem install cocoapods
cat@cats-Mac-mini catsheets % pod setup
```
2. Follow Xcode signing flow
  - Open Xcode workspace in project
```
cat@cats-Mac-mini catsheets % pwd
/Users/cat/code/flutter-sheets/catsheets
cat@cats-Mac-mini catsheets % open ios/Runner.xcworkspace
```
  - Select device by run button
  - Select Runner project
  - In Runner target settings make sure Development Team is selected
  - Trust Devece and Dev Cert on Device
    - General > Device Management
  - Verify General > Indentity > Bundle Identifier is unique
3. Start flutter project
```
cat@cats-Mac-mini catsheets % flutter run
```

### Resources
- [Learn How to Save Data from Flutter App to Google Sheets | Flutter Tutorial For Beginners](https://www.youtube.com/watch?v=x2CoecrzBCA)
- [Flutter PWA Tutorial - 1/2](https://www.youtube.com/watch?v=i6GS3lCkAY8)
- [Flutter Official PWA Support - 2/2](https://www.youtube.com/watch?v=abKzgvl-Ceg)
- [Google Sheets intallable trigger](https://developers.google.com/apps-script/guides/triggers/installable)
- [DropDown And Multiple DropDown In Flutter](https://www.youtube.com/watch?v=dbcB8d8WlJo)
- [AndriodX Migration](https://flutter.dev/docs/development/androidx-migration)
- [desiprogrammer - Dropdown In Flutter](https://gitlab.com/desiprogrammer/flutter_dropdown) [Tutorial](https://youtu.be/dbcB8d8WlJo)
- [Flutter : Drop down 1](https://www.youtube.com/watch?v=0h0oNEwupUA)
- [Flutter : Drop down 2](https://www.youtube.com/watch?v=0c5lpKKtwG0)
- [DesiProgrammer - YouTube Channel](https://www.youtube.com/c/DesiProgrammer/videos)
- [tbd]()
- [tbd]()
- [tbd]()
- [tbd]()
- [tbd]()
- [tbd]()
- [tbd]()
- [git-touch - github](https://github.com/git-touch/git-touch/tree/master/lib)
- [Git services in flutter](https://flutterawesome.com/a-git-services-including-github-built-with-flutter/)
- [flutter templates](https://flutterawesome.com/tag/templates/)
- [flutter_realistic_forms](https://github.com/seenickcode/flutter_realistic_forms)
- [Uber clone with flutter](https://www.youtube.com/playlist?list=PLmnT6naTGy2TNKTW2W-twfG_gFuCtnFQF)
- [Uber clone with flutter - github](https://github.com/Santos-Enoque/uber_clone_with_flutter)

