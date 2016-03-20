describe 'syn-auth.session.factory', ->

  auth = require( 'src/' )
  data =
    settings:
      country: 'mx'
      language: 'ES'
      fullName: 'Fake User'
    token:
      expires_in: 60 * 60
      refresh_token: 'fake-refresh-token'
      access_token: 'fake-access-token'


  describe '#createFromAuthResponse', ->

    beforeEach ->
      @expiration = Date.now() + ( 60 * 60 * 1000 )
      @result = auth.session.factory.createFromAuthResponse( data )

    it 'should return expected session object', ->
      @result.user().name().should.equal 'Fake User'
      @result.locale().country().should.equal 'MX'
      @result.locale().language().should.equal 'es'
      @result.token().should.equal 'fake-access-token'
      @result.refreshToken().should.equal 'fake-refresh-token'
      @result.expiration().toString().should.equal new Date( @expiration ).toString()
