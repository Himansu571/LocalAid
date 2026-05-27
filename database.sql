create database localaid;
use localaid;

select * from locations;
select * from services;
select * from service_providers;
INSERT INTO services (name, description, icon, created_at) VALUES
('Plumber', 'Home and commercial plumbing services', 'droplet', NOW()),
('Electrician', 'Electrical installation and repair', 'lightning-charge', NOW()),
('Tutor', 'Home tuition for school and college students', 'book', NOW()),
('Doctor', 'General physician and clinic services', 'heart', NOW()),
('Driver', 'Personal and taxi driving services', 'car-front', NOW()),
('Beauty Salon', 'Hair, makeup and styling', 'scissors', NOW()),
('Auto Service', 'Car and bike repair and maintenance', 'tools', NOW()),
('Home Cleaning', 'House and office cleaning services', 'house-check', NOW())
ON DUPLICATE KEY UPDATE description = VALUES(description);

INSERT INTO locations (name, description, created_at) VALUES
('Puri', 'Local services in Puri', NOW()),
('Cuttack', 'Local services in Cuttack', NOW()),
('Bhubaneswar', 'Local services in Bhubaneswar', NOW()),
('Rourkela', 'Local services in Rourkela', NOW()),
('Balasore', 'Local services in Balasore', NOW()),
('Sambalpur', 'Local services in Sambalpur', NOW()),
('Berhampur', 'Local services in Berhampur', NOW()),
('Jajpur', 'Local services in Jajpur', NOW()),
('Angul', 'Local services in Angul', NOW()),
('Jharsuguda', 'Local services in Jharsuguda', NOW()),
('Baripada', 'Local services in Baripada', NOW()),
('Bhadrak', 'Local services in Bhadrak', NOW()),
('Dhenkanal', 'Local services in Dhenkanal', NOW()),
('Kendrapara', 'Local services in Kendrapara', NOW()),
('Khurda', 'Local services in Khurda', NOW()),
('Rayagada', 'Local services in Rayagada', NOW())
ON DUPLICATE KEY UPDATE description = VALUES(description);


-- Get IDs (adjust if your IDs differ)
SELECT id, name FROM services;
SELECT id, name FROM locations;

-- Assume (for example):
-- Plumber = 1, Electrician = 2, Tutor = 3, Doctor = 4
-- Bhubaneswar = 3, Cuttack = 2

INSERT INTO service_providers
(service_id, location_id, provider_name, contact_info, email, rating, description, created_at)
VALUES
-- Plumbers in Bhubaneswar (service_id 1, location_id 3)
(1, 3, 'Sharma Plumbing Works',  '9876543210', 'sharma.plumb.bbsr@example.com', 4.5, '24x7 emergency plumbing and leakage repair.', NOW()),
(1, 3, 'Sai Pipe Fittings',     '9876543211', 'sai.pipe.bbsr@example.com',      4.2, 'Bathroom, kitchen, and pipeline installation.', NOW()),
(1, 3, 'QuickFix Plumbers',     '9876543212', 'quickfix.plumb.bbsr@example.com',4.8, 'Fast response for all plumbing issues.', NOW()),

-- Plumbers in Cuttack (service_id 1, location_id 2)
(1, 2, 'Cuttack City Plumbers', '9876543213', 'city.plumb.ctc@example.com',      4.3, 'Residential and commercial plumbing services.', NOW()),
(1, 2, 'RiverSide Plumbing',    '9876543214', 'riverside.plumb.ctc@example.com',4.1, 'Pipeline repair and new connections.', NOW()),
(1, 2, 'Metro Plumb Care',      '9876543215', 'metro.plumb.ctc@example.com',    4.6, 'AMC and regular maintenance packages.', NOW()),

-- Electricians in Bhubaneswar (service_id 2, location_id 3)
(2, 3, 'SafeVolt Electricians', '9876543220', 'safevolt.elec.bbsr@example.com', 4.7, 'Wiring, MCB, inverter and earthing services.', NOW()),
(2, 3, 'Urban Spark Services',  '9876543221', 'urbanspark.bbsr@example.com',    4.4, 'Home and office electrical setup.', NOW()),
(2, 3, 'Bright Light Electric', '9876543222', 'brightlight.bbsr@example.com',   4.2, 'Lighting and fan installations.', NOW()),

