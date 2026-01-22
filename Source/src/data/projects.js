// Re-export projects from centralised personalData
import { personalData } from './personalData';

// Export projects with backward compatibility for Android component
// Export projects with backward compatibility for Android component
export const projects = personalData.projects.map(project => ({
  ...project,
  // Ensure backward compatibility with old format
  category: project.category === 'Made By Me' ? 'madeByMe' : 
            project.category === 'Contributed' ? 'contributed' : 
            project.category.toLowerCase(),
  // Construct githubLink from links array
  githubLink: project.links?.find(l => l.label === 'GitHub' || l.label === 'Source')?.url,
  // Construct storeLinks array from links array
  storeLinks: project.links?.filter(l => l.label === 'Play Store' || l.label === 'App Store').map(l => l.url),
}));
