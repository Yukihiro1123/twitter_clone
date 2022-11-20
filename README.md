# twitter_clone

## やること

- プロフィール画面

  - 他者のページに遷移した後フォロー/フォロワーリストがおかしくなる 優先度 \*\*

- プロフィール編集ページ

  - 投稿欄に Circle が出てこない 優先度\*

- メアド変更ページ

  - CircularProgress が出てこない -> confirmDialog で前の画面に戻るから？ 優先度\*
  - エラーメッセージの日本語化 優先度\*
  - フォームのバリデーション 優先度\*

- パスワード変更ページ

  - CircularProgress が出てこない　-> confirmDialog で前の画面に戻るから？ 優先度\*
  - エラメッセージの日本語化 優先度\*
  - フォームのバリデーション 優先度\*

## エラー集

- 投稿処理後のエラー

```zsh
  Looking up a deactivated widget's ancestor is unsafe.
  At this point the state of the widget's element tree is no longer stable.
  To safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.

```

https://zenn.dev/ryouhei_furugen/articles/2fa82ba62c88da

- 画面遷移時のエラー

```zsh
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

```
