 <h1>RS Skill Test App</h1>

## Getting Started

To get started with RS Skill Test App, follow these simple steps:

## Install Flutter on Windows

[download](https://docs.flutter.dev/get-started/install/windows) the Flutter SDK package by clicking on the following button on the webpage.
When finished, the Flutter SDK should be in the C:\user\{username}\dev\flutter directory.

Update your Windows PATH variable

    Press Windows + Pause.

    If your keyboard lacks a Pause key, try Windows + Fn + B.

    The System > About dialog displays.

    Click Advanced System Settings > Advanced > Environment Variables...

    The Environment Variables dialog displays.

    In the User variables for (username) section, look for the Path entry.

        If the entry exists, double-click on it.

        The Edit Environment Variable dialog displays.

            Double-click in an empty row.

            Type %USERPROFILE%\dev\flutter\bin.

            Click the %USERPROFILE%\dev\flutter\bin entry.

            Click Move Up until the Flutter entry sits at the top of the list.

            Click OK three times.

        If the entry doesn't exist, click New....

        The Edit Environment Variable dialog displays.

            In the Variable Name box, type Path.

            In the Variable Value box, type %USERPROFILE%\dev\flutter\bin

            Click OK three times.

    To enable these changes, close and reopen any existing command prompts and PowerShell instances.

1. **Clone the Repository:**

   ```shell
   git clone https://github.com/Sayeed-Maheen/Git-Glimpse.git

2. **Install Dependencies:**

   ```shell
   cd RetinaSoft-Skill-Test-App
   
   flutter pub get

3. **Run the App:**

   ```shell
   flutter run