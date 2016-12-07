http   = require 'http'
_      = require 'lodash'
GotoTraining = require '../../gototraining.coffee'

class GetOrganizers
  constructor: ({@encrypted}) ->
    @gototraining = new GotoTraining {accessToken: @encrypted.secrets.credentials.secret}
    @accountKey = @encrypted.secrets.credentials.accountKey

  do: ({data}, callback) =>
    @gototraining.api('GET', "/accounts/#{@accountKey}/organizers", null, null, (error, response, body) =>
      return callback @_userError(422, error) if error
      return callback null, {
        metadata:
          code: 200
          status: http.STATUS_CODES[200]
        data: body
      }
    )

  _userError: (code, message) =>
    error = new Error message
    error.code = code
    return error

module.exports = GetOrganizers
