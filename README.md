# qiita-ansible
vagrantでansibleサーバ(work)を構築してkubernetes(master/node)を自動構築する。

## 実行手順
```
# local pc
git clone https://github.com/keita69/qiita-k8s-ha.git
cd qiita-k8s-ha
vagrant up
vagrant ssh work
# work server
cd ansible
ansible-playbook -i invently/local site.yml
```

## フォルダ構成
README.md … これ
ansible … ansibleフォルダ。[ベストプラクティスのフォルダ構成](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html#id12)参考にしている。
vagrant … Vagrantで使用する資産(provisionerのシェルなど)
Vagrantfile … Vagrant定義ファイル

## STEPの意味
* STEP1　・・・　基本設定（glusterfsや/etc/hostsの設定など）
  * /etc/hosts
  * set timezone Asia/Tokyo
  * set up glusterfs
* STEP2　・・・　kubernetesの設定

## 設計方針
* OSをはじめとするソフトウェアのバージョンが変化しない（固定）となるようにする
* インフラの役割とミドルの役割の境界を明確にする。ローカルPCだとvagrantがインフラを担務し、ansibleはミドルを担務する。
* ミドル(ansibleでの構築)はvagrant（local pc）に構築する場合と、AWSなどのクラウドに構築する場合で変更内容を最小限にする。

## インフラ(vagrant)でやっていること
* サーバの構築
  * work
  * HAProxy
  * k8s master(s)
  * k8s node(s)
* ネットワークの構築
* 各サーバのプロキシ設定
* workサーバにansibleをインストール
* workサーバにansible資産をコピー

## ミドル(ansible)でやっていること
* 全サーバで共通的な処理（/etc/hostsの設定など）
* glusterfsのインストール
* kubernetesのインストール
