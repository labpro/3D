# Introdução


# Firmware

Uma parte importante da configuração da impressora é a alteração e instalação do
firmware.  Antes  de tudo, vou ressaltar que esse firmware nada mais é do que um
código    arduino   com   um   monte   de   arquivos   C++   (*.cpp   e   *.h). 

O firmware  que  estamos  usando  é  o Marlin. Esse firmware pode ser encontrado
[neste link](https://github.com/MarlinFirmware/Marlin).


## Como fazer as alterações do firmware?

Em  geral,  a  calibração  da impressora requer que você defina os parâmetros da
impressora,  ou  seja,  o  tamanho  da  mesa,  o  tipo  de motor, como é feita a
transmissão  mecânica  em cada um dos eixos, etc. Essa definição é feita fazendo
alterações   em   um   único   arquivo  do  firmware  chamado  `Configuration.h`

Nesse arquivo você vai encontrar uma série de variáveis que você pode alterar de
acordo  com  a  impressora.  Após todas as alterações necessárias, basta fazer o
upload para o arduino.

### Quais são as variáveis?

Essas  variáveis  estão todas em `firmware/Configuration.h`. Os valores listados
a seguir foram os que sofreram alteração a partir do firmware genérico do Marlin
baixado  do  link  citado acima. Existem muitas outras opções que foram deixadas
conforme já estavam.

##### Porta Serial e taxa de simbolos/seg (taxa de comunicação com o Arduino)
```c
#define SERIAL_PORT 0
#define BAUDRATE 115200
```

##### O tipo e versão da placa (Ramps v1.4)
```c
#ifndef MOTHERBOARD
  #define MOTHERBOARD BOARD_RAMPS_14_EFB
#endif
```
No  arquivo `firmware/boards.h` tem uma lista de todas as placas suportadas pelo
firmware Marlin. A nossa é a de número 43 que é o valor da MACRO `BOARD_RAMPS_14_EFB`.

##### Sensores de Paradas (endstop) para indicar os Limites de Movimento nos eixos
```c
// Mechanical endstop with COM to ground and NC to Signal uses "false" here (most common setup).
#define X_MIN_ENDSTOP_INVERTING true // set to true to invert the logic of the endstop.
#define Y_MIN_ENDSTOP_INVERTING true // set to true to invert the logic of the endstop.
#define Z_MIN_ENDSTOP_INVERTING true // set to true to invert the logic of the endstop.
#define X_MAX_ENDSTOP_INVERTING false // set to true to invert the logic of the endstop.
#define Y_MAX_ENDSTOP_INVERTING false // set to true to invert the logic of the endstop.
#define Z_MAX_ENDSTOP_INVERTING false // set to true to invert the logic of the endstop.
#define Z_MIN_PROBE_ENDSTOP_INVERTING false // set to true to invert the logic of the endstop.
```
os  endstops  são os sensores de parada. Atualmente a impressora possui apenas 4
no  total.  Todavia,  no momento apenas 3 estão sendo usados que são respectivos
aos  eixos X,Y e Z. Eles servem para indicar a coordenada cartesiana `0` de cada
eixo.  Tendo em vista que essa impressora tem os limites de X:[0,200], Y:[0,200]
e Z:[0,200]  dados  em milímetros, seria interessante instalar mais 3 endstops e
configurá-los   para  que  as  coordenadas  `X200  Y200  e  Z200`  também  sejam
identificadas.  Quando  estamos  fazendo  a  calibração,  é muito fácil mover os
motores     para     o     lado    errado    de    forma    não    intensional. 

Também  existe  o  endstop  para fazer o nivelamento automático da mesa. Todavia
ainda       não       conseguimos      configurar      essa      funcionalidade.

Em resumo, o estado atual da impressora é que ela identifica apenas as coordenadas
`(0,0,0)` que são conhecidas como `home (x,y,z)`.

##### Definição dos Limites de movimento depois de fazer o home
```c
// Travel limits after homing (units are in mm)
#define X_MIN_POS 0
#define Y_MIN_POS -10
#define Z_MIN_POS 0
#define X_MAX_POS 198
#define Y_MAX_POS 201
#define Z_MAX_POS 196
```
esses  valores  foram  obtidos com a ajuda do pessoal do Fablab. Todavia, eu não
sei   explicar  como  eles  chegaram  neles.  Aparentemente  esses  valores  são
aproximações  dadas  com  alguma folga para evitar que os motores ultrapassem os
limites físicos da impressora.

##### Configurações de Movimento
```c
#define DEFAULT_AXIS_STEPS_PER_UNIT   {80,80,4000,527.667}  // default steps per unit for Ultimaker
#define DEFAULT_MAX_FEEDRATE          {150, 150, 2, 50}    // (mm/sec)
#define DEFAULT_MAX_ACCELERATION      {1000,1000,5,500}    // X, Y, Z, E maximum start speed for accelerated moves. E default values are good for Skeinforge 40+, for older versions raise them a lot.

#define DEFAULT_ACCELERATION          500    // X, Y, Z and E acceleration in mm/s^2 for printing moves
#define DEFAULT_RETRACT_ACCELERATION  500    // E acceleration in mm/s^2 for retracts
#define DEFAULT_TRAVEL_ACCELERATION   500    // X, Y, Z acceleration in mm/s^2 for travel (non printing) moves

// The speed change that does not require acceleration (i.e. the software might assume it can be done instantaneously)
#define DEFAULT_XYJERK                20.0    // (mm/sec)
#define DEFAULT_ZJERK                 0.4     // (mm/sec)
#define DEFAULT_EJERK                 5.0    // (mm/sec)
```
Esses   valores   correspondem  às  configurações  de  movimentação  padrões  da
impressora.     A     primeira     parte    são    referentes    ao    seguinte:

1. `DEFAULT_AXIS_STEPS_PER_UNIT`: Número de passos(neste caso micropassos) dos 
   motores nos eixos X,Y,Z e E. Esses valores foram obtidos através de fórmulas
   que envolvem vários parâmetros como: Número de passos por revolução, tipo de 
   correias e barras roscadas, etc. Apenas para citar alguns!

2. `DEFAULT_MAX_FEEDRATE`: feedrate nesse caso significa velocidade em mm/seg

quanto as outras configurações ainda não sabemos explicar os valores. Não lembro
se  elas  já  vieram do firmware original do Marlin ou se foram configuradas por
outra  pessoa.  Esses  detalhes ainda precisam ser visto durante a calibração da
impressora  

##### Configurações do Modulo LCD e Cartão SD
```c
#define LCD_LANGUAGE pt-br
#define ULTRA_LCD   // Character based
#define SDSUPPORT
#define REVERSE_MENU_DIRECTION
```
Quanto a essas configurações:
1. `LCD_LANGUAGE`: Português Brasil
2. `ULTRA_LCD`: é o tipo de display da Impressora
3. `SDSUPPORT`: habilita suporte para ler do cartão
4. `REVERSE_MENU_DIRECTION`: sem isso fica estranho controlar pelo display LCD

## Como fazer o upload do firmware para o Arduino?

Uma  vez  que  as  alterações  foram  feitas, chegou a hora de fazer o upload do
firmware  para  o  Arduino  da  impressora. Esse procedimento é tão fácil quanto
fazer  o  upload do blink led. Existem duas maneiras: Pela IDE do Arduino e pela
linha de comando.

Além  disso,  o  firmware  só  vai  conseguir ser compilado corretamente se você
instalar  a  biblioteca  "LiquidCrystal"  pela  IDE do Arduino. Se o seu arduino
estiver  instalado  em  Inglês,  é  só  ir  em  `Sketch->Include Library->Manage
Libraries...`.  Dai  vai  abrir uma janela onde você pode pesquisar por "liquid"
por exemplo. Depois que você abrar, clica em cima dela e depois em `install`. Se
ainda assim você obter erros de compilação o jeito vai ser fazer depuração. Leia
qual  é o erro. Se ele reclamar de que não reconhece o include "alguma coisa" vá
de  novo  em  Manage  Libraries  e  pesquise  por  esse alguma coisa e instale a
biblioteca  necessária.  Se  der  erro  de sintax possivelmente tem alguma coisa
errada no código do firmware.

### Upload Pela IDE do Arduino

1. Abra a IDE do arduino
2. Abra o arquivo que está em `firmware/Marlin.ino`
3. Click no botão upload.
4. Só isso!

### Upload Pela linha de comando

A IDE do Arduino possui uma interface pela linha de comando.

1. Entre no diretório `firmware`
2. Dai é só executar o comando `arduino --upload Marlin.ino`
3. Só isso!

### Upload Pela linha de comando usando o Makefile

Dentro  do  diretório  `firmware` tem um `Makefile` com o comando acima. Se você
tiver o make instalado é só fazer o seguinte:

1. Entre no diretório `firmware`
2. Execute `make upload`
3. Pronto!

É claro que em todos os casos, você deve ter o Arduino conectado pela USB do seu
computador.

## O que falta fazer sobre firmware?

1. Tentar fazer a configuração a partir do zero: Baixar o firmware do Marlin no 
   link dado e tentar entender e refazer todas as opções obtendo os dados 
   precisos para esta impressora. Ainda existe muita incerteza sobre alguns 
   valores.

2. Experimentar as opções em `Configuration.h` uma a uma afim de melhor a 
   precisão.  Essa é uma das partes da calibração que será descrita a seguir.

3. Configurar o `AUTO_BED_LEVELING_FEATURE` em `Configuration.h`. Essa função é 
   importante para fazer peças que exigem uma precisão maior. Isso seria no caso 
   mais um refinamento do que calibração.

# Host Softwares

Host  softwares  são  programas que podem ser instalados no computador e que dão
uma  interface  com  a  sua impressora atravez da comunicação USB com o Arduino.
Dessa  forma,  você  pode  executar vários comandos da impressora através desses
programas. 


## Pronterface

Atualmente  estamos usando o [Pronterface](http://www.pronterface.com/) pois foi
o único  que  está  rodando  dentro  dos conformes no Línux. Todavia, ele só foi
testado  no  Arch Línux de forma que ainda não sabemos o comportamento em outros
sistemas    operacionais    como   o   Windows   e   o   Ubuntu   por   exemplo.

A instalação no Arch Linux pode ser feita pelo pacote do AUR: `printrun-git`.

Esse programa é escrito em python e conta com duas interfaces, uma gráfica e a 
outra pela linha de comando.


# Calibração

# Modelagem