-- Electricians in Cuttack (service_id 2, location_id 2)
(2, 2, 'Cuttack Power Care',    '9876543223', 'powercare.ctc@example.com',      4.5, 'All types of electrical repair.', NOW()),
(2, 2, 'CityLine Electric',     '9876543224', 'cityline.elec.ctc@example.com',  4.0, 'New wiring and load upgrade.', NOW()),
(2, 2, 'Sai Electric House',    '9876543225', 'saielectric.ctc@example.com',    4.3, 'Shop and home electrical work.', NOW()),

-- Tutors in Bhubaneswar (service_id 3, location_id 3)
(3, 3, 'SmartLearn Tutors',     '9876543230', 'smartlearn.bbsr@example.com',    4.8, 'Class 6–10 maths and science at home.', NOW()),
(3, 3, 'Future Academy',        '9876543231', 'future.acad.bbsr@example.com',   4.6, 'IIT/JEE and NEET coaching.', NOW()),
(3, 3, 'English Plus Classes',  '9876543232', 'engplus.bbsr@example.com',       4.3, 'Spoken English and grammar.', NOW()),

-- Tutors in Cuttack (service_id 3, location_id 2)
(3, 2, 'Success Point Tuition', '9876543233', 'successpoint.ctc@example.com',   4.5, 'School tuitions for all boards.', NOW()),
(3, 2, 'Scholars Home Tutors',  '9876543234', 'scholars.ctc@example.com',       4.4, 'Home tuition for 1–12.', NOW()),
(3, 2, 'Cuttack Coaching Hub',  '9876543235', 'coachhub.ctc@example.com',       4.2, 'Competitive exam preparation.', NOW()),

-- Doctors in Bhubaneswar (service_id 4, location_id 3)
(4, 3, 'Dr. Mishra Clinic',     '9876543240', 'dr.mishra.bbsr@example.com',     4.9, 'General physician and family doctor.', NOW()),
(4, 3, 'HealthFirst Clinic',    '9876543241', 'healthfirst.bbsr@example.com',   4.6, 'Multi-speciality outpatient services.', NOW()),
(4, 3, 'City Care Hospital OPD','9876543242', 'citycare.opd.bbsr@example.com',  4.4, 'OPD and basic diagnostics.', NOW()),

-- Doctors in Cuttack (service_id 4, location_id 2)
(4, 2, 'Dr. Sahoo Nursing Home','9876543243', 'dr.sahoo.ctc@example.com',       4.7, 'General and emergency services.', NOW()),
(4, 2, 'Wellness Polyclinic',   '9876543244', 'wellness.ctc@example.com',       4.5, 'Multiple specialists under one roof.', NOW()),
(4, 2, 'Happy Kids Clinic',     '9876543245', 'happykids.ctc@example.com',      4.8, 'Child specialist (pediatrics).', NOW());


USE localaid;

INSERT INTO service_providers
(service_id, location_id, provider_name, contact_info, email, rating, description, created_at)
VALUES
/* Puri (location_id = 1) */
(1, 1, 'Puri Ocean Plumbers', '9810001001', 'plumb.puri1@example.com', 4.3, 'Plumbing repair and installation in Puri.', NOW()),
(1, 1, 'Jagannath Plumbing Service', '9810001002', 'plumb.puri2@example.com', 4.1, '24x7 plumber for Puri town.', NOW()),
(2, 1, 'Puri Power Electric', '9810001201', 'elec.puri1@example.com', 4.2, 'Home and shop electrical services.', NOW()),
(2, 1, 'SeaSide Electric Works', '9810001202', 'elec.puri2@example.com', 4.0, 'Wiring and lighting installation.', NOW()),
(3, 1, 'Puri Study Centre', '9810001301', 'tutor.puri1@example.com', 4.4, 'School tuition classes for 1–10.', NOW()),
(3, 1, 'Temple City Tutors', '9810001302', 'tutor.puri2@example.com', 4.3, 'Home tutors for all subjects.', NOW()),
(4, 1, 'Puri Health Clinic', '9810001401', 'doc.puri1@example.com', 4.5, 'General physician clinic in Puri.', NOW()),
(4, 1, 'Sea Breeze Hospital OPD', '9810001402', 'doc.puri2@example.com', 4.2, 'Outpatient consultations and diagnostics.', NOW()),

