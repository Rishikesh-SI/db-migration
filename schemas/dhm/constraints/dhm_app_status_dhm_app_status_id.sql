-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_app_status dhm_app_status_id
-- Type: CONSTRAINT

-- Name: dhm_app_status dhm_app_status_id; Type: CONSTRAINT; Schema: dhm; Owner: -
--

ALTER TABLE ONLY dhm.dhm_app_status
    ADD CONSTRAINT dhm_app_status_id PRIMARY KEY (app_id);


--
