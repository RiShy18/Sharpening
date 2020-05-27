#include <stdio.h>
#include <stdlib.h>

//void edge(unsigned char *i1, int w, int h);
//void contrast(unsigned char *i1, int w, int h, int k);




int main(int argc, char *argv[]){
    void blur(unsigned char *i1, int w, int h);
    void edge(unsigned char *i1, int w, int h);
	// variables
	int value = 0;
	int choice = 0;
	int i,j;
    char information[54];
	int width, height;
	unsigned char *image1,*image2;
	char outfilename[512];
    FILE *input, *output;
	
	// argument check
	if (argc < 3){
		printf("usage: ./program op_num input1.bmp [value|input2.bmp]\n");
		return 1;
	}
	choice = atoi(argv[1]);
	
	// read input image (It must be a 24-bit bmp file)
	input = fopen(argv[2],"rb");
	fread(information, 1, 54, input);
	width = *(int*)(information+18);
	height = *(int*)(information+22);
	image1 = (unsigned char*) calloc(width*height,1); 
	unsigned char blue, green, red;
	for (i=0; i<height; i++)
		for (j=0; j<width; j++){
			blue = getc(input);
            green = getc(input);
            red = getc(input);
			// convert to grayscale
			image1[i*width+j] = (blue+green+red)/3;
		}
	fclose(input);



	// edge operation
	if(choice == 2){
		if (argc < 4){
			printf("usage: ./program 2 input1.bmp value\n");
			return 1;
		}
		value = atoi(argv[3]);
		if (value < 0 || value > 255){
			printf("value must be in [0,255] for this operation\n");
			return 1;
		}
		blur(image1,width,height);
	}

	
	

	// oversharpening operation
	else if(choice == 8){
		edge(image1,width,height);
	}




	// wrong choice for operation
	else{
		printf("op_num must be in [1,10]\n");
		return 1;
	}

	// save the resulting image to a file
	if (choice != 9){
		outfilename[0]='o';
		outfilename[1]='u';
		outfilename[2]='t';
		outfilename[3]='_';
		for (i=0; argv[2][i]!='\0'; i++)
			outfilename[i+4]=argv[2][i];
		outfilename[i+4]='\0';
		output = fopen(outfilename,"wb");
		*(int*)(information+18) = width;
		*(int*)(information+22) = height;
		fwrite(information, 1, 54, output);
		for (i=0; i<height; i++)
			for (j=0; j<width; j++){
				putc(image1[i*width+j],output);
				putc(image1[i*width+j],output);
				putc(image1[i*width+j],output);
			}
		fclose(output);
	}
	free(image1);
	
	return 0;
}