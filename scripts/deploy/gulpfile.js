'use strict'
var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    pump = require('pump'),
    cssmin = require('gulp-cssmin'),
    clean = require('gulp-clean'),
    path = require("path"),
    argv = require('yargs').argv,
    path = require("path"),
    zip = require('gulp-zip'),
    gulpRimraf = require("gulp-rimraf"),
    exit = require('gulp-exit'),
    git = require('gulp-git'),
    gulpSequence = require('gulp-sequence'),
    mySSH = require('./gulp/ssh'),
    fs = require('fs'),
    shell = require('gulp-shell');

var deployConfig = {
    test: {
        servers: [{
            sshConfig: {
                host: '127.0.0.1',
                port: 22,
                username: 'lancelot',
                password: 'lancelot',
                readyTimeout: 200000
            }
        }],
        deployPath: "/home/web/dist",
        deploySrc: [],
        deployServers: []
    }
};

var cfg;

function getEnvConf(type) {
    var conf = {};
    conf.env = argv.env || "test";
    conf.type = type;
    conf.rootDir = path.normalize(path.join(__dirname, type));
    conf.distDir = path.normalize(path.join(__dirname, "/dist"));
    conf.distTempDir = path.normalize(__dirname + "/dist/temp");
    console.log("env: %s", conf.env);
    console.log("root dir : %s", conf.rootDir);
    console.log("dist dir : %s", conf.distDir);
    return conf;
}


gulp.task('echo', shell.task([
     'echo hello',
     'echo word'
]))

gulp.task('pull', function () {
    var env = argv.env || "test";
    var repo = {
        test: "develop",
        production: "master"
    };
    git.checkout(repo[env], function (err) {
        if (err) throw err;
        git.pull('origin', [repo[env]], function (err) {
            if (err) throw err;
            var tag = new Date().format("yyyyMMdd.hhmmss");
            git.tag(tag, 'Version' + tag, function (err) {
                if (err) throw err;
            });
        });
    });
});


var STATIC_SRC = 'static/';
var paths = {
    allCss: [STATIC_SRC + 'css/*.css', STATIC_SRC + 'css/*/*.css'],
    scripts: [STATIC_SRC + 'js/*.js', STATIC_SRC + 'js/*/*.js']
};

gulp.task('static:clean', function () {
    return gulp.src('dist-static/', {read: false})
        .pipe(clean());
});

gulp.task('static:copy', ['static:clean'], function () {
    return gulp.src('static/**/*')
        .pipe(gulp.dest('dist-static'));
});

gulp.task('static:css', function () {
    gulp.src(paths.allCss)
        .pipe(cssmin())
        .pipe(gulp.dest('dist-static/css'));
});

gulp.task('static:uglify', function (cb) {
    pump([
            gulp.src(paths.scripts),
            uglify(),
            gulp.dest('dist-static/js')
        ],
        cb
    );
});

gulp.task('static:zip', function () {
    return gulp.src(["dist-static/**/*"])
        .pipe(zip('publish.zip'))
        .pipe(gulp.dest("./dist-static"))
});

gulp.task('static:deploy', function () {
    var env = argv.env || "test";
    cfg = deployConfig[env];
    if (!cfg) {
        console.error("Invalid env !!!");
    }

    cfg.deploySrc = ["dist-static/**"];
    cfg.deployPath = cfg.deployPath + "/static";
    cfg.deployServers = cfg.servers;

    var envCfg = getEnvConf("static");
    var logName = "deploy-" + envCfg.type;
    gulp.src("dist-static/publish.zip")
        .pipe(mySSH({
            servers: [cfg.deployServers[0]],
            dest: cfg.deployPath + '/publish.zip',
            shell: ['cd ' + cfg.deployPath,
                'shopt -s extglob',
                'sudo rm -rf !(logs|node_modules|publish.zip)',
                'unzip -o publish.zip',
                "rm publish.zip"
            ],
            logPath: logName
        }))
        .pipe(exit());
});

gulp.task('project-static', function () {
    gulpSequence('static:copy', 'static:css', 'static:uglify', 'static:zip',
        'static:deploy',
        function () {
            console.log("***** Deploy Finished！！！！");
            process.exit(0);
        }
    );
});

gulp.task('project-main', function (cb) {
    var env = argv.env || "test";
    cfg = deployConfig[env];
    if (!cfg) {
        console.error("Invalid env !!!");
    }
    cfg.deploySrc = ["dist/**"];
    cfg.deployPath = cfg.deployPath + "/app";
    cfg.deployServers = cfg.servers;

    var envCfg = getEnvConf("main");
    require("./gulp/deploy.js")(envCfg, cfg);

    gulpSequence("clean:dist", "copyWebSiteToDist",
        "process:setting", "process:dockerfile", "zipPublishFile",
        "startDeploy",
        function () {
            console.log("***** Deploy Finished！！！！");
            process.exit(0);
        });
});
