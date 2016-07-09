What's ?
===============
chef で使用する git-daemon の cookbook です。

Usage
-----
cookbook なので berkshelf で取ってきて使いましょう。

* Berksfile
```ruby
source "https://github.com/bageljp/"

cookbook "git-daemon", git: "https://github.com/bageljp/cookbook-git-daemon.git"
```

```
berks vendor
```

#### Role and Environment attributes

* sample_role.rb
```ruby
override_attributes(
  "git-daemon" => {
    "repos" => [
      "srcs",
      "docs",
    ]
  }
)
```

Recipes
----------

#### git-daemon::default
git-daemon と xinetd をインストールして設定し、リポジトリを作成します。

Attributes
----------

主要なやつのみ。

#### git-daemon::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['git-daemon']['repos']</tt></td>
    <td>array string</td>
    <td>作成する Git のリポジトリ。</td>
  </tr>
</table>

