select map.img_ID, rpm.RepPatternID, ts.HighFactorType1 UserHighFactor, rpm.HighPoint PatternHighFactor,
	ts.C_NumberD, ts.C_NumberI, ts.C_NumberS, ts.C_NumberC, tc.TestCode, rp.ReferenceName
from pditestsummary ts
   inner join RepPatternModels rpm ON ts.ProfileID1 = rpm.RepPatternID
	inner join PDIRepProfile rp ON rpm.RepPatternID = rp.PDIRepProfileID
	inner join dbo.ImageIdMap map ON rp.PatternImageID = map.ClientObjectID
   inner join TestResults tr ON ts.TestResultsID = tr.TestResultsID
   inner join Purchase_TestCode ptc ON tr.TestCodeID = ptc.TestCodeID
   inner join TestCode tc ON ptc.TestCodeID = tc.TestCodeID
where tc.TestCode IN (
'PDIPKHNHKBIF',
'PDIPHFOOCKLA',
'PDIPHMGNCJII',
'PDIPEHIMNPNG'
)
ORDER BY tr.TestCompleteDate DESC