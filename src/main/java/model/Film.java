package model;

/**
 *
 * @author AXELL
 */
public class Film {
    private int id;
    private String judul;
    private String genre;
    private int durasi;
    private String ratingUsia;
    private String sinopsis;
    private String posterUrl;

    public Film() {}

    public Film(int id, String judul, String genre, int durasi, String ratingUsia, String sinopsis, String posterUrl) {
        this.id = id;
        this.judul = judul;
        this.genre = genre;
        this.durasi = durasi;
        this.ratingUsia = ratingUsia;
        this.sinopsis = sinopsis;
        this.posterUrl = posterUrl;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getJudul() { return judul; }
    public void setJudul(String judul) { this.judul = judul; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public int getDurasi() { return durasi; }
    public void setDurasi(int durasi) { this.durasi = durasi; }

    public String getRatingUsia() { return ratingUsia; }
    public void setRatingUsia(String ratingUsia) { this.ratingUsia = ratingUsia; }

    public String getSinopsis() { return sinopsis; }
    public void setSinopsis(String sinopsis) { this.sinopsis = sinopsis; }

    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }
}
