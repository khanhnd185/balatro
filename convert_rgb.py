def hex_to_rgb(hex_str: str):
    """Convert a hex color string into an RGB dictionary."""
    # Remove '#' if present
    hex_str = hex_str.lstrip('#')

    # Validate length
    if len(hex_str) != 6:
        raise ValueError("Hex color must be exactly 6 characters.")

    try:
        r = int(hex_str[0:2], 16)
        g = int(hex_str[2:4], 16)
        b = int(hex_str[4:6], 16)
    except ValueError:
        raise ValueError("Hex color contains invalid characters. Use 0-9 and A-F only.")

    return {"r": r, "g": g, "b": b}


def main():
    print("=== Hex-to-RGB Converter ===")

    while True:
        hex_input = input(">").strip()

        if hex_input.lower() == "exit":
            break

        try:
            rgb = hex_to_rgb(hex_input)
            print(f"{{r={rgb['r']}, g={rgb['g']}, b={rgb['b']}}}")
        except ValueError as e:
            print(f"Error: {e}")


if __name__ == "__main__":
    main()
