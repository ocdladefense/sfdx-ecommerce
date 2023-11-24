public class JsonPayloadException extends Exception {

    public enum ErrorTypes {SERIALIZATION_ERROR}

    private String message;

    public JsonPayloadException(JsonPayloadException.ErrorTypes error, String message) {
        this.message = error.name() + '; ' + message;
        // super(theMessage);
    }

    public override String getMessage() {
        return this.message;
    }
}