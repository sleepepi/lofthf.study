## 13.0.1

## 13.0.0 (October 4, 2020)

### Enhancements
- **General Changes**
  - Changed "Sign in" to "Staff login" to reduce number of accidental sign ups
  - Changed "Articles" to "Newsletters"
  - Articles are now sorted by publish date
- **Document Changes**
  - Featured documents are now display on the Documents Overview
  - Documents can now be renamed
  - Documents can now be archived
    - Archived documents are only visible to editors
    - Archived documents do not show up in search results
- **Gem Changes**
  - Update to ruby 2.7.1
  - Update to rails 6.0.3.3
  - Update to carrierwave 2.1.0
  - Update to kaminari 1.2.1

## 12.0.0 (January 13, 2020)

### Enhancements
- **Dashboard Changes**
  - Dashboard now displays a randomization overview
  - Complete profile widget no longer requires a photo to be uploaded
- **Articles Changes**
  - Editors can now write short articles that will display on the dashboard
- **Folder Changes**
  - Folders are now sorted alphabetically in each category
  - All files in a folder can be downloaded as a single zip file
- **Document Changes**
  - Reduced size of folder names in documents sidebar
  - Admins can now set keywords for documents to improve search results for
    documents
- **Site Changes**
  - Display Staff ID on site pages in the directory
  - Display phone number on site pages in the directory
- **User Changes**
  - Admins can now associate a Staff ID with a user that will display in the
    directory and in the menu bar
- **Gem Changes**
  - Update to ruby 2.6.4
  - Update to rails 6.0.2.1
  - Update to bootstrap 4.4.1
  - Update to carrierwave 2.0.2
  - Update to devise 4.7.1
  - Update to coffee-rails 5.0
  - Update to font-awesome-sass 5.12.0
  - Update to haml 5.1.2
  - Update to jquery-rails 4.3.5
  - Update to pg_search 2.3.2
  - Update to rubyzip 2.0.0

## 11.0.0 (August 10, 2019)

### Enhancements
- **Report Changes**
  - Report pages without any reports now display a message
  - Descriptions can be added to reports that support markdown formatting
  - Left hand column of report tables now freeze when scrolling horizontally
  - Report rows can be marked as emphasized to group rows together visually
    - Subsequent rows are indented until the next emphasized row

## 10.0.0 (August 4, 2019)

### Enhancements
- **Admin Changes**
  - Admins now receive an email when a user confirms their account
- **General Changes**
  - Remove example reports from dashboard
- **Gem Changes**
  - Update to pg_search 2.3.0
  - Remove bootsnap

### Bug Fix
- Fix bug that prevented reports from being reordered on pages

## 9.0.0 (June 23, 2019)

### Enhancements
- **Reports Added**
  - Editors can create reports that pull data from Slice on a daily basis
  - Reports can be grouped on pages that users can see under the home tab on the
    dashboard
- **Gem Changes**
  - Update to ruby 2.6.3
  - Update to devise 4.6.2
  - Update to haml 5.1.1
  - Update to jbuilder 2.9
  - Update to pg_search 2.2.0

## 8.0.0 (April 16, 2019)

### Enhancements
- **Videos Added**
  - Editors can embed videos for users to view
- **Gem Changes**
  - Update to ruby 2.6.2
  - Update to rails 6.0.0.beta3
  - Update to carrierwave 1.3.1
  - Update to devise 4.6.1
  - Update to font-awesome-sass 5.8.1

## 7.1.0 (March 8, 2019)

### Enhancements
- **Gem Changes**
  - Update to bootstrap 4.3.1

## 7.0.1 (February 8, 2019)

### Enhancements
- **Gem Changes**
  - Downgrade to carrierwave 1.2.3

## 7.0.0 (February 8, 2019)

### Enhancements
- **General Changes**
  - Display profile picture in menu
  - Update welcome email to indicate that account approval is needed before site
    access
- **Gem Changes**
  - Update to ruby 2.6.1
  - Update to devise 4.6.0
  - Update to mini_magick 4.9.2

### Bug Fix
- Fix bug where cached browser redirects prevented file downloads

## 6.0.0 (January 29, 2019)

### Enhancements
- **Gem Changes**
  - Update to pg_search 2.1.4

### Bug Fix
- Fix an issue downloading profile pictures via ActiveStorage links

## 5.0.1 (January 25, 2019)

### Bug Fix
- Fix an issue downloading documents via ActiveStorage links

## 5.0.0 (January 25, 2019)

### Enhancements
- **Admin Changes**
  - Account approval email now forwards to the account show page
- **General Changes**
  - Added example pareto chart
- **Site Changes**
  - Coordinating centers now split into Clinical Coordinating Center and Data
    Coordinating Center
- **Gem Changes**
  - Update to ruby 2.6.0
  - Update to rails 6.0.0.beta1
  - Update to carrierwave 1.3.1
  - Update to bootstrap 4.2.1
  - Update to font-awesome-sass 5.6.1

## 4.0.0 (November 7, 2018)

### Enhancements
- **General Changes**
  - Users are now forwarded to dashboard after login if no other internal URL
    was visited before login
  - Updated overall randomization goal number
- **Document Changes**
  - Increased the default maximum upload size for files to 100 MB
  - Uploading files now provides an error message if the files exceed the upload
    limit
- **Gem Changes**
  - Update to ruby 2.5.3

## 3.0.0 (October 16, 2018)

### Enhancements
- **General Changes**
  - Add updated Privacy Policy

## 2.0.2 (October 9, 2018)

### Bug Fixes
- Fix for friendly forwarding
- Dashboard "Complete your profile" section no longer asks for profile picture
  if it has already been uploaded

## 2.0.1 (October 5, 2018)

### Bug Fix
- Fix a crash caused by friendly forwarding that could occur when signing in or
  signing out

## 2.0.0 (October 5, 2018)

### Enhancements
- **General Changes**
  - Update LOFT-HF logo
  - Internal pages and file links now friendly forward after sign in
- **Admin Changes**
  - Simplify folder archiving and management for admins
- **Profile Changes**
  - Users can now edit their profile and account settings
- **Search Changes**
  - Search now returns more specific results as more search terms are added
- **Gem Changes**
  - Update to font-awesome-sass 5.3.1

### Bug Fix
- Fix issue with uploading a file to a folder that shares the same name as
  another folder

## 1.0.0 (August 21, 2018)

### Enhancements
- **General Changes**
  - Add landing page
  - Add contact page
  - Add version page
  - Add dashboard
  - Add directory
  - Add document pages
  - Add randomization report
  - Add data health page
  - Add report card page
  - Add search page
  - Add coordinating centers and recruiting centers pages
- **Admin Changes**
  - Add admin dashboard
  - Add user role management
  - Admins are notified by email when a user registers a new account
- **Editor Changes**
  - Editors can create folders and assign them to a category
  - Editors can upload files to folders
  - Editors can create sites and assign users as members
  - Editors can edit and reorder categories
- **Registration Changes**
  - Welcome emails are sent to new user registrations
  - Users need to confirm their email
  - Users are notified by email when their account is approved
- **Base Web Framework**
  - Rails for the web framework
  - Amazon AWS for hosting and continuous deployment
  - Travis CI for continuous integration testing
  - Devise for authentication
  - Bootstrap for user interface
  - Font Awesome for icons
