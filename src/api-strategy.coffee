_ = require 'lodash'
PassportGototraining = require 'passport-citrix'

class GototrainingStrategy extends PassportGototraining
  constructor: (env) ->
    throw new Error('Missing required environment variable: ENDO_GOTOTRAINING_GOTOTRAINING_CLIENT_ID')     if _.isEmpty process.env.ENDO_GOTOTRAINING_GOTOTRAINING_CLIENT_ID
    throw new Error('Missing required environment variable: ENDO_GOTOTRAINING_GOTOTRAINING_CLIENT_SECRET') if _.isEmpty process.env.ENDO_GOTOTRAINING_GOTOTRAINING_CLIENT_SECRET
    throw new Error('Missing required environment variable: ENDO_GOTOTRAINING_GOTOTRAINING_CALLBACK_URL')  if _.isEmpty process.env.ENDO_GOTOTRAINING_GOTOTRAINING_CALLBACK_URL

    options = {
      clientID:     process.env.ENDO_GOTOTRAINING_GOTOTRAINING_CLIENT_ID
      clientSecret: process.env.ENDO_GOTOTRAINING_GOTOTRAINING_CLIENT_SECRET
      callbackUrl:  process.env.ENDO_GOTOTRAINING_GOTOTRAINING_CALLBACK_URL
    }

    super options, (accessToken, refreshToken, params, profile, callback) =>
      callback null, {
        id: profile.id
        username: profile.userName
        secrets:
          credentials:
            secret: accessToken
            refreshToken: refreshToken
            organizerKey: params.organizer_key
            accountKey:  params.account_key
      }


module.exports = GototrainingStrategy
