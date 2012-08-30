/*************************************************************************
  This is an Arduino library for the Adafruit Thermal Printer.
  Pick one up at --> http://www.adafruit.com/products/597
  These printers use TTL serial to communicate, 2 pins are required.

  Adafruit invests time and resources providing this open source code.
  Please support Adafruit and open-source hardware by purchasing products
  from Adafruit!

  Written by Limor Fried/Ladyada for Adafruit Industries.
  MIT license, all text above must be included in any redistribution.
 *************************************************************************/

// If you're using Arduino 1.0 uncomment the next line:
#include "SoftwareSerial.h"
// If you're using Arduino 23 or earlier, uncomment the next line:
//#include "NewSoftSerial.h"

#include "Adafruit_Thermal.h"
#include "adalogo.cpp"
#include "adaqrcode.cpp"

int printer_RX_Pin = 5;  // This is the green wire
int printer_TX_Pin = 6;  // This is the yellow wire

Adafruit_Thermal printer(printer_RX_Pin, printer_TX_Pin);

void setup(){
  Serial.begin(9600);
  printer.begin();

  // The following function calls are in setup(), but do not need to be.
  // Use them anywhere!  They're just here so they're run only one time
  // and not printed over and over.
  // Some functions will feed a line when called to 'solidify' setting.
  // This is normal.

  // Test inverse on & off
  printer.inverseOn();
  printer.println("Inverse ON");
  printer.inverseOff();

  // Test character double-height on & off
  printer.doubleHeightOn();
  printer.println("Double Height ON");
  printer.doubleHeightOff();

  // Set text justification (right, center, left) -- accepts 'L', 'C', 'R'
  printer.justify('R');
  printer.println("Right justified");
  printer.justify('C');
  printer.println("Center justified");
  printer.justify('L');
  printer.println("Left justified");

  // Test more styles
  printer.boldOn();
  printer.println("Bold text");
  printer.boldOff();

  printer.underlineOn(); 
  printer.println("Underlined text ");
  printer.underlineOff();

  printer.setSize('L');     // Set type size, accepts 'S', 'M', 'L'
  printer.print("Large");   // Print line
  printer.setSize('M');     // Setting the size adds a linefeed
  printer.print("Medium");  // Print line
  printer.setSize('S');     // Setting the size adds a linefeed
  printer.println("Small"); // Print line

  printer.justify('C');
  printer.println("normal\nline\nspacing");
  printer.setLineHeight(50);
  printer.println("Taller\nline\nspacing");
  printer.setLineHeight(); // Reset to default
  printer.justify('L');

  // Barcode examples
  printer.feed(1);
  // CODE39 is the most common alphanumeric barcode
  printer.printBarcode("ADAFRUT", CODE39);
  printer.setBarcodeHeight(100);
  // Print UPC line on product barcodes
  printer.printBarcode("123456789123", UPC_A);

  // Print the 56x57 pixel logo in adalogo.cpp
  printer.printBitmap(56, 57, adalogo);

  // Print the 128x135 pixel QR code in adaqrcode.cpp
  printer.printBitmap(128, 135, adaqr);
  printer.println("Adafruit!");
  printer.feed(1);

  printer.sleep();      // Tell printer to sleep
  printer.wake();       // MUST call wake() before printing again, even if reset
  printer.setDefault(); // Restore printer to defaults
}

void loop() {
}
