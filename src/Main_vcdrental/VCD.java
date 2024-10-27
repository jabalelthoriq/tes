package Main_vcdrental;

public abstract class VCD {
    protected String title;
    protected int duration;
    
    public VCD(String title, int duration) {
        this.title = title;
        this.duration = duration;
    }
    
    public String getTitle() {
        return title;
    }
    
    public int getDuration() {
        return duration;
    }
    
    public abstract String toString();
}