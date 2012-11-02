class MongoDQB.Views.ReportCatalogView extends Backbone.View
	tagName: 'ul'
	className: 'nav-list nav-stacked nav-right-bar well'
	initialize: ->
		#no longer neccessary now that I got observer to work and fire report fetch
		#@collection.bind 'change', @render, @
		@template = $('#reportCatalogList').html()
		@
	render: =>
		catalogTemplate = Handlebars.compile(@template)
		$(@el).html(catalogTemplate(menuHeader: 'Hello Report Navigation'))
		for report in @collection.models
			reportLinkView = new MongoDQB.Views.ReportLinkView(model: report)
			$(@el).append reportLinkView.render().el
		@