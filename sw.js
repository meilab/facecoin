var cacheName = "elm-pwa";
var filesToCache = [
  "./",
  "./index.html",
  "./elm.js",
  "./css/meilab.css",
  "./images/404.png",
  "./images/cover1.jpg",
  "./images/elm.png",
  "./images/favicon.ico"
];

self.addEventListener('install', function(e){
  //console.log("[Service Worker] install");
  e.waitUntil(
    caches.open(cacheName).then(function(cache){
      //console.log("[Service Worker] Caching APP Installed");
      cache.addAll(filesToCache);
    })
  );
});


self.addEventListener('activate', function(e){
  //console.log("[Service Worker] Activate");
  e.waitUntil(
    caches.keys().then(function(keyList){
      return Promise.all(keyList.map(function(key){
        if (key !== cacheName) {
          //console.log("[Service Worker] Delete old cache");
          return caches.delete(key);
        }
      }));
    })
  );

  // fix a corner case as in "your first PWA"
  return self.clients.claim();
});

self.addEventListener('fetch', function(e) {
  //console.log('[Service Worker] Fetch', e.request.url);
  var dataUrl = 'https://query.yahooapis.com/v1/public/yql';
  if (e.request.url.indexOf(dataUrl) > -1) {
    /*
     * When the request URL contains dataUrl, the app is asking for fresh
     * weather data. In this case, the service worker always goes to the
     * network and then caches the response. This is called the "Cache then
     * network" strategy:
     * https://jakearchibald.com/2014/offline-cookbook/#cache-then-network
     */
    e.respondWith(
      caches.open(dataCacheName).then(function(cache) {
        return fetch(e.request).then(function(response){
          cache.put(e.request.url, response.clone());
          return response;
        });
      })
    );
  } else {
    /*
     * The app is asking for app shell files. In this scenario the app uses the
     * "Cache, falling back to the network" offline strategy:
     * https://jakearchibald.com/2014/offline-cookbook/#cache-falling-back-to-network
     */
    e.respondWith(
      caches.match(e.request).then(function(response) {
        return response || fetch(e.request);
      })
    );
  }
});
