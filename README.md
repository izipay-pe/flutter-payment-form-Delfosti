<h1>
Flutter payment form example
</h1>
The aim of this repository is to explain how the payment redirection form through a web view mobile can be done easily.

## How it works
* A mobile app with a webview mobile payment redirection form integration: this repository explains this integration!
* A merchant server that executes payments transactions with the payment servers: [merchant server repository](https://github.com/lyra/webview-payment-sparkjava-integration-sample)

## Configuration before run
To run the example of the app, you have to configure the flutter environment

1.[Install Flutter](https://flutter.dev/docs/get-started/install)

Follow the instructions of the official Flutter documentation and at the end, run this command to ensure the installation:
`flutter doctor`

2.[Install Android Studio](https://developer.android.com/studio/install)

Follow the instructions of the official Android Studio documentation. After that, you need to link Flutter and Android Studio; you can run this command to do that:
`flutter config --android-studio-dir <path where you install android studio>`

3.Update Google Chrome

You need to update Google Chrome to the most recent version, in order to advoid errors in the web view, you can download the APK from this link: [Google Chrome APK v93-0-4577](https://www.apkmirror.com/apk/google-inc/chrome/chrome-93-0-4577-62-release/google-chrome-fast-secure-93-0-4577-62-6-android-apk-download/download/?forcebaseapk)
However you can research and install the most recent Internet Browser that you want.

To install the APK, you need to have an emulator already running, drag and drop the APK that you download to the emulator, wait to be installed and when it's finished, close the emulator and do a cold boot to run the emulator, so the changes can be reflected.

## Run the application
1.Clone the repository

`git clone https://git.lbg.office.fr.lyra/examples/flutter-payment-form-examples.git`

2.Install de dependencies of the project

`flutter get pub`

3.Open the project under Android Studio and run it in your preferred device

