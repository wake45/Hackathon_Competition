/*
 * Typical pin layout used:
 * -----------------------------------------------------------------------------------------
 *             MFRC522      Arduino       Arduino   Arduino    Arduino          Arduino
 *             Reader/PCD   Uno/101       Mega      Nano v3    Leonardo/Micro   Pro Micro
 * Signal      Pin          Pin           Pin       Pin        Pin              Pin
 * -----------------------------------------------------------------------------------------
 * RST/Reset   RST          9             5         D9         RESET/ICSP-5     RST
 * SPI SS      SDA(SS)      10            53        D10        10               10
 * SPI MOSI    MOSI         11 / ICSP-4   51        D11        ICSP-4           16
 * SPI MISO    MISO         12 / ICSP-1   50        D12        ICSP-1           14
 * SPI SCK     SCK          13 / ICSP-3   52        D13        ICSP-3           15
 */

#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN         9          // Configurable, see typical pin layout above
#define SS_PIN          10         // Configurable, see typical pin layout above

MFRC522 mfrc522(SS_PIN, RST_PIN);  // Create MFRC522 instance

void setup() {
   Serial.begin(9600);      // Initialize serial communications with the PC
   while (!Serial);      // Do nothing if no serial port is opened (added for Arduinos based on ATMEGA32U4)
   SPI.begin();         // Init SPI bus
   mfrc522.PCD_Init();      // Init MFRC522
   mfrc522.PCD_DumpVersionToSerial();   // Show details of PCD - MFRC522 Card Reader details
}

void loop() {
   // Look for new cards
   if ( ! mfrc522.PICC_IsNewCardPresent()) {
      return;
   }

   // Select one of the cards
   if ( ! mfrc522.PICC_ReadCardSerial()) {
      return;
   }

   // Dump debug info about the card; PICC_HaltA() is automatically called
  //mfrc522.PICC_DumpToSerial(&(mfrc522.uid));
  String content = "";
  
  for(byte i = 0; i < mfrc522.uid.size; i++) {
    Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? "0" : " ");
    Serial.print(mfrc522.uid.uidByte[i], HEX);
    content.concat(String(mfrc522.uid.uidByte[i] < 0x10 ? "0" : " "));
    content.concat(String(mfrc522.uid.uidByte[i], HEX));
  }

  //Serial.print("Message : ");
  content.toUpperCase();
  Serial.println();

  if(content.substring(1) == "82 49 86 89") {
    delay(1000);
  }
  if(content.substring(1) == "30 5B 59 A8") {
    delay(1000);
  }
}
