### **Git Project** 

#### **Objective:**

You will work on a project involving a simple website. You will learn
and practice various Git concepts including branching, merging, handling
merge conflicts, rebasing, pulling, versioning, and rolling back
changes. This project is designed to be completed in 1 hour.

#### **Project Setup (15 minutes)**

1.  **Install Git**: Ensure Git is installed on your system. Verify with
    > git --version.

> ![](.//media/image1.png){width="5.8125in"
> height="2.0833333333333335in"}

**Set Up Git**: Configure your Git username and email:\
\
git config \--global user.name \"Your Name\"

git config \--global user.email \"<your.email@example.com>\"

![](.//media/image2.png){width="5.8125in" height="2.0833333333333335in"}

2.  **Create a GitHub Repository**:

3.  **Initialize the Project**:

git add .

git commit -m \"Initial commit: Added project structure and index.html\"

git push origin main

![](.//media/image3.png){width="6.268055555555556in"
height="3.5236111111111112in"}

#### **Exercise 1: Branching and Basic Operations** 

**Create a New Branch**:\
\
git checkout -b feature/add-about-page

1.  **Add a New Page**:

Create about.html

Commit and push changes:\
\
git add src/about.html

git commit -m \"Added about page\"

git push origin feature/add-about-page

![](.//media/image4.png){width="6.268055555555556in"
height="3.1368055555555556in"}

#### **Exercise 2: Merging and Handling Merge Conflicts** 

**Create Another Branch**:\
\
git checkout main

git checkout -b feature/update-homepage

1.  **Update the Homepage**:

Modify index.html:

Commit and push changes:\
\
git add src/index.html

git commit -m \"Updated homepage content\"

git push origin feature/update-homepage

![](.//media/image5.png){width="6.268055555555556in"
height="3.5416666666666665in"}

2.  **Create a Merge Conflict**:

Modify index.html on the feature/add-about-page branch:

![](.//media/image6.png){width="6.268055555555556in"
height="2.4680555555555554in"}

3.  **Merge and Resolve Conflict**:

Attempt to merge feature/add-about-page into main:\
\
git checkout main

git merge feature/add-about-page

-   

Resolve the conflict in src/index.html, then:\
\
git add src/index.html

git commit -m \"Resolved merge conflict in homepage\"

git push origin main

![](.//media/image7.png){width="6.268055555555556in"
height="3.5055555555555555in"}

#### **Exercise 3: Rebasing** 

1.  **Rebase a Branch**:\
    > \
    > git checkout feature/update-homepage

git rebase main

**Push the Rebased Branch**:\
\
git push -f origin feature/update-homepage

![](.//media/image8.png){width="6.268055555555556in"
height="2.379861111111111in"}

#### **Exercise 4: Pulling and Collaboration** 

1.  **Pull Changes from Remote**:

2.  **Simulate a Collaborator\'s Change**:

3.  **Pull Collaborator\'s Changes**

**Platform**

#### **Objective:**

You will work on a project to collaboratively develop a simple blogging
platform. You will practice various Git concepts including branching,
merging, handling merge conflicts, rebasing, pulling, versioning,
rolling back changes, stashing, and cherry-picking commits. The project
is designed to be completed in 1.5 Hours

#### **Exercise 1: Branching and Adding Features** 

**Create a New Branch for Blog Post Feature**:\
\
git checkout -b feature/add-blog-post

1.  **Add a Blog Post Page**:

> ![](.//media/image9.png){width="5.518055555555556in"
> height="3.1020833333333333in"}

#### **Exercise 2: Collaborating with Merging and Handling Merge Conflicts** 

**Create Another Branch for Author Info**:\
\
git checkout main

git checkout -b feature/add-author-info

1.  **Add Author Info to Blog Page**:

Modify blog.html:\
\
echo \"\<p\>Author: John Doe\</p\>\" \>\> src/blog.html

-   

Commit and push changes:\
\
git add src/blog.html

git commit -m \"Added author info to blog post\"

git push origin feature/add-author-info

![](.//media/image10.png){width="5.518055555555556in"
height="3.1020833333333333in"}

2.  **Create a Merge Conflict**:

Modify blog.html on the feature/add-blog-post branch:\
\
git checkout feature/add-blog-post

git push origin feature/add-blog-post

![](.//media/image11.png){width="5.518055555555556in"
height="3.1020833333333333in"}

3.  **Merge and Resolve Conflict**:

Attempt to merge feature/add-blog-post into main:\
\
git checkout main

git merge feature/add-blog-post

-   

Resolve the conflict in src/blog.html, then:\
\
git add src/blog.html

git commit -m \"Resolved merge conflict in blog post\"

git push origin main

![](.//media/image12.png){width="5.518055555555556in"
height="2.092361111111111in"}

#### **Exercise 3: Rebasing and Feature Enhancement (25 minutes)**

1.  **Rebase a Branch for Comment Feature**:

Rebase feature/add-author-info onto main:\
\
git checkout feature/add-author-info

git rebase main

2.  **Add Comment Section**:

Modify blog.html to add a comment section:

git add src/blog.html

git commit -m \"Added comment section\"

git push origin feature/add-author-info

> ![](.//media/image13.png){width="5.518055555555556in"
> height="2.092361111111111in"}

#### **Exercise 4: Pulling and Simulating Collaboration** 

1.  **Pull Changes from Remote**:

Ensure the main branch is up-to-date:\
\
git checkout main

git pull origin main

-   

2.  **Simulate a Collaborator\'s Change**:

    -   Make a change on GitHub directly (e.g., edit blog.html to add a
        > new comment).

3.  **Pull Collaborator\'s Changes**:

Pull the changes made by the collaborator:\
\
git pull origin main

> ![](.//media/image14.png){width="5.518055555555556in"
> height="2.092361111111111in"}

#### **Exercise 5: Versioning and Rollback** 

1.  **Tagging a Version**:\
    > \
    > git tag -a v1.0 -m \"Version 1.0: Initial release\"

git push origin v1.0

2.  **Make a Change that Needs Reversion**:

Modify blog.html:

git add src/blog.html

git commit -m \"Incorrect comment update\"

git push origin main

![](.//media/image15.png){width="6.268055555555556in"
height="2.376388888888889in"}

3.  **Revert to a Previous Version**:

![](.//media/image16.png){width="6.268055555555556in"
height="2.376388888888889in"}
