#include<stdio.h>

int main() {
    int N, i;
    do{
        printf("Nhap so phan tu cua mang: ");
        scanf("%d", &N);
    } while (N <= 0);
    
    int A[N], B[N], C[N], D[N];
    for (i = 0; i < N; i++) {
        printf("A[%d] = ", i);
        scanf("%d", &A[i]);
    }
    for(i = 0; i < N; i++) {
        B[i] = 1;
    }

    int k = 0;
    for(i = 0; i < N; i++) {
        int count = 1, j;
        if(B[i]) {
            B[i] = 0;
            for(j = i + 1; j < N; j++) {
                if(A[j] == A[i]) {
                    count++;
                    B[j] = 0;
                }
            }
            
            C[k] = A[i];
            D[k] = count;
            k++;
        }
    }

    int min = D[0];
    for (i = 1; i<k; i++) {
        if (D[i] < min) {
            min = D[i];
        }
    }
    printf("Phan tu co so lan xuat hien it nhat trong mang A la:");
    for (i = 0; i<k; i++) {
        if(D[i] == min) {
            printf("\nPhan tu: %d - Xuat hien o vi tri: ", C[i]);
            for(int j = 0; j<N; j++) {
                if (A[j] == C[i])
                    printf("%d ", j);
            }
        }
    }
    return 0;
}