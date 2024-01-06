package mx.edu.utez.viajabara.utils.validator;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonParser {
    public JsonParser() {
    }

    public  int[] convertJsonToIntArray(String json)  {
        ObjectMapper objectMapper = new ObjectMapper();

        String[] arrayStrings = new String[0];
        try {
            arrayStrings = objectMapper.readValue(json, String[].class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }

        int[] arrayEnteros = new int[arrayStrings.length];
        for (int i = 0; i < arrayStrings.length; i++) {
            arrayEnteros[i] = Integer.parseInt(arrayStrings[i]);
        }

        return arrayEnteros;
    }
}
