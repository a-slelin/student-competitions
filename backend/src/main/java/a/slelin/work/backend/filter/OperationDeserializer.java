package a.slelin.work.backend.filter;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import java.io.IOException;

public class OperationDeserializer extends StdDeserializer<Operation> {

    protected OperationDeserializer() {
        super(Operation.class);
    }

    @Override
    public Operation deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException {
        String value = jsonParser.getValueAsString().trim();
        return Operation.of(value);
    }
}
