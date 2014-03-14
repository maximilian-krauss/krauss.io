chai    = require 'chai'
teaser  = require '../app_modules/teaser'
expect  = chai.expect
chai.should()

describe 'teaser', ->
	describe '.image(location)', ->

		it 'should be defined', ->
			teaser.image.should.not.null

		it 'should return the teaser for index', ->
			teaser.image('/').should.equal '/static/images/header-background.jpg'

		it 'should return the teaser for contact page', ->
			teaser.image('/imprint').should.equal '/static/images/header-background-contact.jpg'

		it 'should return the fallback if the location is unknown', ->
			teaser.image('/blahblahblah').should.equal '/static/images/header-background.jpg'