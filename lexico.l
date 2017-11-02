
%option noyywrap
simbolo [ "!#$%&()*+,-./:;<=>?@[\]_{}]
digito [0-9] 
letra [a-zA-Z]|\361|\321
caracter {letra}|{digito}|{simbolo}
identificador {letra}({letra}|{digito})*
numero_entero {digito}+
nr2 "."{digito}
nr3 "E+"|"E-"|"E"
numero_real  {numero_entero}{nr2}|{numero_entero}{nr3}{numero_entero}|{numero_entero}{nr2}{nr3}{numero_entero}
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
{basura} {}
%%
int existsFile(char* fileName) 
{
	FILE* file = NULL;
	file = fopen(fileName,"r");
	if (file == NULL)
		return 0;
	else {
		fclose(file);
		return 1;
	}
	return 0;
}
int validarEntradas(int argc, char** argv){
    //Caso 1

    if (argc == 1){
        printf("Error: Faltan par%cmetros en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 2
    if (argc == 2){
        printf("Error: Falta par%cmetro en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 3 
    if( argc > 3 ){
        printf("Error: Demasiados par%cmetros en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 4
    if (!existsFile(argv[1])){
        printf("Error: El archivo de entrada no existe.\n");
        return 0;
    }
    //Caso 5
    if (existsFile(argv[2])){
        printf("Error: El archivo de salida ya existe.\n");
        return 0;
    }
    return 1;
}
int main(int argc, char** argv){
    if(!validarEntradas(argc,argv)){
        return 0;
    }
    yyin = fopen(argv[1],"r");
    yyout = fopen(argv[2], "w");
    yylex();
    return 1;
}