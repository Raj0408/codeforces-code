#include <iostream>
#include <bits/stdc++.h>
using namespace std;

extern int a = 10;


class Node{

public:
    int value;
    Node *next;

    Node(int val){
        value = val;
        next = nullptr;
    }
};


// Shallow copy

int main() {


        try{
            int a = 10/0;
            throw "errorrrorrk";

        }


        catch(exception e){
            cout<<"Error ";
            cout<<e.what()<<endl;

        }

}
