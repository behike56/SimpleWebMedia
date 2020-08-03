# ubuntiu:latestもあり
FROM ubuntu:20.04

# 一覧の更新＆パッケージ # shellはzshに変更
RUN apt-get update -y \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends zsh \
  && apt-get -y install vim git curl wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git config --global http.sslverify true && \
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k && \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

COPY ./dot-configs .

CMD ["/usr/bin/zsh"]

# PythonとVimをインストール
RUN apt-get update -y \
    && apt-get install -y python3.8 python3.8-dev \
    && apt-get -y install vim

# 作業ディレクトリ
WORKDIR /usr/src/app

# 環境変数を設定
# Pythonがpyc filesとdiscへ書き込むことを防ぐ
# Pythonが標準入出力をバッファリングすることを防ぐ
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive

# 依存関係のインストールとpipenvをインストール
RUN apt-get update \
    && apt-get install -y curl \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && apt-get install -y python3.8-distutils \
    && python3.8 get-pip.py \
    && pip install -U pip \
    && apt-get install -y build-essential libssl-dev libffi-dev python-dev python3-dev libpq-dev

# pipenvのインストール
RUN pip install pipenv

# ローカルマシンののPipfileをコンテナにコピー
COPY Pipfile ./

# Pipfile.lockを無視してPipfileに記載のパッケージをシステムにインストール
# その後、pipenvをアンインストール
RUN pipenv install --system --skip-lock \
    && pip uninstall -y pipenv virtualenv-clone virtualenv

# RUN chmod +x ./entrypoint.sh

# シェルスクリプトをコピー
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh

COPY . /usr/src/app/

# RUN chmod +x /usr/src/app/entrypoint.sh

# シェルスクリプトを実行
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