/* Rourkela (location_id = 4) */
(1, 4, 'Rourkela Steel City Plumbers', '9810004001', 'plumb.rkl1@example.com', 4.3, 'Residential plumbing in Rourkela.', NOW()),
(1, 4, 'Rourkela Pipe Works', '9810004002', 'plumb.rkl2@example.com', 4.1, 'Leakage repair and pipeline installation.', NOW()),
(2, 4, 'Steel City Electric', '9810004201', 'elec.rkl1@example.com', 4.4, 'Electrical wiring and inverter fitting.', NOW()),
(2, 4, 'Rourkela Power House', '9810004202', 'elec.rkl2@example.com', 4.0, 'Shop and home electrical work.', NOW()),
(3, 4, 'Rourkela Coaching Point', '9810004301', 'tutor.rkl1@example.com', 4.5, 'Coaching for school and entrance exams.', NOW()),
(3, 4, 'Smart Kids Tutors Rourkela', '9810004302', 'tutor.rkl2@example.com', 4.3, 'Home tutors for classes 1–12.', NOW()),
(4, 4, 'Rourkela City Clinic', '9810004401', 'doc.rkl1@example.com', 4.6, 'General physician and specialist OPD.', NOW()),
(4, 4, 'SteelCare Hospital OPD', '9810004402', 'doc.rkl2@example.com', 4.4, 'OPD and diagnostics in Rourkela.', NOW()),

/* Balasore (location_id = 5) */
(1, 5, 'Balasore Pipe Masters', '9810005001', 'plumb.bls1@example.com', 4.2, 'Home and shop plumbing services.', NOW()),
(1, 5, 'North Coast Plumbers', '9810005002', 'plumb.bls2@example.com', 4.0, 'Emergency plumbing in Balasore.', NOW()),
(2, 5, 'Balasore Electric Works', '9810005201', 'elec.bls1@example.com', 4.3, 'Electrical repair and installation.', NOW()),
(2, 5, 'Coastal Power Services', '9810005202', 'elec.bls2@example.com', 4.1, 'Lighting and wiring experts.', NOW()),
(3, 5, 'Balasore Learning Hub', '9810005301', 'tutor.bls1@example.com', 4.4, 'Tuition for classes 6–10.', NOW()),
(3, 5, 'CoastLine Tutors', '9810005302', 'tutor.bls2@example.com', 4.2, 'Home tutors all subjects.', NOW()),
(4, 5, 'Balasore Care Clinic', '9810005401', 'doc.bls1@example.com', 4.5, 'General physician clinic.', NOW()),
(4, 5, 'North Coast Hospital OPD', '9810005402', 'doc.bls2@example.com', 4.3, 'OPD and lab tests.', NOW()),

/* Sambalpur (location_id = 6) */
(1, 6, 'Sambalpur City Plumbers', '9810006001', 'plumb.sbp1@example.com', 4.3, 'House plumbing in Sambalpur.', NOW()),
(1, 6, 'Hirakud Plumbing Service', '9810006002', 'plumb.sbp2@example.com', 4.1, 'Pipeline and bathroom fitting.', NOW()),
(2, 6, 'Sambalpur Electric Care', '9810006201', 'elec.sbp1@example.com', 4.4, 'Electrical setup and repair.', NOW()),
(2, 6, 'Mahanadi Power Services', '9810006202', 'elec.sbp2@example.com', 4.2, 'Wiring, fans, and lighting.', NOW()),
(3, 6, 'Sambalpur Study Circle', '9810006301', 'tutor.sbp1@example.com', 4.5, 'School tuition all subjects.', NOW()),
(3, 6, 'RiverSide Tutors', '9810006302', 'tutor.sbp2@example.com', 4.3, 'Home tuition specialists.', NOW()),
(4, 6, 'Sambalpur Health Clinic', '9810006401', 'doc.sbp1@example.com', 4.6, 'Family doctor and diagnostics.', NOW()),
(4, 6, 'Mahanadi Hospital OPD', '9810006402', 'doc.sbp2@example.com', 4.4, 'Outpatient services.', NOW()),

