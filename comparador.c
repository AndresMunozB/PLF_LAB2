#include <stdio.h>
#include <string.h>


int compare(char* first, char* second){
	FILE* file_first = fopen(first,"r");
	FILE* file_second = fopen(second,"r");
	char buffer_first[200];
	char buffer_second[200];
	int lineas = 0;
	while(!feof(file_first)){
		lineas++;
		fscanf(file_first,"%s",buffer_first);
		fscanf(file_second,"%s",buffer_second);
		if(strcmp(buffer_first,buffer_second)){
			printf("Error linea: %d\n",lineas);
		}

	}
}
int main(int argc,char **argv){
	compare(argv[1],argv[2]);
}