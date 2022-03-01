#latest:最新のフルパッケージ。:
#slim:使用頻度の低いツールやライブラリを除外した最小パッケージ。:
#alpine:シンプル軽量なAlpine Linuxベースで構築された超軽量イメージ。:Alpine Linux
#bullseye:Debian11で構築されたイメージ。:Debian(v11)
#bullseye-slim:Debian11で構築されたイメージ。使用頻度の低いツールを除外した最小パッケージ。:Debian(v11)
#buster:Debian10で構築されたイメージ。:Debian(v10)
#buster-slim:Debian10で構築されたイメージ。使用頻度の低いツールを除外した最小パッケージ。:Debian(v10)
#stretch:Debian9で構築されたイメージ。:Debian(v9)
#stretch-slim:Debian9で構築されたイメージ。使用頻度の低いツールを除外した最小パッケージ。:Debian(v9)
#jessie:Debian8で構築されたイメージ。:Debian(v8)
#jessie-slim:Debian8で構築されたイメージ。使用頻度の低いツールを除外した最小パッケージ。:Debian(v8)
#windowsservercore:Windows用サーバー系OSで構築したイメージ。:Windows
FROM golang:1.17.7-bullseye
# Visual Studio Code Remote Development 拡張機能がデフォルトで開くディレクトリ
WORKDIR /workspace
# Visual Studio Code でコードのフォーマットや Lint などの支援を受けるのに必要なモジュール
# モジュール未インストール時に Visual Studio Code を開き、次のコマンドで一覧表示されたもの
# Ctrl + Shift + P -> Go: Install/Update Tools
RUN go get github.com/uudashr/gopkgs/v2/cmd/gopkgs
RUN go get github.com/ramya-rao-a/go-outline
RUN go get github.com/cweill/gotests/...
RUN go get github.com/fatih/gomodifytags
RUN go get github.com/josharian/impl
RUN go get github.com/haya14busa/goplay/cmd/goplay
RUN go get github.com/go-delve/delve/cmd/dlv
# div-dap(デバッグアダプタ) のインストール方法は次のドキュメントを参考にしましたらしい
# https://github.com/golang/vscode-go/blob/v0.26.0/docs/dlv-dap.md#updating-dlv-dap
RUN GOBIN=/tmp/ go get github.com/go-delve/delve/cmd/dlv@master \
 && mv /tmp/dlv $GOPATH/bin/dlv-dap
RUN go get github.com/golangci/golangci-lint/cmd/golangci-lint
RUN go get golang.org/x/tools/gopls