/* Berhampur (location_id = 7) */
(1, 7, 'Berhampur Plumbing Works', '9810007001', 'plumb.bam1@example.com', 4.2, 'Plumbing and bathroom fitting.', NOW()),
(1, 7, 'Ganjam Pipe Care', '9810007002', 'plumb.bam2@example.com', 4.0, 'Emergency plumbing in Berhampur.', NOW()),
(2, 7, 'Berhampur Electric Services', '9810007201', 'elec.bam1@example.com', 4.3, 'Electrical wiring and repair.', NOW()),
(2, 7, 'Silk City Electric', '9810007202', 'elec.bam2@example.com', 4.1, 'Lighting and inverter setup.', NOW()),
(3, 7, 'Berhampur Coaching Hub', '9810007301', 'tutor.bam1@example.com', 4.5, 'Coaching for school & entrance.', NOW()),
(3, 7, 'Silk City Tutors', '9810007302', 'tutor.bam2@example.com', 4.3, 'Home tutors for all classes.', NOW()),
(4, 7, 'Berhampur City Clinic', '9810007401', 'doc.bam1@example.com', 4.6, 'General physician.', NOW()),
(4, 7, 'Ganjam Health Centre', '9810007402', 'doc.bam2@example.com', 4.4, 'OPD and basic diagnostics.', NOW()),

/* Jajpur (location_id = 8) */
(1, 8, 'Jajpur Road Plumbers', '9810008001', 'plumb.jaj1@example.com', 4.2, 'Home plumbing services.', NOW()),
(1, 8, 'Kalinga Plumbing Service', '9810008002', 'plumb.jaj2@example.com', 4.0, 'Pipeline and leakage repair.', NOW()),
(2, 8, 'Jajpur Electric Point', '9810008201', 'elec.jaj1@example.com', 4.3, 'Electrical installation.', NOW()),
(2, 8, 'Kalinga Electric Works', '9810008202', 'elec.jaj2@example.com', 4.1, 'Lighting and wiring jobs.', NOW()),
(3, 8, 'Jajpur Study Centre', '9810008301', 'tutor.jaj1@example.com', 4.4, 'School tuition classes.', NOW()),
(3, 8, 'Smart Tutors Jajpur', '9810008302', 'tutor.jaj2@example.com', 4.2, 'Home tutors.', NOW()),
(4, 8, 'Jajpur Health Clinic', '9810008401', 'doc.jaj1@example.com', 4.5, 'General clinic.', NOW()),
(4, 8, 'Kalinga Hospital OPD', '9810008402', 'doc.jaj2@example.com', 4.3, 'OPD and lab.', NOW()),

/* Angul (location_id = 13) */
(1,13, 'Angul City Plumbers', '9810009001', 'plumb.ang1@example.com', 4.2, 'Residential and shop plumbing.', NOW()),
(1,13, 'Talcher Plumbing Service', '9810009002', 'plumb.ang2@example.com', 4.0, 'Emergency plumbing.', NOW()),
(2,13, 'Angul Electric Care', '9810009201', 'elec.ang1@example.com', 4.3, 'Electrical repair and wiring.', NOW()),
(2,13, 'Coalfield Electric Works', '9810009202', 'elec.ang2@example.com', 4.1, 'Inverter and lighting.', NOW()),
(3,13, 'Angul Learning Point', '9810009301', 'tutor.ang1@example.com', 4.4, 'School tuition.', NOW()),
(3,13, 'Coalfield Tutors', '9810009302', 'tutor.ang2@example.com', 4.2, 'Home tutors for 1–12.', NOW()),
(4,13, 'Angul Health Clinic', '9810009401', 'doc.ang1@example.com', 4.5, 'General physician.', NOW()),
(4,13, 'Talcher Hospital OPD', '9810009402', 'doc.ang2@example.com', 4.3, 'OPD services.', NOW()),

