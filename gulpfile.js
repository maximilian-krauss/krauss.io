var gulp    = require('gulp'),
	gutil   = require('gulp-util'),
	coffee  = require('gulp-coffee'),
	clean   = require('gulp-clean'),
	bower   = require('gulp-bower');

gulp.task('bower', function() {
	return bower();
});

gulp.task('clean-directories', ['bower'], function() {
	gulp.src('./app/**/*.js')
		.pipe(clean({ read: false, force: true }));

	gulp.src('./public/js/**/*.js')
		.pipe(clean({ read: false, force: true }));
});

gulp.task('compile-server', ['clean-directories'], function() {
	gulp.src('./src/server/**/*.coffee')
		.pipe(coffee({ bare: false }))
		.pipe(gulp.dest('./app'));
});

gulp.task('compile-client', ['clean-directories'], function() {
	gulp.src('./src/client/**/*.coffee')
		.pipe(coffee({ bare: false }))
		.pipe(gulp.dest('./public/js'));
});


gulp.task('default', function() {
	gulp.run('heroku:production');
});

gulp.task('heroku:production', [
	'compile-server',
	'compile-client'
]);