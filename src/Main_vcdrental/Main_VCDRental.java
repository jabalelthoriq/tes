package Main_vcdrental;

import java.util.ArrayList;
import java.util.Scanner;

public class Main_VCDRental {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<VCD> vcdList = new ArrayList<>();
        
        while (true) {
            System.out.println("\n=== VCD Rental System ===");
            System.out.println("1. Add Movie");
            System.out.println("2. Add Music Video");
            System.out.println("3. View All Data");
            System.out.println("0. Exit");
            System.out.print("Choose menu: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); // consume newline
            
            if (choice == 0) {
                System.out.println("Thank you for using VCD Rental System!");
                break;
            } else if (choice == 1) {
                System.out.println("\n-- Add New Movie --");
                System.out.print("Title    : ");
                String title = scanner.nextLine();
                System.out.print("Director : ");
                String director = scanner.nextLine();
                System.out.print("Rating   : ");
                int rating = scanner.nextInt();
                System.out.print("Duration : ");
                int duration = scanner.nextInt();
                scanner.nextLine();
                
                vcdList.add(new Movie(title, duration, director, rating));
                System.out.println("Movie added successfully!");
                
            } else if (choice == 2) {
                System.out.println("\n-- Add New Music Video --");
                System.out.print("Title    : ");
                String title = scanner.nextLine();
                System.out.print("Artist   : ");
                String artist = scanner.nextLine();
                System.out.print("Category : ");
                String category = scanner.nextLine();
                System.out.print("Duration : ");
                int duration = scanner.nextInt();
                scanner.nextLine();
                
                vcdList.add(new MusicVideo(title, duration, artist, category));
                System.out.println("Music Video added successfully!");
                
            } else if (choice == 3) {
                if (vcdList.isEmpty()) {
                    System.out.println("\nNo data available.");
                } else {
                    System.out.println("\n=== VCD Collection Data ===");
                    System.out.println("Title          Director/Artist Duration    Rating/Category");
                    System.out.println("--------------------------------------------------------");
                    for (VCD vcd : vcdList) {
                        System.out.println(vcd.toString());
                    }
                }
            } else {
                System.out.println("Invalid menu choice! Please try again.");
            }
        }
        scanner.close();
    }
}