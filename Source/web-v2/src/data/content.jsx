import { Github, Linkedin, Mail, MapPin } from 'lucide-react';

export const personalData = {
    name: "Ali Haydar AYAR",
    title: "Software Developer",
    jobTitles: [
        "Flutter & Unity Game Developer",
        "Mobile App Developer",
        "Software Engineer",
    ],
    about: [
        "Hello! I am Ali Haydar. I graduated from Karabük University in computer engineering and I am passionate about software development. I have been working with the Flutter framework for more than 2 years and I am constantly improving myself in this field. Additionally, I have 1 year of work experience with Unity Engine and took part in mobile game development processes.",
        "The complex application I developed with Flutter and the mobile games I published with Unity gave me the opportunity to showcase my talents and creativity in the software world. These experiences encouraged me to further my technical skills and develop further in new projects.",
        "I am currently improving myself further in Flutter and looking for new job opportunities in this field. I look forward to contributing and developing unique applications as part of an innovative team.",
        "I am someone who likes to take responsibility, is prone to teamwork and is willing to constantly learn. I look forward to collaborating on new projects and achieving great success together. Feel free to contact me!"
    ],
    services: [
        {
            title: "Mobile Applications",
            description: "Professional development of applications for iOS and Android."
        },
        {
            title: "Mobile Games",
            description: "Professional development of Casual/Hypercasual games for iOS and Android."
        }
    ],
    skills: [
        { name: "Flutter", percentage: 90 },
        { name: "Dart", percentage: 85 },
        { name: "Unity Engine", percentage: 75 },
        { name: "C#", percentage: 70 }
    ],
    contact: {
        email: "alihaydar338@gmail.com",
        location: "Remote/Turkey",
        socials: [
            { name: "LinkedIn", url: "https://www.linkedin.com/in/ali-haydar-ayar-b45a4315b/", icon: Linkedin },
            { name: "GitHub", url: "https://github.com/sonderman", icon: Github },
            { name: "Email", url: "mailto:alihaydar338@gmail.com", icon: Mail },
        ]
    },
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
                date: 'Apr 2024 - Present',
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
    projects: [
        {
            title: "FreeAi Hub",
            description: "Welcome to FreeAi Hub – Your Pocket AI Companion \nNo sign‑up or credits required. Just open the app and dive into AI related tools!",
            category: "Made By Me",
            type: "App",
            platforms: ["Android"],
            images: [
                "/assets/images/apps/freeaihub-1.png",
                "/assets/images/apps/freeaihub-2.png",
            ],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/OpenFreeAiHub" }
            ]
        },
        {
            title: "Daysayar",
            description: "With this app you can challenge with time to reach your targets.",
            category: "Made By Me",
            type: "App",
            platforms: ["Android"],
            images: [
                "/assets/images/apps/daysayar-1.png",
                "/assets/images/apps/daysayar-2.png",
            ],
            links: []
        },
        {
            title: "Macro Data Refinement",
            description: "Dive into the world of Macro Data Refinement, a unique puzzle game where numbers meet strategy! Your mission is to meticulously refine complex data grids to unlock famous cities around the globe.",
            category: "Made By Me",
            type: "App",
            platforms: ["Android"],
            images: [
                "/assets/images/apps/macrodata-1.png",
                "/assets/images/apps/macrodata-2.png",
            ],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.sondermium.macrodatarefinement" }
            ]
        },
        {
            title: "Task Manager",
            description: "You can manage your routine tasks with this app.",
            category: "Made By Me",
            type: "App",
            platforms: ["Android"],
            images: [
                "/assets/images/apps/taskmanager-1.png",
                "/assets/images/apps/taskmanager-2.png",
            ],
            links: []
        },
        {
            title: "Angry Bird Game Clone",
            description: "A classic game clone made with Unity.",
            category: "Made By Me",
            type: "Game",
            platforms: ["Desktop"],
            images: ["/assets/images/games/angrybird-1.png"],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/AngryBirdGameUnity" }
            ]
        },
        {
            title: "Platformer Game",
            description: "A platformer game built with Unity.",
            category: "Made By Me",
            type: "Game",
            platforms: ["Desktop"],
            images: ["/assets/images/games/platformer-1.png"],
            links: [
                { label: "GitHub", url: "https://github.com/Sonderman/PlatformerUnityGame" }
            ]
        },
        {
            title: "Sky Wars Online: Istanbul",
            description: "Multiplayer aerial combat game.",
            category: "Contributed",
            type: "Game",
            platforms: ["Android"],
            images: ["/assets/images/games/skw-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.atlasyazilim.SkyConqueror&hl=en_US" }
            ]
        },
        {
            title: "Zombie Rush Drive",
            description: "Zombie survival driving game.",
            category: "Contributed",
            type: "Game",
            platforms: ["Android"],
            images: ["/assets/images/games/zrd-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.AtlasGameStudios.ZombieRushDrive&hl=en" }
            ]
        },
        {
            title: "Yaren: Tanışma・Sohbet",
            description: "Social dating and chat application.",
            category: "Contributed",
            type: "App",
            platforms: ["Android"],
            images: ["/assets/images/apps/yaren-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.yaren.chatapp" }
            ]
        },
        {
            title: "Collector: Haberin Merkezi",
            description: "News aggregator application.",
            category: "Contributed",
            type: "App",
            platforms: ["Android", "iOS"],
            images: ["/assets/images/apps/collector-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.collector.collector.mobile&hl=tr" },
                { label: "App Store", url: "https://apps.apple.com/tr/app/collector-haberin-merkezi/id6450546836?l=tr" }
            ]
        },
        {
            title: "Tekx - Flört ve Arkadaşlık",
            description: "Dating and friendship application.",
            category: "Contributed",
            type: "App",
            platforms: ["Android"],
            images: ["/assets/images/apps/tekx-1.png"],
            links: [
                { label: "Play Store", url: "https://play.google.com/store/apps/details?id=com.tekx.chatapp&hl=tr" }
            ]
        }
    ]
};
