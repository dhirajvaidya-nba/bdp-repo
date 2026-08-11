from pathlib import Path

import pytest
from airflow.models import DagBag


@pytest.fixture()
def dagbag():
    return DagBag(
        dag_folder=str(Path(__file__).parents[1] / "dags"), include_examples=False
    )


def test_no_import_errors(dagbag):
    assert not dagbag.import_errors, f"DAG import errors: {dagbag.import_errors}"
