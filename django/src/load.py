import json
import sys
from typing import Optional, List, BinaryIO

from dacite import from_dict
from testsolar_testtool_sdk.model.param import EntryParam

from .collector import collect_testcases


def collect_testcases_from_args(
    args: List[str], workspace: Optional[str] = None, pipe_io: Optional[BinaryIO] = None
) -> None:
    if len(args) != 2:
        raise SystemExit("Usage: python load.py <entry_file>")

    filename = args[1]

    with open(filename, "r") as f:
        entry = from_dict(data_class=EntryParam, data=json.loads(f.read()))
        if workspace:
            entry.ProjectPath = workspace
        collect_testcases(entry_param=entry, pipe_io=pipe_io)


if __name__ == "__main__":
    collect_testcases_from_args(sys.argv)