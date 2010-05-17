If Exists (Select * From Information_Schema.Views Where Table_Name = 'vw_Tickets_Notes')
	Drop View vw_Tickets_Notes  

GO

Create View vw_Tickets_Notes  
as  
Select 
  tNumber, tblTask.Description, whoReported, EntryDate, DateAdded, Title, Journal, ATG_Category.Name as Queue,
  Task_Status.Task_Status_Description
From tblTask
Left Join ATG_Journal On ATG_Journal.ParentObjectId = TaskId  
Left Join ATG_Category On ATG_Category.ObjectID = taskCategoryID
Left Join Task_Status On Task_Status.Task_Status_ID = tblTask.StatusLink
Where ATG_Journal.ClassificationObjectId Not In (2, 13)