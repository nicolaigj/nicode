const svgStyle = {
  height: "2em",
};
const pathStyle = {
  stroke: "mediumspringgreen",
  fill: "none",
  strokeWidth: 5,
  strokeLinecap: "round",
  strokeLinejoin: "round",
};

const Logo = () => {
  return (
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 0 100 100"
      style={svgStyle}
    >
      <title>Nicode</title>
      <description>
        A circle with the letter "N" inside, created by a single line
      </description>
      <path
        pathLength="100"
        d="m50 50 20-20v40L30 30v54.6A40 40 0 1 1 50 90"
        style={pathStyle}
      />
    </svg>
  );
};

export default Logo;
