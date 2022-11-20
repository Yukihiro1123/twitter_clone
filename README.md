# twitter_clone

## やること

- ログインページ

  - 確認メール送信　優先度\*\*\*

- プロフィール画面

  - 他者のページに遷移した後フォロー/フォロワーリストがおかしくなる 優先度 \*\*\*
  - ユーザーをフォロー/解除したときに変更がすぐに反映されない 優先度\*\*\*
  - フォロー/フォロワー数　すぐ反映されない 優先度\*\*

- プロフィール編集ページ

  - 編集後にデータ（ユーザー名、bio）がすぐに反映されない 優先度\*\*\*
  - 投稿欄に Circle が出てこない 優先度\*

- メアド変更ページ

  - Circle が出てこない 優先度\*
  - エラーメッセージの日本語化 優先度\*
  - フォームのバリデーション 優先度\*

- パスワード変更ページ

  - Circle が出てこない 優先度\*
  - エラメッセージの日本語化 優先度\*
  - フォームのバリデーション 優先度\*

- go_router を用いた警告
  - 投稿データ削除時のエラーの解決

## エラー集

- 投稿データを削除する際の警告メッセージ yes を押すと、以下のエラーが出る

```zsh
The following assertion was thrown while handling a gesture:
You have popped the last page off of the stack, there are no pages left to show
'package:go_router/src/matching.dart':
Failed assertion: line 104 pos 9: '_matches.isNotEmpty'
```

- 投稿処理後のエラー

```zsh
  Looking up a deactivated widget's ancestor is unsafe.
  At this point the state of the widget's element tree is no longer stable.
  To safely refer to a widget's ancestor in its dispose() method, save a reference to the ancestor by calling dependOnInheritedWidgetOfExactType() in the widget's didChangeDependencies() method.

```

https://zenn.dev/ryouhei_furugen/articles/2fa82ba62c88da

- ログアウト後のエラー

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

- 他者ページへの遷移時のエラー

```zsh
The following _CastError was thrown building FutureBuilder<User>(dirty, state:
_FutureBuilderState<User>#f1b39):
Null check operator used on a null value

The relevant error-causing widget was:
  FutureBuilder<User>
  FutureBuilder:file:///Users/yukihiromurashima/app/flutter%20projects/twitter_clone/lib/screens/profile_screen.dar
  t:18:12

When the exception was thrown, this was the stack:
#0      ProfileScreen.build.<anonymous closure> (package:twitter_clone/screens/profile_screen.dart:21:42)
#1      _FutureBuilderState.build (package:flutter/src/widgets/async.dart:616:55)
#2      StatefulElement.build (package:flutter/src/widgets/framework.dart:4992:27)
#3      ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4878:15)
#4      StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5050:11)
#5      Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#6      ComponentElement._firstBuild (package:flutter/src/widgets/framework.dart:4859:5)
#7      StatefulElement._firstBuild (package:flutter/src/widgets/framework.dart:5041:11)
#8      ComponentElement.mount (package:flutter/src/widgets/framework.dart:4853:5)
...     Normal element mounting (36 frames)
#44     Element.inflateWidget (package:flutter/src/widgets/framework.dart:3863:16)
#45     MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:6435:36)
#46     MultiChildRenderObjectElement.mount (package:flutter/src/widgets/framework.dart:6447:32)
...     Normal element mounting (175 frames)
#221    Element.inflateWidget (package:flutter/src/widgets/framework.dart:3863:16)
#222    MultiChildRenderObjectElement.inflateWidget (package:flutter/src/widgets/framework.dart:6435:36)
#223    Element.updateChild (package:flutter/src/widgets/framework.dart:3592:18)
#224    RenderObjectElement.updateChildren (package:flutter/src/widgets/framework.dart:5964:32)
#225    MultiChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:6460:17)
#226    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#227    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#228    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5050:11)
#229    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#230    StatefulElement.update (package:flutter/src/widgets/framework.dart:5082:5)
#231    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#232    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#233    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#234    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#235    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#236    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#237    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#238    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#239    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:107:11)
#240    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#241    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:6307:14)
#242    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#243    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#244    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5050:11)
#245    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#246    StatefulElement.update (package:flutter/src/widgets/framework.dart:5082:5)
#247    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#248    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:6307:14)
#249    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#250    SingleChildRenderObjectElement.update (package:flutter/src/widgets/framework.dart:6307:14)
#251    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#252    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#253    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#254    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#255    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#256    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#257    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5050:11)
#258    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#259    StatefulElement.update (package:flutter/src/widgets/framework.dart:5082:5)
#260    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#261    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#262    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#263    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#264    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:107:11)
#265    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#266    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#267    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#268    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#269    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:107:11)
#270    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#271    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#272    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#273    StatelessElement.update (package:flutter/src/widgets/framework.dart:4956:5)
#274    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#275    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#276    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#277    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#278    _InheritedNotifierElement.update (package:flutter/src/widgets/inherited_notifier.dart:107:11)
#279    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#280    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#281    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#282    StatelessElement.update (package:flutter/src/widgets/framework.dart:4956:5)
#283    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#284    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#285    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#286    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#287    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#288    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#289    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#290    ProxyElement.update (package:flutter/src/widgets/framework.dart:5228:5)
#291    Element.updateChild (package:flutter/src/widgets/framework.dart:3570:15)
#292    ComponentElement.performRebuild (package:flutter/src/widgets/framework.dart:4904:16)
#293    StatefulElement.performRebuild (package:flutter/src/widgets/framework.dart:5050:11)
#294    Element.rebuild (package:flutter/src/widgets/framework.dart:4604:5)
#295    BuildOwner.buildScope (package:flutter/src/widgets/framework.dart:2667:19)
#296    WidgetsBinding.drawFrame (package:flutter/src/widgets/binding.dart:882:21)
#297    RendererBinding._handlePersistentFrameCallback (package:flutter/src/rendering/binding.dart:378:5)
#298    SchedulerBinding._invokeFrameCallback (package:flutter/src/scheduler/binding.dart:1175:15)
#299    SchedulerBinding.handleDrawFrame (package:flutter/src/scheduler/binding.dart:1104:9)
#300    SchedulerBinding._handleDrawFrame (package:flutter/src/scheduler/binding.dart:1015:5)
#301    _invoke (dart:ui/hooks.dart:148:13)
#302    PlatformDispatcher._drawFrame (dart:ui/platform_dispatcher.dart:318:5)
#303    _drawFrame (dart:ui/hooks.dart:115:31)

════════════════════════════════════════════════════════════════════════════════════════════════════

Another exception was thrown: setState() or markNeedsBuild() called during build.
```
