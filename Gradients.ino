//Gradients.ino

int gradient[] = {100, 80, 60, 40, 20};
// int gradient[] = {100, 90, 50, 10 , 5 };
int LED1 = 11;
int LED2 = 10;
int LED3 = 9;
int LED4 = 6;
int LED5 = 5;
int LED6 = 3;

void setup() 
{

  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(LED4, OUTPUT);
  pinMode(LED5, OUTPUT);
  pinMode(LED6, OUTPUT);


}

void loop() 
{
  // Calculate brightnesses //
  int Br1 = map(gradient[0], 0, 100, 0, 255);
  int Br2 = map(gradient[1], 0, 100, 0, 255);
  int Br3 = map(gradient[2], 0, 100, 0, 255);
  int Br4 = map(gradient[3], 0, 100, 0, 255);
  int Br5 = map(gradient[4], 0, 100, 0, 255);
  int Br6 = map(gradient[5], 0, 100, 0, 255);

  // Write to LEDs //
  analogWrite(LED1, Br1);
  analogWrite(LED2, Br2);
  analogWrite(LED3, Br3);
  analogWrite(LED4, Br4);
  analogWrite(LED5, Br5);
  analogWrite(LED6, Br6);

  
}