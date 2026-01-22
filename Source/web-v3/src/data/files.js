import aboutContent from './files/about';
import experiencesContent from './files/experiences';
import projectsContent from './files/projects';
import { skills } from './files/skills';
import resumeContent from './files/resume';

export const files = [
  {
    name: "about.md",
    content: aboutContent,
    language: "markdown",
  },
  {
    name: "experiences.html",
    content: experiencesContent,
    language: "html",
  },
  {
    name: "projects.md",
    content: projectsContent,
    language: "markdown",
  },
  {
    name: "skills.js",
    content: skills,
    language: "custom", // We'll handle this in EditorWindow
  },
  {
    name: "resume.pdf",
    content: resumeContent,
    language: "pdf",
  },
];
