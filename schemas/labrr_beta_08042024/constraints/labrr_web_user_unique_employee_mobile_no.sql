-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_web_user unique_employee_mobile_no
-- Type: CONSTRAINT

-- Name: labrr_web_user unique_employee_mobile_no; Type: CONSTRAINT; Schema: labrr_beta_08042024; Owner: -
--

ALTER TABLE ONLY labrr_beta_08042024.labrr_web_user
    ADD CONSTRAINT unique_employee_mobile_no UNIQUE (mobile_no);


--
