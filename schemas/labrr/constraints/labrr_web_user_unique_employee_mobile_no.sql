-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_web_user unique_employee_mobile_no
-- Type: CONSTRAINT

-- Name: labrr_web_user unique_employee_mobile_no; Type: CONSTRAINT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_web_user
    ADD CONSTRAINT unique_employee_mobile_no UNIQUE (mobile_no);


--
