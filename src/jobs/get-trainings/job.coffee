http   = require 'http'
_      = require 'lodash'
GotoTraining = require '../../gototraining.coffee'

class GetTrainings
  constructor: ({@encrypted}) ->
    @gototraining = new GotoTraining {accessToken: @encrypted.secrets.credentials.secret}
    @organizerKey = @encrypted.secrets.credentials.organizerKey

  do: ({data}, callback) =>
    if _.has(data, 'organizerKey')
      @organizerKey = data.organizerKey if data.organizerKey?

    @gototraining.api('GET', "/organizers/#{@organizerKey}/trainings", null, null, (error, response, body) =>
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

module.exports = GetTrainings
