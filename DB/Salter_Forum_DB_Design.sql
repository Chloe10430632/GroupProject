Create Database Salter
go

CREATE TABLE [BoardCategories] (
  [board_id] integer PRIMARY KEY,
  [title] nvarchar(255),
  [description] nvarchar(MAX),
  [view_count] int,
  [is_active] bit,
  [sort_order] int
)
GO

CREATE TABLE [BoardInteraction] (
  [interaction_id] integer PRIMARY KEY,
  [board_id] integer,
  [user_id] integer,
  [type] nvarchar(50) NOT NULL 
        CHECK (type IN ('FOLLOW', 'VIEW')),
  [created_at] datetime
)
GO

CREATE TABLE [Posts] (
  [post_id] integer PRIMARY KEY,
  [user_id] integer,
  [board_id] integer,
  [content] nvarchar(MAX),
  [tags] nvarchar(255),
  [location_id] int,
  [view_count] INT DEFAULT (0),
  [status]  nvarchar(50) NOT NULL 
        CHECK (status IN ('NORMAL', 'HIDE', 'DELETED')) DEFAULT ('NORMAL'),
  [is_pinned] bit DEFAULT (0),
  [created_at] datetime,
  [updated_at] datetime
)
GO

CREATE TABLE [PostsImages] (
  [image_id] integer PRIMARY KEY,
  [post_id] integer,
  [image_url] nvarchar(500),
  [sort_index] int
)
GO

CREATE TABLE [Comments] (
  [comment_id] integer PRIMARY KEY,
  [post_id] integer,
  [parentComment_id] integer,
  [user_id] integer,
  [content] nvarchar(MAX),
  [created_at] datetime,
  [updated_at] datetime
)
GO

CREATE TABLE [PostInteraction] (
  [interaction_id] integer PRIMARY KEY,
  [post_id] integer,
  [user_id] integer,
  [type] nvarchar(50) NOT NULL 
        CHECK (type IN ('LIKE', 'COLLECT', 'SHARE','REPORT')),
  [report_reason] nvarchar(max),
  [created_at] datetime
)
GO

CREATE TABLE [SensitiveWords] (
  [word_id] integer PRIMARY KEY,
  [word] nvarchar(max),
  [level] nvarchar(50)
        CHECK (level IN ('LOW', 'MID', 'HIGH')) DEFAULT ('HIGH'),
)
GO

CREATE TABLE [Ads] (
  [ad_id] integer PRIMARY KEY,
  [title] nvarchar(255),
  [img_url] nvarchar(500),
  [link_url] nvarchar(500),
  [start_date] datetime,
  [end_date] datetime,
  [status] nvarchar(50) NOT NULL
        CHECK (status IN ('REQUEST', 'ACTIVE', 'END','REJECT')) DEFAULT ('REQUEST'),
)
GO

ALTER TABLE [BoardCategories] ADD FOREIGN KEY ([board_id]) REFERENCES [Posts] ([board_id])
GO

ALTER TABLE [BoardCategories] ADD FOREIGN KEY ([board_id]) REFERENCES [BoardInteraction] ([board_id])
GO

ALTER TABLE [PostsImages] ADD FOREIGN KEY ([post_id]) REFERENCES [Posts] ([post_id])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([post_id]) REFERENCES [Comments] ([post_id])
GO

ALTER TABLE [Comments] ADD FOREIGN KEY ([comment_id]) REFERENCES [Comments] ([parentComment_id])
GO

ALTER TABLE [Posts] ADD FOREIGN KEY ([post_id]) REFERENCES [PostInteraction] ([post_id])
GO
