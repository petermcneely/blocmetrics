# blocmetrics

An analytics service and reporting tool that can be used with web apps to track user activity. Register your rails application to be consumed at https://bk-blocmetrics.herokuapp.com

To utilize the blocmetrics event tracking in your registered rails application, place the following Javascript in the application's app/assets/javascripts/application.js file:

```
var blocmetrics = {};

blocmetrics.report = function(eventName)
{
	var event = {event: {name: eventName}};

	var request = new XMLHttpRequest();

	request.open("POST", "https://bk-blocmetrics.herokuapp.com/api/events", true);

	request.setRequestHeader('Content-Type', 'application/json');

	request.send(JSON.stringify(event));
};
```

And then call `blocmetrics.report` with your event name in the appropriate html file(s).
