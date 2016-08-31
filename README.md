# Schnellreferenz

Dieses Repository beinhaltet die Sources für die Webseite [capoeira-trier.de](http://www.capoeira-trier.de). Diese basiert auf dem Framework [Foundation 5](http://foundation.zurb.com/sites/docs/v/5.5.3/).

## Branches

Dieses Repository besteht aus den folgenden Branches

+ **master**, der die SASS- und Jade-Quelltexte  beinhaltet.
+ **gh-pages**, der die publizierte Webseite mit Assets, transpilierten Sources und zugehörigen Bibliotheken beinhaltet.

## Gulp-Tasks

+ **build** baut die Webseite (jade, sass,images)
+ **watch** baut die Webseite und überwacht die SASS- und Jade-Quelltexte mithilfe von [gulp-server-livereload](https://github.com/hiddentao/gulp-server-livereload). Die lokale Adresse lautet: http://localhost:8000
+ **deploy** veröffentlicht die Website durch das Verschieben der transpilierten Sources aus dem Verzeichnis `public` in den Branch **gh-pages**

## Workflow

1. Repository clonen
2. `gulp watch`
3. Sources manipulieren, Images hinzufügen, etc...
4. `git add`, `git commit` & `git push`
5. `gulp deploy`

**Hinweis**: `gulp deploy` legt ausschließlich eine Kopie der transpilierten HTML, CSS, etc. Quelldateien in den Branch `gh-pages`. Die Sourcedateien müssen bei Änderungen daher noch mal explizit mittels `git push` in den Branch **master** abgelegt werden.