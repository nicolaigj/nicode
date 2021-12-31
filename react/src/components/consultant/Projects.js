import Hash from "components/Hash";

const Period = ({ period }) => {
  return (
    <div className="period">
      <time dateTime={period.from}>{period.from}</time>
      <span> - </span>
      <time dateTime={period.to}>{period.to}</time>
    </div>
  );
};

const Projects = ({ consultant }) => {
  return (
    <section className="consultant-projects">
      <h2>
        <Hash text="Experience and projects" />
      </h2>
      <ul>
        {consultant.projects.map(({ title, period, description, tags }) => (
          <li key={title}>
            <Period period={period} />
            <h3>{title}</h3>
            <p className="description">{description}</p>
            <p className="tags">
              {tags.map((tag) => (
                <span key={tag}>{tag}</span>
              ))}
            </p>
          </li>
        ))}
      </ul>
    </section>
  );
};

export default Projects;
