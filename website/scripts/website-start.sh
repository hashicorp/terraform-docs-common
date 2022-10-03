# Repo which we are cloning and executing npm run build:deploy-preview within
REPO_TO_CLONE=dev-portal
# Set the subdirectory name for the terraform-website app
PREVIEW_DIR=website-preview
CLONE_DIR=website-preview
# Get the git branch of the commit that triggered the deploy preview
# - https://vercel.com/docs/concepts/projects/environment-variables#system-environment-variables
# This will power remote image assets in local and deploy previews
CURRENT_GIT_BRANCH=$(git branch --show-current)

# This is where content files live, relative to the website-preview dir
# - override the default of "../content"
LOCAL_CONTENT_DIR=../docs

echo "CURRENT_GIT_BRANCH is $CURRENT_GIT_BRANCH"

should_pull=true

# Clone the dev-portal project, if needed
if [ ! -d "$PREVIEW_DIR" ]; then
    echo "⏳ Cloning the $REPO_TO_CLONE repo, this might take a while..."
    git clone --depth=1 https://github.com/hashicorp/$REPO_TO_CLONE.git "$PREVIEW_DIR"
    should_pull=false
fi

# # use local dev-portal repo
# if [ ! -d "$PREVIEW_DIR" ]; then
#     echo "⏳ Copying the $REPO_TO_CLONE repo, this might take a while..."
#     cp -R "/Users/kevin/repos/dev-portal" "./$PREVIEW_DIR"
# fi

# cd into the preview directory project
cd "$PREVIEW_DIR"

# If the directory already existed, pull to ensure the clone is fresh
if [ "$should_pull" = true ]; then
    git pull origin main
fi

# # Run the dev-portal content-repo start script
PREVIEW_FROM_REPO=terraform-docs-common \
IS_CONTENT_PREVIEW=true \
LOCAL_CONTENT_DIR=$LOCAL_CONTENT_DIR \
CURRENT_GIT_BRANCH=$CURRENT_GIT_BRANCH \
npm run start:local-preview