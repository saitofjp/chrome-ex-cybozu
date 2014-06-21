module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        expand: true
        cwd: "."
        src: "app/src/**/*.coffee"
        dest: "."
        ext: ".js"
        extDot :"last"
        
        
  grunt.registerTask 'buildConfig', ->
    configJson = grunt.file.readJSON('app/chrome_config.json')
    manifest = {
      dest : "app/manifest.json"
      template : grunt.file.read('app/manifest.tpl.json')
    }
    manifestJsonText = grunt.template.process(manifest.template, {data  : configJson  })
    grunt.file.write(manifest.dest, manifestJsonText)

    configJs = {
      dest :  "app/chrome_config.json.js"
      template : "var config =<%= config %>;"
    }
    configJsText = grunt.template.process(configJs.template, {data  : {config : JSON.stringify(configJson.config)} });
    grunt.file.write(configJs.dest, configJsText);

        
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.registerTask('default', ["buildConfig", 'coffee'])
