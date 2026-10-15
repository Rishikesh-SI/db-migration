-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_web_user unique_employee_mobile_no
-- Type: CONSTRAINT

-- Name: labpr_web_user unique_employee_mobile_no; Type: CONSTRAINT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.labpr_web_user
    ADD CONSTRAINT unique_employee_mobile_no UNIQUE (mobile_no);


--
