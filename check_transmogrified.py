import argparse
import pathlib

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input")
    parser.add_argument("--expected", required=True)

    args = parser.parse_args()

    with open(args.input) as f:
        actual = f.read()
        expected = pathlib.Path(args.expected).name
        assert actual == expected, f"expected: {expected}, got: {actual}"
