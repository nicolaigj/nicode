const Hash = ({ text }) => {
  const hash = encodeURI(text.replace(/\s/gm, "-"));
  return (
    <>
      <a id={hash} href={`#${hash}`}>
        #
      </a>
      <span> {text}</span>
    </>
  );
};

export default Hash;
