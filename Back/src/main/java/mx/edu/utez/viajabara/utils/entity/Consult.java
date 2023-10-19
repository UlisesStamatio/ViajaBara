package mx.edu.utez.viajabara.utils.entity;

import java.util.List;

public class Consult {
    private List entities;
    private long total;

    public Consult() {
    }

    public Consult(List entities, long total) {
        this.entities = entities;
        this.total = total;
    }

    public List getEntities() {
        return entities;
    }

    public void setEntities(List entities) {
        this.entities = entities;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }
}
