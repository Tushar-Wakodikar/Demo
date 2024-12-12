public class CIG10 {
    public String make;
    public String model;
    public Integer year;

    public CIG10() {
        this.make = 'Unknown';
        this.model = 'Unknown';
        this.year = 0;
    }

    public CIG10(String make, String model, Integer year) {
        this.make = make;
        this.model = model;
        this.year = year;
    }

    public void displayCarDetails() {
        System.debug('Make: ' + make);
        System.debug('Model: ' + model);
        System.debug('Year: ' + year);
    }

}