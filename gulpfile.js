/*
 * Aikar's Minecraft Timings Parser
 *
 * Written by Aikar <aikar@aikar.co>
 * http://aikar.co
 * http://starlis.com
 *
 * @license MIT
 */
"use strict";
const gulp = require('gulp');
require('gulp-bash-completion')(gulp);
const $u = require('./gulp.util');
const webpack = require('webpack');
const webpackConfig = require('./webpack.config');

gulp.task('build:dev', gulp.parallel((cb) => {
  let config = webpackConfig(false);
  webpack(config, config.reporter(cb));
}));

gulp.task('build:release', gulp.parallel((cb) => {
  let config = webpackConfig(true);
  webpack(config, config.reporter(cb));
}));


gulp.task('default', gulp.parallel(() => {
  process.env.NODE_ENV = process.env.NODE_ENV || "development";
  let config = webpackConfig(process.env.NODE_ENV === "production", true);
  webpack(config, config.reporter());
}));
