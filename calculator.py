import ast
import operator

# Supported operations
operators = {
    ast.Add: operator.add,
    ast.Sub: operator.sub,
    ast.Mult: operator.mul,
    ast.Div: operator.truediv,
    ast.USub: operator.neg
}

def evaluate(node):
    if isinstance(node, ast.Num):  # Single number
        return node.n
    
    elif isinstance(node, ast.BinOp):  # a + b, a * b, etc.
        left = evaluate(node.left)
        right = evaluate(node.right)
        op_type = type(node.op)

        if op_type in operators:
            return operators[op_type](left, right)
        else:
            raise ValueError(f"Unsupported operator: {op_type.__name__}")

    elif isinstance(node, ast.UnaryOp):  # Negative numbers: -5
        op_type = type(node.op)
        if op_type in operators:
            return operators[op_type](evaluate(node.operand))
        else:
            raise ValueError(f"Unsupported unary operator: {op_type.__name__}")

    else:
        raise ValueError(f"Invalid expression node: {node}")

def calculate(expression: str):
    try:
        parsed = ast.parse(expression, mode='eval')
        return evaluate(parsed.body)
    except Exception as e:
        return f"Error: {e}"


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
    print("=== Calculator and Hex-to-RGB Converter ===")

    while True:
        expr = input(">").strip()

        if expr.lower() == "exit":
            break

        if expr.startswith("#"):
            try:
                rgb = hex_to_rgb(expr)
                print(f"{{r={rgb['r']}, g={rgb['g']}, b={rgb['b']}}}")
            except ValueError as e:
                print(f"Error: {e}")
        else:
            result = calculate(expr)
            print(result)


if __name__ == "__main__":
    main()
