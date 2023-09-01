#include <stdio.h>
#include <string.h>

int main() {
    char string[100];
    int check = 0, i;    
    while (check == 0 ) {
        printf("Nhap xau ky tu: ");
        gets(string);
        for(i = 0; i < strlen(string); i++) {
            if(string[i] != ' ' && string[i] != '\0') {
                    check = 1;
            }
        }
        if(check == 0) {
            printf("ERROR: Khong duoc de trong. Vui long nhap lai!\n");
        }
    }
    int count = 0, shortest = 100;

    for (i = 0; i <= strlen(string); i++) {
        if (string[i] != ' ' && string[i] != '\0') {
            count++;
        } else {
            if (count < shortest && count != 0) {
                shortest = count;
            }
            count = 0;
        }
    }
    int z = 0, dem = 0;
    printf("Ky tu ngan nhat trong chuoi vua nhap la: ");
    for(i = 0; i < strlen(string); i++) {
        if(string[i] != ' ') {
            dem++;
            if(dem == shortest && (string[i+1] == ' ' || string[i+1] == '\0')) {
                if(z != 0 )
                    printf(", ");
                printf("'");
                for(int j = i - dem + 1; j <= i; j++)
                    printf("%c", string[j]);
                printf("'");
                z++;
            }
        } else {
            dem = 0;
        }
    }
    return 0;
}
