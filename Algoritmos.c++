#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <algorithm>

using namespace std;

// Implementación de los algoritmos de ordenamiento

void insertionSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 1; i < n; ++i) {
        int currentElement = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > currentElement) {
            arr[j + 1] = arr[j];
            j--;
        }
        arr[j + 1] = currentElement;
    }
}

void selectionSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; ++i) {
        int minIndex = i;
        for (int j = i + 1; j < n; ++j) {
            if (arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        swap(arr[i], arr[minIndex]);
    }
}

void bubbleSort(vector<int>& arr) {
    int n = arr.size();
    for (int i = 0; i < n - 1; ++i) {
        for (int j = 0; j < n - i - 1; ++j) {
            if (arr[j] > arr[j + 1]) {
                swap(arr[j], arr[j + 1]);
            }
        }
    }
}

void countingSort(vector<int>& arr, int exp) {
    int n = arr.size();
    vector<int> output(n);
    vector<int> count(10, 0);

    for (int i = 0; i < n; ++i) {
        int index = (arr[i] / exp) % 10;
        count[index]++;
    }

    for (int i = 1; i < 10; ++i) {
        count[i] += count[i - 1];
    }

    for (int i = n - 1; i >= 0; --i) {
        int index = (arr[i] / exp) % 10;
        output[count[index] - 1] = arr[i];
        count[index]--;
    }

    for (int i = 0; i < n; ++i) {
        arr[i] = output[i];
    }
}

void radixSort(vector<int>& arr) {
    int maxElement = *max_element(arr.begin(), arr.end());
    int exp = 1;
    while (maxElement / exp > 0) {
        countingSort(arr, exp);
        exp *= 10;
    }
}

vector<int> generador_entrada(int n) {
    vector<int> datos;
    srand(time(0)); // Configuración de la semilla de generación aleatoria
    
    for (int i = 0; i < n; ++i) {
        datos.push_back(rand() % 100 + 1); // Generar números aleatorios en el rango 0-99
    }
    
    return datos;
}

// Función para resolver el problema de ordenamiento

void problema_ordenamiento(vector<int>& datos, int opcion) {
    switch (opcion) {
        case 1:
            insertionSort(datos);
            break;
        case 2:
            selectionSort(datos);
            break;
        case 3:
            bubbleSort(datos);
            break;
        case 4:
            radixSort(datos);
            break;
        default:
            cout << "Opción inválida." << endl;
    }
}

int main() {
    int n = 10; 
    vector<int> datos = generador_entrada(n);

    for(int i = 1; i <= 4; ++i) {
        cout << "Ordenamiento " << i + 1 << ": ";
        problema_ordenamiento(datos, i);
        for (int num : datos) {
        cout << num << " ";
        }
    }
    
    return 0;
}