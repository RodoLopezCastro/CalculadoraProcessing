
//color boton #FF8000
//Pagina porcentaje #FF8000

Panel panel;
boolean primerNum=true;
boolean decimal=false;
String valor="";
String valor2="";
float valorF=0;
float valorF2=0;
String opcion;
float resultado=0;
void setup() {
  size(280,360);
  panel = newPanel();
  panel.add(
    newVBox().gap(0).position(0,0).size(280,360)
    .add(newHBox().gap(0).height(80)
      .add(newTextField().value("0").id("pantalla"))
    )
    .add(newHBox().gap(0)
      .add(newButton("C").id("c"))
      .add(newButton("+/-").id("s"))
      .add(newButton("%").id("%"))
      .add(newButton("÷").id("÷"))
      )
    .add(newHBox().gap(0)
      .add(newButton("7").id("7"))
      .add(newButton("8").id("8"))
      .add(newButton("9").id("9"))
      .add(newButton("X").id("*"))
    )
    .add(newHBox().gap(0)
      .add(newButton("4").id("4"))
      .add(newButton("5").id("5"))
      .add(newButton("6").id("6"))
      .add(newButton("-").id("-"))
    )
    .add(newHBox().gap(0)
      .add(newButton("1").id("1"))
      .add(newButton("2").id("2"))
      .add(newButton("3").id("3"))
      .add(newButton("+").id("+"))
    )
    .add(newHBox().gap(0)
      .add(newButton("0").id("0").width(140))
      .add(newButton(",").id(","))
      .add(newButton("=").id("="))
    )
  );
  panel.update();
}

void draw() {
  background(255);
  panel.draw();
}

void mousePressed() {
  panel.mouseDown(mouseX,mouseY,new Click());
}

void mouseReleased() {
  panel.mouseUp(mouseX,mouseY,null);
}

void keyPressed() {
  panel.keyStroke(key,keyCode,null);
}

class Click extends Action {
  void run(Graphic g) {
    Control c = (Control)g;
    
     if (c.id()=="s"){
        cambioSigno();
      }
      //Numeros
      else if (c.id()=="0")        
        printPanel(c.id());
      else if (c.id()=="1")        
        printPanel(c.id());
      else if (c.id()=="2") 
        printPanel(c.id());
      else if (c.id()=="3") 
        printPanel(c.id());
      else if (c.id()=="4") 
        printPanel(c.id());
      else if (c.id()=="5")
        printPanel(c.id());
      else if (c.id()=="6") 
        printPanel(c.id());
      else if (c.id()=="7") 
        printPanel(c.id());
      else if (c.id()=="8") 
        printPanel(c.id());
      else if (c.id()=="9") 
        printPanel(c.id());
        
       //Operadores 
      else if (c.id()=="+") 
        operadores(c.id());
      else if (c.id()=="-") 
        operadores(c.id());
      else if (c.id()=="*") 
        operadores(c.id());
      else if (c.id()=="÷") 
        operadores(c.id());
        
        
      else if (c.id()=="=") 
        operacion();
      else if (c.id()=="c") 
        limpiar();
      else if (c.id()==",") 
        coma();
        else if (c.id()=="%") 
        porcentaje();
  }
  
  void porcentaje(){
      Control pantalla = (Control)panel.getById("pantalla");
      if(valor2==""){
        valor2 = pantalla.value();
      }
      
      Float result = float(valor) * float(valor2) / 100;
      
      pantalla.value(result+"");
      panel.update();
      
      primerNum= true;
    valor = result+"";
    valor2 = "";
    valorF = 0;
    valorF2 = 0;
    resultado = 0;
    opcion = "c";
  }
  
  void coma(){
      Control pantalla = (Control)panel.getById("pantalla");
      pantalla.value(valor+".");
      panel.update();
      decimal = true;
  }
  
  void cambioSigno(){
    Control pantalla = (Control)panel.getById("pantalla");
    
    float f = float(pantalla.value()) * -1;
    
    pantalla.value(str(f));
    
    if(primerNum){
      valor = str(f);
    }
    else{
      valor2 = str(f);
    }
    
    panel.update();
  }
  
  void printPanel(String id) {
    Control pantalla = (Control)panel.getById("pantalla");

    
    if(primerNum){
      if(decimal){
        valor = float(valor) +float("0."+id)+"";
        pantalla.value(valor);      
        decimal = false;
      }
      else{
        valor += id;
        pantalla.value(valor);
      }
      
      
    }else{
      if(decimal){
        valor2 = float(valor2) +float("0."+id)+"";
        pantalla.value(valor2);      
        decimal = false;
      }
      else{
        valor2 += id;
        pantalla.value(valor2);
      }
    }

    panel.update();
  }
  
  void operadores(String id) {
    primerNum= false;
    opcion = id;
        
    if (resultado != 0) {
        valor2 = "";
    }
    
    Control pantalla = (Control)panel.getById("pantalla");
    
    pantalla.value(id);
    panel.update();
  }
  
  void operacion() {
    Control pantalla = (Control)panel.getById("pantalla");
    
      primerNum = true;
      valorF = float(valor); 
      valorF2 = float(valor2);
      
      if (opcion == "+") {
        resultado = valorF + valorF2;
      }
      else if (opcion == "-") {
        resultado = valorF - valorF2;
      }
      else if (opcion == "*") {
        resultado = valorF * valorF2;
      }
      else if (opcion == "÷") {
        resultado = valorF / valorF2;
      }
      pantalla.value(str(resultado));
      valor = str(resultado);
    panel.update();
  }
  
  
  void limpiar() {
    primerNum= true;
    valor = "";
    valor2 = "";
    valorF = 0;
    valorF2 = 0;
    resultado = 0;
    opcion = "c";
    Control pantalla = (Control)panel.getById("pantalla");
    pantalla.value("0");
    panel.update();
  }
}