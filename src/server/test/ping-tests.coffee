chai    = require 'chai'
pings   = require '../app_modules/pings'
expect  = chai.expect
chai.should()

describe 'pings', ->

	describe '.appReport', ->

		it 'should be defined', ->
			pings.appReport.should.not.null

		it 'should report', (done) ->
			pings.appReport 'winfydingends', (report) ->
				report.should.not.null
				report.length.should.not.null
				report.length.should.equal(14)
				done()
			, (err) ->
				done(err)
