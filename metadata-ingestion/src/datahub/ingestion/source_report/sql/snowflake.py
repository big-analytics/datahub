from dataclasses import dataclass, field
from typing import Dict, List

from datahub.ingestion.source.sql.sql_common import SQLSourceReport
from datahub.ingestion.source_report.time_window import BaseTimeWindowReport


@dataclass
class BaseSnowflakeReport(BaseTimeWindowReport):
    pass


@dataclass
class SnowflakeReport(BaseSnowflakeReport, SQLSourceReport):
    num_table_to_table_edges_scanned: int = 0
    num_table_to_view_edges_scanned: int = 0
    num_view_to_table_edges_scanned: int = 0
    num_external_table_edges_scanned: int = 0
    upstream_lineage: Dict[str, List[str]] = field(default_factory=dict)

    cleaned_host_port: str = ""
    run_ingestion: bool = False
    provision_role_done: bool = False
    provision_role_success: bool = False

    # https://community.snowflake.com/s/topic/0TO0Z000000Unu5WAC/releases
    saas_version: str = ""
    role: str = ""
    role_grants: List[str] = field(default_factory=list)
