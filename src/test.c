int main() {
    printf("Hello, World!");
    int x = 10;
    for (int i = 0; i < 5; i++) {
        x = x + i;
    }
    if (x > 15) {
        printf("x is greater than 15");
    } else {
        printf("x is not greater than 15");
    }
}