# Fairmont rXg Portal

Custom splash and landing pages for the Fairmont rXg portal system.

## Repository Structure

This repository contains all the files needed for the Fairmont custom portal:

- **views/**: ERB template files for splash pages, login forms, etc.
- **stylesheets/**: SCSS/CSS files for portal styling
- **javascripts/**: JavaScript files for portal functionality  
- **images/**: Image assets (logos, backgrounds, icons)
- **react_components/**: React components for dynamic features
- **fair_controller.rb**: Ruby controller with custom logic
- **bootstrap.yml**: Portal configuration and email templates

## rXg Git Integration

This repository is designed to work with rXg's native Git portal source feature:

1. The rXg device pulls files directly from this repository
2. Changes pushed to the repository are automatically synced
3. The web server can restart automatically after sync

## Making Changes

### Splash Page Changes
- Edit `views/_splash.erb` for the main splash page
- Edit `views/_index.erb` for the landing page logic
- Modify `stylesheets/portal.scss.erb` for styling

### Images and Assets
- Replace images in the `images/` directory
- Update image references in the view files

### Advanced Customization
- Modify `fair_controller.rb` for custom logic
- Update `bootstrap.yml` for email templates and configuration

## Development Workflow

1. Make changes to files in this repository
2. Commit and push changes to GitHub
3. rXg device automatically pulls changes (based on sync frequency)
4. Test changes on the portal

## Portal Access

Once deployed, users will see:
- Custom splash page with Fairmont branding
- Login forms for different authentication methods
- Customized styling and imagery