/* Jharsuguda (location_id = 14) */
(1,14, 'Jharsuguda Plumbers', '9810010001', 'plumb.jsg1@example.com', 4.2, 'House plumbing.', NOW()),
(1,14, 'IB Valley Plumbing', '9810010002', 'plumb.jsg2@example.com', 4.0, 'Pipeline work.', NOW()),
(2,14, 'Jharsuguda Electric Services', '9810010201', 'elec.jsg1@example.com', 4.3, 'Electrical repair.', NOW()),
(2,14, 'Industrial Electric Works', '9810010202', 'elec.jsg2@example.com', 4.1, 'Wiring and connections.', NOW()),
(3,14, 'Jharsuguda Coaching Centre', '9810010301', 'tutor.jsg1@example.com', 4.4, 'School tuition.', NOW()),
(3,14, 'IB Valley Tutors', '9810010302', 'tutor.jsg2@example.com', 4.2, 'Home tutors.', NOW()),
(4,14, 'Jharsuguda City Clinic', '9810010401', 'doc.jsg1@example.com', 4.5, 'General physician.', NOW()),
(4,14, 'IB Valley Hospital OPD', '9810010402', 'doc.jsg2@example.com', 4.3, 'OPD and diagnostics.', NOW()),

/* Baripada (location_id = 15) */
(1,15, 'Baripada Plumbers', '9810011001', 'plumb.bmp1@example.com', 4.2, 'Home plumbing.', NOW()),
(1,15, 'Similipal Plumbing Service', '9810011002', 'plumb.bmp2@example.com', 4.0, 'Pipeline repair.', NOW()),
(2,15, 'Baripada Electric Works', '9810011201', 'elec.bmp1@example.com', 4.3, 'Electrical services.', NOW()),
(2,15, 'Similipal Electric Care', '9810011202', 'elec.bmp2@example.com', 4.1, 'Lighting and wiring.', NOW()),
(3,15, 'Baripada Study Point', '9810011301', 'tutor.bmp1@example.com', 4.4, 'Tuition classes.', NOW()),
(3,15, 'Similipal Tutors', '9810011302', 'tutor.bmp2@example.com', 4.2, 'Home tutors.', NOW()),
(4,15, 'Baripada Health Clinic', '9810011401', 'doc.bmp1@example.com', 4.5, 'General doctor.', NOW()),
(4,15, 'Similipal Hospital OPD', '9810011402', 'doc.bmp2@example.com', 4.3, 'OPD and tests.', NOW()),

/* Bhadrak (location_id = 16) */
(1,16, 'Bhadrak Plumbers', '9810012001', 'plumb.bdr1@example.com', 4.2, 'Plumbing services.', NOW()),
(1,16, 'Chandbali Plumbing', '9810012002', 'plumb.bdr2@example.com', 4.0, 'Emergency plumber.', NOW()),
(2,16, 'Bhadrak Electric Care', '9810012201', 'elec.bdr1@example.com', 4.3, 'Electrical work.', NOW()),
(2,16, 'Chandbali Electric', '9810012202', 'elec.bdr2@example.com', 4.1, 'Wiring and repair.', NOW()),
(3,16, 'Bhadrak Coaching', '9810012301', 'tutor.bdr1@example.com', 4.4, 'School tuition.', NOW()),
(3,16, 'Chandbali Tutors', '9810012302', 'tutor.bdr2@example.com', 4.2, 'Home tutors.', NOW()),
(4,16, 'Bhadrak City Clinic', '9810012401', 'doc.bdr1@example.com', 4.5, 'General physician.', NOW()),
(4,16, 'Chandbali Health Centre', '9810012402', 'doc.bdr2@example.com', 4.3, 'OPD services.', NOW()),

/* Dhenkanal (location_id = 17) */
(1,17, 'Dhenkanal Plumbers', '9810013001', 'plumb.dnk1@example.com', 4.2, 'Home plumbing.', NOW()),
(1,17, 'Kapilas Plumbing Service', '9810013002', 'plumb.dnk2@example.com', 4.0, 'Leak repair.', NOW()),
(2,17, 'Dhenkanal Electric Works', '9810013201', 'elec.dnk1@example.com', 4.3, 'Electrical repair.', NOW()),
(2,17, 'Kapilas Electric Care', '9810013202', 'elec.dnk2@example.com', 4.1, 'Lighting installation.', NOW()),
(3,17, 'Dhenkanal Study Centre', '9810013301', 'tutor.dnk1@example.com', 4.4, 'Tuition classes.', NOW()),
(3,17, 'Kapilas Tutors', '9810013302', 'tutor.dnk2@example.com', 4.2, 'Home tuition.', NOW()),
(4,17, 'Dhenkanal Health Clinic', '9810013401', 'doc.dnk1@example.com', 4.5, 'General doctor.', NOW()),
(4,17, 'Kapilas Hospital OPD', '9810013402', 'doc.dnk2@example.com', 4.3, 'OPD and tests.', NOW()),

