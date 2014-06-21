module.exports = (grunt) ->
  grunt.initConfig
    app : grunt.file.readJSON('app/config.json')
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        expand: true
        cwd: "."
        src: "app/src/**/*.coffee"
        dest: "."
        ext: ".js"
        extDot :"last"
        
        
  grunt.registerTask 'build.config', ->

    manifest = {
      dest : "app/manifest.json"
      template : grunt.file.read('app/manifest.tpl.json')
    }
    grunt.file.write(manifest.dest, grunt.template.process(manifest.template))

    configJs = {
      dest :  "app/config.json.js"
      template : "var <%= app.define %> = <%= JSON.stringify(app.config) %>;"
    }
    grunt.file.write(configJs.dest,  grunt.template.process(configJs.template))

        
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.registerTask('default', ["build.config", 'coffee'])
