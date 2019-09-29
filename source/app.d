import std.stdio;


enum Role
    {
        父, 母, 哥, 姐, 弟, 妹, 儿, 女, 爷, 奶, 姥爷, 姥姥, 孙子, 孙女, 外孙子, 外孙女,
        伯, 叔, 姑, 舅, 姨,
    };

enum Decorate
    {
        伯, 叔, 姑, 舅, 姨,
    };

enum CoupleDecorate
    {
        父, 母, 爷, 奶, 夫, 妻
    };

string[] allpeople;

int father(string a, string b)
{
    // if a can call b "father", either true, or "in law", return 1
    return 0;
}

int mother(string a, string b)
{
    // if a can call b "mother", either true, or "in law", return 1
    return 0;
}

int fm(string a, string b)
{
    if (father(a, b) || mother(a, b)) return 1;
    return 0;
}

// the timestamp where a is born
int borntime(string a)
{
    return 1;
}

// gender: 1 = male, 2 = female
int g(string a)
{
    return 0;
}

// if a and b are couple, or was couple
// 1 = yes, and a is husband, b is wife
// 2 = yes, and a is wife, b is husband
// 3 = yes, no distinguish
// 0 = no
int couple(string a, string b)
{
    return 1;
}

// if a and b has relation and in the same level
// 1 = big brother
// 2 = young brother
// 3 = big sister
// 4 = young sister
int slr(string a, string b)
{
    foreach (x; allpeople)
    {
        if (fm(a, x) && fm(b, x))
        {
            if (g(b) == 1) return borntime(a) < borntime(b) ? 1 : 2;
            if (g(b) == 2) return borntime(a) < borntime(b) ? 3 : 4;
        }
    }
    return 0;
}

string[] relation(string a, string b)
{
    string[] r;

    if (father(a, b)) r ~= "父亲";
    if (mother(a, b)) r ~= "母亲";
    if (couple(a, b) == 1) r ~= "丈夫";
    if (couple(a, b) == 2) r ~= "妻子";

    if (fm(b, a)) r ~= (g(b) == 1? "儿子" : "女儿");

    {
        int t = slr(a, b);
        if (t == 1) r ~= "哥哥";
        if (t == 2) r ~= "弟弟";
        if (t == 3) r ~= "姐姐";
        if (t == 4) r ~= "妹妹";
    }

    foreach (x; allpeople)
    {
        if (father(a, x) && father(x, b)) r ~= "爷爷";
        if (father(a, x) && mother(x, b)) r ~= "奶奶";
        if (mother(a, x) && father(x, b)) r ~= "姥爷";
        if (mother(a, x) && mother(x, b)) r ~= "姥姥";

        if (father(b, x) && fm(x, a)) r ~= (g(b) == 1? "孙子" : "孙女");
        if (mother(b, x) && fm(x, a)) r ~= (g(b) == 1? "外孙子" : "外孙女");
    }

    return r;
}

void main()
{
    Role x = Role.父亲;
	writeln("Edit source/app.d to start your project.");
}