/* Kendrapara (location_id = 18) */
(1,18, 'Kendrapara Plumbers', '9810014001', 'plumb.kdp1@example.com', 4.2, 'Plumbing services.', NOW()),
(1,18, 'Delta Plumbing Service', '9810014002', 'plumb.kdp2@example.com', 4.0, 'Emergency plumber.', NOW()),
(2,18, 'Kendrapara Electric Care', '9810014201', 'elec.kdp1@example.com', 4.3, 'Electrical work.', NOW()),
(2,18, 'Delta Electric Works', '9810014202', 'elec.kdp2@example.com', 4.1, 'Wiring and repair.', NOW()),
(3,18, 'Kendrapara Coaching', '9810014301', 'tutor.kdp1@example.com', 4.4, 'School tuition.', NOW()),
(3,18, 'Delta Tutors', '9810014302', 'tutor.kdp2@example.com', 4.2, 'Home tutors.', NOW()),
(4,18, 'Kendrapara City Clinic', '9810014401', 'doc.kdp1@example.com', 4.5, 'General physician.', NOW()),
(4,18, 'Delta Health Centre', '9810014402', 'doc.kdp2@example.com', 4.3, 'OPD services.', NOW()),

/* Khurda (location_id = 19) */
(1,19, 'Khurda Plumbers', '9810015001', 'plumb.khd1@example.com', 4.2, 'Home plumbing.', NOW()),
(1,19, 'Barunei Plumbing', '9810015002', 'plumb.khd2@example.com', 4.0, 'Leak repair.', NOW()),
(2,19, 'Khurda Electric Works', '9810015201', 'elec.khd1@example.com', 4.3, 'Electrical repair.', NOW()),
(2,19, 'Barunei Electric Care', '9810015202', 'elec.khd2@example.com', 4.1, 'Lighting and wiring.', NOW()),
(3,19, 'Khurda Study Centre', '9810015301', 'tutor.khd1@example.com', 4.4, 'Tuition.', NOW()),
(3,19, 'Barunei Tutors', '9810015302', 'tutor.khd2@example.com', 4.2, 'Home tuition.', NOW()),
(4,19, 'Khurda Health Clinic', '9810015401', 'doc.khd1@example.com', 4.5, 'General doctor.', NOW()),
(4,19, 'Barunei Hospital OPD', '9810015402', 'doc.khd2@example.com', 4.3, 'OPD and tests.', NOW()),

/* Rayagada (location_id = 20) */
(1,20, 'Rayagada Plumbers', '9810016001', 'plumb.rgd1@example.com', 4.2, 'Plumbing services.', NOW()),
(1,20, 'Tribal Hills Plumbing', '9810016002', 'plumb.rgd2@example.com', 4.0, 'Emergency repair.', NOW()),
(2,20, 'Rayagada Electric Care', '9810016201', 'elec.rgd1@example.com', 4.3, 'Electrical work.', NOW()),
(2,20, 'Hillside Electric Works', '9810016202', 'elec.rgd2@example.com', 4.1, 'Wiring and installation.', NOW()),
(3,20, 'Rayagada Coaching', '9810016301', 'tutor.rgd1@example.com', 4.4, 'School tuition.', NOW()),
(3,20, 'Hillside Tutors', '9810016302', 'tutor.rgd2@example.com', 4.2, 'Home tuition.', NOW()),
(4,20, 'Rayagada Health Clinic', '9810016401', 'doc.rgd1@example.com', 4.5, 'General physician.', NOW()),
(4,20, 'Tribal Hills Hospital OPD', '9810016402', 'doc.rgd2@example.com', 4.3, 'OPD and diagnostics.', NOW());


select * from users;