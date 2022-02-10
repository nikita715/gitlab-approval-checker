# gitlab-approval-checker

Plugin for GitLab CI that adds a stage to check whether a merge request is approved by N people or not.

## Usage

Import the plugin to your GitLab CI pipeline:

```yaml
include: 'https://raw.githubusercontent.com/nikita715/gitlab-approval-checker/main/approval-check.gitlab-ci.yml'
```

Add a stage to the pipeline:

```yaml
stages:
- approve
```

Add variables to your Gitlab CI settings:

| Name                     | Value                                      |
|--------------------------|--------------------------------------------|
| PROJECT_PRIVATE_TOKEN    | Private token of the project               |
| PROJECT_UPVOTES_QUANTITY | Required quantity of merge request upvotes |
