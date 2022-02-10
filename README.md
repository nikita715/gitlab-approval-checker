# gitlab-approval-checker

Plugin for GitLab CI that adds a stage to check whether a merge request is approved by N people or not.

## Usage

Import the plugin to your GitLab CI pipeline:

```yaml
include:
  - remote: 'https://raw.githubusercontent.com/nikita715/gitlab-approval-checker/v1.0.0/approval-check.gitlab-ci.yml'
```

Add variables to the pipeline:

```yaml
variables:
  APPROVAL_CHECKER_DEBUG: "true" # ci logging
  APPROVAL_CHECKER_UPVOTES_QUANTITY: "1"  # required quantity of merge request upvotes
```

Add a stage to the pipeline:

```yaml
stages:
- check-approval
```

Add a variable to your Gitlab CI settings:

| Name                           | Value                                                     |
|--------------------------------|-----------------------------------------------------------|
| APPROVAL_CHECKER_PRIVATE_TOKEN | Private token of the project with scopes \[api, read_api] |

## Automated approval checking

You also can enable automatic triggering of failed check-approval jobs when they've got enough upvotes.
In addition to the above settings, you need to import this plugin:

```yaml
include:
  - remote: 'https://raw.githubusercontent.com/nikita715/gitlab-approval-checker/v1.0.0/approval-scheduled-check.gitlab-ci.yml'
```

Add a scheduled pipeline to your project (**CI/CD** > **Schedules**) with a variable:

| Name                                | Value                            |
|-------------------------------------|----------------------------------|
| APPROVAL_CHECKER_SCHEDULED_JOB_NAME | scheduled-approval               |
