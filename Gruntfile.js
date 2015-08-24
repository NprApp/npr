module.exports = function(grunt) {

  var autoprefixer = require('autoprefixer-core');
  require('load-grunt-tasks')(grunt);

  require('time-grunt')(grunt);
  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    uglify: {
      options: {
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> */\n'
      },
      build: {
        src: 'src/<%= pkg.name %>.js',
        dest: 'build/<%= pkg.name %>.min.js'
      },
      app: {
        files: {
          "js/app.min.js": ["js/app.js"]
        }
      }
    },
    connect: {
      options: {
        port: 9000,
        // Change this to '0.0.0.0' to access the server from outside.
        hostname: 'localhost',
        livereload: 35729
      },
      livereload: {
        options: {
          open: true,
          middleware: function(connect, options) {
            if (!Array.isArray(options.base)) {
              options.base = [options.base];
            }

            // Setup the proxy
            var middlewares = [
              require('grunt-connect-proxy/lib/utils').proxyRequest,
              connect.static('.tmp'),
              connect().use(
                '/bower_components',
                connect.static('./bower_components')
              ),
              connect.static(appConfig.app)
            ];

            // Make directory browse-able.
            var directory = options.directory || options.base[options.base.length - 1];
            middlewares.push(connect.directory(directory));

            return middlewares;
          }
        }
      }
    },
    watch: {
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          'public/css/**/*.css',
          'public/js/**/*.js',
          'public/index.html'
        ]
      },
      sass: {
        files: ['src/stylesheets/**/*.sass', 'src/stylesheets/**/*.scss'],
        tasks: 'sass:dev',
      },
      coffee: {
        files: ['src/javascripts/**/*.coffee'],
        tasks: ['coffee:dev'],
      },
      ngtemplates: {
        files: ['src/javascripts/**/*.html'],
        tasks: ['ngtemplates']
      },
      postcss: {
        files: ['public/css/*.css'],
        tasks: ["postcss"]
      },
      gruntfile: {
        files: ['Gruntfile.js']
      }
    },

    sass: {
      dev: {
        options: {
          compass: true,
          lineNumbers: true
        },
        files: [{
          expand: true,
          cwd: 'src/stylesheets/',
          src: ['*.sass','*.scss'],
          dest: 'public/css',
          ext: '.css'
        }]
      },
      prod: {}
    },
    copy: {
      main: {
        files: [
          {expand: true, cwd: 'bower_components/font-awesome/', src: ['fonts/*'], dest: 'public/', filter: 'isFile'}
        ]
      }
    },
    postcss: {
      options: {
        map: {
            inline: false
        },

        processors: [
          require('autoprefixer-core')({browsers: 'last 2 versions'}), // add vendor prefixes
        ]
      },
      dist: {
        src: 'public/css/*.css'
      }
    },

    coffee: {
      dev: {
        files: {
          "public/js/app.min.js": [
            "src/javascripts/application.coffee",
            'src/javascripts/services/base.coffee',
            'src/javascripts/services/**/*.coffee',
            'src/javascripts/factories/**/*.coffee',
            'src/javascripts/directives/**/*.coffee',
            'src/javascripts/components/**/*.coffee',
            'src/javascripts/models/base.coffee',
            'src/javascripts/models/**/*.coffee',
            'src/javascripts/filters/base.coffee',
            'src/javascripts/filters/**/*.coffee',
            'src/javascripts/modules/**/*.coffee',
          ]
        }
      },
      prod: {
        files: {
          "public/js/app.js": [
            'app/assets/javascripts/core/*',
            'app/assets/javascripts/controllers/*',
            'app/assets/javascripts/models/*',
            'app/assets/javascripts/factories/*',
            'app/assets/javascripts/components/*',
            'app/assets/javascripts/directives/*',
            'app/assets/javascripts/routes/*',
            "app/assets/javascripts/application.coffee"
          ]
        }
      }
    },
    ngtemplates: {
      'npr.app': {
        cwd: 'src/javascripts',
        src: ['**/*.html'],
        dest: 'public/js/views/templates.js'
      }
    },

    concat: {
      dev: {
        src: [
          'bower_components/jquery/dist/jquery.js',
          'bower_components/angular/angular.js',
          'bower_components/angular-ui-router/release/angular-ui-router.js',
          'bower_components/angular-ui-switch/angular-ui-switch.min.js',
          'bower_components/angular-animate/angular-animate.min.js',
          'bower_components/angular-resource/angular-resource.min.js',
          'bower_components/angular-sanitize/angular-sanitize.min.js',
          'bower_components/angular-storage/build/angular-storage.min.js',
          'bower_components/angular-aside/dist/js/angular-aside.min.js',
          'bower_components/angular-cache/dist/angular-cache.min.js',
          'bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js',
          'bower_components/angular-loading-bar/build/loading-bar.min.js',
          'bower_components/angular-underscore-module/angular-underscore-module.js',
          'bower_components/restangular/dist/restangular.js',
          'bower_components/toastr/toastr.min.js',
          'bower_components/moment/min/moment-with-locales.js',
          'bower_components/jquery-mousewheel/jquery.mousewheel.min.js',
          'bower_components/perfect-scrollbar/min/perfect-scrollbar.min.js',
          'bower_components/underscore/underscore-min.js',
          'bower_components/bootstrap-sass-official/assets/javascripts/bootstrap.js',
          'bower_components/angularjs-datepicker/dist/angular-datepicker.min.js',
        ],
        dest: 'public/js/libs.js'
      },
      csslibs: {
        src: [
          'bower_components/perfect-scrollbar/min/perfect-scrollbar.min.css',
          'bower_components/fontawesome/css/font-awesome.min.css',
          'bower_components/angularjs-datepicker/dist/angular-datepicker.min.css',
          'bower_components/angular-ui-switch/angular-ui-switch.min.css',
          'bower_components/angular-loading-bar/build/loading-bar.min.css',
          'bower_components/toastr/toastr.min.css',
          'bower_components/angular-aside/dist/css/angular-aside.min.css',
        ],
        dest: 'public/css/libs.css'
      },
      prod: {
        src: ['src/libs.min/**/*.js'],
        dest: 'public/js/libs.js'
      }
    }

  });
  grunt.registerTask('default', [
    'sass:dev',
    'postcss:dist',
    'coffee:dev',
    'ngtemplates',
    'concat:dev',
    'concat:csslibs',
    'copy:main',
    'watch'
  ]);
  grunt.registerTask('build', [
    'sass:prod',
    'coffee:prod',
    'uglify:app',
    'ngtemplates',
    'concat:prod',
    'watch'
  ]);

  grunt.registerTask('css', ['sass']);

  grunt.loadNpmTasks('grunt-install-dependencies'); // auto installing dependencies
  grunt.loadNpmTasks('grunt-connect-proxy'); // proxy
  grunt.loadNpmTasks('grunt-shell-spawn'); // rails starting
  grunt.loadNpmTasks('grunt-exec');
  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-jsbeautifier');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-angular-templates');
  grunt.loadNpmTasks('grunt-postcss');


};
