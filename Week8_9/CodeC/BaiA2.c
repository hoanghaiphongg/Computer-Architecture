#include<stdio.h>

int main() {
    int x,y,m,n;
    do {
        printf("Nhap so nguyen duong M = ");
        scanf("%d",&m);
    } while (m<=0);
    do {
        printf("Nhap so nguyen duong N = ");
        scanf("%d",&n);
    } while (n<=0);
    
    x=m;
    y=n;
    while(m!=n) {
        if(m>n)
            m-=n;
        else
            n-=m;
    }
    printf("BCNN(%d,%d) = la %d", x, y,(x*y)/m);
    return 0;
}


