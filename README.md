# twitter_clone

## やること

他者ページに遷移する際に自分がそのユーザーをフォローしているか判定する処理を行う
フォローした直後に

村島 1 -> 村島 2 をフォローしたあと村島 3 をフォロー
村島 2 -> 村島 3 をフォローしたあと村島 1 をフォロー
村島 3 -> 村島 1 をフォローしたあと村島 2 をフォロー

- プロフィール画面

  - フォロー・フォロワーがすぐ反映されない　優先度 \*\*\*
  - 他者のページに遷移した後フォロー/フォロワーリストがおかしくなる 優先度 \*\*\*

- メアド変更ページ

  - CircularProgress 優先度\*
  - エラーメッセージの日本語化 優先度\*
  - フォームのバリデーション 優先度\*

- パスワード変更ページ

  - CircularProgress 優先度\*
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
EXCEPTION CAUGHT BY WIDGETS LIBRARY
Null check operator used on a null value


```
