public with sharing class IntegrationAPI {
    private static final String HTTP_GET = 'GET';
    private static final String ENDPOINT_GITHUB = 'https://api.github.com/search/repositories?q=language:Java&sort=stars&page=1';

    private Map<String, String> getAccessMapHeader() {
        Map<String, String> lMapHeader = new Map<String, String> {
            'Content-Type' => 'application/json'};
        return lMapHeader;
    }

    private HttpRequest getRequest(String method, Map<String, String> headerMap) {
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        for (String key : headerMap.keySet()) {
            request.setHeader(key, headerMap.get(key));
        }
        request.setTimeout(120000);
        return request;
    }

    private HttpResponse doRequest(HttpRequest request) {
        HttpResponse lResponse = new HttpResponse();
        try {
            Http lHttp = new Http();
            lResponse = lHttp.send(request);
            if(lResponse.getStatusCode() >= 300) {
                throw new IntegrationAPIException('Ocorreu um erro na chamada da API!');
            }
            return lResponse;
        } catch(System.CalloutException e) {
            throw e;
        }
    }

    public List<ItemWrp> getItems() {
        HttpRequest request = getRequest(HTTP_GET, getAccessMapHeader());
        request.setEndpoint(ENDPOINT_GITHUB);
        HttpResponse response = doRequest(request);
        starWrp returnResponse = (starWrp) JSON.deserialize(
            response.getBody(), starWrp.class
        );

        return returnResponse.items;
    }

    public class starWrp {
        public List<ItemWrp> items {get; set;}
    }

    public class ItemWrp {
        public String id {get; set;}
        public String name {get; set;}
        public OwnerWrp owner {get; set;}
        public Integer stargazers_count {get; set;}
        public Integer forks_count {get; set;}
    }

    public class OwnerWrp {
        public String login {get; set;}
    }

    public class IntegrationAPIException extends Exception {}
}
