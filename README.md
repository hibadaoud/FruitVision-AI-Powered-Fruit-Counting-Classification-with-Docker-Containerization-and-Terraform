<a name="readme-top"></a>
<div align="center">

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
</div>


<!-- PROJECT LOGO --> 
<br />
<div align="center">
  <a href="https://github.com/hibadaoud/FruitVision">
    <img src="application/FruitVision/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png" alt="Logo" width="256" height="256">
  </a>
    <h1 style="font-size:50px">Fruit Vision
    </h1>
  <p align="center">
    Automate Fruit Counting
    <br />
    <br />
    <a href="https://github.com/hibadaoud/FruitVision/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/hibadaoud/FruitVision/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>


# Fruit Vision
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#about-the-project">About The Project</a></li>
    <li><a href="#features">Features</a></li>
     <li><a href="#installation">Detectron2</a></li>
    <li><a href="#installation">Installation</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contributing">Docker Setup</a></li>
    <li><a href="#contributing">Microsoft Azure Terraform Setup</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This application leverages artificial intelligence to accurately count the number of fruits on a tree from images. It is designed to aid researchers and agricultural professionals by simplifying the process of yield estimation and crop management, thus providing valuable insights for agricultural decisions.

This is a project by Farah Elloumi & Hiba Daoud realized for their end-of-year project at the Higher School of Communications at Tunis (SUP'COM).

<br/>
<div style="display:flex;flex-direction:column;justify-content:canter;" align="center">
    <div>  
        <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/a14a6abe-f49c-403e-a9b1-225616b11194" alt="pic1" height="400">
<!--         <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/86dc13e8-df93-4ee0-8b74-7595cbae113b" alt="Login and signup" height="400">
        <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/b3516cc3-544f-4091-83bf-4038d0fc029b" alt="settings" height="400">   -->
    </div>
    <br/>
    <div>
        <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/b0d97f9c-db2d-4660-969b-60bf6aa8744c" alt="pic2" height="400">    
<!--         <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/c69c97bb-d3bd-4dc2-a207-bc1625fd27cd" alt="Prediction History" height="400">
    </div> -->
    <br/>
    <div>
        <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/678e4631-0f33-4211-8843-f0915ec5c632" alt="pic3" height="400">    
<!--         <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/c69c97bb-d3bd-4dc2-a207-bc1625fd27cd" alt="Prediction History" height="400">
    </div> -->
    <br/>
    <div>
        <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/605465c4-cb6e-4d1e-8d78-e3db9b27bfde" alt="pic3" height="400">    
<!--         <img style="padding:10px;" src="https://github.com/hibadaoud/FruitVision/assets/153644549/c69c97bb-d3bd-4dc2-a207-bc1625fd27cd" alt="Prediction History" height="400">
    </div> -->
    <br/>
</div>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Features

- **AI-Powered Fruit Detection**: Uses advanced deep learning models to identify and count fruits accurately.
- **User-Friendly Interface**: Features an easy-to-use interface that allows users to quickly upload images and get counts in real-time.
- **Data Analysis Tools**: Includes functionality to analyze and export data for further agricultural planning and analysis.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Detectron2

We have utilized the Detectron2 model, found on [this site](https://github.com/facebookresearch/detectron2), which is a state-of-the-art object detection library developed by Facebook AI Research. We have adapted this model according to our fruit database to ensure high accuracy in fruit detection and counting.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Installation

1. **Clone this repository** to your local machine.
2. **Navigate to the project directory**.
3. **Run `flutter pub get`** to install dependencies.
4. **Connect your device** and **run the app** using `flutter run`.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Docker Setup

To simplify the deployment process, we have containerized the application using Docker. Follow these steps to set up and run the application in a Docker container:
1. **Build the Docker image** using `docker build -t fruitvision:latest .`
2. **Run the Docker container** using `docker run -p 8000:8000 fruitvision:latest`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Microsoft Azure Terraform Setup
We have also utilized Terraform to manage and provision the infrastructure on Microsoft Azure. Follow these steps to set up the infrastructure using Terraform:

1. **Configure Azure credentials** using `az login`.
2. **Navigate to the project directory** using `cd terraform` .
3. **Initialize Terraform** using `terraform init`.
4. **Apply the Terraform configuration** using `terraform apply`.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
<p align="right">(<a href="#readme-top">back to top</a>)</p>

## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Farah Elloumi - [@Farah-Elloumi][linkedin-url] - farah.elloumi@supcom.tn <br/>
<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/hibadaoud/FruitVision.svg?style=for-the-badge
[contributors-url]: https://github.com/hibadaoud/FruitVision/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/hibadaoud/FruitVision.svg?style=for-the-badge
[forks-url]: https://github.com/hibadaoud/FruitVision/network/members
[stars-shield]: https://img.shields.io/github/stars/hibadaoud/FruitVision.svg?style=for-the-badge
[stars-url]: https://github.com/hibadaoud/FruitVision/stargazers
[issues-shield]: https://img.shields.io/github/issues/hibadaoud/FruitVision.svg?style=for-the-badge
[issues-url]: https://github.com/hibadaoud/FruitVision/issues
[license-shield]: https://img.shields.io/github/license/hibadaoud/FruitVision.svg?style=for-the-badge
[license-url]: https://github.com/hibadaoud/FruitVision/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/farah-elloumi-735ab1269/
