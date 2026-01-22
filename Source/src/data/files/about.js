// Generate about markdown dynamically from personalData
import { personalData } from '../personalData';

const aboutMarkdown = `# ${personalData.name}
###### ${personalData.title}

${personalData.about.join('\n\n')}

## Contact
- **Email:** ${personalData.contact.email}
- **Location:** ${personalData.contact.location}
- [LinkedIn](${personalData.contact.socials.find(s => s.name === 'LinkedIn')?.url})
- [GitHub](${personalData.contact.socials.find(s => s.name === 'GitHub')?.url})`;

export default aboutMarkdown;
