gulp = require('gulp')
plumber = require('gulp-plumber')
bower = require('gulp-bower')
sass = require('gulp-sass')
jade = require('gulp-jade')
rename = require('gulp-rename')
image = require('gulp-image')
livereload = require('gulp-livereload')
del = require('del')
ghPages = require('gulp-gh-pages')

paths =
  bower:  'bower_components/'
  jade:   'jade/'
  sass:   'sass/'
  images: 'img/'
  data:   'data/'
  public: 'public/'
  publicJS:     'public/js/'
  publicCSS:    'public/css/'
  publicFonts:  'public/fonts/'
  publicImages: 'public/img/'

files =
  jade:   "#{paths.jade}[^_]*.jade"
  sass:   "#{paths.sass}*.sass"
  data:   "#{paths.data}*.coffee"
  images: "#{paths.images}*"
  public: "#{paths.public}**/*"

gulp.task 'clean', (cb) ->
  del paths.public, cb

gulp.task 'install', ['clean'], ->
  bower()

gulp.task 'copy', ['install'], ->
  # js
  gulp.src [
    "#{paths.bower}foundation/js/foundation.min.js"
    # deprecated:
    "#{paths.bower}bootstrap-sass/assets/javascripts/bootstrap.min.js"
    "#{paths.bower}jquery/dist/jquery.min.js"
  ]
    .pipe gulp.dest(paths.publicJS) 
  # images
  gulp.src files.images
    .pipe image()
    .pipe gulp.dest(paths.publicImages)
  # fonts
  gulp.src "#{paths.bower}bootstrap-sass/assets/fonts/bootstrap/*"
    .pipe gulp.dest(paths.publicFonts)

gulp.task 'build', ['copy'], ->
  # jade & sass
  gulp.tasks.jade.fn()
  gulp.tasks.sass.fn()

gulp.task 'jade', ->
  # static jade files
  gulp.src files.jade
  .pipe plumber()
  .pipe jade()
  .pipe gulp.dest(paths.public)
  .pipe livereload()

  # # jade tempaltes
  # data = require("./#{paths.data}personen.coffee")
  # # personen
  # for id, person of data.personen
  #   params =
  #     locals: person
  #     cache: false
  #   gulp.src("#{paths.jadeTemplates}person.jade")
  #     .pipe(jade(params))
  #     .pipe(rename("#{id}.html"))
  #     .pipe(gulp.dest(paths.public))
  # # instutut
  # params =
  #   locals: data
  #   cache: false
  # gulp.src("#{paths.jadeTemplates}institut.jade")
  #   .pipe(jade(params))
  #   .pipe(gulp.dest(paths.public))

gulp.task 'sass', ->
  params =
    outputStyle: 'compressed' 
  gulp.src files.sass
    .pipe plumber()
    .pipe sass(params)
    .pipe gulp.dest(paths.publicCSS)
    .pipe livereload()

gulp.task 'watch', ['build'], ->
  livereload.listen()
  gulp.watch [files.jade, files.data], ['jade']
  gulp.watch files.sass, ['sass']

gulp.task('deploy', ['build'],  ->
  gulp.src files.public 
    .pipe ghPages()
) # deploy