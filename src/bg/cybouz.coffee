class @Cybouz
  @CB_URL        : "https://www.itsol.co.jp/cgi-bin/cb6/ag.cgi"
  @CB_FOLDER_URL : "#{@CB_URL}?page=MyFolderIndex";
  @CB_CHECK_URL  : "#{@CB_URL}?page=MailCheckInterval&info=&notimecard=1";

  isCbUrl : (url) ->
    return url.indexOf(CB_URL) != -1