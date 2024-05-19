 <h1>RS Skill Test App</h1>

## Getting Started

To get started with RS Skill Test App, follow these simple steps:

## Pre-installation Requirements

Windows 10 operating system installed (Flutter will work on Windows 7 SP1 and later versions).

At least 1.65 GB of free disk space (Additional free storage is needed for other tools and IDEs, if not already installed).

Windows Powershell 5.0 or newer.

Git for Windows version 2.0 or newer (Optional).

Android Studio installed.

Visual Studio 2022 with C++ (Optional).

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

Run Flutter doctor

The flutter doctor command validates that all components of a complete Flutter development environment for Windows.

    Open PowerShell.

    To verify your installation of all the components, run the following command.

    C:> flutter doctor