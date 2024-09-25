# ベースイメージはRubyを使用
FROM ruby:3.1.4

# 環境変数設定
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

# 必要なパッケージをインストール
RUN apt-get update -qq \
  && apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  python3 \
  python3-pip

# Node.js と Yarn のキーを追加
RUN mkdir -p /etc/apt/keyrings \
  && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
  && NODE_MAJOR=18 \
  && wget --quiet -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# 再度apt-getを更新し、Ruby on Railsプロジェクトに必要なパッケージをインストール
RUN apt-get update -qq \
  && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

# Pythonライブラリのインストール
RUN pip3 install --break-system-packages yfinance

# 作業ディレクトリを作成
RUN mkdir /yfinance
WORKDIR /yfinance

# bundlerのインストール
RUN gem install bundler


# GemfileおよびGemfile.lockをコピーし、bundle installを実行
COPY Gemfile /yfinance/Gemfile
COPY Gemfile.lock /yfinance/Gemfile.lock
RUN gem install bundler
RUN bundle install

# yarn.lockをコピーし、yarn installを実行
COPY yarn.lock /yfinance/yarn.lock
RUN yarn install

# プロジェクトの全ファイルをコピー
COPY . /yfinance

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000", "ruby", "import_data.rb"]
