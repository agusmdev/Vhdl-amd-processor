### Ejercicio 1
#### Implementación del pipeline:
En este ejercicio agregamos al *datapath* los *flip-flop* y señales necesarias para lograr el pipeline.
Cuando analizamos el programa:

    1. stur x0, [x0]   
    2. stur x1, [x0, #8]   
    3. stur x2, [x0, #16]   
    4. stur x3, [x0, #24]   
    5. stur x4, [x0, #32]   
    6. stur x5, [x0, #40]   
    7.  stur x6, [x0, #48]   
    8. ldur x7, [x0]  
    9. ldur x8, [x0, #8]  
    10. ldur x9, [x0, #16]  
    11. ldur x10, [x0, #24]  
    12. ldur x11, [x0, #32]  
    13. ldur x12, [x0, #40]  
    14. ldur x13, [x0, #48]  
    15. sub x14, x14, x14  
    16. cbz x14, loop  
    17. sub x15, x0, x1  
    loop:  
    18. add x15, x0, x1  
    19. stur x15, [x0, #56]       

Descubrimos que habia presencia de hazards.   
Hazards de datos:   
  - Entre la linea 14 y 15 registro x14  
  - Entre las lineas 18 y 19 registro x15  

Hazard de control:     
  - Entre las lineas 16 y 17
 
Para resolverlos introdujimos instrucciones *nop*. Para los hazards de datos usamos 2 instrucciones *nop* que separaban las lineas conflictivas. 
Para el hazard de control introdujimos 3 *nops* (luego del cbz).  
Se necesitaron de 30 ciclos de clock para completar el programa.


### Ejercicio 3
#### Analisis procesador con pipeline:
       add x0, x31, #0x2 
       add x1, x0, #0x2
       add x2, x1, #0x2
       add x3, x2, #0x2
       stur x0, [x31]
       stur x1, [x31, #8]
       stur x2, [x31, #16]
       stur x3, [x31, #24]
a) Se producen hazards de datos, entre todas las instrucciones *add*, por lo tanto en los registros **X1**, **X2** y **X3** se van a escribir valores incorrectos.
b) No. En este caso no basta reordenando las instrucciones porque cada *add* depende del anterior.
Lo que si se lograria reordenando un poco las instrucciones (iniciso d) seria ahorrar 1 *stall*, pero aun asi se siguen necesitando.
c) Si. Es posible evitar los hazards utilizando instrucciones *nop* ya que si colocamos 2 *nop* debajo de cada *add* nos aseguramos que todos en la etapa de __*decode*__ tengan el valor correcto en cada registro que utilicen.
d) La forma mas conveniente de ejecutar el codigo, utilizando *nop* y cambiando de lugar una instruccion: 

       add x0, x31, #0x2 
       nop
       nop
       add x1, x0, #0x2
       nop
       nop
       add x2, x1, #0x2
       nop
       stur x0, [x31]
       add x3, x2, #0x2
       stur x1, [x31, #8]
       stur x2, [x31, #16]
       stur x3, [x31, #24]
Finalmente luego de ejecutar el codigo en el orden correcto y usando instrucciones *nop*, obtenemos el siguiente resultado en memoria: 

    Memoria RAM de Arm:
    Address Data
    0 0000000000000002
    1 0000000000000004
    2 0000000000000006
    3 0000000000000008
    4 0000000000000000
    5 0000000000000000
        .......
    63 0000000000000000 