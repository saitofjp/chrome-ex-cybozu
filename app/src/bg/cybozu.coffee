class @Cybozu
  constructor : (@cbUrl)->
    @cbFolderUrl = "#{@cbUrl}?page=MyFolderIndex";
    @cbReciveInPageUrl = "#{@cbUrl}?page=MyFolderIndex#receive";
    @cbChekcerUrl  = "#{@cbUrl}?page=MailCheckInterval&info=&notimecard=1";

  isCbUrl : (url) ->
    return url.indexOf(@cbUrl) != -1

   getChckerUrl :->
     @cbChekcerUrl

   getActiveTab : () ->
    return new Promise (resolve, reject)=>
      chrome.tabs.query {url : "#{@cbUrl}*"} , (tabs) =>
        for tab in tabs
          if tab.url? and @isCbUrl(tab.url)
            resolve(tab)
        reject()

   pageUpdated: ( callback )->
       chrome.tabs.onUpdated.addListener ( tabId, changeInfo, tab)=>
         if tab.url? && @isCbUrl(tab.url)
           callback tabId, changeInfo, tab

  openPage : ->
    @getActiveTab().then (tab)=>
        chrome.tabs.update tab.id, {
          selected: true
        }
    , =>
        chrome.tabs.create url: @cbFolderUrl

  openPageAndMailCheck : ->
    @getActiveTab().then (tab)=>
      chrome.tabs.update tab.id, {
        selected: true
        url: @cbReciveInPageUrl
      }
    , =>
      chrome.tabs.create url: @cbReciveInPageUrl

