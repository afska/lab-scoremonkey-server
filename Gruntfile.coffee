"use strict"

require("coffee-script/register")
#[^] last version of coffee

module.exports = (grunt) ->
  #-------
  #Plugins
  #-------
  require("load-grunt-tasks") grunt

  #-----
  #Tasks
  #-----
  grunt.registerTask "default", "server"

  grunt.registerTask "server", "nodemon"
  grunt.registerTask "test", "mochaTest"
  grunt.registerTask "build", ["clean:build", "coffee", "clean:specs"]

  #------
  #Config
  #------
  grunt.initConfig
    # Clean build directory
    clean:
      build: src: "build"
      specs: src: "build/*.spec.js"

    # Run server and watch for changes
    nodemon:
      dev:
        script: "main.js"
        options:
          ext: "js,coffee"

    # Compile coffee
    coffee:
      compile:
        expand: true
        cwd: "#{__dirname}/src"
        src: ["**/{,*/}*.coffee"]
        dest: "build/"
        rename: (dest, src) ->
          dest + "/" + src.replace(/\.coffee$/, ".js")

    # Run tests
    mochaTest:
      options:
        reporter: "spec"
      src: ["src/**/*.spec.coffee"]
