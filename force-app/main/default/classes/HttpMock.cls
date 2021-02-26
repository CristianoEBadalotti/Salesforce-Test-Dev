@isTest 
global class HttpMock implements HttpCalloutMock {
    private static final String ENDPOINT_GITHUB = 'https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1';

    global HttpResponse respond(HttpRequest request) {
        HttpResponse response = new HttpResponse();
        if (request.getMethod() == 'GET') {
            if(request.getEndpoint().indexOf(ENDPOINT_GITHUB) == 0) {
                return getItems(response);
            }
        }
        return null;
    }  
    
    private HttpResponse getItems(HttpResponse response) {
        response.setBody('{ "total_count": 9305955, "incomplete_results": false,   "items": [ { "id": 121395510, "name": "CS-Notes", "owner": { "login": "CyC2018" }, "stargazers_count": 121835, "forks_count": 39534  }, { "id": 132464395, "name": "JavaGuide", "owner": { "login": "Snailclimb" }, "stargazers_count": 98057, "forks_count": 33811 }, { "id": 22790488, "name": "java-design-patterns", "owner": { "login": "iluwatar" }, "stargazers_count": 1257, "forks_count": 32811 } ] }');
        return response;
    }
}
