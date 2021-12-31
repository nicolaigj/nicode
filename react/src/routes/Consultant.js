import { useParams } from "react-router-dom";
import { consultantList } from "./_consultants.json";
import NotFound from "routes/NotFound";
import Main from "components/Main";
import Intro from "components/consultant/Intro";
import About from "components/consultant/About";
import Projects from "components/consultant/Projects";

import "./consultant.css";

const Consultant = () => {
  let { consultantName } = useParams();

  const consultant = consultantList.find(
    (consultant) =>
      consultant.name.toLowerCase() === consultantName.toLowerCase()
  );

  if (!consultant) {
    return <NotFound />;
  }

  return (
    <Main>
      <article className="consultant">
        <Intro consultant={consultant} />
        <About consultant={consultant} />
        <Projects consultant={consultant} />
      </article>
    </Main>
  );
};

export default Consultant;
