%chk=SQ01_Polar_Cam-B3LYP_6-31+G_d-p_IEF-PCM.chk
%mem=7Gb
%nproc=4
#p CAM-B3LYP/gen gfinput scf=maxcycle=200 Polar=(DCSHG) CPHF=RdFreq scrf=(iefpcm,read,solvent=Chloroform)
Polar depende do metodo experimental
Primeira Hiperpolarizabilidade

0 1
C          0.40360        5.51740        0.00000
C          1.71245        5.02526        0.00000
C          1.94903        3.64878        0.00000
C          0.87705        2.75457        0.00000
C         -0.43860        3.25363        0.00000
C         -0.67404        4.63208        0.00000
C         -1.56097        2.30339        0.00000
C         -1.26837        0.84792        0.00000
C          0.00000        0.32371        0.00000
C          1.14534        1.28041        0.00000
C          0.35005       -1.08397        0.00000
C         -0.49041       -2.14818        0.00000
C         -0.09270       -3.55722        0.00000
C         -1.10554       -4.53730        0.00000
C         -0.79731       -5.89649        0.00000
C          0.53620       -6.31031        0.00000
C          1.24869       -3.99461        0.00000
C          1.55596       -5.35151        0.00000
O         -2.37640        0.09322        0.00000
O         -2.75118        2.63930        0.00000
O          2.30583        0.87358        0.00000
H          0.22498        6.58806        0.00000
H          2.55050        5.71544        0.00000
H         -1.69782        4.99037        0.00000
H          2.95802        3.25172        0.00000
H          1.42325       -1.24806        0.00000
H         -1.56093       -1.97463        0.00000
H          2.05675       -3.27003        0.00000
H          2.59573       -5.66600        0.00000
H          0.78149       -7.36825        0.00000
H         -2.14509       -4.21959        0.00000
H         -1.59710       -6.63147        0.00000
H         -3.11837        0.73833        0.00000

1907nm

H C O 0
6-31+g(d,p)
****

