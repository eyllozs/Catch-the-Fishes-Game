class Fish {
  float x, y, z; 
  float speed = 2;
  boolean reverse;
  float r1, g1 ,b1;
  float r2, g2 ,b2;
  float cx, cy;
  float w, h;
  float offset;

 public Fish()
  {
    update();
    display();
  }
  Fish(float x, float y, float z, boolean reverse, float speed) {
    this.x = x;
    this.y = y;
    this.z = z; // z koordinatını ekliyoruz
    this.reverse = reverse;
    this.speed = speed;
    r1= random(0, 255);
    g1= random(0, 255);
    b1= random(0, 255);
    r2= random(0, 255);
    g2= random(0, 255);
    b2= random(0, 255);
    h= random(20, 30);
    w= random(30, 60);
    cx= 0;
    cy= 480;
    offset = 0;
  }
  
  void update() {
    // Hareket et
    if (reverse) {
      x -= speed;
      if (x < 0) {
        reverse=false;
      }
    } else {
      x += speed;
      if (x > width) {
        reverse=true;
      }
    }
  }

  void display() {
    // Balığı çiz
    pushMatrix();
    translate(x, y);
    // Balık şekli ve özellikleri
    // Burada balığın nasıl görüneceğini belirleyebilirsiniz.
    // Örneğin: ellipse(), triangle(), veya image() fonksiyonlarını kullanabilirsiniz.
    beginShape();
    fill(r1, g1, b1);
    //body
    lightSpecular(20, 220, 220)  ;

    ellipse(cx, cy, w, h);
    noLights()  ;
    if(reverse){
      //tail
      triangle(cx+w/2, cy, cx+w+offset, cy-h/2, cx+w+offset, cy+h/2);
      
      offset = sin(frameCount * 0.05) * 10;
      //üst yüzgeç
     // triangle(cx, cy-h/2, cx+6+offset, cy-h/2-6, cx+4+offset, cy-h/2-2);
      beginShape();
      vertex(cx, cy-h/2, 0);
      vertex(cx+6+offset, cy-h/2-10, 5);
      vertex( cx+4+offset, cy-h/2-1, 0);
      offset = sin(frameCount * 0.05) * 10; 
      endShape(CLOSE);
      
      //alt yğzgeç
      //triangle(cx, cy+h/2, cx+6+offset, cy+h/2+6, cx+4+offset, cy+h/2+2);
      beginShape();
      vertex(cx, cy+h/2, 0);
      vertex(cx+6+offset, cy+h/2+10, 0);
      vertex( cx+4+offset, cy+h/2+1, 0);
      offset = sin(frameCount * 0.05) * 10; 
      endShape(CLOSE);
      //göz
      fill(r2, g2, b2);
      ellipse(cx+-10, cy-2, 7, 7);
      
    } else{
      triangle(cx-w/2, cy, cx-w+offset, cy-h/2, cx-w+offset, cy+h/2);
      offset = sin(frameCount * 0.05) * 10;
      //triangle(cx, cy-h/2, cx-6+offset, cy-h/2-6, cx-4+offset, cy-h/2-2);
      beginShape();
      vertex(cx, cy-h/2, 0);
      vertex(cx-6+offset, cy-h/2-10, 0);
      vertex( cx-4+offset, cy-h/2-1, 0);
      offset = sin(frameCount * 0.05) * 10; 
      endShape(CLOSE);
      //triangle(cx, cy+h/2, cx-6+offset, cy+h/2+6, cx-4+offset, cy+h/2+2);
      beginShape();
      vertex(cx, cy+h/2, 0);
      vertex(cx-6+offset, cy+h/2+10, 0);
      vertex( cx-4+offset, cy+h/2+1, 0);
      offset = sin(frameCount * 0.05) * 10; 
      endShape(CLOSE);
      fill(r2, g2, b2);
      ellipse(cx+10, cy-2, 7, 7);
    }
    
    endShape(CLOSE);
    popMatrix();
  }
}
