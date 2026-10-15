-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_app_status tcs_app_status_id
-- Type: CONSTRAINT

-- Name: tcs_app_status tcs_app_status_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_app_status
    ADD CONSTRAINT tcs_app_status_id PRIMARY KEY (app_id);


--
