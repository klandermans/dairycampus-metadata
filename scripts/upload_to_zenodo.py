#!/usr/bin/env python3
"""
Upload Dairy Campus Metadata & Calculation Package directly to Zenodo via the REST API.
Reads ZENODO_ACCESS_TOKEN from environment or ~/.env.
"""

import os
import sys
import json
import requests
from pathlib import Path

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

USE_SANDBOX = "--sandbox" in sys.argv
AUTO_PUBLISH = "--publish" in sys.argv

BASE_URL = "https://sandbox.zenodo.org/api" if USE_SANDBOX else "https://zenodo.org/api"
DEPOSITS_URL = f"{BASE_URL}/deposit/depositions"

FILES_TO_UPLOAD = [
    "zenodo_deposit_files/01_Dairy_Campus_Master_Data_Dictionary.csv",
    "zenodo_deposit_files/02_Dairy_Campus_Metadata_Dictionary_EN.xlsx",
    "zenodo_deposit_files/03_Dairy_Campus_Complete_Data_Catalog.html",
    "zenodo_deposit_files/03_Dairy_Campus_Complete_Data_Catalog.md",
    "zenodo_deposit_files/04_Dairy_Campus_Calculations_and_Queries.zip"
]

METADATA = {
    "metadata": {
        "title": "Dairy Campus Research Data Platform: Metadata Dictionary, Extraction Queries, and Calculation Models",
        "upload_type": "dataset",
        "description": open("zenodo_deposit_files/zenodo_description_ready_to_paste.html").read(),
        "creators": [
            {
                "name": "Klandermans, Bert",
                "affiliation": "Dairy Campus, Wageningen University & Research"
            },
            {
                "name": "de Jong, Fedde",
                "affiliation": "Dairy Campus, Wageningen University & Research"
            }
        ],
        "keywords": [
            "Dairy Campus",
            "Wageningen University & Research",
            "Dairy cattle",
            "Precision Livestock Farming",
            "Enteric methane",
            "GreenFeed",
            "Roughage Intake Control",
            "Hokofarm RIC",
            "Trioliet Triomatic",
            "Nedap Velos",
            "GEA Milking",
            "Cow behaviour",
            "FAIR data",
            "Data dictionary",
            "Metadata"
        ],
        "access_right": "open",
        "license": "cc-by-4.0"
    }
}


def main():
    if not TOKEN:
        print("ERROR: Zenodo API Access Token is missing.", file=sys.stderr)
        print("Please set ZENODO_ACCESS_TOKEN in ~/.env or environment.", file=sys.stderr)
        sys.exit(1)

    print(f"Connecting to Zenodo API: {BASE_URL}...")
    headers = {"Content-Type": "application/json"}
    params = {"access_token": TOKEN}

    # 1. Create Deposition Draft
    print("Creating new draft deposition...")
    r = requests.post(DEPOSITS_URL, params=params, json=METADATA, headers=headers)
    if r.status_code not in [200, 201]:
        print(f"Failed to create deposition: {r.status_code} - {r.text}", file=sys.stderr)
        sys.exit(1)

    deposition = r.json()
    dep_id = deposition["id"]
    bucket_url = deposition["links"]["bucket"]
    view_url = deposition["links"]["html"]
    doi = deposition.get("metadata", {}).get("prereserve_doi", {}).get("doi", "N/A")

    print(f"\n[+] Created Deposition ID: {dep_id}")
    print(f"[+] Reserved DOI: {doi}")
    print(f"[+] Deposition URL: {view_url}\n")

    # 2. Upload Files to the Bucket
    for fpath in FILES_TO_UPLOAD:
        if not os.path.exists(fpath):
            print(f"Warning: File {fpath} not found, skipping.")
            continue
        fname = os.path.basename(fpath)
        print(f"Uploading {fname} ({os.path.getsize(fpath) / 1024:.1f} KB)...", end="", flush=True)
        with open(fpath, "rb") as fp:
            upload_url = f"{bucket_url}/{fname}"
            upload_r = requests.put(upload_url, data=fp, params=params)
            if upload_r.status_code in [200, 201]:
                print(" OK")
            else:
                print(f" FAILED: {upload_r.status_code} - {upload_r.text}")

    print("\n[+] All files uploaded successfully!")
    print(f"[+] Draft is ready for review at: {view_url}")

    # 3. Publish if requested
    if AUTO_PUBLISH:
        print("\nPublishing deposition...")
        publish_url = f"{DEPOSITS_URL}/{dep_id}/actions/publish"
        pub_r = requests.post(publish_url, params=params)
        if pub_r.status_code == 202:
            print("[+] Successfully published to Zenodo!")
            print(f"[+] Public record: {view_url}")
        else:
            print(f"Publish failed: {pub_r.status_code} - {pub_r.text}")
    else:
        print("\n(Note: The record has been saved as a draft. You can inspect it at the URL above and click 'Publish' when ready, or run with --publish to publish automatically).")


if __name__ == "__main__":
    main()
