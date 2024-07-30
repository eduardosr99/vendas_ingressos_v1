--------- PROJETO_EVENTOS -----------

-- Visualização das tabelas

-- Nome das colunas ID foram alteradas em todas as tabelas para facilitar a identificação. Ex: [tickets].[id] >> [tickets].[ticket_id]

SELECT 
	   [ticket_id]
      ,[event_id]
      ,[spot_id]
      ,[ticket_kind]
  FROM [test_db].[dbo].[tickets]

SELECT 
	   [event_id]
	  ,[name]
      ,[location]
      ,[organization]
      ,[rating]
      ,[date]
      ,[image_url]
      ,[capacity]
      ,[price]
      ,[partner_id]
FROM [test_db].[dbo].[events]

SELECT 
	   [spot_id]
	  ,[event_id]
      ,[name]
      ,[status]
      ,[ticket_id]

FROM [test_db].[dbo].[spots]

SELECT*
FROM [test_db].[dbo].[event_details]

-- Exclusão da coluna [tickets].[price]

ALTER TABLE dbo.tickets DROP COLUMN price

-- Inserção de dados em [dbo].[tickets]
INSERT INTO [test_db].[dbo].[tickets] (ticket_id, event_id, spot_id, ticket_kind) VALUES
('1e9f3ede-f7bb-4c99-9121-7b4357488841', '10853e59-dc5b-4d7b-a028-01513ef50d76', '6c7bdf8d-9146-43df-8b0b-3ae3d4c18cba', 'Full'),
('87a64ec6-8360-4a0f-b3fa-edd9b3b23670', '5b79831a-a9d3-4538-8fb5-569494bd17a5', '7c022408-c6ec-4575-b362-923822ee83b4', 'Half'),
('c93abf5d-48bb-490a-b6ab-9c63a408d02c','8beff8fd-39e4-49ea-ae5e-a0ec9af888c5', 'af20c380-b6c8-4c99-b1d9-780871b80ab1', 'Half'),
('849f1a3a-1145-433d-94b3-2bfb16da487f','5b79831a-a9d3-4538-8fb5-569494bd17a5', 'cb3e9985-dec6-4c7b-9675-409dad659196', 'Half'),
('47a7a57d-4a95-40f3-8f87-bd3edada10c6','e0352b32-7698-4805-b029-28302b3a911f', 'deb28dbe-cbe1-4bf3-a7e3-bce4aa52b54f', 'Full'),
('39189eda-f4e2-4251-b764-57fbcb0421f1','e0352b32-7698-4805-b029-28302b3a911f', 'cb3e9985-dec6-4c7b-9675-409dad659196', 'Full'),
('70652891-754e-44aa-bac4-88f3bb1173df','8beff8fd-39e4-49ea-ae5e-a0ec9af888c5', '6c7bdf8d-9146-43df-8b0b-3ae3d4c18cba', 'Full'),
('324301e2-bf77-4f15-b3a1-12d52219c635','8beff8fd-39e4-49ea-ae5e-a0ec9af888c5', '7c022408-c6ec-4575-b362-923822ee83b4', 'Full'),
('5f6e367e-06d8-4dce-b26a-7846c1961c73','10853e59-dc5b-4d7b-a028-01513ef50d76', 'cb3e9985-dec6-4c7b-9675-409dad659196', 'Half'),
('1def08f1-6219-4da4-87ce-476f1604fff6','5b79831a-a9d3-4538-8fb5-569494bd17a5', 'e2e2e2e2-2e2e-2e2e-2e2e-2e2e2e2e2e2e', 'Half'),
('7a36ca3c-d557-490f-9a0c-851c6bd1f3a5','8beff8fd-39e4-49ea-ae5e-a0ec9af888c5','cb3e9985-dec6-4c7b-9675-409dad659196', 'Full'),
('4eb90745-44d0-4a59-8c49-1888090edd60','10853e59-dc5b-4d7b-a028-01513ef50d76', 'cb3e9985-dec6-4c7b-9675-409dad659196', 'Full'),
('89dc26b6-d2fd-4899-b084-800e38902154','e0352b32-7698-4805-b029-28302b3a911f','e2e2e2e2-2e2e-2e2e-2e2e-2e2e2e2e2e2e', 'Full'),
('b32f8f50-b26a-4cbb-a537-627e5c5236ea','e0352b32-7698-4805-b029-28302b3a911f','cb3e9985-dec6-4c7b-9675-409dad659196', 'Full'),
('2d6eb518-e355-4388-ab8d-0959d6dbeafe', '8beff8fd-39e4-49ea-ae5e-a0ec9af888c5', '7c022408-c6ec-4575-b362-923822ee83b4', 'Half'),
('fa887746-ea23-465f-af16-62c25937bcbb', 'e0352b32-7698-4805-b029-28302b3a911f', 'e2e2e2e2-2e2e-2e2e-2e2e-2e2e2e2e2e2e', 'Half'),
('997a41b0-d4bb-4cb0-9b91-19005270e8bd', '8beff8fd-39e4-49ea-ae5e-a0ec9af888c5','af20c380-b6c8-4c99-b1d9-780871b80ab1', 'Half')
;


-- Criação da tabela event_details
USE test_db
CREATE TABLE event_details (
    ticket_id VARCHAR(50) PRIMARY KEY,
    event_name NVARCHAR(100),
    location NVARCHAR(100),
    organization NVARCHAR(100),
    event_date DATE,
    capacity INT,
    spot_name NVARCHAR(100),
    status NVARCHAR(50),
    ticket_kind NVARCHAR(50),
    price DECIMAL(10, 2)
);

-- Inserção de dados na tabela event_details com cálculo condicional para price
INSERT INTO [test_db].[dbo].[event_details] (ticket_id, event_name, location, organization, event_date, capacity, spot_name, status, ticket_kind, price)
SELECT 
    t.ticket_id,
    e.name AS event_name,
    e.location,
    e.organization,
    e.date,
    e.capacity,
    s.name AS spot_name,
    s.status,
    t.ticket_kind,
    CASE 
        WHEN t.ticket_kind = 'Half' THEN e.price / 2
        ELSE e.price
    END AS price
FROM 
    [test_db].[dbo].[tickets] t
JOIN 
    [test_db].[dbo].[events] e ON t.event_id = e.event_id
JOIN 
    [test_db].[dbo].[spots] s ON t.spot_id = s.spot_id;


