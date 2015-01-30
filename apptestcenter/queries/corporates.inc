select TOP 100 map.img_ID, rpm.RepPatternID, ts.HighFactorType1 UserHighFactor, rpm.HighPoint PatternHighFactor,
	ts.C_NumberD, ts.C_NumberI, ts.C_NumberS, ts.C_NumberC, tc.TestCode, rp.ReferenceName
from pditestsummary ts
   inner join RepPatternModels rpm ON ts.ProfileID1 = rpm.RepPatternID
	inner join PDIRepProfile rp ON rpm.RepPatternID = rp.PDIRepProfileID
	inner join dbo.ImageIdMap map ON rp.PatternImageID = map.ClientObjectID
   inner join TestResults tr ON ts.TestResultsID = tr.TestResultsID
   inner join Purchase_TestCode ptc ON tr.TestCodeID = ptc.TestCodeID
   inner join TestCode tc ON ptc.TestCodeID = tc.TestCodeID
   inner join corporatepurchases cp ON ptc.PurchaseID = cp.PurchaseID
-- WHERE rpm.HighPoint <> 'X' AND ts.HighFactorType1 <> rpm.HighPoint
ORDER BY tr.TestCompleteDate DESC