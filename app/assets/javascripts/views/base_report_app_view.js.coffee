class MongoDQB.Views.BaseAppView extends Backbone.View

	viewBindInputs: (e) =>
		console.log 'view binding inputs!'
		newKey = $(e.target).attr('name')
		newVal = $(e.target).val()
		@model.set(newKey.toString(), newVal)
		console.log @model.toJSON()
		@