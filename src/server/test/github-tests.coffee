chai = require 'chai'
github = require '../app_modules/github'
dotenv      = require "dotenv"
expect = chai.expect
chai.should()

dotenv.load();

describe 'GitHub', ->

	describe 'repoDetails', ->
		it 'should not be null', ->
			github.repoDetails.should.not.null

		it 'should return project details', (done) ->
			github.repoDetails 'Winfy', (repoDetails) ->
				repoDetails.should.not.null
				repoDetails.stargazers.should.not.null
				repoDetails.forks.should.not.null
				done()
			, (err) ->
				done(err)