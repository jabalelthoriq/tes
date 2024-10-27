package Main_vcdrental;

public class Movie extends VCD {
    private String director;
    private int rating;
    
    public Movie(String title, int duration, String director, int rating) {
        super(title, duration);
        this.director = director;
        this.rating = rating;
    }
    
    public String getDirector() {
        return director;
    }
    
    public int getRating() {
        return rating;
    }
    
    @Override
    public String toString() {
        return String.format("%-15s %-15s %-10d %d", 
                title, director, duration, rating);
    }
}