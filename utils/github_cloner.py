import os
import subprocess
from typing import Optional


def clone_repo(url: str, dest_root: str) -> str:
    """
    Clone a Git repository to a destination folder.

    Args:
        url (str): Git repository URL.
        dest_root (str): Root directory to clone into.

    Returns:
        str: Path to the cloned repository.
    """
    os.makedirs(dest_root, exist_ok=True)

    repo_name = url.rstrip("/").split("/")[-1]
    if repo_name.endswith(".git"):
        repo_name = repo_name[:-4]

    dest_path = os.path.join(dest_root, repo_name)

    if os.path.exists(dest_path):
        print(f"[RepoCloner] Repository already exists at {dest_path}")
        return dest_path

    try:
        subprocess.check_call(["git", "clone", "--depth", "1", url, dest_path])
        print(f"[RepoCloner] Cloned repository to {dest_path}")
    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"[RepoCloner] Failed to clone repository: {e}")

    return dest_path