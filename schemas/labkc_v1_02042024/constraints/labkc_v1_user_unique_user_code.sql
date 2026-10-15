-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_user unique_user_code
-- Type: CONSTRAINT

-- Name: labkc_v1_user unique_user_code; Type: CONSTRAINT; Schema: labkc_v1_02042024; Owner: -
--

ALTER TABLE ONLY labkc_v1_02042024.labkc_v1_user
    ADD CONSTRAINT unique_user_code UNIQUE (user_code);


--
