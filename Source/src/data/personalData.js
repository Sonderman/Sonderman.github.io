import { Github, Linkedin, Mail, AppWindow, Gamepad2 } from 'lucide-react';

export const personalData = {
    // Basic information
    name: "Ali Haydar AYAR",
    title: "Computer Engineer",
    jobTitles: [
        "Unity Game Developer",
        "Flutter Developer",
        "Software Engineer",
        "Computer Engineer",
    ],
    heroDescription: "Passionate about building high-performance applications and immersive gaming experiences.",
    
    // About paragraphs
    about: [
        "Hello! I am Ali Haydar. I graduated from Karabük University in computer engineering and I am passionate about software development. I have been working with the Flutter framework for more than 3 years and I am constantly improving myself in this field. Additionally, I have 1 year of work experience with Unity Engine and took part in mobile game development processes.",
        "The complex application I developed with Flutter and the mobile games I published with Unity gave me the opportunity to showcase my talents and creativity in the software world. These experiences encouraged me to further my technical skills and develop further in new projects.",
        "I am currently improving myself further in Flutter and looking for new job opportunities in this field. I look forward to contributing and developing unique applications as part of an innovative team.",
        "I am someone who likes to take responsibility, is prone to teamwork and is willing to constantly learn. I look forward to collaborating on new projects and achieving great success together. Feel free to contact me!"
    ],
    
    // Services offered
    services: [
        {
            title: "Mobile Applications",
            description: "Professional development of applications for iOS and Android.",
            icon: AppWindow
        },
        {
            title: "Mobile Games",
            description: "Professional development of Casual/Hypercasual games for iOS and Android.",
            icon: Gamepad2
        }
    ],
    
    // Skills with percentages
    skills: [
        { name: "Network", percentage: 20 },
        { name: "System Administration", percentage: 20 },
        { name: "Flutter", percentage: 90 },
        { name: "Dart", percentage: 85 },
        { name: "Unity Engine", percentage: 75 },
        { name: "C#", percentage: 70 }
    ],
    
    // Contact information
    contact: {
        email: "alihaydar338@gmail.com",
        location: "Ankara/Turkey",
        socials: [
            { 
                name: "LinkedIn", 
                url: "https://www.linkedin.com/in/ali-haydar-ayar-b45a4315b/", 
                icon: Linkedin 
            },
            { 
                name: "GitHub", 
                url: "https://github.com/sonderman", 
                icon: Github 
            },
            { 
                name: "Email", 
                url: "mailto:alihaydar338@gmail.com", 
                icon: Mail 
            },
        ]
    },
    
    // Resume - Education and Experience
    resume: {
        education: [
            {
                date: '2015 - 2020',
                title: 'Bachelor of Computer Engineering',
                subtitle: 'Karabuk University, Karabuk/Turkey',
            }
        ],
        experience: [
            {
                date: 'Dec 2025 - Present',
                title: 'System And Network Specialist',
                details: ['Working in a Ministry of the interior of the Republic of Türkiye as a System And Network Specialist.']
            },
            {
                date: 'Apr 2024 - Dec 2025',
                title: 'Flutter & Unity Game Developer | Freelancer',
                details: ['Have published 80+ apps on mobile platforms.']
            },
            {
                date: 'Mar 2023 - Mar 2024',
                title: 'Game Developer',
                details: [
                    'I took part in the development process of 2 mobile games:',
                    'Sky Wars Online: Istanbul',
                    'Zombie Rush Drive',
                ]
            }
        ]
    },
    
    // Projects - Unified format supporting both mobile and desktop views
    projects: [
        {
            title: "FreeAi Hub",
            description: "Welcome to FreeAi Hub – Your Pocket AI Companion \nNo sign‑up or credits required. Just open the app and dive into AI related tools!",
            category: "Made By Me",
            type: "app",
            platforms: ["Android"],
            createdDate: "2025-04-21",
            color: "bg-blue-500",
            images: [
                "/images/projects/freeaihub-1.png",
                "/images/projects/freeaihub-2.png",
                "/images/projects/freeaihub-3.png",
                "/images/projects/freeaihub-4.png",
                "/images/projects/freeaihub-5.png",
            ],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/OpenFreeAiHub" }
            ]
        },
        {
            title: "Daysayar",
            description: "With this app you can challenge with time to reach your targets.",
            category: "Made By Me",
            type: "app",
            platforms: ["Android"],
            createdDate: "2024",
            color: "bg-purple-500",
            images: [
                "/images/projects/daysayar-1.png",
                "/images/projects/daysayar-2.png",
                "/images/projects/daysayar-3.png",
                "/images/projects/daysayar-4.png",
                "/images/projects/daysayar-5.png",
            ],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/Daysayar" }
            ]
        },
        {
            title: "Macro Data Refinement",
            description: "Dive into the world of Macro Data Refinement, a unique puzzle game where numbers meet strategy! Your mission is to meticulously refine complex data grids to unlock famous cities around the globe.",
            category: "Made By Me",
            type: "app",
            platforms: ["Android"],
            createdDate: "2025-03-16",
            color: "bg-green-500",
            images: [
                "/images/projects/macrodata-1.png",
                "/images/projects/macrodata-2.png",
                "/images/projects/macrodata-3.png",
                "/images/projects/macrodata-4.png",
                "/images/projects/macrodata-5.png",
                "/images/projects/macrodata-6.png",
            ],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.sondermium.macrodatarefinement" }
            ]
        },
        {
            title: "Task Manager",
            description: "You can manage your routine tasks with this app.",
            category: "Made By Me",
            type: "app",
            platforms: ["Android"],
            createdDate: "2024",
            color: "bg-yellow-500",
            images: [
                "/images/projects/taskmanager-1.png",
                "/images/projects/taskmanager-2.png",
                "/images/projects/taskmanager-3.png",
                "/images/projects/taskmanager-4.png",
                "/images/projects/taskmanager-5.png",
                "/images/projects/taskmanager-6.png",
            ],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/Flutter-TaskManager" }
            ]
        },
        {
            title: "Angry Bird Game Clone",
            description: "A classic game clone made with Unity.",
            category: "Made By Me",
            type: "game",
            platforms: ["Desktop"],
            createdDate: "2022",
            images: ["/images/projects/angrybird-1.png"],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/AngryBirdGameUnity" }
            ],
            playableAssetPath: "angrybird"
        },
        {
            title: "Platformer Game",
            description: "A platformer game built with Unity.",
            category: "Made By Me",
            type: "game",
            platforms: ["Desktop"],
            createdDate: "2021",
            images: ["/images/projects/platformer-1.png"],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/PlatformerUnityGame" }
            ],
            playableAssetPath: "platformer"
        },
        {
            title: "Sky Wars Online: Istanbul",
            description: "Multiplayer aerial combat game.",
            category: "Contributed",
            type: "game",
            platforms: ["Android"],
            createdDate: "2023",
            images: ["/images/projects/skw-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.atlasyazilim.SkyConqueror&hl=en_US" }
            ]
        },
        {
            title: "Zombie Rush Drive",
            description: "Zombie survival driving game.",
            category: "Contributed",
            type: "game",
            platforms: ["Android"],
            createdDate: "2023",
            color: "bg-red-600",
            images: [
                "/images/projects/zrd-1.png",
                "/images/projects/zrd-2.png",
                "/images/projects/zrd-3.png",
                "/images/projects/zrd-4.png",
            ],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.AtlasGameStudios.ZombieRushDrive&hl=en" }
            ]
        },
        {
            title: "Yaren: Tanışma・Sohbet",
            description: "Social dating and chat application.",
            category: "Contributed",
            type: "app",
            platforms: ["Android"],
            createdDate: "2024-11-26",
            color: "bg-red-500",
            images: ["/images/projects/yaren-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.yaren.chatapp" }
            ]
        },
        {
            title: "Collector: Haberin Merkezi",
            description: "News aggregator application.",
            category: "Contributed",
            type: "app",
            platforms: ["Android", "iOS"],
            createdDate: "2024-12-20",
            color: "bg-cyan-500",
            images: ["/images/projects/collector-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.collector.collector.mobile&hl=tr" },
                { label: "App Store", url: "https://apps.apple.com/tr/app/collector-haberin-merkezi/id6450546836?l=tr" }
            ]
        },
        {
            title: "Tekx - Flört ve Arkadaşlık",
            description: "Dating and friendship application.",
            category: "Contributed",
            type: "app",
            platforms: ["Android"],
            createdDate: "2024-12-29",
            color: "bg-orange-600",
            images: ["/images/projects/tekx-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.tekx.chatapp&hl=tr" }
            ]
        }
    ]
};
