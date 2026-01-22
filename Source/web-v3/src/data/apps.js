import { Share2, Gamepad2, MessageCircle, Camera, Music, Map, Mail, Calendar } from 'lucide-react';

export const apps = [
    {
        id: 1,
        name: "Social",
        icon: Share2,
        color: "bg-blue-500",
        images: [
            "https://placehold.co/300x500/007acc/ffffff?text=Social+App+1",
            "https://placehold.co/300x500/007acc/ffffff?text=Social+App+2"
        ]
    },
    {
        id: 2,
        name: "Games",
        icon: Gamepad2,
        color: "bg-purple-500",
        images: [
            "https://placehold.co/300x500/8b5cf6/ffffff?text=Game+Screenshot+1",
            "https://placehold.co/300x500/8b5cf6/ffffff?text=Game+Screenshot+2"
        ]
    },
    {
        id: 3,
        name: "Chat",
        icon: MessageCircle, // Note: lucid-react exports might vary, check imports if it fails
        color: "bg-green-500",
        images: [
            "https://placehold.co/300x500/22c55e/ffffff?text=Chat+UI"
        ]
    },
    {
        id: 4,
        name: "Photos",
        icon: Camera,
        color: "bg-yellow-500",
        images: [
            "https://placehold.co/300x500/eab308/ffffff?text=Photo+Gallery"
        ]
    },
    {
        id: 5,
        name: "Music",
        icon: Music,
        color: "bg-red-500",
        images: [
            "https://placehold.co/300x500/ef4444/ffffff?text=Music+Player"
        ]
    },
    {
        id: 6,
        name: "Maps",
        icon: Map,
        color: "bg-indigo-500",
        images: [
            "https://placehold.co/300x500/6366f1/ffffff?text=Map+View"
        ]
    },
    {
        id: 7,
        name: "Mail",
        icon: Mail,
        color: "bg-cyan-500",
        images: [
            "https://placehold.co/300x500/06b6d4/ffffff?text=Inbox"
        ]
    },
    {
        id: 8,
        name: "Calendar",
        icon: Calendar,
        color: "bg-orange-500",
        images: [
            "https://placehold.co/300x500/f97316/ffffff?text=Events"
        ]
    },
];
