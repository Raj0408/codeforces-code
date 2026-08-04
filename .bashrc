##########################
# Codeforces Setup
##########################

# -------------------------
# Compile + run with input/expected check
# Works for contest (common input/output) and practice (per-problem input/output)
# -------------------------
cf() {
    if [ -z "$1" ]; then
        file=$(ls -t *.cpp 2>/dev/null | head -n 1)
        if [ -z "$file" ]; then
            echo "⚠️ No .cpp files found!"
            return 1
        fi
        echo "📂 Using latest file: $file"
    else
        file="$1"
    fi

    exe="${file%.cpp}"

    # Compile
    g++ -std=c++17 -O2 -Wall "$file" -o "$exe"
    if [ $? -ne 0 ]; then
        echo "❌ Compilation failed!"
        return 1
    fi
    echo "✅ Compiled $file → $exe"

    # Check for contest common input or local input
    if [ -f "../input.txt" ]; then
        echo "▶ Running with contest input.txt ..."
        ./"$exe" < ../input.txt | tee ../output.txt
        out="../output.txt"
        exp="../expected.txt"
    elif [ -f "input.txt" ]; then
        echo "▶ Running with local input.txt ..."
        ./"$exe" < input.txt | tee output.txt
        out="output.txt"
        exp="expected.txt"
    else
        echo "▶ Running without input redirection ..."
        ./"$exe"
        return
    fi

    # Compare with expected if exists
    if [ -f "$exp" ]; then
        echo "🔍 Comparing with $exp ..."
        if diff -q "$out" "$exp" >/dev/null; then
            echo "✅ Output matches expected!"
        else
            echo "❌ Output differs!"
            echo "--- Your Output ---"
            cat "$out"
            echo "--- Expected Output ---"
            cat "$exp"
            echo "-------------------"
        fi
    fi
}

# -------------------------
# Run manually with any input file
# -------------------------
cfmanual() {
    if [ -z "$1" ]; then
        echo "Usage: cfmanual <inputfile>"
        return 1
    fi
    file=$(ls -t *.cpp 2>/dev/null | head -n 1)
    exe="${file%.cpp}"
    if [ ! -f "$exe" ]; then
        g++ -std=c++17 -O2 -Wall "$file" -o "$exe" || return 1
    fi
    echo "▶ Running $exe with $1 ..."
    ./"$exe" < "$1"
}

# -------------------------
# Create a new practice problem
# -------------------------
cfpractice() {
    if [ -z "$1" ]; then
        echo "Usage: cfpractice <problem_name>"
        return 1
    fi
    base=/media/data/Codeforces/practice"$1"
    mkdir -p "$base"
    cp /media/data/Codeforces/template.cpp "$base/main.cpp"
    touch "$base/input.txt" "$base/expected.txt"
    echo "✅ Practice problem $1 setup at $base"
}

# -------------------------
# Setup a new contest with problems A..F
# Common input/output at contest root
# -------------------------
cfcontest() {
    if [ -z "$1" ]; then
        echo "Usage: cfcontest <contest_id>"
        return 1
    fi
    base=/media/data/Codeforces/contest_"$1"
    mkdir -p "$base"
    for p in A B C D E F; do
        mkdir -p "$base/$p"
        cp /media/data/Codeforces/template.cpp "$base/$p/$p.cpp"
    done
    touch "$base/input.txt" "$base/expected.txt"
    echo "✅ Contest $1 setup at $base (common input/output at root)"
}

# -------------------------
# Create a single new file from template (standalone problem)
# -------------------------
cfnew() {
    if [ -z "$1" ]; then
        echo "Usage: cfnew <filename>"
        return 1
    fi
    cp /media/data/Codeforces/template.cpp "$1.cpp"
    touch input.txt expected.txt
    echo "✅ Created $1.cpp with input.txt & expected.txt"
}
