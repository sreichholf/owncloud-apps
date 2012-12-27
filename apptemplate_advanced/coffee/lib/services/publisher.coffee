###
# ownCloud - News app
#
# @author Bernhard Posselt
# Copyright (c) 2012 - Bernhard Posselt <nukeawhale@gmail.com>
#
# This file is licensed under the Affero General Public License version 3 or later.
# See the COPYING-README file
#
###

###
# Used for properly distributing received model data from the server
###
angular.module('OC').factory '_ModelPublisher', ->


        class ModelPublisher

                constructor: () ->
                        @subscriptions = {}


                # Use this to subscribe to a certain hashkey in the returned json data
                # dictionary.
                # If you send JSON from the server, you'll receive something like this
                #
                # 	{
                #		data: {
                #			something: ['one', 'two']
                #		}
                # 	}
                #
                # To get the array ['one', 'two'] passed to your model, just subscribe
                # to the key:
                #	ModelPublisher.subscribeModelTo('something', myModelInstance)
                #
                subscribeModelTo: (model, name) ->
                        @subscriptions[name] or= []
                        @subscriptions[name].push(model)


                # This will publish data from the server to all registered subscribers
                # The parameter 'name' is the name under which subscribers have registered
                publishDataTo: (data, name) ->
                        for subscriber in @subscriptions[name] || []
                                subscriber.handle(data)


        return ModelPublisher