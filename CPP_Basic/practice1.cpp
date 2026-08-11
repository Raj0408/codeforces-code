#include <bits/stdc++.h>

using namespace std;

// this code generate the non consecutive 1 binary string of n length

void generateStrings(int n,vector<string> &vec,string prev,string s){
    if(n == 0){
        vec.push_back(s);
        return;
    }
    // i have two option select 0 or 1 
    generateStrings(n-1,vec,"0",s+"0");
    if(prev != "1"){
        generateStrings(n-1,vec,"1",s+"1");
    }
}

void generatePrentheses(int n,vector<string> &vec,int left, int right,string s){
    if(s.size() == 2 * n){
        vec.push_back(s);
        return;
    }   

    if(left < n){
        generatePrentheses(n,vec,left+1,right,s+"(");
    }
    if(right < n && left != right){
        generatePrentheses(n,vec,left,right+1,s+")");
    }
    
}

void powerSet(string s,vector<string> &vec,int i,string curr){
    vec.push_back(curr);
    for(int j = i;j<s.size();j++){  
        curr.push_back(s[j]);
        powerSet(s,vec,j+1,curr);
        curr.pop_back();
    }
}

int main(){
    int n = 3;
    // cin >> n;
    vector<string> vec;
    // generateStrings(n,vec,"","");
    // generatePrentheses(n,vec,0,0,"");
    powerSet("abcd",vec,0,"");
    for(auto &i:vec){
        for(auto k:i){
            cout<<k;
        }
        cout<<"@@";
    }

}