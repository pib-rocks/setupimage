# pib-rocks/setupimage

Welcome to the “setupimage” repository of pib.rocks! This project streamlines the creation of custom Raspberry Pi OS images tailored for the pib.rocks robot, automating the setup process for ease of use.

## Table of Contents

- [About](#about)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Building Locally](#building-locally)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## About

The `setupimage` project automates the creation of a custom Raspberry Pi OS (pibOS) image using a GitHub workflow. This process includes cloning repositories, installing dependencies, downloading a base image, setting up the pib backend, creating the image, and uploading it as a release.

## Features

- **Automated Image Creation:**  
  Automates the creation of a Raspberry Pi OS image, simplifying the setup process for users.
- **Streamlined Setup:**  
  Automates the setup process for `pib-backend`, eliminating the need for manual intervention.
- **CustomPiOS Integration:**  
  Utilizes [CustomPiOS](https://github.com/guysoft/CustomPiOS) and depends on [pib-backend](https://github.com/pib-rocks/pib-backend) to create a tailored image.
- **Easy Installation:**  
  The created image can be flashed onto a microSD card (minimum 32GB) using [rpi-imager](https://github.com/raspberrypi/rpi-imager), with configuration handled directly within the imager.
- **Automatic Final Installation:**  
  Completes the installation of `pib-backend` after the first boot, as Docker images require a running system for deployment.
- **Use Case:**  
  Facilitates the deployment and configuration of the [pib.rocks](https://pib.rocks/) robot by creating a functional image.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following:

- [rpi-imager](https://www.raspberrypi.com/software/) installed.
- A microSD card with at least 32GB of storage.
- The latest release from the [setupimage releases page](https://github.com/pib-rocks/setupimage/releases).

### Installation

1. **Download the Latest Release:**
   - Example: [pibOS-25.04.06-15.34.img.xz](https://github.com/pib-rocks/setupimage/releases/download/v0.1.0/pibOS-25.04.06-15.34.img.xz)

2. **Flash the Image:**
   - Use `rpi-imager` to flash the downloaded image onto your microSD card.

3. **Boot the Raspberry Pi:**
   - Insert the microSD card into your Raspberry Pi and boot it up.
   - Note: The initial setup, including Docker configuration, may take some time.

### Building Locally 
(Optional)

If you prefer to build the image locally, follow these steps:

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/pib-rocks/setupimage.git
   ```

2. **Navigate to the Project Directory:**
   ```bash
   cd setupimage/pibOS
   ```

3. **Run the Build Script:**
   ```bash
   sudo ./build_dist
   ```

## Usage

Once the image is flashed and the Raspberry Pi is booted, the `pib-backend` will complete its installation automatically. You can then proceed with configuring your pib.rocks robot as needed.

## Contributing

We welcome contributions! Please read our contributing guidelines before submitting pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For any questions or support, please open an issue or contact us through the provided channels.