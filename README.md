# twitter_clone

- いいねした投稿リスト表示（終了）

## やること

- いいねページの作成

- メールアドレス・パスワード変更

- 投稿データの削除（ユーザーが自分の時のみ）

## ひとまず後回し

- 認証（確認メール送信）

- プロフィール編集（編集後にデータがすぐに反映されない）

## メモ

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

sha-1 を取得するのに用いるコマンド

cd android
./gradlew signingReport

https://zenn.dev/ryouhei_furugen/articles/2fa82ba62c88da
