local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

print("Loading C++ snippets from init.lua")

return {
  s(
    {
      trig = "init",
      name = "C++ Template",
      dscr = "C++ competitive programming template",
      priority = 1000, -- Higher priority to override any potential conflicts
    },
    fmt(
      [[
    #include <bits/stdc++.h>
    using namespace std;

    /* clang-format off */

    /* TYPES  */
    #define ll long long
    #define pii pair<int, int>
    #define pll pair<long long, long long>
    #define vi vector<int>
    #define vll vector<long long>
    #define mii map<int, int>
    #define si set<int>
    #define sc set<char>

    /* FUNCTIONS */
    #define f(i,s,e) for(long long int i=s;i<e;i++)
    #define cf(i,s,e) for(long long int i=s;i<=e;i++)
    #define rf(i,e,s) for(long long int i=e-1;i>=s;i--)
    #define pb push_back
    #define eb emplace_back

    /* PRINTS */
    template <class T>
    void print_v(vector<T> &v) {{ cout << "{{"; for (auto x : v) cout << x << ","; cout << "\b}}"; }}

    /* UTILS */
    #define MOD 1000000007
    #define PI 3.1415926535897932384626433832795
    #define read(type) readInt<type>()
    ll min(ll a,int b) {{ if (a<b) return a; return b; }}
    ll min(int a,ll b) {{ if (a<b) return a; return b; }}
    ll max(ll a,int b) {{ if (a>b) return a; return b; }}
    ll max(int a,ll b) {{ if (a>b) return a; return b; }}
    ll gcd(ll a,ll b) {{ if (b==0) return a; return gcd(b, a%b); }}
    ll lcm(ll a,ll b) {{ return a/gcd(a,b)*b; }}
    string to_upper(string a) {{ for (int i=0;i<(int)a.size();++i) if (a[i]>='a' && a[i]<='z') a[i]-='a'-'A'; return a; }}
    string to_lower(string a) {{ for (int i=0;i<(int)a.size();++i) if (a[i]>='A' && a[i]<='Z') a[i]+='a'-'A'; return a; }}
    bool prime(ll a) {{ if (a==1) return 0; for (int i=2;i<=round(sqrt(a));++i) if (a%i==0) return 0; return 1; }}
    void yes() {{ cout<<"YES\n"; }}
    void no() {{ cout<<"NO\n"; }}

    /* clang-format on */

    /* Main()  function */
    auto solve(){{
        //Write your code here
        {}
    }}
    int main()
    {{

        #ifndef ONLINE_JUDGE
        freopen("input.txt", "r", stdin);
        freopen("output.txt", "w", stdout);
        #endif

        int tc;
        cin>>tc;

        while(tc--){{
            solve();
        }}
        return 0;
    }}
  ]],
      { i(1) }
    )
  ),
}
