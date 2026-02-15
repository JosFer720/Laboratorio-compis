# Analizador Léxico con Flex

**Link al video:** Problema 2.mp4  

---

## Descripción

Este programa implementa un analizador léxico utilizando Flex.  
Reconoce distintos tipos de tokens como identificadores, literales numéricos, operadores, comentarios y cadenas con secuencias de escape.

Además, muestra la línea y la posición donde se encuentra cada token.

---

## Funcionalidades

El programa reconoce:

- Identificadores válidos
- Enteros
- Flotantes
- Notación científica
- Números hexadecimales
- Operadores aritméticos
- Operadores relacionales
- Operadores lógicos
- Comentarios de una línea y multilínea
- Cadenas entre comillas dobles con secuencias de escape
- Delimitadores como paréntesis, llaves, coma y punto y coma
- Errores léxicos con línea y posición

Los comentarios son ignorados y no generan tokens.

---

## Cómo compilar

Dentro del entorno donde esté instalado Flex:

```bash
rm -f lex.yy.c scanner
flex lab1.l
gcc lex.yy.c -o scanner -lfl

## Cómo ejecutar
```bash
rm -f lex.yy.c scanner && flex lab1.l && gcc lex.yy.c -o scanner -lfl && ./scanner prueba.js
