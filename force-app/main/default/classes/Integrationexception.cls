public class Integrationexception extends Exception{
    private static final String CL_DEFAULT_ERROR_MSG = 'Ocorreu um erro inesperado na integração.';

    public HttpResponse hResponse;
    public ResponseError responseError;

    public Integrationexception(HttpResponse response, Exception e) {
        String errorMsg = '';

        this.hResponse = response;
        if(e != null) {
            errorMsg += e.getMessage() +'\n';
        }
        if(this.hResponse != null){
            if(this.hResponse.getStatusCode() == 404){
                errorMsg += 'Registro não encontrado.\n';
            }
            if(String.isNotEmpty(this.hResponse.getBody())){
                try {
                    this.responseError = (ResponseError)JSON.deserialize(this.hResponse.getBody(), ResponseError.class);
                    if(!this.responseError.errors.isEmpty()){
                        for(Error err : this.responseError.errors){
                            errorMsg += err.message+'\n';
                        }
                    }
                } catch (Exception ex) {
                    errorMsg += this.hResponse.getBody()+'\n';
                }
            }
        }
        this.setMessage(errorMsg);
    }

    public class ResponseError {
        public List<Error> errors;
    }

    public class Error {
        public Decimal code;
        public String message;
    }
}
