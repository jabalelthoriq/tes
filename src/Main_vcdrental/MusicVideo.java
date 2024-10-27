package Main_vcdrental;

public class MusicVideo extends VCD {
    private String artist;
    private String category;
    
    public MusicVideo(String title, int duration, String artist, String category) {
        super(title, duration);
        this.artist = artist;
        this.category = category;
    }
    
    public String getArtist() {
        return artist;
    }
    
    public String getCategory() {
        return category;
    }
    
    @Override
    public String toString() {
        return String.format("%-15s %-15s %-10d %s", 
                title, artist, duration, category);
    }
}