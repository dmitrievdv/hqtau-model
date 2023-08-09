using TTauUtils
using Plots


star = Star("HQTau", 2.64, 1.87, 5000, 42)

mag = TTauUtils.Models.StationaryRotatingMagnetosphereNHCool("test", star, 2, 3, 1e-9, 10000, 10)
mag_norot = TTauUtils.StationarySolidMagnetosphereNHCool("test", star, 2, 3, 1e-9, 10000, 10)
mag_empty = TTauUtils.StationarySolidMagnetosphereNHCool("test", star, 2, 3, 1e-12, 7000, 10)

prof = HydrogenProfile(mag, 4, 2, 45, 0.05, 0.05, 0.05, 200, red_v_max = 500, blue_v_max = 500)
prof_norot = HydrogenProfile(mag_norot, 4, 2, 45, 0.05, 0.05, 0.05, 200, red_v_max = 500, blue_v_max = 500)
prof_syn = HydrogenProfile(mag_empty, 4, 2, 45, 0.05, 0.05, 0.05, 200, red_v_max = 500, blue_v_max = 500)
phot_spec = TTauUtils.Profiles.readpolluxspecfile("../model/spec/M_p5000g4.0z0.00t1.0_a0.00c0.00n0.00o0.00r0.00s0.00_VIS.spec", 4,2, 4861.4)
prof_phot = TTauUtils.Profiles.addphotospherespec(prof, 0.1, phot_spec, progress_output = true, sinicorr = true)
prof_norot_phot = TTauUtils.Profiles.addphotospherespec(prof_norot, 0.1, phot_spec, progress_output = true, sinicorr = true)
prof_syn = TTauUtils.Profiles.addphotospherespec(prof_syn, 0.1, phot_spec, progress_output = true, sinicorr = true)
# TTauUtils.Profiles.PhotosphereSpectrum()
# TTauUtils.Profiles.addphotospherespec()
plot(prof_phot, label="rot")
plot!(prof_norot_phot, label="norot")
plot!(prof_syn, label="syn")
