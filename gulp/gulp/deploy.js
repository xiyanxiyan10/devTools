var gulp = require('gulp'),
    zip = require('gulp-zip'),
    gulpRimraf = require("gulp-rimraf"),
    exit = require('gulp-exit'),
    mySSH = require('./ssh');

module.exports = function (envCfg, cfg) {
    var envCfg = envCfg;
    var cfg = cfg;

    gulp.task('copyWebSiteToDist', function () {
        var deploySrc = [
            "*.py",
            "!**/*.pyc",
            "iseecore/**/*",
            "models/**/*",
            "otherpackage/**/*",
            "services/**/*",
            "template/**/*",
            "translations/**/*",
            "util/**/*",
            "views/**/*"
        ];
        return gulp.src(deploySrc, {base: './'})
            .pipe(gulp.dest("./dist"));
    });

    gulp.task('process:setting', function () {
        return gulp.src("config/" + envCfg.env + "/*")
            .pipe(gulp.dest("./dist"));
    });

    gulp.task('process:dockerfile', function () {
        return gulp.src([
            ".docker/Dockerfile." + envCfg.type,
            ".docker/dockerignore." + envCfg.type], {base: './.docker'})
            .pipe(gulp.dest("./dist"));
    });

    gulp.task('zipPublishFile', function () {
        return gulp.src(["dist/**/*"])
            .pipe(zip('publish.zip'))
            .pipe(gulp.dest("./dist"))
    });

    gulp.task('startDeploy', function () {
        var logName = "deploy-" + envCfg.type;
        var tag = "v" + new Date().format("yyyyMMdd-hhmmss");
        return gulp.src("dist/publish.zip")
            .pipe(mySSH({
                servers: [cfg.deployServers[0]],
                dest: cfg.deployPath + '/publish.zip',
                shell: ['cd ' + cfg.deployPath,
                    'shopt -s extglob',
                    'rm -rf !(logs|node_modules|publish.zip)',
                    'unzip -o publish.zip',
                    'chmod u+x -R *',
                    "rm publish.zip",
                    "mv Dockerfile." + envCfg.type + " Dockerfile",
                    "mv dockerignore." + envCfg.type + " .dockerignore",
                    "sudo docker build -t a80:5000/project-" + envCfg.type + ":" + tag + " .",
                    "sudo docker push a80:5000/project-" + envCfg.type + ":" + tag,
                    "cd ../../k8s/",
                    "./deploy.sh project-" + envCfg.type + " " + tag + "",
                ],
                logPath: logName
            }))
            .pipe(exit());
    });

    gulp.task("clean:dist", function (cb) {
        return gulp.src(envCfg.distDir, {read: false})
            .pipe(gulpRimraf({force: true}));
    });

};

Date.prototype.format = function (fmt) { //author: meizz
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "h+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}
