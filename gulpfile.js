var gulp    = require('gulp'),
	gutil   = require('gulp-util'),
	coffee  = require('gulp-coffee'),
	clean   = require('gulp-clean'),
	bower   = require('gulp-bower'),
	concat  = require('gulp-concat');

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
	gulp.src(['./src/client/app.coffee', './src/client/**/*.coffee'])
		.pipe(coffee({ bare: false }).on('error', gutil.log))
		.pipe(concat('app.js'))
		.pipe(gulp.dest('./public/js'))

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
