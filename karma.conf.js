module.exports = function(config){
  config.set({

    basePath : './',

    files : [
      'public/js/libs.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'public/js/app.min.js',
      'public/js/views/templates.js',
      'test/**/*_test.js'
    ],

    autoWatch : true,

    frameworks: ['jasmine'],

    browsers : ['Chrome'],

    plugins : [
            'karma-chrome-launcher',
            'karma-firefox-launcher',
            'karma-jasmine',
            'karma-junit-reporter'
            ],

    junitReporter : {
      outputFile: 'test_out/unit.xml',
      suite: 'unit'
    }

  });
};
