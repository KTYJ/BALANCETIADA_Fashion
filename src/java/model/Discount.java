package model; //NEW

public class Discount {

    private String id;
    private String code;
    private String type;
    private int value;
    private String description;

    public Discount() {
    }

    public Discount(String ID, String CODE, String TYPE, int VALUE, String DESCRIPTION) {
        this.id = ID;
        this.code = CODE;
        this.type = TYPE;
        this.value = VALUE;
        this.description = DESCRIPTION;
    }

    public String getId() {
        return id;
    }

    public void setId(String ID) {
        this.id = ID;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String CODE) {
        this.code = CODE;
    }

    public String getType() {
        return type;
    }

    public void setType(String TYPE) {
        this.type = TYPE;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int VALUE) {
        this.value = VALUE;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String DESCRIPTION) {
        this.description = DESCRIPTION;
    }

    public String getDisplay() {
        return code + " - " + value + (type.equals("P") ? "%" : " MYR");
    }
}
