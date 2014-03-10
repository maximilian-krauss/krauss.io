var gulp            = require('gulp'),
	gutil           = require('gulp-util'),
	coffee          = require('gulp-coffee'),
	clean           = require('gulp-clean'),
	bower           = require('gulp-bower'),
	concat          = require('gulp-concat'),
	bowerPath       = './bower_components',
	thirdPartyLibs  = [
		'jquery/dist/jquery.min.js',
		'angular/angular.min.js',
		'angular-route/angular-route.min.js',
		'angular-animate/angular-animate.min.js',
		'angular-loading-bar/build/loading-bar.min.js',
		'showdown/compressed/showdown.js',
		'uikit/dist/js/uikit.min.js',
		'd3/d3.min.js',
		'nvd3/nv.d3.min.js',
		'angularjs-nvd3-directives/dist/angularjs-nvd3-directives.js',
		'moment/moment.js'
	];

gulp.task('bower', function() {
	return bower();
});

gulp.task('clean-directories', ['bower'], function() {
	gulp.src('./app/**/*.js')
		.pipe(clean({ read: false, force: true }));

	gulp.src('./public/js/**/*.js')
		.pipe(clean({ read: false, force: true }));
	gulp.src('./public/html/**/*.html')
		.pipe(clean({ read: false, force: true }));
	gulp.src('./public/css/**/*.css')
		.pipe(clean({ read: false, force: true }));
});

gulp.task('compile-server', ['clean-directories'], function() {
	gulp.src('./src/server/**/*.coffee')
		.pipe(coffee({ bare: false }).on('error', gutil.log))
		.pipe(gulp.dest('./app'));
});

gulp.task('compile-client', ['clean-directories'], function() {
	var thirdPartyPaths = [],
		index;

	for(index = 0; index < thirdPartyLibs.length; index++) {
		thirdPartyPaths.push([bowerPath, thirdPartyLibs[index]].join('/'));
	}

	gulp.src(['./src/client/app.coffee', './src/client/**/*.coffee'])
		.pipe(coffee({ bare: false }).on('error', gutil.log))
		.pipe(concat('app.js'))
		.pipe(gulp.dest('./public/js'));

	gulp.src(thirdPartyPaths)
		.pipe(concat('vendor.js'))
		.pipe(gulp.dest('./public/js'));

	gulp.src('./src/client/html/**/*.html')
		.pipe(gulp.dest('./public/html'));

	gulp.src('./src/client/css/**/*.css')
		.pipe(gulp.dest('./public/css'));
});


gulp.task('default', ['heroku:production'] );

gulp.task('heroku:production', [
	'compile-server',
	'compile-client'
]);
