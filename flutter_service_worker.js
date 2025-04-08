'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "01750418ce018f506b7a4ebad484b58d",
"assets/AssetManifest.bin.json": "b08c37c653f32e8f0800ac738102d78b",
"assets/AssetManifest.json": "bb20d9a16f34f88fa6d48c9d2b766b3e",
"assets/assets/cv-game.png": "2e63f524faaf03d2000efbcb50b6a81b",
"assets/assets/cv.png": "c6154fd23f30b432582047d32082da56",
"assets/assets/icons/app_store.png": "3cdc9974de0026e915b4cfb4336a1ab6",
"assets/assets/icons/book.png": "d9d529b4578eab5ea2a0e7e33685cecb",
"assets/assets/icons/flutter.png": "4434036275ba8db1b066957a361cbdb0",
"assets/assets/icons/game.png": "4c68bd1d08b3fc2b11d89934acef8857",
"assets/assets/icons/github.png": "63de5479e8eb4676570c49e2579cab01",
"assets/assets/icons/google_play.png": "90139a15af0287b014b3a8a51a5195e9",
"assets/assets/icons/linkedin.png": "dbce0cfd7ae44f852e206c24bb8c4318",
"assets/assets/icons/phone.png": "07a9dce226e6e930853ab55ed1dce0c3",
"assets/assets/icons/suitcase.png": "3868f67d6d9004fe386efb1de7ee71a1",
"assets/assets/icons/unity.png": "a7cdbf65fb14c049f4805d7cf1feb2af",
"assets/assets/images/apps/collector-1.png": "69e799d7998d46c06bf839b1ecd0e808",
"assets/assets/images/apps/daysayar-1.png": "625e50847d7b94883fb3d4e41d78c8cc",
"assets/assets/images/apps/daysayar-2.png": "a2ea4284ad604b8074143c1790923766",
"assets/assets/images/apps/daysayar-3.png": "72aeb0f23c371a0fc241b61c86b42db7",
"assets/assets/images/apps/daysayar-4.png": "2014ae21a595c45bed7bb4a6aeed3392",
"assets/assets/images/apps/daysayar-5.png": "a1cc2e7e7e7b7502d8e1e10b9d0df7d1",
"assets/assets/images/apps/macrodata-1.png": "7dddeaa4d618de2fe4a003a821185d62",
"assets/assets/images/apps/macrodata-2.png": "494020181cb84af7420e74dc946a4c3b",
"assets/assets/images/apps/macrodata-3.png": "c84c4603e238df1de9b8a1541d94f13e",
"assets/assets/images/apps/macrodata-4.png": "d9382aada3e959c69352c2b9b6c66dd1",
"assets/assets/images/apps/macrodata-5.png": "0dae746d04b6894dc8de40b7b2b36a52",
"assets/assets/images/apps/macrodata-6.png": "5a2b467d1f7d6de6b2e111a0360342c9",
"assets/assets/images/apps/taskmanager-1.png": "5c8ef8f65d0bdfa6384c71faecd90f34",
"assets/assets/images/apps/taskmanager-2.png": "46470322aab445c62f97b6dd2029be54",
"assets/assets/images/apps/taskmanager-3.png": "aa1b733541c782eb501b456ff32c15b8",
"assets/assets/images/apps/taskmanager-4.png": "b05cce279bc49e58b00dae848bebdc9a",
"assets/assets/images/apps/taskmanager-5.png": "6a4c3574f18d85fafd4b41629e0e5957",
"assets/assets/images/apps/taskmanager-6.png": "0eadccdec5c4cb2a9811924c5978e3b0",
"assets/assets/images/apps/tekx-1.png": "4c7d92f1b1fdffe1a4de725c186343a3",
"assets/assets/images/apps/yaren-1.png": "92981228d7a722875bf58df5a7863777",
"assets/assets/images/games/angrybird-1.png": "cadeafaffa3f7fb2165f2681a5d33f38",
"assets/assets/images/games/platformer-1.png": "3123da1543c67c3d76d52dd498d66b9b",
"assets/assets/images/games/skw-1.png": "b9e7dc9f4127d5d9028616259bc92efe",
"assets/assets/images/games/zrd-1.png": "cdcae23c1c5058e7bc8e779628e90375",
"assets/assets/images/games/zrd-2.png": "4464a7b7f2adadd2be6b62c39e17a4bf",
"assets/assets/images/games/zrd-3.png": "bc0c0b9dd48cd2fa76c60869c818a3f1",
"assets/assets/images/games/zrd-4.png": "b14cfc1d3fec6277dc44c365d95e6869",
"assets/assets/profileImage.png": "29f576197df372f56ec88c282da607b0",
"assets/FontManifest.json": "3ddd9b2ab1c2ae162d46e3cc7b78ba88",
"assets/fonts/MaterialIcons-Regular.otf": "78cb3e4a29b53d7378192d4527ec5690",
"assets/NOTICES": "0a390189d033e16e368e19b43f38f5a5",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "86e461cf471c1640fd2b461ece4589df",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/chromium/canvaskit.js": "34beda9f39eb7d992d46125ca868dc61",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206",
"favicon.png": "aac8f800388f6286151cd6217ee77447",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"flutter_bootstrap.js": "7a46ff0e043eae84e6e96a8ec7b8b6dd",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "3c399803c894840550f9dfe2dccb23a8",
"/": "3c399803c894840550f9dfe2dccb23a8",
"main.dart.js": "1d13d38e79bc17d5fecd0f897d4ed975",
"manifest.json": "07f66434d604ccac1b4d5244f35598aa",
"version.json": "1b7d813ce4f4cc6a66848ef373c7957d"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
