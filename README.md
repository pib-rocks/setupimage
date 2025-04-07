# pib-rocks/setupimage

Welcome to the “setupimage” repository of pib.rocks! This project provides an automated process for creating images tailored to the pib.rocks robot.

## Table of Contents

- [About](#about)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About

The project `setupimage` automatically creates an individual Raspberry Pi OS (pibOS) image. This is done with the help of a Github workflow process. Here, repositories are cloned, dependencies are installed, a base image is downloaded, the pib backend is installed, the image is created and finally uploaded via a GitHub workflow.

## Features

**Automated Creation of Raspberry Pi OS Images:**
- `setupimage` automates the creation process of a Raspberry Pi OS image as a release to simplify the setup process for the user.

**Simplified Setup Process:**
- The setup process of `pib-backend` is largely automated, requiring no manual intervention from the user.

**Integration with CustomPiOS:**
- The project utilizes [CustomPiOS](https://github.com/guysoft/CustomPiOS) and is dependent on [pib-backend](https://github.com/pib-rocks/pib-backend) to create a customized image.

**Easy Installation:**
- The created image can be flashed onto a microSD card (at least 32GB) using the [rpi-imager](https://github.com/raspberrypi/rpi-imager). Configuration is done directly in the rpi-imager.

**Automatic Final Installation:**
- The installation process of `pib-backend` is completed after the first boot, as Docker images can only be deployed on a running system.

**Use Case:**
- `setupimage` creates a functional image for the [pib.rocks](https://pib.rocks/) robot to facilitate its deployment and configuration.


## Getting Started 

### Prerequisites

Before you begin, ensure you have the following prerequisites:

- Download and install rpi-imager: https://www.raspberrypi.com/software/
- Download latest release from here: https://github.com/pib-rocks/setupimage/releases
- A microSD card (at least 32GB)

### Install on microSD
- Download the latest release, e.g. https://github.com/pib-rocks/setupimage/releases/download/v0.1.0/pibOS-25.04.06-15.34.img.xz 
- Install the local image using rpi-imager.
- Boot the pi with this image.
- Be patient, setting up docker takes time.


### Build locally (optionally)

1. Clone the repository:
  ```bash
  git clone https://github.com/pib-rocks/setupimage.git
  ```

2. Change directory
  ```bash
  cd setupimage/pibOS
  ```

3. Run build script
  ```bash
  sudo ./build_dist
  ```
