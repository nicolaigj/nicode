const Contact = ({ contact }) => {
  return (
    <address>
      {contact.email && <a href={`mailto:${contact.email}`}>{contact.email}</a>}

      {contact.mobile && <a href={`tel:${contact.phone}`}>{contact.mobile}</a>}

      {contact.linkedin && (
        <a href={`https://www.linkedin.com/in/${contact.linkedin}`}>
          {contact.linkedin}
        </a>
      )}
    </address>
  );
};

const Intro = ({ consultant }) => {
  const { name, headshot, preamble, contact } = consultant;
  return (
    <section className="consultant-intro">
      <img src={headshot} alt={name} />
      <div>
        <p>
          Hi I’m {name}, {preamble}
        </p>
        <Contact contact={contact} />
      </div>
    </section>
  );
};

export default Intro;
