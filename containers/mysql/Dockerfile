FROM mysql
#ポート
EXPOSE 3306
#MySQL設定ファイルのコピー
COPY ./my.cnf /etc/mysql/conf.d/my.cnf
#docker runで実行
CMD ["mysqld"]
