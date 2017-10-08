%option noyywrap
simbolo [" "!\x27#$%&'()*+,-./:;<=>?@[\]_{}]
digito [0-9]
letra_min [a-z]|"ñ"
letra_may [A-Z]|"Ñ"
letra {letra_min}|{letra_may}
identificador {letra}({letra}|{digito})*
numero_entero {digito}+
numero_real  {numero_entero}"."{digito}+
caracter {letra}|{digito}|{simbolo}
string "'"{caracter}+"'"
palabra_reservada "ABS"|"BAJAR"|"CARACTER"|"CONST"|"CUADR"|"CUANDO"|"DIV"|"ENTERO"|"ENTONCES"|"ESCRIB"|"ESCRIBL"|"FALSO"|"FIN"|"HACER"|"HASTA"|"IMPAR"|"INICIO"|"LEER"|"LOGICO"|"MIENTRAS"|"NO"|"O"|"PROGRAMA"|"REAL"|"REPITA"|"RESTO"|"SEA"|"SI"|"SINO"|"SUBIR"|"VAR"|"VERDAD"|"Y"
operador "<"|">"|"="|"+"|"-"|"*"|"/"
puntuacion "."|":"|","|";"|"("|")"
nobasura {string}|{numero_entero}|{numero_real}|{identificador}|{operador}|{puntuacion}
basura [^{nobasura}]



%%
{operador} {fprintf(yyout,"%s\n",yytext);}
{puntuacion} {fprintf(yyout,"%s\n",yytext);}
{palabra_reservada} {fprintf(yyout,"%s\n",yytext);}
{identificador} {fprintf(yyout,"IDENTIFICADOR\n");}
{numero_entero} {fprintf(yyout,"NUMERO_ENTERO\n");}
{numero_real} {fprintf(yyout,"NUMERO_REAL\n");}
{string} {fprintf(yyout,"STRING\n");}
<<EOF>> {yyterminate();}
{basura} {/*printf("basura: (%s)\n",yytext);*/}
%%
int main(){
    yyin = fopen("Bravo.txt","r");
    yyout = fopen("SalidaBravo.txt", "w");
    yylex();
    return 1;
}