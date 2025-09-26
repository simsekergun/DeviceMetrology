# Device Metrology
# Prediction From Integrated Dispersion Data

Note: In this study, we assume a totally random noise added to the integrated dispersion datasets. 

1) Predicting ring dimensions from integrated dispersion datasets (under no noise, 50 MHz random noise, and 200 MHz random noise).
2) Sellmeier model from integrated dispersion datasets (under no noise, 50 MHz random noise, and 200 MHz random noise).
3) Integrated dispersion prediction from ring dimensions (Sellmeier model 2 only, because the experimental dataset was generated with a gas ratio of 5:1)


We consider a microring resonator composed of Si<sub>3</sub>N<sub>4</sub> as the core material and SiO<sub>2</sub> as the cladding. The outer ring radius is fixed at $23~\mu$m, while the waveguide height and width are varied to construct a comprehensive dataset for dispersion analysis. Specifically, the height is swept from $620$~nm to $720$~nm in increments of $5$~nm, and the width is swept from $750$~nm to $950$~nm in increments of $10$~nm, resulting in $441$ unique training designs. In addition, we generate a test dataset by randomly selecting $50$ distinct integer width–height combinations (in nanometers) from the same ranges as the training dataset.


To accurately capture material dispersion, we employ wavelength-dependent relative permittivity models for both Si<sub>3</sub>N<sub>4</sub> ({https://opg.optica.org/ol/abstract.cfm?URI=ol-46-23-5970})and SiO<sub>2</sub> ({https://www.sciencedirect.com/science/article/pii/S0022309397004389}).

