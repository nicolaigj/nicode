import Hash from "components/Hash";

const About = ({ consultant }) => {
  return (
    <section className="consultant-about">
      <h2>
        <Hash text="About Me" />
      </h2>
      <p>{consultant.focus}</p>
      <p className="availability">
        {consultant.availability}
        <a href={"mailto:" + consultant.contact.email}> Contact me!</a>
      </p>
    </section>
  );
};

export default About;
