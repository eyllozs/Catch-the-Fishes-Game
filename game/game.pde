PImage backgroundImage;
PImage fishIcon;
PImage fishook;
PImage heart1;
PImage heart2;
PImage heart3;
PImage heart4;
float yOffset = 0;
PFont font;
int restFish;
int missedAttempts = 0;

PImage[] images; // Resimleri tutmak için dizi
int currentImageIndex = 1; // Şu anki resim indeksi
int imageChangeInterval = 800; // Resim değiştirme aralığı (ms)
int lastImageChangeTime = 0; // Son resim değiştirme zamanı
boolean pauseImage = false; // Fotoğrafın duraklatılma durumu

int tubeRes = 360;
float[] tubeX = new float[tubeRes];
float[] tubeY = new float[tubeRes];
PImage img;

int rowCount = 5;
int fishCount =4; // sıradaki Balık sayısı
int fishSpacing = 115; // Balıklar arasındaki boşluk
float barValue = 0.0; // Başlangıç değeri
float barSpeed = 0.3; // Değer değişim hızı

boolean isHeart2Visible = false;
boolean isHeart3Visible = false;
boolean isHeart4Visible = false;

boolean startScreen = true;

void setup() {
  fullScreen(P3D);
  backgroundImage = loadImage("background2.png");
  font = createFont("ActiveRegular.OTF", 48);
  textFont(font);
  textAlign(CENTER, CENTER);

  fishIcon = loadImage("fishIcon.png");
  fishook = loadImage("bait.png");

  heart1 = loadImage("heart1.png");
  heart2 = loadImage("heart2.png");
  heart3 = loadImage("heart3.png");
  heart4 = loadImage("heart4.png");
  
  img = loadImage("wood2.png");
  float angle = 400.0 / tubeRes;
  for (int i = 0; i < tubeRes; i++) {
    tubeX[i] = cos(radians(i * angle));
    tubeY[i] = sin(radians(i * angle));
  }
  noStroke();

  restFish = fishCount*rowCount;
  fishList = new ArrayList<Fish>(); // Balıkları tutmak için ArrayList oluştur

  for (int i = 0; i < rowCount; i++) {
    for (int j = 0; j < fishCount; j++) {
      float x = random(width); // Balığın x koordinatı rastgele belirlensin
      float y = i * fishSpacing; // Balığın y koordinatını belirle
      float z = 300; // Balığın y koordinatını belirle
      boolean reverse = random(1) < 0.5; // Rastgele ters yönde hareket etsin mi?
      float speed = random(3, 8);
      fishList.add(new Fish(x, y,z, reverse, speed)); // Balığı ArrayList'e ekle
    }
  }

  // Resimleri yükleyin
  images = new PImage[5];
  for (int i = 0; i < 5; i++) {
    images[i] = loadImage("power" + (i+1) + ".png");
  }
  

  
}
ArrayList<Fish> fishList = new ArrayList<Fish>();
void draw() {
  background(backgroundImage);
  image(backgroundImage, 0, -15, width, height);
  
  if (startScreen) {
    fill(244, 146, 49);
    textSize(60);
    textAlign(CENTER);
    translate(0, 50);
    text("Game Rules", width / 2, height / 2+80);
    textSize(35);
    fill(87, 46, 0);
    text("1) Adjust the strength of your fishing rod with the spacebar. Each sea layer has a separate power setting.", width / 2, height / 2+115);
    text("2) You can only move your fishing rod in the layer you selected.", width / 2, height / 2+150);
    text("3) If you can't catch the fish, you will lose one of your hearts.", width / 2, height / 2+185);
    text("4) If you lose all 3 hearts, you will lose the game.", width / 2, height / 2+220);
    translate(0, -50);
    fill(255);
    textSize(100);
    textAlign(CENTER);
    text("Press S to start", width / 2, height / 2+20);
    return;
  }

  stroke(1);
  fill(255, 255, 255, 100);  // Beyaz renk, %25 opaklık
  rect(0, 0, width, 100);

  fill(#e60000);  // Kırmızı renk (#e60000)
  textSize(48);
  text("Catch The Sweet Fishes", width/2, 60);

  fill(0);
  textSize(30);
  text("game", width/2+190, 25);


  image(fishIcon, width - fishIcon.width - 155, 25);
  image(heart1, 20, 5);
  fill(#e60000);
  textSize(55);
  text(""+restFish, width- 120, 65);

  textSize(25);
  text("REST", width- 70, 58);



  for (int i = 0; i < fishList.size(); i++) {
    fishList.get(i).update();
    fishList.get(i).display();
  }


  //olta
  //beginShape();
  //fill(164, 72, 23);
  //rect(width/2, height/2+180, 18, 355, 5);
  //fill(177, 177, 177);
  //rect(width/2+20, height-60, 18, 36, 5);
  image(img, width/2+3, height/2+178, 15, 5);
  //endShape(CLOSE);

  float mousex = mouseX;
  float mousey = mouseY;
  strokeWeight(2);
  stroke(255);
  beginShape();
  line(width/2+9, height/2+180, mousex, mousey);
  strokeWeight(1);
  image(fishook, mouseX-20, mouseY-20);
  endShape(CLOSE);
  // Sol alt köşeye resmi çiz
  image(images[currentImageIndex], 150, height - 10 - images[currentImageIndex].height);

  // Resim değiştirme zamanını kontrol et
  if (!pauseImage && millis() - lastImageChangeTime > imageChangeInterval) {
    // Sonraki resme geç
    currentImageIndex = (currentImageIndex + 1) % 5;
    lastImageChangeTime = millis();
  }
  if (restFish==0) {
  background(backgroundImage);
  image(backgroundImage, 0, -15, width, height);
  textSize(100);
  fill(124, 252, 0);
  text("You Win!", width / 2, height / 2);
  textSize(60);
  text("Press R to return to the start screen", width / 2, height / 2 + 80);
  return ;
  }
  
  if (isHeart2Visible) {
  image(heart2, 20, 5, heart2.width, heart2.height);
}
  if (isHeart3Visible) {
  image(heart3, 20, 5, heart2.width, heart2.height);
}
  if (isHeart4Visible) {
  background(backgroundImage);
  image(backgroundImage, 0, -15, width, height);
  image(heart4, 20, 5, heart4.width, heart4.height);
  textSize(100);
  fill(255, 0, 0);
  text("Game Over", width / 2, height / 2);
  textSize(60);
  text("Press R to return to the start screen", width / 2, height / 2 + 80);

    return;
}
noStroke();
   drawC();
  
}

  void mousePressed() {
  boolean fishCaught = false; // Balığın yakalanıp yakalanmadığını kontrol etmek için

  for (int i = 0; i < fishList.size(); i++) {
    Fish fish = fishList.get(i);

    if (mouseX < fish.x + 30 && mouseX > fish.x - 30 &&
      mouseY < fish.y + fish.cy + 30 && mouseY > fish.y + fish.cy - 30) {
      fishList.remove(i);
      restFish--;
      fishCaught = true;
      break;
    }
  }

if (!fishCaught) {
  missedAttempts++;
  if (missedAttempts == 1) {
    isHeart2Visible = true; // Heart2 resmini görünür yap
  } else if (missedAttempts == 2) {
    isHeart3Visible = true;
  } else if (missedAttempts == 3) {
    isHeart4Visible = true;

  }
}

}




void mouseMoved() {
  // Fare sınırlarını belirle
  int mouseYMin = 0;
  int mouseYMax = height;


  // Şu anki resim indeksine göre fare sınırlarını ayarla
  if (currentImageIndex == 0) {
    mouseYMin = 900;
    mouseYMax = 960;
  } else if (currentImageIndex == 1) {
    mouseYMin = 790;
    mouseYMax = 850;
  } else if (currentImageIndex == 2) {
    mouseYMin = 680;
    mouseYMax = 740;
  } else if (currentImageIndex == 3) {
    mouseYMin = 570;
    mouseYMax = 630;
  } else if (currentImageIndex == 4) {
    mouseYMin = 460;
    mouseYMax = 520;
  }

  // Fareyi sınırla
  if (mouseY < mouseYMin) {
    mouseY = mouseYMin;
  } else if (mouseY > mouseYMax) {
    mouseY = mouseYMax;
  }
}

void keyPressed() {
  if (startScreen) {
    if (key == 's' || key == 'S') {
      startScreen = false;
      resetGame(); // Oyunu sıfırla
    }
  } else {
    if (key == ' ') {
      pauseImage = !pauseImage; // Duraklatma durumunu tersine çevir
    } else if (key == 'r' || key == 'R') {
      startScreen = true;
      resetGame(); // Oyunu sıfırla
    }
  }
}

void resetGame() {
  missedAttempts = 0;
  isHeart2Visible = false;
  isHeart3Visible = false;
  isHeart4Visible = false;
  restFish = fishCount * rowCount;
  fishList.clear();

  for (int i = 0; i < rowCount; i++) {
    for (int j = 0; j < fishCount; j++) {
      float x = random(width);
      float y = i * fishSpacing;
       float z = i * fishSpacing;
      boolean reverse = random(1) < 0.5;
      float speed = random(3, 8);
      fishList.add(new Fish(x, y, z, reverse, speed));
    }
  }
}

void drawC() {
 translate(width / 2, height / 2+360);
  rotateY(map(mouseX, 0, width, -PI, PI));

  float scaleAmount = 0.1;

  beginShape(QUAD_STRIP);
  texture(img);

  for (int i = 0; i <= tubeRes; i++) { // "<=" koymak, döngünün tam çevreyi tamamlamasını sağlar
    int index = i % tubeRes; // son elemana ulaştığında, başa dönmek için modulo alır
    float x = tubeX[index] * 100 * scaleAmount;
    float z = tubeY[index] * 100 * scaleAmount;
    float u = img.width / (float) tubeRes * i; // u, tubeRes ile aynı sayıda adımda olmalıdır, bu yüzden i kullanılır.
    vertex(x+10, -183, z, u, 0);
    vertex(x+10, 160, z, u, img.height);
  }
  endShape(CLOSE); // shape'yi kapatmak genellikle iyi bir fikirdir

  beginShape(QUADS);
  texture(img);
  float quadSize = 10 * scaleAmount;
  vertex(0, -quadSize, 0, 0, 0);
  vertex(quadSize, -quadSize, 0, quadSize, 0);
  vertex(quadSize, quadSize, 0, quadSize, quadSize);
  vertex(0, quadSize, 0, 0, quadSize);
  endShape();
}
