import { personalData } from '../personalData';

const generateProjectsMarkdown = () => {
    const categories = [...new Set(personalData.projects.map(p => p.category))];
    
    let markdown = "# Projects\n\n";
    
    categories.forEach(category => {
        markdown += `## ${category}\n\n`;
        const categoryProjects = personalData.projects.filter(p => p.category === category);
        
        categoryProjects.forEach(project => {
            markdown += `### ${project.title}\n`;
            markdown += `*${project.type.charAt(0).toUpperCase() + project.type.slice(1)} (${project.platforms.join(', ')}) - ${project.createdDate}*\n`;
            markdown += `${project.description}\n`;
            
            if (project.links && project.links.length > 0) {
                project.links.forEach(link => {
                    markdown += `- [${link.label}](${link.url})\n`;
                });
            }
            markdown += "\n";
        });
    });
    
    return markdown.trim();
};

export default generateProjectsMarkdown();
