#include<reg52.h>
#include<intrins.h>
unsigned char code dispbitcode[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};//共阳极段码
unsigned char com[]={0x01,0x02,0x04,0x08};//位选地址
unsigned char dispbuf[3];
unsigned char sign;
unsigned char digital;
unsigned int flag=0;
double T;
double U;
int TT;

sbit ST=P3^0;
sbit OE=P3^1;
sbit EOC=P3^5;
sbit CLK=P3^3;
sbit ALARM=P3^4;
sbit STOP=P3^2;
sbit MOTOR=P3^6;

void TimeInitial();
void intInitial();
void Delay(unsigned int i);
void Display(int t);
double func(double U,int a);

void main(){
		TimeInitial();	intInitial();
		CLK=0;	ALARM=0;	MOTOR=0;
		while(1)
		{
			ST=0;ST=1;ST=0;
			while(EOC==0);
			OE=1;
			digital=P0;
			OE=0;

			U=digital*5.0/255.0-2.5;
			T=0.4705*func(U,5)+0.2617*func(U,4)-0.1288*func(U,3)+0.7678*func(U,2)+18.38*U+24.687;
			
			if(T>60){
				MOTOR=1;
				if(!flag)	ALARM=1;
			}
			else ALARM=MOTOR=flag=0;
			
			if(T>0)	TT=T+0.5;
			else		TT=T-0.5;

			if(TT>=0)	sign=0xC0;
			else{			sign=0xBF;	TT=0-TT;}

			Display(TT);
		}
}

void TimeInitial(){ 
	TMOD=0x10;
	TH1=(65536-200)/256;
	TL1=(65536-200)%256;
	EA=1;
	ET1=1;
	TR1=1;
}

void intInitial(){
	IT0=0;
	EA=1;
	EX0=1;
}

void Display(int t){ 
	dispbuf[0]=t%10;				//取个位
	dispbuf[1]=(t/10)%10;		//取十位
	dispbuf[2]=(t/100)%10;	//取百位
	
	P2=com[0];
	P1=sign;
	Delay(5);

	P2=com[1];
	P1=dispbitcode[dispbuf[2]];
	Delay(5); 

	P2=com[2];
	P1=dispbitcode[dispbuf[1]];
	Delay(5);

	P2=com[3];
	P1=dispbitcode[dispbuf[0]];
	Delay(5);
}

double func(double U,int a){
	double UU=1;
	while(a){
		UU=UU*U;
		a--;
	}
	return UU;
}

void Delay(unsigned int i){
  unsigned int j;
  for(;i>0;i--)
  {
		for(j=0;j<125;j++){;}
  }
}

void t1(void) interrupt 3 using 0{
  TH1=(65536-200)/256;
  TL1=(65536-200)%256;
  CLK=~CLK;
}

void int0(void) interrupt 0 using 0{
	ALARM=0;
	flag=1;
}