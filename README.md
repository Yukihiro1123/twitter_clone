# twitter_clone

- いいねした投稿リスト表示（終了）

## やること

- 投稿データの削除（ユーザーが自分の時のみ）

- 他者ページへの遷移

- フォロー、フォロー解除

- メールアドレス・パスワード変更

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

## エラー

https://zenn.dev/ryouhei_furugen/articles/2fa82ba62c88da

══╡ EXCEPTION CAUGHT BY WIDGETS LIBRARY ╞═══════════════════════════════════════════════════════════
The following \_CastError was thrown building ProfilePage(dirty, dependencies: [InheritedGoRouter]):
Null check operator used on a null value

The relevant error-causing widget was:
ProfilePage
ProfilePage:file:///Users/yukihiromurashima/app/flutter%20projects/twitter_clone/lib/screens/home_screen.dart:23:
13

When the exception was thrown, this was the stack:
#0 ProfileViewModel.currentUser (package:twitter_clone/view_models/profile_view_model.dart:22:53)
#1 ProfileViewModel.setProfileUser (package:twitter_clone/view_models/profile_view_model.dart:26:19)
#2 ProfilePage.build (package:twitter_clone/view/profile/profile_page.dart:23:22)
#3 StatelessElement.build (package:flutter/src/widgets/framework.dart:4949:49)
#4 ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4878:15)
#5 Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#6 BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:2667:19)
#7 WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:882:21)
#8 RendererBinding.\_handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:378:5)
#9 SchedulerBinding.\_invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1175:15)
#10 SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1104:9)
#11 SchedulerBinding.\_handleDrawFrame (package:flutter/src/scheduler/binding.dart:1015:5)
#12 \_invoke (dart:ui/hooks.dart:148:13)
#13 PlatformDispatcher.\_drawFrame (dart:ui/platform_dispatcher.dart:318:5)
#14 \_drawFrame (dart:ui/hooks.dart:115:31)

════════════════════════════════════════════════════════════════════════════════════════════════════
[VERBOSE-2:dart_vm_initializer.cc(41)] Unhandled Exception: 'package:cloud_firestore/src/query.dart': Failed assertion: line 712 pos 11: '(value as List).isNotEmpty': 'in' filters require a non-empty [List].
#0 \_AssertionError.\_doThrowNew (dart:core-patch/errors_patch.dart:51:61)
#1 \_AssertionError.\_throwNew (dart:core-patch/errors_patch.dart:40:5)
#2 \_JsonQuery.where (package:cloud_firestore/src/query.dart:712:11)
#3 DatabaseManager.getLikePosts (package:twitter_clone/models/db/database_manager.dart:139:10)
<asynchronous suspension>
#4 ProfileViewModel.getLikePosts (package:twitter_clone/view_models/profile_view_model.dart:40:17)
<asynchronous suspension>
