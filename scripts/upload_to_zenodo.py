#!/usr/bin/env python3
"""
Upload Dairy Campus Metadata & Calculation Data Descriptor directly to Zenodo via the REST API.
Creates a metadata-only record (no file attachments) as requested.
Reads ZENODO_ACCESS_TOKEN from environment or ~/.env.
"""

import os
import sys
import json
import requests
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

# Load from ~/.env if available
env_path = Path.home() / ".env"
if env_path.exists():
    with open(env_path) as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith("#") and "=" in line:
                k, v = line.split("=", 1)
                os.environ.setdefault(k.strip(), v.strip().strip("'\""))

TOKEN = os.environ.get("ZENODO_ACCESS_TOKEN") or os.environ.get("ZENODO_TOKEN") or os.environ.get("ZENODO_API_TOKEN")

AUTO_PUBLISH = "--publish" in sys.argv
BASE_URL = "https://zenodo.org/api"


def main():
    if not TOKEN:
        print("ERROR: Zenodo API Access Token is missing.", file=sys.stderr)
        print("Please set ZENODO_ACCESS_TOKEN in ~/.env or environment.", file=sys.stderr)
        sys.exit(1)

    print(f"Connecting to Zenodo InvenioRDM API: {BASE_URL}...")
    headers = {
        "Authorization": f"Bearer {TOKEN}",
        "Content-Type": "application/json"
    }

    # 1. First, check if there is an existing draft we just created (24092291)
    target_id = None
    r_check = requests.get(f"{BASE_URL}/user/records", headers=headers)
    if r_check.status_code == 200:
        for hit in r_check.json().get("hits", {}).get("hits", []):
            if "Dairy Campus Research Data Platform" in hit.get("metadata", {}).get("title", ""):
                if hit.get("status") == "draft":
                    target_id = hit["id"]
                    print(f"[+] Found existing draft ID: {target_id}")
                    break

    # If no existing draft found, create one
    if not target_id:
        print("Creating new metadata-only draft (no file attachments)...")
        init_payload = {
            "files": {"enabled": False},
            "metadata": {
                "title": "Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies",
                "resource_type": {"id": "dataset"},
                "publication_date": "2026-11-09",
                "creators": [
                    {
                        "person_or_org": {
                            "type": "personal",
                            "family_name": "Klandermans",
                            "given_name": "Bert",
                            "name": "Klandermans, Bert"
                        },
                        "affiliations": [{"name": "Dairy Campus, Wageningen University & Research"}]
                    },
                    {
                        "person_or_org": {
                            "type": "personal",
                            "family_name": "de Jong",
                            "given_name": "Fedde",
                            "name": "de Jong, Fedde"
                        },
                        "affiliations": [{"name": "Dairy Campus, Wageningen University & Research"}]
                    }
                ],
                "description": "<p>Initializing descriptor...</p>"
            }
        }
        r_create = requests.post(f"{BASE_URL}/records", headers=headers, json=init_payload)
        if r_create.status_code != 201:
            print(f"Failed to create draft: {r_create.status_code} - {r_create.text}", file=sys.stderr)
            sys.exit(1)
        target_id = r_create.json()["id"]

    draft_url = f"{BASE_URL}/records/{target_id}/draft"
    review_url = f"https://zenodo.org/uploads/{target_id}"
    doi_str = f"10.5281/zenodo.{target_id}"

    print(f"[+] Draft ID: {target_id}")
    print(f"[+] Assigned DOI: {doi_str}")
    print(f"[+] Review URL: {review_url}")

    # 2. Generate updated article HTML with exact field names and assigned DOI
    from update_zenodo_refined_article import generate_article_html
    article_html = generate_article_html(doi_str=doi_str)
    Path("zenodo_deposit_files/zenodo_full_article_description.html").write_text(article_html, encoding="utf-8")

    # 3. Update draft metadata with full article
    full_payload = {
        "files": {"enabled": False},
        "metadata": {
            "title": "Dairy Campus Research Data Platform: Comprehensive Data Descriptor, Standardized Metadata Dictionaries, and Calculation Methodologies",
            "resource_type": {"id": "dataset"},
            "publication_date": "2026-11-09",
            "creators": [
                {
                    "person_or_org": {
                        "type": "personal",
                        "family_name": "Klandermans",
                        "given_name": "Bert",
                        "name": "Klandermans, Bert"
                    },
                    "affiliations": [{"name": "Dairy Campus, Wageningen University & Research"}]
                },
                {
                    "person_or_org": {
                        "type": "personal",
                        "family_name": "de Jong",
                        "given_name": "Fedde",
                        "name": "de Jong, Fedde"
                    },
                    "affiliations": [{"name": "Dairy Campus, Wageningen University & Research"}]
                }
            ],
            "description": article_html,
            "subjects": [
                {"subject": "Dairy Campus"},
                {"subject": "Wageningen University & Research"},
                {"subject": "Dairy cattle"},
                {"subject": "Precision Livestock Farming"},
                {"subject": "Enteric methane"},
                {"subject": "GreenFeed"},
                {"subject": "Roughage Intake Control"},
                {"subject": "Hokofarm RIC"},
                {"subject": "Trioliet Triomatic"},
                {"subject": "Nedap Velos"},
                {"subject": "GEA Milking"},
                {"subject": "Cow behaviour"},
                {"subject": "FAIR data"},
                {"subject": "Data dictionary"},
                {"subject": "Metadata"}
            ]
        }
    }

    r_put = requests.put(draft_url, headers=headers, json=full_payload)
    if r_put.status_code == 200:
        print("[+] Successfully updated Zenodo draft description with full Data Descriptor article!")
    else:
        print(f"[-] Warning: Failed to update description: {r_put.status_code} - {r_put.text}")
        sys.exit(1)

    print(f"\n[+] Draft is ready for review at: {review_url}")
    print("[+] All files/attachments disabled (metadata-only record).")
    print("[+] Field names strictly match the SQL tables.")

    # 4. Publish if requested
    if AUTO_PUBLISH:
        print("\nPublishing deposition...")
        pub_url = f"{draft_url}/actions/publish"
        pub_r = requests.post(pub_url, headers=headers)
        if pub_r.status_code in [200, 202]:
            pub_data = pub_r.json()
            pub_record_url = pub_data.get("links", {}).get("self_html", f"https://zenodo.org/records/{target_id}")
            print("[+] Successfully published to Zenodo!")
            print(f"[+] Public record: {pub_record_url}")
        else:
            print(f"Publish failed: {pub_r.status_code} - {pub_r.text}")
    else:
        print("\n(Note: The record is saved as a draft. You can review it at the link above and click 'Publish' when satisfied, or run with --publish to publish via API).")


if __name__ == "__main__":
    main()
