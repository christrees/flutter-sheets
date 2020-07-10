# flutter-sheets
flutter application to read and write google sheets

## catsheets based off of [Flutter App to Google Sheets](https://www.westernhomecommunities.org/)
1. Create a new blank google sheet [TC 1:28](https://youtu.be/x2CoecrzBCA?t=88)
  - [catsheets](https://docs.google.com/spreadsheets/d/1jyKoInSV74FM7iSPGm5Pl8q-y4SwAM5uMHNkcMP2sMg/edit#gid=0)
  - Put names in first row Name, Email, Phone and Feedback
2. Add script access [TC 2:14](https://youtu.be/x2CoecrzBCA?t=134_
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
  - Name: catsheets
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
  
 
### Resources
- [Learn How to Save Data from Flutter App to Google Sheets | Flutter Tutorial For Beginners](https://www.youtube.com/watch?v=x2CoecrzBCA)
- [Flutter PWA Tutorial - 1/2](https://www.youtube.com/watch?v=i6GS3lCkAY8)
- [Flutter Official PWA Support - 2/2](https://www.youtube.com/watch?v=abKzgvl-Ceg)
- [tbd]()
- [tbd]()
- [tbd]()
- [tbd]()
