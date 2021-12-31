import { Link } from "react-router-dom";
import Logo from "./Logo";

const Main = ({ children }) => {
  return (
    <>
      <header>
        <nav
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
          }}
        >
          <Link to="/">
            <Logo />
          </Link>
        </nav>
      </header>
      <main>{children}</main>
      <footer>
        <p style={{ fontSize: "1rem", opacity: 0.5 }}>Created by Nicode.</p>
      </footer>
    </>
  );
};

export default Main;
