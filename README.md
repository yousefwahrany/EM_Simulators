# 2D Electromagnetic Scattering Simulation using Method of Moments (MoM)

This MATLAB script simulates 2D electromagnetic wave scattering from a conducting sheet using the **Method of Moments (MoM)** and **Hankel-based Green's functions**. The output includes current distribution on the object and the scattered electric field in the surrounding space.

---

## 📌 Features

- Defines a custom-shaped 2D scatterer (conducting surface)
- Calculates interaction matrix using a 2D Hankel integral kernel
- Solves for surface current density `J` using MoM
- Computes total electric field (`E_total = E_incident + E_scattered`) at points in space
- Visualizes:
  - Magnitude and phase of surface current
  - Total field distribution
  - Field due to the induced current only

---

## 🧮 Methodology

- **Formulation**: Electric field integral equation (EFIE) using Hankel function for 2D Green's function
- **Discretization**: The object is divided into segments; midpoint method is used
- **Solving**: Linear system `Z * J = E` is constructed and solved
- **Post-processing**: Field is evaluated over a grid using calculated current `J`

---

## 🔧 Parameters

| Parameter        | Description                             | Value        |
|------------------|-----------------------------------------|--------------|
| `f`              | Frequency                               | 300 MHz      |
| `c`              | Speed of light                          | 3e8 m/s      |
| `mu_o`           | Permeability of free space              | 4π×10⁻⁷ H/m  |
| `ko`             | Wave number                             | 2πf / c      |
| `Body`           | Geometry of the conducting object       | Custom shape |
| `N`              | Number of segments                      | Derived from object geometry |
| `x_0`, `y_0`     | Observation grid                        | [-2, 2] × [-2, 2] |

---

## 📈 Outputs

- **`J`**: Surface current distribution on the object (magnitude and phase)
- **`E_space`**: Total electric field (`E_incident + E_scattered`) on the grid
- **`E_J`**: Scattered field due to current only

### Plots:
- Current magnitude vs. position
- Phase of current along the object
- 2D heatmap of total electric field
- 2D heatmap of scattered field

---

## ▶️ How to Run

1. Make sure all dependencies (especially `Hankel_integral_2D.m` and `calculate_E_2D.m`) are in the same directory.
2. Open MATLAB and run the main script.
3. Adjust object geometry by modifying the `Body` definition.
4. View the generated plots and field distributions.

---

## 📂 File Dependencies

- `Hankel_integral_2D.m`: Function to compute the Hankel-based integral between two segments.
- `calculate_E_2D.m`: Function to evaluate the field due to a segment at a point in space.

---

## 📌 Notes

- Parallel computing is used (`parfor`) to accelerate field calculations over a grid.
- This script is ideal for understanding EM wave interaction with custom 2D geometries.

---

## 📧 Contact




# 🔋 2D Electrostatic Potential Solver using Line Charge Method (Method of Moments)

This MATLAB script computes the **electrostatic potential distribution** in 2D space caused by a finite **line charge distribution** along the x-axis using the **Method of Moments (MoM)**. The resulting potential field is visualized as a heatmap and equipotential contour.

---

## 📌 Features

- Simulates electrostatic potential from a uniformly charged sheet or line
- Solves integral equation using midpoint MoM
- Visualizes:
  - 2D potential field (`V`)
  - Equipotential contour (`V = 0`)
  - Optionally, electric field vector plot

---

## 🧮 Methodology

- **Formulation**: The electric potential at a point is calculated by integrating the potential contribution from each segment of the charged line using:
  
  \[
  V(x, y) = \frac{1}{4\pi\epsilon_0} \int \frac{\rho(x')}{\sqrt{(x - x')^2 + y^2}} dx'
  \]

- **Discretization**: The charged sheet is divided into `N` segments. The integral equation is solved using **midpoint collocation**.

- **Solving**: Linear system `S * q = V0` is solved for unknown line charge density `q`, assuming constant potential `Vo` on the sheet.

---

## 🔧 Parameters

| Parameter        | Description                               | Value          |
|------------------|-------------------------------------------|----------------|
| `Vo`             | Potential of charged sheet                | 1 V            |
| `epsilon`        | Permittivity of free space                | 8.85×10⁻¹² F/m |
| `x1`, `x2`       | Start and end of the charged sheet        | -0.5 to 0.5 m  |
| `N`              | Number of line segments                   | 21             |
| `x_0`, `y_0`     | Grid for evaluation of `V(x, y)`          | [-3, 3] × [-3, 3] |

---

## 📈 Outputs

- **`q_n`**: Computed linear charge density on the sheet
- **`V_space`**: 2D matrix of potential values in space
- **Plots**:
  - Heatmap of potential distribution
  - Equipotential contour line for `V = 0`

---

## ▶️ How to Run

1. Ensure the helper function `calculate_V.m` and `ln_integral.m` exist in the same folder.
2. Open the script in MATLAB.
3. Run the file. 
4. The figure will show the potential field and contour lines.
5. You can optionally enable vector field visualization (electric field) by uncommenting the `quiver` line.

---

## 📂 File Dependencies

- `ln_integral.m`: Computes the analytical/logarithmic integral kernel for MoM.
- `calculate_V.m`: Computes potential due to a single charged segment at a point.

---

## 📌 Notes

- The current script uses a fixed geometry, but you can generalize it by adjusting `x1`, `x2`, and `N`.
- This approach demonstrates the foundational method used in boundary element electrostatics problems.

---

## 📧 Contact

For any questions or suggestions, please contact Yousef T. Wahrany at yousef.wahrany@gmail.com
