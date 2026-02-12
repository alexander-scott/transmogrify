import argparse
import pathlib

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("input")
    parser.add_argument("--output", required=True)
    parser.add_argument("--aux")

    args = parser.parse_args()

    name = pathlib.Path(args.input).name

    if args.aux:
        print(args.aux)

    with open(args.output, "x") as f:
        f.write(name)
