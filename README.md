# twitter_clone

```zsh
flutter pub add firebase_core
firebase login
dart pub global activate flutterfire_cli
flutterfire configure
```

User データ

ユーザー名
アイコン
プロフィール文章

投稿

ユーザーアイコン
ユーザー名
投稿日時
ツイート内容
いいね

view_model -> repository -> dbmanager
(changeNotifier)

// Dynamic Links will start with https://twitterclone-9a2bf.web.app
"appAssociation": "AUTO",
"rewrites": [ { "source": "/**", "dynamicLinks": true } ]

google-site-verification=eKDBC0wGSEZY-RgtKBLxgSOfXcOz2t78z_D5nByf6ZU

Dynamic route

yukitwitterclone.page.link

AndroidManifest.xml

```xml

 <intent-filter>
                <action android:name="android.intent.action.VIEW"/>
                <category android:name="android.intent.category.DEFAULT"/>
                <category android:name="android.intent.category.BROWSABLE"/>
                <data
                    android:host="twitterclone-9a2bf.web.app"
                    android:scheme="https"/>
            </intent-filter>

```

build.gradle

```gradle
// Import the BoM for the Firebase platform
    implementation platform('com.google.firebase:firebase-bom:31.0.3')

    // Add the dependencies for the Dynamic Links and Analytics libraries
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation 'com.google.firebase:firebase-dynamic-links'
    implementation 'com.google.firebase:firebase-analytics'

```

sha-1

cd android
./gradlew signingReport
