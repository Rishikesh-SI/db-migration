-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_web_user unique_employee_mobile_no
-- Type: CONSTRAINT

-- Name: labdsg_web_user unique_employee_mobile_no; Type: CONSTRAINT; Schema: labdsg; Owner: -
--

ALTER TABLE ONLY labdsg.labdsg_web_user
    ADD CONSTRAINT unique_employee_mobile_no UNIQUE (mobile_no);


--
