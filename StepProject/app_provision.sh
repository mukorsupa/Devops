#!/bin/bash

# Install dependencies
sudo apt-get update
sudo apt-get install -y openjdk-11-jdk git

. /etc/environment 

# Set up project directory (ensure APP_USER is correct)
PROJECT_DIR="/home/$APP_USER/petclinic/StepProject/PetClinic"
APP_DIR="/home/$APP_USER"

# Create directory
sudo mkdir -p $PROJECT_DIR 
sudo chown -R $APP_USER:$APP_USER $PROJECT_DIR

# Clone the repository as APP_USER
git clone https://oauth2:glpat-LQmMqGYc5fsysn-hcswK@gitlab.com/dan-it/groups/devops3.git $PROJECT_DIR

# Check for directory existence after cloning
if [ ! -d "$PROJECT_DIR" ]; then
  echo "Error: Project directory was not created. Check Git clone step."
  exit 1  
fi

# Maven build (as APP_USER)
sudo -u $APP_USER -H $PROJECT_DIR/mvnw clean test package

# Copy the JAR file (as APP_USER)
sudo -u $APP_USER -H cp $PROJECT_DIR/target/*.jar $APP_DIR/petclinic.jar 

# Run the application as APP_USER
sudo -u $APP_USER -H java -jar $APP_DIR/petclinic.jar & 
