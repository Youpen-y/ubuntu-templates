#!/usr/bin/env python3
"""
Tool - Description of tool

Usage:
    python script.py [options]

Author:
    Name <email>
Version:
    0.1.0
License:
    MIT
"""

from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path
from typing import Optional

# --- Logging setup ---
def setup_logging(verbose: bool = False) -> None:
    """Configure logging based on verbosity level."""
    level = logging.DEBUG if verbose else logging.INFO
    logging.basicConfig(
        level=level,
        format="%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )


# --- Core functions ---
def example_function(input_data: str) -> str:
    """
    Example function demonstrating docstring style.

    Args:
        input_data: Input string to process

    Returns:
        Processed output string
    """
    return input_data.upper()


# --- Main logic ---
def parse_args() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(
        description="Description of what this script does.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument(
        "-v", "--verbose",
        action="store_true",
        help="Enable verbose output"
    )
    parser.add_argument(
        "-o", "--output",
        type=Path,
        help="Output file path"
    )
    parser.add_argument(
        "input",
        nargs="?",
        help="Input data or file"
    )
    return parser.parse_args()


def main() -> int:
    """
    Main entry point.

    Returns:
        Exit code (0 for success, non-zero for failure)
    """
    args = parse_args()
    setup_logging(args.verbose)

    try:
        logging.info("Script started")

        # Your logic here
        if args.input:
            result = example_function(args.input)
            print(result)

        logging.info("Script completed successfully")
        return 0

    except KeyboardInterrupt:
        logging.warning("Interrupted by user")
        return 130
    except Exception as e:
        logging.error(f"Error: {e}", exc_info=args.verbose)
        return 1


if __name__ == "__main__":
    sys.exit(main())
